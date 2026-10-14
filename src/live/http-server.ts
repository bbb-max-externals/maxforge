import { createServer, IncomingMessage } from "node:http";
import { timingSafeEqual } from "node:crypto";
import type { AddressInfo } from "node:net";
import type { ActionRegistry } from "./action-registry.js";
import { ActionInputError } from "./action-registry.js";

export async function startHttpServer(actions: ActionRegistry, token: string) {
  if (token.length < 32) throw new Error("HTTP service requires a strong token");
  let port = 0;
  const server = createServer(async (request, response) => {
    response.setHeader("Content-Type", "application/json; charset=utf-8");
    response.setHeader("Cache-Control", "no-store");
    const reply = (code: number, value: unknown) => {
      response.writeHead(code);
      response.end(JSON.stringify(value));
    };
    // No browser clients, DNS rebinding, CORS, or unauthenticated discovery.
    if (request.headers.origin || request.headers.host !== `127.0.0.1:${port}`) {
      reply(403, { error: "Local non-browser clients only" });
      return;
    }
    const credential = Buffer.from(request.headers.authorization ?? "");
    const expected = Buffer.from(`Bearer ${token}`);
    if (credential.length !== expected.length || !timingSafeEqual(credential, expected)) {
      reply(401, { error: "Unauthorized" });
      return;
    }
    try {
      if (request.method === "GET" && request.url === "/v1/tools") {
        reply(200, { apiVersion: 1, tools: actions.list() });
      } else if (request.method === "POST" && /^\/v1\/tools\/maxforge_[a-z_]+$/.test(request.url ?? "")) {
        if (request.headers["content-type"]?.split(";")[0] !== "application/json") {
          reply(415, { error: "Expected application/json" });
          return;
        }
        const result = await actions.call(request.url!.slice("/v1/tools/".length), await body(request));
        reply(200, result);
      } else reply(404, { error: "Unknown API route" });
    } catch (error) {
      reply(400, { error: error instanceof Error ? error.message : String(error),
        ...(error instanceof ActionInputError ? {
          code: "INVALID_ARGUMENT", execution: "not_executed", retrySafe: false,
        } : {}),
      });
    }
  });
  server.requestTimeout = 30_000;
  server.headersTimeout = 10_000;
  server.on("connection", (socket) => socket.setTimeout(30_000, () => socket.destroy()));
  await new Promise<void>((resolve, reject) => {
    server.once("error", reject);
    server.listen(0, "127.0.0.1", () => {
      server.off("error", reject);
      resolve();
    });
  });
  port = (server.address() as AddressInfo).port;
  return {
    port,
    close: () => new Promise<void>((resolve, reject) => {
      server.close((error) => error ? reject(error) : resolve());
      server.closeIdleConnections();
    }),
  };
}

async function body(request: IncomingMessage): Promise<unknown> {
  const chunks: Buffer[] = [];
  let length = 0;
  for await (const chunk of request) {
    length += chunk.length;
    if (length > 4 * 1024 * 1024) throw new Error("Request exceeds 4 MiB");
    chunks.push(chunk);
  }
  return JSON.parse(Buffer.concat(chunks).toString("utf8"));
}
