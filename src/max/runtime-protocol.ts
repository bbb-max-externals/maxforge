import * as z from "zod/v4";

const name = z.string().min(1).max(256).refine((value) => !value.includes("\0"));
export const runtimeAtomSchema = z.union([
  z.number().finite().min(-Number.MAX_SAFE_INTEGER).max(Number.MAX_SAFE_INTEGER),
  z.string().max(1024).refine((value) => !value.includes("\0")),
]);
export const runtimeTargetSchema = z.strictObject({
  targetPath: z.array(name).max(31),
  runtimeId: name,
  varName: z.string().max(256).refine((value) => !value.includes("\0")),
  maxclass: name,
});
export const runtimeRequestSchema = z.strictObject({
  patcherId: name,
  scope: name,
  instanceId: name.describe("Exact lifetime ID from list_patches; reopen invalidates it"),
  expectedStructureToken: z.string().regex(/^[a-f0-9]{16}$/),
  target: runtimeTargetSchema.describe("Copy all fields from inspect_patch; no title or coordinate routing"),
  allowUnmanaged: z.boolean().default(false).describe("Only true for an explicitly user-selected unmanaged box; does not adopt it"),
});
export const runtimeMessageSchema = z.strictObject({
  selector: name.describe("An explicitly supported Max message, e.g. int, float, bang, list, set"),
  atoms: z.array(runtimeAtomSchema).max(256),
});
export const runtimeSendSchema = runtimeRequestSchema.extend({ message: runtimeMessageSchema });
export const runtimeStateSchema = z.discriminatedUnion("status", [
  z.object({ status: z.literal("available"), values: z.array(runtimeAtomSchema).max(16384) }),
  z.object({ status: z.literal("unavailable"), reason: z.string() }),
]);
export const runtimeResultSchema = z.object({
  type: z.literal("maxforge.runtime.result"),
  requestId: name,
  patcherId: name,
  scope: name,
  instanceId: name,
  operation: z.enum(["read", "send"]),
  target: runtimeTargetSchema,
  execution: z.literal("completed").describe("Native dispatch/read completed, not a guarantee of downstream or deferred output"),
  managed: z.boolean(),
  objectClass: name,
  supportedMessages: z.array(name),
  state: runtimeStateSchema,
});
export const runtimeFailureSchema = z.object({
  type: z.literal("maxforge.runtime.error"),
  requestId: name,
  patcherId: name,
  scope: name,
  code: name,
  message: z.string(),
  execution: z.enum(["not_executed", "unknown"]),
});
export type RuntimeRequest = z.input<typeof runtimeRequestSchema> & {
  readonly message?: z.input<typeof runtimeMessageSchema>;
};
export type RuntimeResult = z.output<typeof runtimeResultSchema>;
export type RuntimeFailure = z.output<typeof runtimeFailureSchema>;

export class RuntimeOperationError extends Error {
  constructor(
    readonly code: string,
    message: string,
    readonly execution: "not_executed" | "unknown",
    readonly requestId?: string,
  ) { super(message); }
}
