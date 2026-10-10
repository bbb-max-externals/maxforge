import { homedir } from "node:os";
import { join } from "node:path";
import { readFile, readdir } from "node:fs/promises";
import * as z from "zod/v4";

export const serviceDescriptorSchema = z.object({
  apiVersion: z.literal(1),
  maxPid: z.number().int().positive(),
  pid: z.number().int().positive(),
  port: z.number().int().min(1).max(65535),
  token: z.string().regex(/^[a-f0-9]{64}$/),
  version: z.string(),
});
export type ServiceDescriptor = z.infer<typeof serviceDescriptorSchema>;
export function serviceDirectory(): string {
  return process.env.MAXFORGE_SERVICE_DIR ?? join(homedir(), ".maxforge", "services");
}

export async function discoverServices(directory = serviceDirectory()): Promise<ServiceDescriptor[]> {
  const names = await readdir(directory).catch((error: NodeJS.ErrnoException) => {
    if (error.code === "ENOENT") return [];
    throw error;
  });
  const services: ServiceDescriptor[] = [];
  for (const name of names.filter((name) => /^\d+\.json$/.test(name))) {
    try {
      const descriptor = serviceDescriptorSchema.parse(JSON.parse(await readFile(join(directory, name), "utf8")));
      checkProcess(descriptor.maxPid);
      checkProcess(descriptor.pid);
      services.push(descriptor);
    } catch { /* Ignore stale or incomplete discovery records. */ }
  }
  return services;
}

function checkProcess(pid: number): void {
  try { process.kill(pid, 0); }
  catch (error) {
    // Sandboxed clients may read discovery files but cannot probe other processes.
    // EPERM is not proof of a stale descriptor; the authenticated request decides.
    if ((error as NodeJS.ErrnoException).code !== "EPERM") throw error;
  }
}
