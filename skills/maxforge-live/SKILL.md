---
name: maxforge-live
description: Set up maxforge, migrate from its old MCP integration, and inspect, edit, or operate live Max/MSP patches and UI values through local HTTP. Use maxforge for offline patch generation.
---

# Maxforge live

Install the complete Max package and create one `maxforge` object. Do not add
helper objects, configure MCP, launch a broker, or install a separate server.

## Setup and migration

For installation, updates, or migration from `maxforge-mcp`, read
[setup](references/setup.md). It covers installing the complete official Max
package and uninstalling the obsolete MCP skill. Run that workflow only when
setup or migration is requested; a missing connection alone is not permission
to replace software or remove skills. Ordinary live editing starts below.

## Discovery

Read `~/.maxforge/services/<Max PID>.json`. Select a live owner/helper; ask for
the target if several Max processes are plausible. The descriptor supplies API
version 1, HTTP port and bearer token. Never print or persist the token elsewhere.
Require a supported `apiVersion`, not a skill/package version match. If the
protocol is unsupported, stop and report it rather than guessing endpoints.
Call `http://127.0.0.1:<port>` with `Authorization: Bearer <token>`:

- `GET /v1/tools` discovers installed action schemas.
- `POST /v1/tools/<action>` sends an application/json object.

The optional CLI offers `maxforge live services`, `maxforge live tools --pid PID`,
and `maxforge live call ACTION 'JSON' --pid PID`. It does not need a matching npm
version. If discovery is empty, ask the user to create `maxforge`; do not start
the private helper manually.

## Editing

Discover schemas from `/v1/tools`. Require `maxforge_prepare_change`,
`maxforge_apply_prepared_change`, and `maxforge_get_working_source`. Call
`maxforge_help` with topic `workflow` when the contract is unfamiliar or tools
are missing. Read results from `structuredContent`; check `isError` even on
HTTP 200. Use help topic `recovery` after ambiguous failures.

Select patcherId/scope only from `maxforge_list_patches`. Require
versionCompatible: failure means a mixed Max package, not an outdated agent npm.
Inspect and pass the exact structure token. Never route by title or filename.

DSL is complete desired state: omitted managed objects are deleted. Send the
complete `desiredDsl` once to `maxforge_prepare_change`, or use retained
`baseSourceRef` plus `edits` for local changes. Line ranges are 1-based half-open
`[startLine, endLine)`, non-overlapping, relative to the original source; equal
boundaries insert. Read bounded snippets with `maxforge_get_working_source`
`detail: "matches"`; fetch `detail: "full"` only for broad rewrites or recovery.

Require `canApply: true`. Review counts, all deletes/disconnects, replacements,
warnings, and conflicts before sending only `receiptId` to
`maxforge_apply_prepared_change`. Receipts are process-local, expire, and are
consumed before native mutation: never retry one after a timeout or rejection.
Inspect the outcome first, then prepare a fresh receipt if appropriate.

Review human edit evidence without claiming it proves intent. The default
review is compact; request `detail: "full"` for exact before/after evidence.
Adopt accepted changes with the reviewed token, or prepare concrete next DSL
with `manualChanges: "merge"`; merge only after canApply=true. Retain returned
`sourceRef`. If `workingDslRequiredAsCurrent` is true, use that ref as
`currentSourceRef` for full-source preparation or `baseSourceRef` for edits.

Require acknowledgement.revision to equal targetRevision and statePersisted
to be true; check verification revision/counts when present. Missing baseline or
persistence warnings do not authorize replay: inspect first. Save explicitly.
Do not discard dirty patches, overwrite files, resolve ambiguous identities, or
erase history without user authority.

Use meaningful DSL names derived from function, routing, comments, and existing
vocabulary. A name becomes a managed varname and is structural identity:
renaming is not just relabeling. When extending an existing patch,
inspect the surrounding patch context before naming it.
Do not silently claim an unmanaged human-created box; preserve its ownership
unless the user explicitly authorizes adoption through the supported workflow.

## Runtime UI control

For values, clicks, bang, or selection, read [runtime UI](references/runtime-ui.md).
Use `maxforge_read_runtime` and `maxforge_send_message`, not a DSL edit or
attribute write. Require `runtime_ui_v1` in the selected patch's capabilities.
Copy `instanceId` from the list and the complete target identity plus structure
token from inspection. Read without output first; choose an explicitly supported
class/message. `set` is class-specific, not a universal silent operation.
Only set `allowUnmanaged` for a user-selected existing box; it does not adopt it.
Completion acknowledges native dispatch, not downstream or audio completion.
Never automatically retry an ambiguous send. Do not install an update merely
because the connected external lacks this capability.

## Constraints

One Max process shares one service/catalog. Optional @config on the first object
selects durable project state/history. Without config, state is scoped to the
current Max PID: retain full DSL for recovery after restarting Max. Helper
failure requires Max restart; never blindly retry a mutation timeout.

Confirm third-party definitions with maxforge_catalog; metadata does not prove
installation. Use send~/receive~ and never invent `inlet~` or `outlet~` for
subpatch signal I/O. Use API inspection/editing rather than screenshots, Max
JavaScript, node.script, or raw thispatcher commands for managed edits.
