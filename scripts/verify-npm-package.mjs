#!/usr/bin/env node
import { execFile } from "node:child_process";
import { mkdir, mkdtemp, readFile, rm, stat, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { isDeepStrictEqual, promisify } from "node:util";

const run = promisify(execFile);
const repository = resolve(fileURLToPath(new URL("..", import.meta.url)));
const temporary = await mkdtemp(join(tmpdir(), "maxforge-package-"));
try {
  const manifest = JSON.parse(await readFile(join(repository, "package.json"), "utf8"));
  const lock = JSON.parse(await readFile(join(repository, "package-lock.json"), "utf8"));
  if (lock.packages[""].version !== manifest.version || !isDeepStrictEqual(lock.packages[""].bin, manifest.bin)) {
    throw new Error("Lockfile version/bins differ from package.json");
  }
  if (Object.keys(manifest.bin).join() !== "maxforge" || manifest.exports["./mcp"]) {
    throw new Error("Legacy broker/MCP entrypoints must not be published");
  }
  const packDirectory = join(temporary, "pack");
  await mkdir(packDirectory);
  await writeFile(join(temporary, "package.json"), JSON.stringify({ private: true }));
  const { stdout } = await run("npm", ["pack", "--ignore-scripts", "--json", "--pack-destination", packDirectory], { cwd: repository });
  const packed = JSON.parse(stdout)[0];
  const files = new Set(packed.files.map(({ path }) => path));
  for (const path of ["dist/cli/index.js", "dist/live/bin.js", "skills/maxforge/SKILL.md", "skills/maxforge/agents/openai.yaml", "skills/maxforge-live/SKILL.md", "skills/maxforge-live/agents/openai.yaml", "skills/maxforge-live/references/setup.md"]) {
    if (!files.has(path)) throw new Error(`Missing npm artifact: ${path}`);
  }
  for (const path of files) {
    if (path.startsWith("dist/mcp/") || path.startsWith("skills/maxforge-mcp/") || /dist\/live\/(broker|server)/.test(path)) throw new Error(`Stale legacy artifact: ${path}`);
  }
  await run("npm", ["install", "--ignore-scripts", "--no-audit", "--no-fund", "--no-package-lock", join(packDirectory, packed.filename)], { cwd: temporary });
  const cli = join(temporary, "node_modules", ".bin", process.platform === "win32" ? "maxforge.cmd" : "maxforge");
  if (process.platform !== "win32" && ((await stat(cli)).mode & 0o111) === 0) throw new Error("CLI is not executable");
  const dsl = join(temporary, "smoke.maxdsl");
  await writeFile(dsl, 'patch "Package smoke" | "Installed CLI" | 320x240\nbtn = button\nout = print smoke\nbtn -> out\n');
  const validation = await run(cli, ["validate", dsl], { cwd: temporary });
  if (validation.stdout.trim() !== "Validation passed." || validation.stderr) throw new Error("Installed CLI validation failed");
  await run(process.execPath, ["--input-type=module", "--eval", [
    'const live = await import("maxforge/live");',
    'for (const name of ["MaxforgeWebSocketBridge", "MaxforgePatchService", "createMaxforgeActions"]) {',
    '  if (typeof live[name] !== "function") throw new Error(`Missing live export: ${name}`);',
    '}',
    'try { await import("maxforge/mcp"); throw new Error("Legacy export remains"); }',
    'catch (error) { if (error.code !== "ERR_PACKAGE_PATH_NOT_EXPORTED") throw error; }',
  ].join("\n")], { cwd: temporary });
  const discovery = await run(cli, ["live", "services"], { cwd: temporary, env: { ...process.env, MAXFORGE_SERVICE_DIR: join(temporary, "no-services") } });
  if (discovery.stdout.trim() !== "[]") throw new Error("Installed discovery CLI failed");
  console.log(`Verified installed maxforge npm package ${manifest.version}.`);
} finally {
  await rm(temporary, { recursive: true, force: true });
}
