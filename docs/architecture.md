# Architecture

Max owns the live runtime. Agents are HTTP clients, not process owners.

```text
agent -- HTTP + bearer token --> bundled Node service
                                  | validation / DSL / diff / history
                                  | authenticated loopback WebSocket
                                  v
Max process: [maxforge] [maxforge] [maxforge]
                 shared native helper launcher
```

The launcher is a singleton inside the external. First deferred initialization
starts the helper; other objects share startup state. The Max-owned pipe—not
an individual patch—owns its lifetime. Native patch operations stay on Max's
main thread. Launch uses OS process APIs, not a shell, and resolves resources
relative to the loaded module.

| Layer | Source | Responsibility |
|---|---|---|
| Syntax/compiler | `src/dsl`, `src/core` | Offline parsing, catalogs, serialization |
| Patch domain | `src/max` | Canonical graph, diff, protocol, edit evidence |
| Application | `src/live/service.ts`, `reconcile.ts` | Desired state and conflicts |
| Persistence | `src/live/state-store.ts`, `edit-history-store.ts` | Recovery and writer lease |
| Actions | `src/live/actions.ts`, `action-registry.ts` | Validation and contracts |
| Runtime/API | `src/live/bin.ts`, `http-server.ts`, `runtime.ts` | Max-owned service |
| Client | `src/live/discovery.ts`, `client.ts` | Optional thin HTTP client |
| Native | `source/projects/maxforge` | Max APIs, observation, helper lifecycle |

Domain code is independent of DSL and transports. Services use patch-adapter
interfaces; runtime composes the concrete DSL adapter. HTTP actions do not own
graph logic. There is no MCP SDK, stdio frontend, broker, or legacy external.

The live deployment unit is the complete Max ZIP: binary, service, dependencies,
using Max’s Node executable. HTTP API compatibility is independent of package versions; the native
version check only detects a mixed installation.
