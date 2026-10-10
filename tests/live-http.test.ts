import { afterEach, describe, expect, it, vi } from "vitest";
import { spawn, ChildProcessWithoutNullStreams } from "node:child_process";
import { mkdtemp, readFile, rm, stat, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import { once } from "node:events";
import { request } from "node:http";
import { startHttpServer } from "../src/live/http-server.js";
import { createMaxforgeRuntime } from "../src/live/runtime.js";
import { discoverServices } from "../src/live/discovery.js";

const cleanup: Array<() => Promise<unknown>> = [];
afterEach(async () => {
  vi.restoreAllMocks();
  for (const dispose of cleanup.splice(0).reverse()) await dispose();
});

describe("Max-owned HTTP service", () => {
  it("keeps discovery available to sandboxed clients but ignores dead/malformed records", async () => {
    const directory = await mkdtemp(join(tmpdir(), "maxforge-discovery-"));
    cleanup.push(() => rm(directory, { recursive: true, force: true }));
    const descriptor = { apiVersion: 1, maxPid: 123, pid: 124, port: 12345, token: "a".repeat(64), version: "test" };
    await writeFile(join(directory, "123.json"), JSON.stringify(descriptor));
    await writeFile(join(directory, "125.json"), "invalid");
    const probe = vi.spyOn(process, "kill").mockImplementation(() => {
      throw Object.assign(new Error("sandbox"), { code: "EPERM" });
    });
    expect(await discoverServices(directory)).toEqual([descriptor]);
    probe.mockImplementation(() => { throw Object.assign(new Error("dead"), { code: "ESRCH" }); });
    expect(await discoverServices(directory)).toEqual([]);
  });

  it("authenticates, exposes installed schemas, validates inputs and rejects browser/DNS requests", async () => {
    const token = "a".repeat(64);
    const runtime = await createMaxforgeRuntime({ MAXFORGE_WS_PORT: "0", MAXFORGE_STATE_FILE: "off" });
    cleanup.push(() => runtime.close());
    const http = await startHttpServer(runtime.actions, token);
    cleanup.push(() => http.close());
    const url = `http://127.0.0.1:${http.port}`;
    const headers = { Authorization: `Bearer ${token}`, "Content-Type": "application/json" };
    expect((await fetch(`${url}/v1/tools`)).status).toBe(401);
    expect((await fetch(`${url}/v1/tools`, { headers: { ...headers, Origin: "https://example.org" } })).status).toBe(403);
    const spoofedHostStatus = await new Promise<number | undefined>((resolveStatus, reject) => {
      const outgoing = request(`${url}/v1/tools`, { headers: { ...headers, Host: "example.org" } }, (response) => {
        response.resume();
        response.on("end", () => resolveStatus(response.statusCode));
      });
      outgoing.on("error", reject);
      outgoing.end();
    });
    expect(spoofedHostStatus).toBe(403);
    const tools = await (await fetch(`${url}/v1/tools`, { headers })).json() as {
      apiVersion: number; tools: Array<{ name: string; inputSchema: { type: string; required?: string[] } }>;
    };
    expect(tools.apiVersion).toBe(1);
    expect(tools.tools).toHaveLength(21);
    expect(tools.tools.every((tool: { inputSchema: { type: string } }) => tool.inputSchema.type === "object")).toBe(true);
    expect(tools.tools.find((tool) => tool.name === "maxforge_inspect_patch")?.inputSchema.required)
      .toEqual(["patcherId", "scope"]);
    expect(tools.tools.find((tool) => tool.name === "maxforge_get_working_source")?.inputSchema.required)
      .toEqual(["patcherId", "scope"]);
    const call = (action: string, body: string) => fetch(`${url}/v1/tools/${action}`, { method: "POST", headers, body });
    expect((await call("maxforge_help", "{")).status).toBe(400);
    expect((await call("maxforge_help", '{"topic":"invalid"}')).status).toBe(400);
    expect((await call("maxforge_unknown", "{}")).status).toBe(400);
    expect((await fetch(`${url}/missing`, { headers })).status).toBe(404);
    expect((await fetch(`${url}/v1/tools/maxforge_help`, { method: "POST", headers: { Authorization: headers.Authorization }, body: "{}" })).status).toBe(415);
    const result = await (await call("maxforge_list_patches", "{}")).json() as {
      isError?: boolean; structuredContent: { patches: unknown[] };
    };
    expect(result.isError).not.toBe(true);
    expect(result.structuredContent.patches).toEqual([]);
  });

  it("starts with no installed agent server, survives client disconnects, and exits on owner pipe EOF", async () => {
    const directory = await mkdtemp(join(tmpdir(), "maxforge-live-"));
    cleanup.push(() => rm(directory, { recursive: true, force: true }));
    const version = JSON.parse(await readFile("package.json", "utf8")).version;
    const executable = process.env.MAXFORGE_TEST_NODE ?? process.execPath;
    const child = spawn(executable, [resolve("dist/live/bin.js"), String(process.pid), version], {
      env: { ...process.env, MAXFORGE_SERVICE_DIR: directory }, stdio: "pipe",
    });
    cleanup.push(async () => {
      if (child.exitCode === null) { child.kill(); await once(child, "exit"); }
    });
    await ready(child);
    const services = await discoverServices(directory);
    expect(services).toHaveLength(1);
    const descriptor = services[0];
    expect(descriptor.pid).toBe(child.pid);
    if (process.platform !== "win32") expect((await stat(join(directory, `${process.pid}.json`))).mode & 0o777).toBe(0o600);
    const headers = { Authorization: `Bearer ${descriptor.token}`, Connection: "close" };
    for (let index = 0; index < 2; index++) {
      expect((await fetch(`http://127.0.0.1:${descriptor.port}/v1/tools`, { headers })).status).toBe(200);
    }
    const exit = once(child, "exit");
    child.stdin.end();
    expect((await exit)[0]).toBe(0);
    expect(await discoverServices(directory)).toEqual([]);
  });

  it("rejects mixed native/service packages before publishing an endpoint", async () => {
    const child = spawn(process.execPath, [resolve("dist/live/bin.js"), String(process.pid), "wrong-version"], { stdio: "pipe" });
    let output = "";
    child.stdout.on("data", (data) => { output += data; });
    expect((await once(child, "exit"))[0]).not.toBe(0);
    expect(output).not.toContain("MAXFORGE_READY");
  });
});

function ready(child: ChildProcessWithoutNullStreams): Promise<void> {
  return new Promise((resolveReady, reject) => {
    let output = "";
    let errors = "";
    const timeout = setTimeout(() => reject(new Error(`No readiness: ${errors}`)), 5000);
    child.stderr.on("data", (data) => { errors += data; });
    child.stdout.on("data", (data) => {
      output += data;
      if (/^MAXFORGE_READY \d+ \d+ [a-f0-9]{64}\n/.test(output)) { clearTimeout(timeout); resolveReady(); }
    });
    child.once("exit", () => { clearTimeout(timeout); reject(new Error(`Service exited: ${errors}`)); });
    child.once("error", (error) => { clearTimeout(timeout); reject(error); });
  });
}
