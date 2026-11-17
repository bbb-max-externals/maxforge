import { CompileError, ErrorCode } from "../core/types.js";
import { collectBlock, SourceLine, toSourceLines } from "./blocks.js";
import { evaluateExpression } from "./expression.js";
import { applyStyles, defineStyle, instantiate, parseUse, Style } from "./ui-templates.js";
import { isOrdinaryStatement, opensBlock } from "./object-syntax.js";

interface ExpandResult {
  source: string;
  errors: CompileError[];
}

export interface ExpansionLimits {
  readonly maxExpandedLines?: number;
  readonly maxLoopIterations?: number;
}

interface ExpansionState {
  readonly errors: CompileError[];
  readonly maxExpandedLines: number;
  readonly maxLoopIterations: number;
  expandedLines: number;
  exhausted: boolean;
  work: number;
  readonly styles: Map<string, Style>;
  readonly templates: Map<string, { params: string[]; body: SourceLine[]; env: Map<string, number>; styles: Map<string, Style> }>;
  readonly calls: string[];
}

export const DEFAULT_MAX_EXPANDED_LINES = 100_000;
export const DEFAULT_MAX_LOOP_ITERATIONS = 100_000;

const FOR_RE = /^for\s+([A-Za-z_]\w*)\s+in\s+(.+?)\.\.(.+?)(?:\s+step\s+(.+?))?\s*\{$/;
const IF_RE = /^if\s+(.+)\s*\{$/;
const ELSE_RE = /^(?:}\s*)?else\s*\{$/;
const INTERPOLATION_RE = /\$\{([^}]*)\}/g;

export function expandControlFlow(
  source: string,
  limits: ExpansionLimits = {}
): ExpandResult {
  const lines = toSourceLines(source);
  const errors: CompileError[] = [];
  const state: ExpansionState = {
    errors,
    maxExpandedLines: positiveIntegerLimit(
      limits.maxExpandedLines,
      DEFAULT_MAX_EXPANDED_LINES,
      "maxExpandedLines"
    ),
    maxLoopIterations: positiveIntegerLimit(
      limits.maxLoopIterations,
      DEFAULT_MAX_LOOP_ITERATIONS,
      "maxLoopIterations"
    ),
    expandedLines: 0,
    exhausted: false,
    work: 0,
    styles: new Map(),
    templates: new Map(),
    calls: [],
  };
  const result = expandBlock(lines, 0, new Map(), state);

  if (result.closed) {
    errors.push({
      code: ErrorCode.SYNTAX_ERROR,
      message: "Unexpected closing brace",
      line: result.closeLine,
    });
  }

  return { source: result.lines.join("\n"), errors };
}

interface BlockResult {
  lines: string[];
  nextIndex: number;
  closed: boolean;
  closeLine?: number;
}

function expandBlock(
  sourceLines: SourceLine[],
  startIndex: number,
  env: Map<string, number>,
  state: ExpansionState,
  root = true,
  aliases: Set<string> = new Set(),
  styles: Map<string, Style> = state.styles
): BlockResult {
  const output: string[] = [];
  let i = startIndex;

  while (i < sourceLines.length && !state.exhausted) {
    const current = sourceLines[i];
    const trimmed = current.text.trim();

    if (++state.work > state.maxExpandedLines + state.maxLoopIterations) {
      state.errors.push({ code: ErrorCode.SYNTAX_ERROR, message: "Expansion work budget exceeded", line: current.line });
      state.exhausted = true;
      break;
    }
    if (!trimmed || trimmed.startsWith("#")) {
      appendLines(output, [current.text], current.line, state);
      i++;
      continue;
    }

    try {
      if (!isOrdinaryStatement(trimmed)) {
        const constant = trimmed.match(/^const\s+([A-Za-z_]\w*)\s*=\s*(.+)$/);
        if (constant) {
          if (env.has(constant[1])) throw new Error(`Duplicate constant: ${constant[1]}`);
          env.set(constant[1], evaluateExpression(constant[2], env));
          i++;
          continue;
        }
        const template = trimmed.match(/^template\s+([A-Za-z_]\w*)\s*\(([^()]*)\)\s*\{$/);
        if (template) {
          const body = collectBlock(sourceLines, i + 1);
          i = body.nextIndex;
          if (!root) throw new Error("Template definitions are root-only");
          if (!body.closed) throw new Error(`Unclosed template: ${template[1]}`);
          if (state.templates.has(template[1])) throw new Error(`Duplicate template: ${template[1]}`);
          const params = template[2].trim() ? template[2].split(",").map((value) => value.trim()) : [];
          if (params.some((value) => !/^[A-Za-z_]\w*$/.test(value)) || new Set(params).size !== params.length) {
            throw new Error("Template parameters must be unique identifiers");
          }
          state.templates.set(template[1], { params, body: body.lines, env: new Map(env), styles: new Map(styles) });
          continue;
        }
        if (/^style\s/.test(trimmed)) {
          if (!root) throw new Error("Style definitions are root-only");
          defineStyle(interpolateLine(trimmed, env, current.line, state.errors), styles);
          i++;
          continue;
        }
        if (/^use\s/.test(trimmed)) {
          const use = parseUse(interpolateLine(trimmed, env, current.line, state.errors), env);
          const template = state.templates.get(use.name);
          if (!template) throw new Error(`Unknown template: ${use.name}`);
          if (use.args.length !== template.params.length) throw new Error(`Template ${use.name} expects ${template.params.length} arguments, received ${use.args.length}`);
          if (aliases.has(use.alias)) throw new Error(`Duplicate template instance: ${use.alias}`);
          aliases.add(use.alias);
          if (state.calls.includes(use.name)) throw new Error(`Recursive template: ${[...state.calls, use.name].join(" -> ")}`);
          if (state.calls.length >= 32) throw new Error("Template nesting exceeds 32 calls");
          const innerEnv = new Map(template.env);
          template.params.forEach((param, index) => innerEnv.set(param, use.args[index]));
          state.calls.push(use.name);
          try {
            const expanded = expandBlock(template.body, 0, innerEnv, state, false, new Set(), template.styles);
            output.push(...instantiate(expanded.lines, use));
          } finally {
            state.calls.pop();
          }
          i++;
          continue;
        }
        if (!root && /^patcher(?:\s|$)/.test(trimmed)) throw new Error("patcher settings are root-only");
      }
    } catch (error) {
      state.errors.push({ code: ErrorCode.SYNTAX_ERROR, message: error instanceof Error ? error.message : String(error), line: current.line });
      return { lines: output, nextIndex: sourceLines.length, closed: false };
    }

    if (trimmed === "}") {
      return { lines: output, nextIndex: i + 1, closed: true, closeLine: current.line };
    }

    const forMatch = !isOrdinaryStatement(trimmed) && trimmed.match(FOR_RE);
    if (forMatch) {
      const body = collectBlock(sourceLines, i + 1);
      if (!body.closed) {
        state.errors.push({
          code: ErrorCode.SYNTAX_ERROR,
          message: `Unclosed for block starting at line ${current.line}`,
          line: current.line,
        });
        return { lines: output, nextIndex: sourceLines.length, closed: false };
      }

      const [, varName, startExpr, endExpr, stepExpr] = forMatch;
      const range = evalRange(
        startExpr,
        endExpr,
        stepExpr,
        env,
        current.line,
        state
      );
      if (range) {
        for (const value of range) {
          if (state.exhausted) break;
          if (++state.work > state.maxExpandedLines + state.maxLoopIterations) {
            state.errors.push({ code: ErrorCode.SYNTAX_ERROR, message: "Expansion work budget exceeded", line: current.line });
            state.exhausted = true;
            break;
          }
          const innerEnv = new Map(env);
          innerEnv.set(varName, value);
          const expanded = expandBlock(body.lines, 0, innerEnv, state, false, aliases, styles);
          output.push(...expanded.lines);
        }
      }

      i = body.nextIndex;
      continue;
    }

    const ifMatch = !isOrdinaryStatement(trimmed) && trimmed.match(IF_RE);
    if (ifMatch) {
      const body = collectBlock(sourceLines, i + 1);
      if (!body.closed) {
        state.errors.push({
          code: ErrorCode.SYNTAX_ERROR,
          message: `Unclosed if block starting at line ${current.line}`,
          line: current.line,
        });
        return { lines: output, nextIndex: sourceLines.length, closed: false };
      }

      const condition = evalExpression(ifMatch[1], env, current.line, state.errors);
      let nextIndex = body.nextIndex;
      let elseBody: ReturnType<typeof collectBlock> | undefined;
      const maybeElse = sourceLines[nextIndex];
      if (maybeElse && ELSE_RE.test(maybeElse.text.trim())) {
        elseBody = collectBlock(sourceLines, nextIndex + 1);
        if (!elseBody.closed) {
          state.errors.push({
            code: ErrorCode.SYNTAX_ERROR,
            message: `Unclosed else block starting at line ${maybeElse.line}`,
            line: maybeElse.line,
          });
          return { lines: output, nextIndex: sourceLines.length, closed: false };
        }
        nextIndex = elseBody.nextIndex;
      }

      if (condition !== null && condition !== 0) {
        const expanded = expandBlock(body.lines, 0, new Map(env), state, false, aliases, styles);
        output.push(...expanded.lines);
      } else if (condition !== null && elseBody) {
        const expanded = expandBlock(elseBody.lines, 0, new Map(env), state, false, aliases, styles);
        output.push(...expanded.lines);
      }

      i = nextIndex;
      continue;
    }

    if (!isOrdinaryStatement(trimmed) && ELSE_RE.test(trimmed)) {
      state.errors.push({
        code: ErrorCode.SYNTAX_ERROR,
        message: "else must immediately follow an if block",
        line: current.line,
      });
      return { lines: output, nextIndex: sourceLines.length, closed: false };
    }

    if (opensBlock(trimmed)) {
      const header = styledLine(current, env, state, styles);
      appendLines(output, [header], current.line, state);

      const body = expandBlock(sourceLines, i + 1, new Map(env), state, false, new Set(), styles);
      output.push(...body.lines);
      if (!body.closed) {
        state.errors.push({
          code: ErrorCode.SYNTAX_ERROR,
          message: `Unclosed block starting at line ${current.line}`,
          line: current.line,
        });
        return { lines: output, nextIndex: sourceLines.length, closed: false };
      }
      appendLines(output, ["}"], current.line, state);
      i = body.nextIndex;
      continue;
    }

    appendLines(
      output,
      [styledLine(current, env, state, styles)],
      current.line,
      state
    );
    i++;
  }

  return { lines: output, nextIndex: i, closed: false };
}

function styledLine(current: SourceLine, env: Map<string, number>, state: ExpansionState, styles: Map<string, Style>): string {
  const text = interpolateLine(current.text, env, current.line, state.errors);
  try {
    return applyStyles(text, styles);
  } catch (error) {
    state.errors.push({ code: ErrorCode.SYNTAX_ERROR, message: error instanceof Error ? error.message : String(error), line: current.line });
    return text;
  }
}

function evalRange(
  startExpr: string,
  endExpr: string,
  stepExpr: string | undefined,
  env: Map<string, number>,
  line: number,
  state: ExpansionState
): number[] | null {
  const start = evalExpression(startExpr, env, line, state.errors);
  const end = evalExpression(endExpr, env, line, state.errors);
  const explicitStep = stepExpr
    ? evalExpression(stepExpr, env, line, state.errors)
    : null;

  if (start === null || end === null || (stepExpr && explicitStep === null)) return null;

  const step = explicitStep ?? (start <= end ? 1 : -1);
  if (step === 0) {
    state.errors.push({
      code: ErrorCode.SYNTAX_ERROR,
      message: "for loop step cannot be 0",
      line,
    });
    return null;
  }
  if ((start < end && step < 0) || (end < start && 0 < step)) {
    state.errors.push({
      code: ErrorCode.SYNTAX_ERROR,
      message: "for loop step does not advance toward the range end",
      line,
    });
    return null;
  }

  const values: number[] = [];
  if (step > 0) {
    for (let value = start; value <= end; value += step) {
      if (!appendRangeValue(values, value, step, line, state)) return null;
    }
  } else {
    for (let value = start; value >= end; value += step) {
      if (!appendRangeValue(values, value, step, line, state)) return null;
    }
  }
  return values;
}

function appendRangeValue(
  values: number[],
  value: number,
  step: number,
  line: number,
  state: ExpansionState
): boolean {
  if (state.maxLoopIterations <= values.length) {
    state.errors.push({
      code: ErrorCode.SYNTAX_ERROR,
      message: `for loop exceeds ${state.maxLoopIterations} iterations`,
      line,
    });
    state.exhausted = true;
    return false;
  }
  if (value + step === value) {
    state.errors.push({
      code: ErrorCode.SYNTAX_ERROR,
      message: "for loop step is too small to advance the range",
      line,
    });
    return false;
  }
  values.push(value);
  return true;
}

function appendLines(
  output: string[],
  lines: readonly string[],
  line: number,
  state: ExpansionState
): void {
  if (state.exhausted || lines.length === 0) return;
  if (state.maxExpandedLines < state.expandedLines + lines.length) {
    state.errors.push({
      code: ErrorCode.SYNTAX_ERROR,
      message: `expanded source exceeds ${state.maxExpandedLines} lines`,
      line,
    });
    state.exhausted = true;
    return;
  }
  output.push(...lines);
  state.expandedLines += lines.length;
}

function positiveIntegerLimit(
  value: number | undefined,
  fallback: number,
  name: string
): number {
  if (value === undefined) return fallback;
  if (!Number.isInteger(value) || value <= 0) {
    throw new Error(`${name} must be a positive integer`);
  }
  return value;
}

function interpolateLine(
  lineText: string,
  env: Map<string, number>,
  line: number,
  errors: CompileError[]
): string {
  return lineText.replace(INTERPOLATION_RE, (_match, expr: string) => {
    const value = evalExpression(expr, env, line, errors);
    return value === null ? "" : formatNumber(value);
  });
}

function formatNumber(value: number): string {
  return Number.isInteger(value) ? String(value) : String(value);
}

function evalExpression(
  expr: string,
  env: Map<string, number>,
  line: number,
  errors: CompileError[]
): number | null {
  try {
    return evaluateExpression(expr, env);
  } catch (error) {
    errors.push({
      code: ErrorCode.SYNTAX_ERROR,
      message: error instanceof Error ? error.message : `Invalid expression: ${expr}`,
      line,
    });
    return null;
  }
}
