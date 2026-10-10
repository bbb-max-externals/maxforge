import { execFile } from "node:child_process";
import { cp, mkdir, mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { promisify } from "node:util";
import { afterEach, describe, expect, it } from "vitest";

const execFileAsync = promisify(execFile);
const verifier = resolve("scripts/verify-max-package.py");
const temporaryDirectories: string[] = [];

afterEach(async () => {
  await Promise.all(temporaryDirectories.splice(0).map((path) =>
    rm(path, { recursive: true, force: true })
  ));
});

describe("Max package verifier", () => {
  it("accepts the checked-in package sources", async () => {
    await expect(execFileAsync("python3", [
      verifier,
      "--source",
      resolve("."),
    ])).resolves.toMatchObject({ stderr: "" });
  });

  it("rejects traversal in package-info filelist paths", async () => {
    const root = await sourceFixture();
    const packageInfoPath = join(root, "package-info.json");
    const packageInfo = JSON.parse(await readFile(packageInfoPath, "utf8"));
    packageInfo.filelist["../escape"] = {};
    await writeJson(packageInfoPath, packageInfo);

    await expect(execFileAsync("python3", [
      verifier,
      "--source",
      root,
    ])).rejects.toMatchObject({
      stderr: expect.stringContaining("unsafe filelist path"),
    });
  });

  it("rejects a help patch that does not instantiate maxforge", async () => {
    const root = await sourceFixture();
    const helpPath = join(root, "help", "maxforge.maxhelp");
    const help = JSON.parse(await readFile(helpPath, "utf8"));
    help.patcher.boxes = help.patcher.boxes.filter(
      ({ box }: { box: { text?: string } }) => box.text !== "maxforge"
    );
    await writeJson(helpPath, help);

    await expect(execFileAsync("python3", [
      verifier,
      "--source",
      root,
    ])).rejects.toMatchObject({
      stderr: expect.stringContaining("does not instantiate maxforge"),
    });
  });

  it("requires packaged helper assets and rejects bundled Node runtimes", async () => {
    const root = await sourceFixture();
    const write = async (relative: string, content: string | Buffer) => {
      await mkdir(dirname(join(root, relative)), { recursive: true });
      await writeFile(join(root, relative), content, { mode: 0o755 });
    };
    const version = JSON.parse(await readFile(join(root, "package.json"), "utf8")).version;
    await write("externals/maxforge.mxo/Contents/Info.plist", `<?xml version="1.0"?><plist version="1.0"><dict><key>CFBundleIdentifier</key><string>jp.2bit.maxforge</string><key>CFBundleShortVersionString</key><string>${version}</string></dict></plist>`);
    await write("externals/maxforge.mxo/Contents/MacOS/maxforge", Buffer.from([0xca, 0xfe, 0xba, 0xbe]));
    await write("externals/maxforge.mxe64", "MZfixture");
    const services = ["externals/maxforge.mxo/Contents/Resources/service", "externals/maxforge-service"];
    for (const service of services) {
      for (const file of ["package.json", "dist/live/bin.js", "dist/live/http-server.js", "data/objects.json", "node_modules/ws/package.json", "node_modules/zod/package.json"]) {
        await write(`${service}/${file}`, JSON.stringify({ version }));
      }
    }
    await expect(execFileAsync("python3", [verifier, "--package", root])).resolves.toMatchObject({ stderr: "" });
    await write(`${services[1]}/node.exe`, "not allowed");
    await expect(execFileAsync("python3", [verifier, "--package", root])).rejects.toMatchObject({ stderr: expect.stringContaining("Node runtime must be provided by Max") });
    await rm(join(root, services[1], "node.exe"));
    await rm(join(root, services[1], "dist/live/bin.js"));
    await expect(execFileAsync("python3", [verifier, "--package", root])).rejects.toMatchObject({ stderr: expect.stringContaining("missing required file") });
  });
});

async function sourceFixture(): Promise<string> {
  const root = await mkdtemp(join(tmpdir(), "maxforge-package-verifier-"));
  temporaryDirectories.push(root);
  for (const relative of [
    "package.json",
    "package-info.json",
    "README.md",
    "LICENSE",
    "help/maxforge.maxhelp",
    "help/managed_plan.json",
    "docs/maxforge.maxref.xml",
  ]) {
    const destination = join(root, relative);
    await mkdir(dirname(destination), { recursive: true });
    await cp(resolve(relative), destination);
  }
  return root;
}

async function writeJson(path: string, value: unknown): Promise<void> {
  await writeFile(path, `${JSON.stringify(value, null, 2)}\n`, "utf8");
}
