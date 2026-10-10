import { readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";

function source(relativePath: string): string {
  return readFileSync(new URL(`../${relativePath}`, import.meta.url), "utf8");
}

describe("module boundaries", () => {
  it("keeps the canonical patch graph independent from DSL and live control", () => {
    const graph = source("src/max/patch-graph.ts");
    expect(graph).not.toMatch(/from "\.\.\/dsl\//);
    expect(graph).not.toMatch(/from "\.\.\/live\//);
    expect(graph).not.toContain("../core/compiler.js");
  });

  it("keeps reconciliation and persistence independent from the WebSocket bridge", () => {
    expect(source("src/live/reconcile.ts")).not.toContain("./bridge.js");
    expect(source("src/live/state-store.ts")).not.toContain("./bridge.js");
  });

  it("keeps services and HTTP actions independent from the concrete DSL adapter", () => {
    expect(source("src/live/service.ts")).not.toContain("./dsl-patch-adapter.js");
    expect(source("src/live/actions.ts")).not.toContain(
      "./dsl-patch-adapter.js"
    );
  });

  it("does not re-export patch-domain internals from the live entry point", () => {
    const liveIndex = source("src/live/index.ts");
    expect(liveIndex).not.toContain("../max/");
    expect(liveIndex).not.toContain("./dsl-patch-adapter.js");
  });
});
