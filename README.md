# maxforge

> [!WARNING]
> This repository is published as AI-assisted, insufficiently tested work in progress ("AI slop"). Treat it as experimental. Correctness, stability, compatibility, and fitness for production use are not guaranteed.

[![npm version](https://img.shields.io/npm/v/maxforge.svg)](https://www.npmjs.com/package/maxforge)
[![Build Max package](https://github.com/bbb-max-externals/maxforge/actions/workflows/build-max-package.yml/badge.svg)](https://github.com/bbb-max-externals/maxforge/actions/workflows/build-max-package.yml)

[Website](https://2bit.jp/maxforge/) · [Documentation](https://2bit.jp/maxforge/docs/) · [npm](https://www.npmjs.com/package/maxforge) · [Max package releases](https://github.com/bbb-max-externals/maxforge/releases)

maxforge is an unofficial toolkit for describing Max patches as text. Its main
use case is generating repeated object and connection structures that are
tedious to build by hand.

It is not affiliated with, endorsed by, or sponsored by Cycling '74.

## What it provides

The offline toolchain can:

- compile `.maxdsl` text to `.maxpat` JSON;
- generate repeated structures with `for`, `if`, and numeric expressions;
- zip-connect consecutive outlet and inlet ranges with concise port mapping;
- validate objects and ports against built-in or project-supplied metadata;
- decompile supported `.maxpat` structure back to DSL; and
- emit Max clipboard text or a portable package directory.

The repository also contains an **experimental** live-control stack:

- `maxforge`, one native Max object per controlled patch; and
- an automatically started, bundled HTTP service using Max’s existing Node runtime shared by all
  objects in the same Max process.

The live stack is a managed desired-state system, not a general Max automation
API, Max undo replacement, or transaction engine.

## Quick start

Node.js 20 or newer is required for the npm tools.

```bash
npx maxforge@latest compile input.maxdsl -o output.maxpat
npx maxforge@latest validate input.maxdsl
```

A small repeated patch:

```maxdsl
patch "Oscillator bank"

for i in 0..7 {
  osc_${i} = cycle~ ${220 + i * 20}
  amp_${i} = *~ 0.125
  osc_${i} -> amp_${i}
}
```

Compile the included example:

```bash
npx maxforge@latest compile examples/voice_bank.maxdsl -o voice_bank.maxpat
```

The range is inclusive. Expansion is bounded; it is not an unrestricted
programming language. See the [DSL specification](docs/dsl-spec.md) for exact
syntax and limits.

## CLI

Common commands:

```bash
maxforge compile input.maxdsl -o output.maxpat
maxforge decompile input.maxpat -o output.maxdsl
maxforge validate input.maxdsl
maxforge catalog cycle~ --json
maxforge doctor --input input.maxdsl
maxforge bundle input.maxdsl -o my-package
```

Run `npx maxforge@latest --help` or read the [CLI guide](docs/cli.md) for all
commands and options. Third-party externals and abstractions require explicit
metadata; see [Object catalogs](docs/object-catalog.md).

## Live control

Install the complete Max package from
[GitHub Releases](https://github.com/bbb-max-externals/maxforge/releases), then
create one `maxforge` object. Nothing else needs to be placed or started.
The object automatically launches the bundled service; other patches share it.

Use a v0.6.0 or newer release: earlier packages contain the removed MCP external.
Download `maxforge-v<VERSION>.zip` and its matching `.sha256`, verify the checksum,
then extract the complete `maxforge` folder into your Max 9 `Packages` directory
(normally `Documents/Max 9/Packages`). Close Max before replacing a package and
keep any backup outside Max's search paths. Do not copy just the external binary:
the package includes its service but no separate Node runtime. Restart Max and
create `maxforge` to connect. An active Max license is needed to save patches.

Agents use the local HTTP API discovered from
`~/.maxforge/services/<Max PID>.json`. Node/npm installation and MCP configuration
are not required. An optional `maxforge live` CLI provides discovery and calls.
Read [live setup and API contracts](docs/live.md) before mutation.

This breaks compatibility: `maxforge.sync`, `maxforge-mcp`, and the old broker
are removed. Update the complete Max package and restart Max.

## Other integrations

- [`node.script` / `thispatcher`](docs/node-script.md) — command generation for
  flat patches; nested targets require Max-side routing.
- [AI agent guide](docs/agent-guide.md) — guidance for generating DSL and using
  managed live control.
- Agent-assisted live setup (Codex, available across projects):

  ```bash
  npx skills add bbb-max-externals/maxforge --skill maxforge-live --agent codex --global
  ```

  Then ask: `Use $maxforge-live to install the Max package, uninstall the old
  maxforge-mcp skill if present, and verify the connection.`
  The skill guides official package download, checksum verification, whole-package
  installation, and scoped legacy-skill removal. Installing the skill alone does
  not run setup or remove anything. See its [setup procedure](skills/maxforge-live/references/setup.md).

- Offline patch generation: install `--skill maxforge` instead. Omit `--global`
  for project-local installation, or choose another supported `--agent`.

Node/npm is needed for the `npx skills` installer, not for the live Max service.
For local development, use this checkout's absolute path instead of
`bbb-max-externals/maxforge`; GitHub installation only sees published commits.

## Documentation

| Topic | Document |
|---|---|
| DSL grammar, expansion, errors, and output | [docs/dsl-spec.md](docs/dsl-spec.md) |
| CLI commands and options | [docs/cli.md](docs/cli.md) |
| External and abstraction metadata | [docs/object-catalog.md](docs/object-catalog.md) |
| HTTP setup, actions, persistence, security, and recovery | [docs/live.md](docs/live.md) |
| Native managed-patch protocol | [docs/patch-sync.md](docs/patch-sync.md) |
| `node.script` integration | [docs/node-script.md](docs/node-script.md) |
| Module boundaries | [docs/architecture.md](docs/architecture.md) |
| Local development and testing | [docs/development.md](docs/development.md) |
| Release process | [docs/releasing.md](docs/releasing.md) |

## Current limits

- Decompilation reconstructs supported structure; it does not recover the
  original source text or every Max-specific field.
- Object metadata is a validation aid, not proof that an object is installed or
  behaves identically on every Max version.
- Auto-layout is basic and deterministic, not a replacement for manual visual
  design.
- Live control manages only its declared scope. It does not guarantee complete
  rollback of runtime state after a failed mutation.
- Local macOS builds are ad-hoc signed. Published versioned release archives
  are Developer ID signed and notarized by CI; do not redistribute a local
  build as if it were a release artifact.

The detailed documents state narrower limits for each subsystem. Those limits
are part of the contract, not optional caveats.

## Development

```bash
npm install
npm run build
npm test
```

See [docs/development.md](docs/development.md) for native builds, coverage,
package validation, website checks, and the repository map. Release tags are
created only as part of the versioned release procedure.

## License

MIT
