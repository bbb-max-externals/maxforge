#!/usr/bin/env node
import { cp, mkdir, readdir, rm } from "node:fs/promises";
import { execFileSync } from "node:child_process";
import { resolve } from "node:path";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL("..", import.meta.url));
const platform = process.argv[2] ?? process.platform;
if (!["darwin", "win32"].includes(platform)) throw new Error("Expected darwin or win32");
const destination = resolve(root, platform === "darwin"
  ? "externals/maxforge.mxo/Contents/Resources/service"
  : "externals/maxforge-service");
await mkdir(destination, { recursive: true });
if ((await readdir(destination)).some((name) => /^node(?:-|\.exe$)/.test(name))) {
  throw new Error("Unexpected bundled Node binary: use a clean build; maxforge must not ship Node");
}
for (const directory of ["dist", "data"]) {
  await rm(resolve(destination, directory), { recursive: true, force: true });
  await cp(resolve(root, directory), resolve(destination, directory), { recursive: true });
}
for (const name of ["package.json", "package-lock.json", "LICENSE"]) {
  await cp(resolve(root, name), resolve(destination, name));
}
execFileSync(process.platform === "win32" ? "npm.cmd" : "npm",
  ["ci", "--omit=dev", "--ignore-scripts", "--no-audit", "--no-fund"],
  { cwd: destination, stdio: "inherit", shell: process.platform === "win32" });
if (platform === "darwin") {
  execFileSync("codesign", ["--force", "--sign", "-", resolve(destination, "../../..")], { stdio: "inherit" });
}
console.log(`Bundled service in ${destination}; Node is provided by Max, not this package.`);
