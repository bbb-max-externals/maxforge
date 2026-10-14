import { describe, it, expect } from "vitest";
import { runtimeSendSchema, runtimeResultSchema } from "../src/max/runtime-protocol.js";

const request = { patcherId: "a", scope: "s", instanceId: "instance_a",
  expectedStructureToken: "0".repeat(16),
  target: { targetPath: [], runtimeId: "obj-1", varName: "human", maxclass: "number" },
  message: { selector: "set", atoms: [4] } };
describe("runtime wire schemas", () => {
  it("requires exact inspected identity and defaults unmanaged permission to false", () => {
    expect(runtimeSendSchema.parse(request).allowUnmanaged).toBe(false);
    for (const field of ["instanceId", "expectedStructureToken", "target"] as const) {
      expect(runtimeSendSchema.safeParse({ ...request, [field]: undefined }).success).toBe(false);
    }
    expect(runtimeSendSchema.safeParse({ ...request, inlet: 1 }).success).toBe(false);
  });
  it.each([NaN, Infinity, 1e30, {}, true, null, "embedded\0null"])("rejects invalid atom %s", (value) => {
    expect(runtimeSendSchema.safeParse({ ...request, message: { selector: "set", atoms: [value] } }).success).toBe(false);
  });
  it("bounds payloads and does not confuse unreadable state with zero", () => {
    expect(runtimeSendSchema.safeParse({ ...request, message: { selector: "list", atoms: Array(257).fill(0) } }).success).toBe(false);
    const base = { type: "maxforge.runtime.result", requestId: "r", patcherId: "a", scope: "s",
      instanceId: "instance_a", operation: "read", target: request.target,
      execution: "completed", managed: false, objectClass: "number", supportedMessages: ["set"] };
    expect(runtimeResultSchema.parse({ ...base, state: { status: "unavailable", reason: "No getter" } }).state.status).toBe("unavailable");
    expect(runtimeResultSchema.safeParse({ ...base, state: { status: "available" } }).success).toBe(false);
  });
});
