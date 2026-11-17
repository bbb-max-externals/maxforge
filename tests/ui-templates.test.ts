import { describe, expect, it } from "vitest";
import dbData from "../data/objects.json" with { type: "json" };
import { compile, decompile, parse } from "../src/index.js";
import type { ObjectDatabase } from "../src/core/types.js";
import { expandControlFlow } from "../src/dsl/expander.js";
import { compileDslToPatchGraph, patchGraphToDsl } from "../src/max/dsl-patch-graph.js";
import { diffPatchGraphs } from "../src/max/patch-graph.js";
import { DslPatchAdapter } from "../src/live/dsl-patch-adapter.js";
import { readFileSync } from "node:fs";
import { evaluateExpression } from "../src/dsl/expression.js";

const db = dbData as unknown as ObjectDatabase;
function output(source: string) {
  const parsed = parse(source);
  expect(parsed.errors).toEqual([]);
  const result = compile(parsed.ast, db);
  expect(result.errors).toEqual([]);
  return result.output!;
}
function graph(source: string) {
  const result = compileDslToPatchGraph(source, db, "ui");
  expect(result.errors).toEqual([]);
  return result.graph!;
}
function errors(source: string) {
  const parsed = parse(source);
  return [...parsed.errors, ...compile(parsed.ast, db).errors].map((e) => e.message).join("\n");
}

