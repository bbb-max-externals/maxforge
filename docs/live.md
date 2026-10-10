# Live control

Install the complete Max package in Max 9 (bundled Node 20 or newer), then create
**`maxforge`** in a patch.
The object starts the bundled service with Max’s own Node automatically. No MCP config,
npm installation, manual server launch, port selection, controller patch,
`node.script`, or routing objects are required.

This is a breaking replacement for `maxforge.sync`, `maxforge-mcp`, and the
project broker. They are removed, not aliases. Replace old objects and remove
old MCP launch configuration. Restart Max after replacing the complete package.

## Ownership and discovery

One helper process is shared by all objects in a Max process. Closing the first
patch does not stop the others. Even closing all patches leaves the helper alive
until Max exits. EOF on the parent-owned pipe shuts it down after normal exit or
a Max crash. A helper failure requires restarting Max; edits are never replayed.

Two automatically assigned loopback listeners serve agent HTTP and native WS.
Adding objects adds no listeners. Separate Max processes have separate services.
Discover them through `~/.maxforge/services/<Max PID>.json` (owner-only file).
Records contain `apiVersion`, `maxPid`, helper `pid`, HTTP `port`, `token`, and
package `version`. Ignore records whose owner/helper is dead; never publish tokens.
`MAXFORGE_SERVICE_DIR` overrides discovery for isolated development/tests.

The optional npm CLI does not start a server or need the same package version:

```sh
maxforge live services
maxforge live tools --pid 12345
maxforge live call maxforge_help '{"topic":"workflow"}' --pid 12345
maxforge live call maxforge_list_patches '{}' --pid 12345
```

Any HTTP client can read the descriptor and call the API; npm is not required.

## HTTP API

Use `http://127.0.0.1:<port>` and `Authorization: Bearer <token>` on every request.
Browser origins, other Host headers, CORS, redirects, and LAN access are unsupported.
Authentication does not protect against other programs running as the same user.

- `GET /v1/tools`: installed action names and input/output JSON Schemas.
- `POST /v1/tools/<action>`: JSON input, with `Content-Type: application/json`.

Results include full `structuredContent` and a compact `content` text summary.
Check `isError` even for HTTP 200. Bad requests return 400; authentication 401;
forbidden host/origin 403; unknown routes 404; wrong content type 415.
Bodies are limited to 4 MiB. A timeout is not evidence that mutation failed.

For patch discovery, call `POST /v1/tools/maxforge_list_patches` with `{}`.
Its `structuredContent.patches` array includes each connected patch's `patcherId`,
`scope`, `title`, `filename`, `filepath`, `revision`, and version compatibility.
Use the returned ID/scope for subsequent actions; duplicate live IDs are rejected.

## Safe mutation

1. Call `maxforge_help` (workflow), `maxforge_catalog`, then `maxforge_list_patches`.
2. Copy patcherId/scope from the list, never from a title. Require versionCompatible.
3. Inspect and review live edits. Preview complete desired DSL with compile_plan.
4. Apply with the exact inspected structure token. Omitted managed objects are deleted.
5. Verify acknowledgement and retain returned workingDsl. Save explicitly.

`versionCompatible` checks the native/helper pair in the installed package, not
the agent's npm version. Help topics `recovery` and `safety` cover reconciliation,
pending applies and history. Native mutation is guarded but not transactional.
If Max auto-resizes a text object, the actual rectangle can differ from the plan
and produce `baselineWarning`; inspect that difference before further mutation.

## Identity, configuration and persistence

Bare objects receive generated identities. Explicit `@patcher_id` and `@scope`
remain available. Saving persists attributes; copying a saved explicit ID also
copies its identity, so assign a distinct ID before using both copies.

Without config, desired-state storage is scoped to the current Max PID, not
guaranteed across Max restarts. Retain complete acknowledged DSL and provide
`currentDsl` when requested. Persistent edit history requires a project config.

The first object may use `maxforge @config /absolute/path/maxforge.config.json`
with a stable `project.id` for durable project state/history and custom catalogs.
All objects share this namespace. Later objects may omit config; conflicting
explicit config is rejected without stopping the shared service. Use another
Max process for another configuration. Reload catalog contents with
`maxforge_reload_catalog`; changing project.id requires a Max restart. Each
project history directory permits one writer.

## Development

Build TypeScript/native code, then run `node scripts/stage-service.mjs` to bundle
only service code and production dependencies. Node is resolved inside the running
Max application; no Node binary is shipped. Node 20.6.1 has been smoke-tested.
Users do not run this script. See
[development](development.md) and [releasing](releasing.md).
