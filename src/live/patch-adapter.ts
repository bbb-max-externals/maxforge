import type { CompileWarning } from "../core/types.js";
import type { PatchBox, PatchGraph } from "../max/patch-graph.js";
import type { MaxforgeSnapshotBox } from "../max/patch-protocol.js";

export interface PatchGraphAdapter {
  compile(
    source: string,
    scope: string
  ): { graph: PatchGraph; warnings: readonly CompileWarning[] };
  serialize(graph: PatchGraph): string;
  resolveLiveBox(
    snapshot: MaxforgeSnapshotBox,
    base: PatchBox,
    baseline?: MaxforgeSnapshotBox
  ): PatchBox;
  /**
   * Whether a live box is an object box (newobj). Message, comment, and UI
   * boxes can also carry text, so text alone is not evidence.
   */
  isObjectBoxSnapshot(snapshot: MaxforgeSnapshotBox): boolean;
}