describe("UI template contracts", () => {
  it.each([8, 16])("keeps audio tester routing and safe startup for %i channels", (count) => {
    const source = readFileSync(new URL("../examples/audio-tester/audio-tester.maxdsl", import.meta.url), "utf8")
      .replace("const channels = 16", `const channels = ${count}`);
    const patch = output(source).patcher;
    const boxes = new Map(patch.boxes.map(({ box }) => [box.id, box]));
    const box = (name: string) => boxes.get(`obj-${name}`)!;
    const wired = (from: string, outlet: number, to: string, inlet: number) => patch.lines.some(({ patchline }) =>
      patchline.source[0] === `obj-${from}` && patchline.source[1] === outlet &&
      patchline.destination[0] === `obj-${to}` && patchline.destination[1] === inlet);
    expect(patch.openinpresentation).toBe(1);
    expect(patch.bglocked).toBe(1);
    expect(patch.bgcolor).toEqual([0.025, 0.025, 0.03, 1]);
    expect(box("output_default").text).toBe("loadmess 0");
    expect(wired("output_default", 0, "output_enabled", 0)).toBe(true);
    expect(box("source_default").text).toBe("loadmess 1");
    expect(box("source_gain_default").text).toBe("loadmess -20.");
    expect(box("output_dac").numinlets).toBe(16);
    expect(box("solo_states").text).toBe(`pak ${Array(16).fill(0).join(" ")}`);
    expect(patch.lines.filter(({ patchline }) => patchline.destination[0] === "obj-output_dac")).toHaveLength(count);
    for (let channel = 1; channel <= count; channel++) {
      const prefix = `channel_${channel}__`;
      expect(box(`${prefix}default`).text).toBe("loadmess -100.");
      expect(wired(`${prefix}default`, 0, `${prefix}db`, 0)).toBe(true);
      expect(wired(`${prefix}gate`, 0, "output_dac", channel - 1)).toBe(true);
      expect(box(`${prefix}solo_order`).text).toBe("t i i");
      expect(wired(`${prefix}solo_order`, 1, `${prefix}gate_state`, 0)).toBe(true);
      expect(wired(`${prefix}solo_order`, 0, "solo_states", channel - 1)).toBe(true);
      expect(wired("any_solo", 0, `${prefix}gate_state`, 2)).toBe(true);
      expect(box(`${prefix}solo`).text).toBe("Solo");
      expect(box(`${prefix}mute`).texton).toBe("Mute");
    }
    // Evaluate the emitted Max gate expression, including unused zero Solo inputs.
    const expression = box("channel_1__audible").text!.slice("expr ".length)
      .replace(/\$i([123])/g, "v$1");
    for (const selected of [[], [1], [1, count]]) {
      const solos = Array.from({ length: 16 }, (_, i) => Number(selected.includes(i + 1)));
      const anySolo = Number(solos.some(Boolean));
      for (let channel = 1; channel <= count; channel++) {
        for (const mute of [0, 1]) {
          const actual = evaluateExpression(expression, new Map([["v1", solos[channel - 1]], ["v2", mute], ["v3", anySolo]]));
          expect(actual).toBe(Number(mute === 0 && (selected.length === 0 || selected.includes(channel))));
        }
      }
    }
  });
  it("accepts adjacent opening braces in nested existing blocks", () => {
    const patch = output(`for i in 1..2{\n for j in 1..2{\n n_\${i}_\${j} = number\n }\n}`);
    expect(patch.patcher.boxes).toHaveLength(4);
    expect(output(`s = p sub{\n n = inlet\n}`).patcher.boxes[0].box.patcher!.boxes).toHaveLength(1);
  });
  it("round-trips literal using arguments without box attributes", () => {
    const patch = output(String.raw`router = route \using(real) \@literal`);
    expect(patch.patcher.boxes[0].box.text).toBe("route using(real) @literal");
    expect(output(decompile(patch, [], { includeBoxSize: true }))).toEqual(patch);
    const managed = graph(String.raw`router = route \using(real)`);
    expect(graph(patchGraphToDsl(managed)).revision).toBe(managed.revision);
  });
  it("stops nested expansion after an over-limit range", () => {
    const result = expandControlFlow(`for i in 1..5000 {\n for j in 1..5001 {\n }\n}`, { maxExpandedLines: 1, maxLoopIterations: 5000 });
    expect(result.errors).toHaveLength(1);
    expect(result.errors[0].message).toContain("exceeds 5000 iterations");
  });
  it.each([8, 16])("expands %i strips with stable IDs and independent origins", (count) => {
    const source = `
const count = ${count}
const gap = 70
style ui = @presentation 1 @fontname "Arial"
style role extends ui = @bgoncolor 1 0.6 0.1 1
template strip(index) {
  label = comment "Channel \${index}" using(ui) @presentation_rect 0 0 60 20 at(1, 2)
  solo = textbutton using(role) @text "Solo" @texton "Solo!" @presentation_rect 0 40 60 24 at(10, 50)
  solo -> label
}
for i in 1..count {
  use strip(i) as channel_\${i} at((i-1)*320, 500) present(24+(i-1)*gap, 145)
}`;
    const patch = output(source);
    expect(patch.patcher.boxes).toHaveLength(count * 2);
    const last = patch.patcher.boxes.at(-1)!.box;
    expect(last).toMatchObject({ id: `obj-channel_${count}__solo`, text: "Solo", texton: "Solo!", presentation: 1 });
    expect(last.patching_rect.slice(0, 2)).toEqual([(count - 1) * 320 + 10, 550]);
    expect(last.presentation_rect).toEqual([24 + (count - 1) * 70, 185, 60, 24]);
    const original = graph(source);
    expect(graph(patchGraphToDsl(original)).revision).toBe(original.revision);
    const next = graph(source.replace("const gap = 70", "const gap = 80"));
    expect(diffPatchGraphs(original, next).operations.every((op) => op.op !== "create" && op.op !== "delete")).toBe(true);
  });

  it("isolates nested instances and actual subpatcher coordinates", () => {
    const patch = output(`
template leaf() {
  n = number at(1, 2)
}
template group() {
  use leaf() as child at(10, 20)
  sub = p inner at(30, 40) {
    input = inlet at(5, 6)
    use leaf() as child at(7, 8)
    input -> child__n
  }
  child__n -> sub
}
use group() as outer at(100, 200)
use group() as second at(500, 600)
`);
    expect(patch.patcher.boxes[0].box.patching_rect.slice(0, 2)).toEqual([111, 222]);
    expect(patch.patcher.boxes[1].box.patcher!.boxes[0].box.patching_rect.slice(0, 2)).toEqual([5, 6]);
    expect(patch.patcher.boxes[1].box.patcher!.boxes[1].box.id).toBe("obj-child__n");
  });

  it("captures constants/styles, shadows parameters, and isolates block constants", () => {
    const patch = output(`
const value = 12
style ui = @fontsize \${value}
template strip(value) {
  n = number using(ui) @value \${value}
}
for value in 1..2 {
  const offset = value + 10
  use strip(offset) as strip_\${value}
}
n = number @value \${value}
`);
    expect(patch.patcher.boxes.map(({ box }) => box.value)).toEqual([11, 12, 12]);
    expect(patch.patcher.boxes[0].box.fontsize).toBe(12);
    expect(errors(`template t() {\n n = number using(later)\n}\nstyle later = @fontsize 12\nuse t() as x`)).toContain("Unknown style");
    expect(errors(`template t() {\n n = number @value \${i}\n}\nfor i in 1..2 {\n use t() as x_\${i}\n}`)).toContain("Undefined variable");
  });

  it("merges styles in order and preserves quoted and escaped syntax", () => {
    const patch = output(String.raw`
style base = @fontsize 10 @fontname "Arial"
style role extends base = @fontsize 11 @bgcolor 0 0 0 1
style large = @fontsize 14
template t() {
  # braces { are comments
  a = message "x using(s) @foo { } -> #" using(role, large) @fontsize 18 at(1, 2)
  b = route \@literal \using(real) using(base) at(3, 4)
}
use t() as x
`);
    expect(patch.patcher.boxes[0].box).toMatchObject({ text: "x using(s) @foo { } -> #", fontsize: 18, fontname: "Arial", bgcolor: [0, 0, 0, 1] });
    expect(patch.patcher.boxes[1].box.text).toBe("route @literal using(real)");
    expect(output(decompile(patch, [], { includeBoxSize: true }))).toEqual(patch);
  });

  it.each(["const", "template", "style", "use", "patcher", "patch", "if", "for"])("preserves the existing identifier %s", (name) => {
    const source = `${name} = button\nsink = button\n${name} -> sink`;
    const patch = output(source);
    patch.patcher.boxes[0].box.id = "obj-1";
    patch.patcher.boxes[0].box.varname = name;
    patch.patcher.lines[0].patchline.source[0] = "obj-1";
    const recovered = output(decompile(patch));
    expect(recovered.patcher.boxes[0].box.id).toBe(`obj-${name}`);
    const managed = graph(source);
    expect(graph(patchGraphToDsl(managed)).revision).toBe(managed.revision);
  });

  it.each([
    ["template t(x) {\n n = number\n}\nuse t() as a", "expects 1 arguments"],
    ["template t() {\n use t() as n\n}\nuse t() as a", "Recursive template"],
    ["template t() {\n n = number\n}\nuse t() as a at(1, 2)", "needs explicit at"],
    ["template t() {\n n = number\n n -> outside\n}\nuse t() as a", "cannot reference caller"],
    ["template t() {\n n = number\n}\nfor i in 1..2 {\n use t() as same\n}", "Duplicate template instance"],
    ["template t() {\n n = number\n}\na__n = number\nuse t() as a", "Duplicate name"],
    ["style bad = @text hello", "Style cannot set @text"],
    ["style bad = @varname identity", "Style cannot set @varname"],
    ["style bad = @__proto__ value", "Style cannot set @__proto__"],
    ["style s = @fontsize 12\na = number using(s) using(s)", "Invalid or duplicate"],
    ["style s = @fontsize 12\na = number using(s) argument", "Invalid or duplicate"],
    ["style s = @fontsize 12\na = number @value 1 using(s)", "must follow object text"],
    ["template t() {\n n = number @presentation_rect 0 0 -1 10\n}\nuse t() as a", "must be positive"],
    ["const n = 1\nconst n = 2", "Duplicate constant"],
    ["use missing() as a", "Unknown template"],
  ])("rejects invalid expansion: %s", (source, expected) => {
    expect(errors(source)).toContain(expected);
  });

  it("bounds nested empty expansions", () => {
    const result = expandControlFlow("for i in 1..100 {\n for j in 1..100 {\n }\n}", { maxExpandedLines: 10, maxLoopIterations: 100 });
    expect(result.errors.map((e) => e.message).join()).toContain("work budget");
  });
});

