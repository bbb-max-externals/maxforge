# Single-object live service

Install the complete Max package and open `maxforge_live.maxpat`. Its sole object
is `maxforge`: it starts the package's service using Max's own Node runtime.
No MCP configuration, Node installation, controller patch, or port setting is needed.
Additional objects share the same service for this Max process.

For repository builds, run `npm ci`, `npm run build`, the CMake build, and
`node scripts/stage-service.mjs` before loading the external. Restart Max when
replacing a previously loaded native binary.

Use `maxforge live services`, then `maxforge live tools` to discover the installed
schemas. The CLI is optional; agents can call the authenticated local HTTP API
directly as described in [live service documentation](../../docs/live.md).

Call `maxforge_list_patches` and use the returned `patcherId` and `scope`, never a
window title. Inspect the target, preview the complete `desired.maxdsl` with
`maxforge_compile_plan`, review all operations, apply, and inspect again. Read
`maxforge_help` first for mutation, reconciliation, and recovery rules.

The example's default scope is `default`. The bridge object remains unmanaged;
only objects belonging to that scope can be changed by the desired DSL.
Use `maxforge_create_patch` to create another window containing one `maxforge`.
Closing the original window does not stop the shared service.
