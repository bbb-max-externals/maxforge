import { randomBytes } from "node:crypto";
import { mkdir, writeFile, rename, unlink } from "node:fs/promises";
import { join } from "node:path";
import { createMaxforgeRuntime, packageVersion } from "./runtime.js";
import { startHttpServer } from "./http-server.js";
import { serviceDirectory, ServiceDescriptor } from "./discovery.js";

// Private entrypoint: the external owns stdin and therefore this process's lifetime.
const [parent, expectedVersion, configuration] = process.argv.slice(2);
if (Number(process.versions.node.split(".")[0]) < 20) {
  throw new Error("maxforge requires Max with Node 20 or newer; update Max");
}
const maxPid = Number(parent);
if (!Number.isInteger(maxPid) || maxPid <= 0 || maxPid !== process.ppid || expectedVersion !== await packageVersion()) {
  throw new Error("Invalid Max owner or mismatched bundled service; reinstall the complete package");
}
const directory = serviceDirectory();
await mkdir(directory, { recursive: true, mode: 0o700 });
const descriptorPath = join(directory, `${maxPid}.json`);
const token = randomBytes(32).toString("hex");
let closing = false;
let shutdown: (() => Promise<void>) | undefined;
const stop = () => {
  closing = true;
  if (shutdown) void shutdown();
};
process.stdin.on("end", stop);
process.stdin.on("error", stop);
process.stdin.resume();
process.on("SIGTERM", stop);
process.on("SIGINT", stop);
const runtime = await createMaxforgeRuntime({
  MAXFORGE_CONFIG: configuration || undefined,
  MAXFORGE_WS_HOST: "127.0.0.1",
  MAXFORGE_WS_PORT: "0",
  MAXFORGE_WS_TOKEN: token,
  // Stable within this Max session, including service restarts. Project configs
  // select durable project state/history through the existing runtime policy.
  ...(configuration ? {} : { MAXFORGE_STATE_FILE: join(directory, `${maxPid}-state.json`) }),
});
let http: Awaited<ReturnType<typeof startHttpServer>>;
try {
  http = await startHttpServer(runtime.actions, token);
} catch (error) {
  await runtime.close();
  throw error;
}
const descriptor: ServiceDescriptor = {
  apiVersion: 1, maxPid, pid: process.pid, port: http.port, token, version: runtime.version,
};
let stopped = false;
shutdown = async () => {
  if (stopped) return;
  stopped = true;
  await unlink(descriptorPath).catch(() => {});
  await Promise.all([http.close(), runtime.close()]);
  process.exit(0);
};
if (closing) await shutdown();
else {
  const temporary = `${descriptorPath}.${process.pid}.tmp`;
  await writeFile(temporary, JSON.stringify(descriptor), { mode: 0o600, flag: "wx" });
  await rename(temporary, descriptorPath);
  process.stdout.write(`MAXFORGE_READY ${runtime.bridge.getStatus().port} ${http.port} ${token}\n`);
}
