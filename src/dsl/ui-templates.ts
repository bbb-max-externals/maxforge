import { formatAttr, isReservedAttributeKey } from "../core/attributes.js";
import { AttrValue } from "../core/types.js";
import { evaluateExpression } from "./expression.js";
import { opensBlock, parseAttributes, parsePositionSuffix, sourceTokens } from "./object-syntax.js";

export type Style = Record<string, AttrValue[]>;

function attributes(text: string): { object: string; attrs: Style } {
  const index = sourceTokens(text).find((token) => token.text.startsWith("@"))?.start;
  if (index === undefined) return { object: text.trim(), attrs: {} };
  const parsed = parseAttributes(text.slice(index));
  if (parsed.errors.length) throw new Error(parsed.errors.join("; "));
  return { object: text.slice(0, index).trim(), attrs: parsed.attrs };
}

function serialize(attrs: Style): string {
  return Object.entries(attrs).map(([key, value]) => formatAttr(key, value)).join(" ");
}

export function defineStyle(text: string, styles: Map<string, Style>): void {
  const match = text.match(/^style\s+([A-Za-z_]\w*)(?:\s+extends\s+([A-Za-z_]\w*))?\s*=\s*(.+)$/);
  if (!match) throw new Error("Invalid style definition");
  const [, name, parent, body] = match;
  if (styles.has(name)) throw new Error(`Duplicate style: ${name}`);
  if (parent && !styles.has(parent)) throw new Error(`Unknown parent style: ${parent}`);
  const parsed = parseAttributes(body);
  if (parsed.errors.length) throw new Error(parsed.errors.join("; "));
  if (parsed.text || !Object.keys(parsed.attrs).length) throw new Error("Styles require @attributes only");
  for (const key of Object.keys(parsed.attrs)) {
    if (isReservedAttributeKey(key) || key === "varname") {
      throw new Error(`Style cannot set @${key}`);
    }
  }
  styles.set(name, { ...styles.get(parent ?? ""), ...parsed.attrs });
}

export function applyStyles(line: string, styles: Map<string, Style>): string {
  const definition = line.match(/^(\s*\w+\s*=\s*)(.*)$/);
  if (!definition) return line;
  const body = definition[2];
  const block = opensBlock(body);
  const positioned = parsePositionSuffix(block ? body.trimEnd().slice(0, -1).trim() : body);
  const tokens = sourceTokens(positioned.text);
  const start = tokens.findIndex((token) => token.text.startsWith("using("));
  if (start < 0) return line;
  if (tokens.slice(start + 1).some((token) => token.text.startsWith("using("))) {
    throw new Error("Invalid or duplicate using(...) suffix");
  }
  if (positioned.errors.length) throw new Error(positioned.errors.join("; "));
  const firstAttribute = tokens.findIndex((token) => token.text.startsWith("@"));
  const end = firstAttribute < 0 ? tokens.length : firstAttribute;
  if (start === 0 || start >= end) throw new Error("using(...) must follow object text and precede attributes");
  const clause = positioned.text.slice(tokens[start].start, tokens[end - 1].end);
  const match = clause.match(/^using\(\s*([A-Za-z_]\w*(?:\s*,\s*[A-Za-z_]\w*)*)\s*\)$/);
  if (!match) throw new Error("Invalid or duplicate using(...) suffix");
  const names = match[1].split(",").map((name) => name.trim());
  const merged: Style = Object.create(null);
  for (const name of names) {
    const style = styles.get(name);
    if (!style) throw new Error(`Unknown style: ${name}`);
    Object.assign(merged, style);
  }
  const withoutUsing = positioned.text.slice(0, tokens[start].start) + positioned.text.slice(tokens[end - 1].end);
  const parsed = attributes(withoutUsing);
  Object.assign(merged, parsed.attrs);
  return `${definition[1]}${parsed.object} ${serialize(merged)}${positionSuffix(positioned.pos, positioned.size)}${block ? " {" : ""}`;
}

function positionSuffix(pos?: number[], size?: number[]): string {
  return pos ? ` at(${[...pos, ...(size ?? [])].join(", ")})` : "";
}

