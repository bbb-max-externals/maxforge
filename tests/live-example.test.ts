import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";
import dbData from "../data/objects.json" with { type: "json" };
import { compile } from "../src/core/compiler.js";
import { ObjectDatabase } from "../src/core/types.js";
import { parse } from "../src/dsl/parser.js";

const database = dbData as unknown as ObjectDatabase;

describe("Max-owned service example", () => {
  it("compiles to one self-contained maxforge object", () => {
    const source = readFileSync(
      new URL(
        "../examples/live/maxforge_live.maxdsl",
        import.meta.url
      ),
      "utf8"
    );
    const parsed = parse(source);
    const result = compile(parsed.ast, database);

    expect(parsed.errors).toEqual([]);
    expect(result.errors).toEqual([]);
    expect(result.success).toBe(true);

    const allBoxes = result.output!.patcher.boxes.map(({ box }) => box);
    const boxes = allBoxes.filter(box => box.maxclass !== "comment");
    expect(allBoxes.find(box => box.maxclass === "comment")?.text).toContain("maxforge_read_runtime");
    expect(boxes).toHaveLength(1);
    expect(result.output!.patcher.lines).toEqual([]);
    expect(boxes[0]).toMatchObject({
      text: "maxforge",
      numinlets: 1,
      numoutlets: 1,
    });
    expect(boxes[0]).not.toHaveProperty("host");
    expect(boxes[0]).not.toHaveProperty("controller");
  });
});