describe("root settings and native UI labels", () => {
  it("round-trips root appearance and both labels, rejecting root settings in live", () => {
    const source = `patcher @openinpresentation 1 @bglocked 1 @bgcolor 0.02 0.02 0.03 1 @editing_bgcolor 0 0 0 1 @locked_bgcolor 0 0 0 1 @default_fontname "Helvetica" @default_fontsize 14
solo = textbutton @mode 1 @text "Solo off" @texton "Solo on" at(1, 2, 61, 25)`;
    const patch = output(source);
    expect(patch.patcher).toMatchObject({ openinpresentation: 1, bglocked: 1 });
    expect(output(decompile(patch, [], { includeBoxSize: true }))).toEqual(patch);
    expect(compileDslToPatchGraph(source, db, "ui").errors[0].message).toContain("root patcher settings");
  });

  it.each([
    "patcher @boxes nope", "patcher @bgcolor 0 0 2 1", "patcher @openinpresentation 2",
    "patcher @default_fontsize -2", "patcher @default_fontname 123", "patcher @bglocked 1\npatcher @bglocked 0",
    "sub = p test {\n patcher @bglocked 1\n n = inlet\n}",
    "template t() {\n patcher @bglocked 1\n}\nuse t() as x",
    "n = number @text overwrite", "n = textbutton @text 1", "n = textbutton @text a b",
  ])("rejects unsafe settings: %s", (source) => expect(errors(source)).not.toBe(""));

  it("validates root settings on the public AST compiler too", () => {
    expect(compile({ type: "program", statements: [], patcherAttrs: { boxes: [1] } }, db).success).toBe(false);
  });

  it("changes a live textbutton label with set, retaining identity and connections", () => {
    const source = `solo = textbutton @text "Off" @texton "On"\nsink = number\nsolo -> sink`;
    const before = graph(source);
    const after = graph(source.replace('"Off"', '"Ready"'));
    const plan = diffPatchGraphs(before, after);
    expect(plan.operations).toHaveLength(1);
    expect(plan.operations[0]).toMatchObject({ op: "set", attribute: "text", value: "Ready" });
    const adapter = new DslPatchAdapter(db);
    const base = before.patcher.boxes[0];
    const resolved = adapter.resolveLiveBox({ varName: base.varName, maxclass: "textbutton", text: "Changed", patchingRect: base.patchingRect, attributes: {}, targetPath: [], runtimeId: "test-button", managed: true }, base);
    expect(resolved.text).toBe("Changed");
    expect(graph(adapter.serialize(after)).revision).toBe(after.revision);
  });
});