// Expressions have parentheses but no comma operator or string values.
function takeArguments(text: string): { values: string[]; rest: string } {
  if (!text.startsWith("(")) throw new Error("Expected (...)");
  let depth = 0;
  for (let i = 0; i < text.length; i++) {
    if (text[i] === "(") depth++;
    if (text[i] === ")" && --depth === 0) {
      const body = text.slice(1, i).trim();
      return { values: body ? body.split(",").map((v) => v.trim()) : [], rest: text.slice(i + 1).trim() };
    }
  }
  throw new Error("Unclosed argument list");
}

export function parseUse(text: string, env: Map<string, number>): {
  name: string; args: number[]; alias: string; pos: number[]; presentation: number[];
} {
  const head = text.match(/^use\s+([A-Za-z_]\w*)\s*/);
  if (!head) throw new Error("Invalid template invocation");
  const arguments_ = takeArguments(text.slice(head[0].length));
  const alias = arguments_.rest.match(/^as\s+([A-Za-z_]\w*)(?:\s+|$)/);
  if (!alias) throw new Error("Template invocation requires 'as identifier'");
  let rest = arguments_.rest.slice(alias[0].length);
  const origins = new Map<string, number[]>();
  while (rest) {
    const kind = rest.match(/^(at|present)\s*/)?.[1];
    if (!kind || origins.has(kind)) throw new Error(`Invalid template origin: ${rest}`);
    const values = takeArguments(rest.slice(kind.length).trimStart());
    if (values.values.length !== 2) throw new Error(`${kind} requires two coordinates`);
    origins.set(kind, values.values.map((value) => evaluateExpression(value, env)));
    rest = values.rest;
  }
  return {
    name: head[1], args: arguments_.values.map((value) => evaluateExpression(value, env)),
    alias: alias[1], pos: origins.get("at") ?? [0, 0], presentation: origins.get("present") ?? [0, 0],
  };
}

export function instantiate(lines: string[], use: ReturnType<typeof parseUse>): string[] {
  const names = new Set<string>();
  let depth = 0;
  for (const line of lines) {
    if (line.trimStart().startsWith("#")) continue;
    if (depth === 0) {
      const name = line.match(/^\s*(\w+)\s*=/)?.[1];
      if (name) names.add(name);
    }
    if (opensBlock(line)) depth++;
    if (line.trim() === "}") depth--;
  }
  const qualify = (name: string) => {
    if (!names.has(name)) throw new Error(`Template ${use.name} cannot reference caller object: ${name}`);
    return `${use.alias}__${name}`;
  };
  depth = 0;
  return lines.map((line) => {
    if (line.trimStart().startsWith("#")) return line;
    const root = depth === 0;
    const block = opensBlock(line);
    if (block) depth++;
    if (line.trim() === "}") depth--;
    if (!root || !line.trim() || line.trimStart().startsWith("#")) return line;
    const definition = line.match(/^\s*(\w+)\s*=\s*(.*)$/);
    if (!definition) {
      if (!line.includes("->")) throw new Error(`Invalid template statement: ${line}`);
      return line.split("->").map((ref) => ref.trim().replace(/^\w+/, qualify)).join(" -> ");
    }
    const text = block ? definition[2].trimEnd().slice(0, -1).trim() : definition[2];
    const positioned = parsePositionSuffix(text);
    if (positioned.errors.length) throw new Error(positioned.errors.join("; "));
    if (!positioned.pos && use.pos.some((value) => value !== 0)) {
      throw new Error(`Template ${use.name}: ${definition[1]} needs explicit at(...) for a patching origin`);
    }
    const pos = positioned.pos?.map((value, i) => value + use.pos[i]);
    const parsed = attributes(positioned.text);
    const rect = parsed.attrs.presentation_rect;
    if (rect) {
      if (rect.length !== 4 || rect.some((value) => typeof value !== "number" || !Number.isFinite(value))) {
        throw new Error("Template presentation_rect requires four finite numbers");
      }
      if (Number(rect[2]) <= 0 || Number(rect[3]) <= 0) throw new Error("Template presentation dimensions must be positive");
      parsed.attrs.presentation_rect = rect.map((value, i) => Number(value) + (use.presentation[i] ?? 0));
    }
    if (pos?.some((value) => !Number.isFinite(value)) || parsed.attrs.presentation_rect?.some((value) => !Number.isFinite(value))) {
      throw new Error("Template origin overflow");
    }
    return `${qualify(definition[1])} = ${parsed.object} ${serialize(parsed.attrs)}${positionSuffix(pos, positioned.size)}${block ? " {" : ""}`;
  });
}
