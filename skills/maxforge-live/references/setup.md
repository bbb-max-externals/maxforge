# Set up and migrate maxforge

Use this workflow when the user requests setup, installation, an update, or
migration. Installing this skill with `skills add` only installs instructions;
it does not execute this workflow or uninstall anything automatically.

## Establish the target

- Work on the machine running Max. The service is loopback-only; installing on
  a remote agent host does not grant access to another machine's Max.
- Identify the intended Max installation and user Packages directory. Require
  Max 9 with its bundled Node 20 or newer, on macOS or Windows. If Max is absent,
  ask the user to install/authorize it; do not install Max or accept its license.
- Inspect existing maxforge package locations and any registered HTTP service.
  A healthy current installation needs no replacement just because this skill
  has changed. Inspect the active project's search paths for conflicting copies
  when a wrong external is loaded; do not recursively scan the entire machine.
- Before replacing a package, have the user save their work and close Max.
  Never force-quit Max, discard patches, or overwrite an active development
  checkout. Preserve an existing package outside Max's search paths for rollback.

## Install the complete official package

1. Read release metadata from
   [bbb-max-externals/maxforge Releases](https://github.com/bbb-max-externals/maxforge/releases)
   (API: `https://api.github.com/repos/bbb-max-externals/maxforge/releases/latest`).
   Honor a user-selected release; otherwise select the latest published release.
   Record its tag and asset URLs. Do not invent a version or asset URL: archives
   may be named `maxforge.zip` or `maxforge-v<VERSION>.zip`.
2. Download the Max package ZIP and its matching `.sha256` asset from that same
   release into a fresh temporary directory. Verify the archive's SHA-256 against
   the supplied checksum before extraction. A mismatch or missing checksum is a
   blocker, not a reason to skip verification. This verifies integrity; the
   checksum is not independent proof of publisher identity.
3. Inspect archive entries for escaping paths before extracting. Preserve macOS
   bundle metadata and permissions (for example, use `ditto -x -k` on macOS).
   Locate the extracted package root containing `package-info.json`. Check:
   - macOS: `externals/maxforge.mxo` and its
     `Contents/Resources/service/dist/live/bin.js`.
   - Windows: `externals/maxforge.mxe64` and adjacent
     `externals/maxforge-service/dist/live/bin.js`.
   - The relevant service also contains `package.json`, `data/objects.json`, and
     production dependencies (`node_modules/ws` and `node_modules/zod`).
   If the release only contains `maxforge.sync` or lacks the bundled live service,
   stop and report that a new-format release is needed. Never substitute the old
   MCP setup or claim installation succeeded. Do not build from source unless
   the user requests a development build.
4. Verify the macOS bundle's signature with `codesign --verify --deep --strict`
   and its stapled notarization ticket with `xcrun stapler validate`. Report
   failures; do not strip quarantine, disable Gatekeeper, or re-sign a download.
5. Place the entire extracted package as `maxforge` inside the intended user's
   Max Packages directory. Defaults are `~/Documents/Max 9/Packages` on macOS
   and the user's Documents folder followed by `Max 9\Packages` on Windows.
   Resolve the actual Documents location on Windows (it may be redirected).
   Follow [Cycling '74 package installation](https://docs.cycling74.com/userguide/packages/).
   Replace an old package as a unit after backing it up; do not overlay new files
   onto an old package or keep backup externals inside a Max search path.

No separate npm maxforge package, system Node, broker, MCP server, or `node.script`
object is needed. Max provides Node; do not install or copy another runtime.

## Uninstall the obsolete MCP skill

As part of requested setup/migration, remove installed copies of the exact skill
`maxforge-mcp`. Keep `maxforge` (offline DSL) and `maxforge-live`.

1. Inventory both relevant project and user scopes, using `npx skills list` and
   `npx skills list -g` when the CLI is available. Inspect the active agent's
   skill locations too: manually installed copies may not be tracked. For Codex,
   check `.agents/skills`, legacy `.codex/skills`, and the configured user skill
   roots, including `~/.agents/skills` and `$CODEX_HOME/skills` (default
   `~/.codex/skills` when `CODEX_HOME` is unset).
   Use other agents' actual configured roots, not a list of guessed locations.
2. Read each candidate's `SKILL.md` and inspect symlinks to establish identity
   and scope. Preserve a copy of any files to be removed outside all skill
   discovery roots in a uniquely named backup directory. If provenance is
   ambiguous or the skill has user customizations, confirm how to preserve it
   before removal. Do not delete a source checkout through a symlink.
3. For CLI-managed installs, run the exact-name removal in the identified scope.
   A canonical `.agents/skills` copy can be shared by several agents. Explain
   that removing it affects those agents too; resolve migration scope first if
   only one agent was authorized. The following commands intentionally omit
   `--agent` to remove the obsolete skill and all its links in that scope (run
   only the applicable commands):

   ```sh
   npx skills remove maxforge-mcp
   npx skills remove maxforge-mcp --global
   ```

   An agent-filtered removal can report success while leaving the shared copy
   discoverable; its success message is not proof of removal. Never use `--all`,
   wildcards, or remove the entire repository's skills. For an unmanaged copy,
   move only the identified `maxforge-mcp` directory or link out of the discovery
   root; do not recursively delete its resolved target.
4. Re-list and check the relevant roots to verify the old skill is no longer
   discoverable and the new skill remains. Report the removed locations and
   recovery backup. If the agent still advertises the old skill in this session,
   start a new session; do not follow cached MCP instructions.

Skill removal does not remove MCP server configuration. Report any known old
maxforge launch entry separately; remove it only if MCP configuration cleanup
is authorized, preserving other servers. Do not mass-uninstall npm packages,
kill unrelated processes, or delete `~/.maxforge` state/history. Old patches
containing `maxforge.sync` require explicit patch migration, not bulk rewriting.

## Verify and finish

Have the user launch Max and create one `maxforge` object in the intended patch
(or do so if app interaction is authorized). No helper patch is required.
Return to the skill's Discovery section: require `apiVersion: 1`, fetch
`GET /v1/tools`, call `maxforge_help` with `topic: workflow`, and list patches.
Require a registered patch with `versionCompatible: true`; this compares the
native external and bundled service, not the installed skill's release version.

Report the release, package location, target patch ID/scope, and legacy-skill
cleanup outcome without the token. A file copy alone is not verified setup.
If Max cannot be launched or no patch is registered, report installation and
live verification separately. Do not mutate an existing patch just to prove
connectivity. If saving is disabled, do not claim save/reopen has been tested.
