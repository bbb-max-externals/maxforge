import { discoverServices } from "./discovery.js";

export async function liveCommand(args: string[]): Promise<void> {
  const argumentsCopy = [...args];
  const pidIndex = argumentsCopy.indexOf("--pid");
  const maxPid = pidIndex === -1 ? undefined : Number(argumentsCopy.splice(pidIndex, 2)[1]);
  if (maxPid !== undefined && (!Number.isInteger(maxPid) || maxPid <= 0)) throw new Error("Invalid --pid");
  const [command = "services", name, json] = argumentsCopy;
  const services = await discoverServices();
  if (command === "services") {
    console.log(JSON.stringify(services.map(({ token: _token, ...service }) => service), null, 2));
    return;
  }
  const candidates = services.filter((service) => maxPid === undefined || service.maxPid === maxPid);
  if (candidates.length !== 1) throw new Error("Select one running Max service with --pid; create a maxforge object first");
  const service = candidates[0];
  let path: string;
  let body: string | undefined;
  if (command === "tools") path = "/v1/tools";
  else if (command === "call" && /^maxforge_[a-z_]+$/.test(name ?? "")) {
    path = `/v1/tools/${name}`;
    body = JSON.stringify(JSON.parse(json ?? "{}"));
  } else throw new Error("Usage: maxforge live services|tools|call <action> <json> [--pid <Max PID>]");
  const response = await fetch(`http://127.0.0.1:${service.port}${path}`, {
    method: body ? "POST" : "GET",
    headers: { Authorization: `Bearer ${service.token}`, "Content-Type": "application/json" },
    body,
    signal: AbortSignal.timeout(60_000),
    redirect: "error",
  });
  const result = await response.json();
  console.log(JSON.stringify(result, null, 2));
  if (!response.ok || (result as { isError?: boolean }).isError) process.exitCode = 1;
}
