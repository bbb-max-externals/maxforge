---
name: maxforge-live
description: Set up maxforge, migrate from its old MCP integration, and inspect or edit live Max/MSP patches through local HTTP. Use maxforge for offline patch generation.
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

Call `maxforge_help` with topic `workflow` before mutation and discover schemas
from `/v1/tools`. Read complete results from `structuredContent`; check `isError`
even on HTTP 200. Use help topic `recovery` after ambiguous failures.

Select patcherId/scope only from `maxforge_list_patches`. Require
versionCompatible: failure means a mixed Max package, not an outdated agent npm.
Inspect and pass the exact structure token. Never route by title or filename.

DSL is complete desired state: omitted managed objects are deleted. Preview
nontrivial changes with `maxforge_compile_plan`. Review human edit evidence
without claiming it proves intent. Adopt accepted changes with the reviewed
token, or reconcile concrete next DSL; merge only after canApply=true.
Retain returned workingDsl as the next source.

Require acknowledgement.revision to equal targetRevision. Missing baseline or
persistence warnings do not authorize replay: inspect first. Save explicitly.
Do not discard dirty patches, overwrite files, resolve ambiguous identities, or
erase history without user authority.

## Constraints

One Max process shares one service/catalog. Optional @config on the first object
selects durable project state/history. Without config, state is scoped to the
current Max PID: retain full DSL for recovery after restarting Max. Helper
failure requires Max restart; never blindly retry a mutation timeout.

Confirm third-party definitions with maxforge_catalog; metadata does not prove
installation. Use send~/receive~ and never invent `inlet~` or `outlet~` for
subpatch signal I/O. Use API inspection/editing rather than screenshots, Max
JavaScript, node.script, or raw thispatcher commands for managed edits.
