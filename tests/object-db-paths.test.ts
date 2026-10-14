import { execFile } from "node:child_process";
import { copyFile, mkdir, mkdtemp, readFile, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import { pathToFileURL } from "node:url";
import { promisify } from "node:util";
import { afterEach, describe, expect, it } from "vitest";

const execFileAsync = promisify(execFile);
const temporaryDirectories: string[] = [];

afterEach(async () => {
  await Promise.all(temporaryDirectories.splice(0).map((path) =>
    rm(path, { recursive: true, force: true })
  ));
});

describe("installed object database paths", () => {
  it.each([
    "Documents/Max 9/Packages/maxforge",
    "日本語/maxforge",
    "percent%20/maxforge",
    "hash#/maxforge",
    "日本語 Max 9 %20 #/maxforge",
  ])("loads the real catalog from %s", async (installationPath) => {
    const temporary = await mkdtemp(join(tmpdir(), "maxforge-object-db-"));
    temporaryDirectories.push(temporary);
    const root = join(temporary, installationPath);
    await mkdir(join(root, "dist/core"), { recursive: true });
    await mkdir(join(root, "data"), { recursive: true });
    for (const file of [
      "package.json",
      "dist/core/object-db.js",
      "dist/core/types.js",
      "data/objects.json",
    ]) {
      await copyFile(resolve(file), join(root, file));
    }

    // A fresh Node process tests the built module at its installed URL, without
    // the test runner's transforms or an already-populated database cache.
    const { stdout } = await execFileAsync(process.execPath, [
      "--input-type=module",
      "-e",
      `const { loadDatabase } = await import(process.argv[1]);
       const database = await loadDatabase();
       console.log(JSON.stringify({ database, cached: database === await loadDatabase() }));`,
      pathToFileURL(join(root, "dist/core/object-db.js")).href,
    ]);
    expect(JSON.parse(stdout)).toEqual({
      database: JSON.parse(await readFile(resolve("data/objects.json"), "utf8")),
      cached: true,
    });
  });
});
