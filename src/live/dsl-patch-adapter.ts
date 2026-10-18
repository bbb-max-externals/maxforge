import { lookupObject } from "../core/object-db.js";
import type { CompileWarning, ObjectDatabase } from "../core/types.js";
import {
  compileDslToPatchGraph,
  patchGraphToDsl,
} from "../max/dsl-patch-graph.js";
import type { PatchBox, PatchGraph } from "../max/patch-graph.js";
import type { MaxforgeSnapshotBox } from "../max/patch-protocol.js";
import { resolveSnapshotAttributes } from "../max/patch-snapshot.js";
import type { PatchGraphAdapter } from "./patch-adapter.js";

export class DslPatchAdapter implements PatchGraphAdapter {
  private nonObjectClasses: ReadonlySet<string> | undefined;

  constructor(private database: ObjectDatabase) {}

  replaceDatabase(database: ObjectDatabase): void {
    this.database = database;
    this.nonObjectClasses = undefined;
  }

  isObjectBoxSnapshot(snapshot: MaxforgeSnapshotBox): boolean {
    if (snapshot.text === undefined) return false;
    // Max reports an object box under its object class (cycle~, plus~,
    // jpatcher), never under a UI, message, or comment box class.
    this.nonObjectClasses ??= new Set([
      "message",
      "comment",
      ...Object.values(this.database)
        .map((definition) => definition.maxclass)
        .filter((maxclass) => maxclass !== "newobj"),
    ]);
    return !this.nonObjectClasses.has(snapshot.maxclass);
  }

  compile(
    source: string,
    scope: string
  ): { graph: PatchGraph; warnings: readonly CompileWarning[] } {
    const result = compileDslToPatchGraph(source, this.database, scope);
    if (!result.success || !result.graph) {
      const diagnostics = result.errors.map((error) => {
        const location = error.line ? `Line ${error.line}: ` : "";
        return `${location}[${error.code}] ${error.message}`;
      });
      throw new Error(diagnostics.join("\n") || "DSL compilation failed");
    }
    return {
      graph: result.graph,
      warnings: result.warnings,
    };
  }

  serialize(graph: PatchGraph): string {
    const source = patchGraphToDsl(graph);
    const roundTrip = this.compile(source, graph.scope).graph;
    if (roundTrip.revision !== graph.revision) {
      throw new Error(
        `Managed graph ${graph.revision} cannot be represented losslessly as DSL; ` +
        `round-trip produced ${roundTrip.revision}`
      );
    }
    return source;
  }

  resolveLiveBox(
    snapshot: MaxforgeSnapshotBox,
    base: PatchBox,
    baseline?: MaxforgeSnapshotBox
  ): PatchBox {
    const resolved = !base.patcher &&
        base.maxclass === "newobj" &&
        snapshot.text
      ? lookupObject(snapshot.text, this.database, true)
      : null;
    return {
      ...base,
      varName: snapshot.varName,
      maxclass: resolved?.maxclass ?? base.maxclass,
      numinlets: resolved?.def.numinlets ?? base.numinlets,
      numoutlets: resolved?.def.numoutlets ?? base.numoutlets,
      outlettype: resolved?.def.outlettype ?? base.outlettype,
      patchingRect: snapshot.patchingRect,
      text: hasStructuralText(base.maxclass) ? snapshot.text : undefined,
      // Max exposes an empty inlet/outlet assist comment even when none was set.
      comment: snapshot.comment === "" && base.comment === undefined ? undefined : snapshot.comment,
      attributes: resolveSnapshotAttributes(snapshot, base, baseline),
    };
  }
}

function hasStructuralText(maxclass: string): boolean {
  return maxclass === "newobj" || maxclass === "message" || maxclass === "comment";
}
