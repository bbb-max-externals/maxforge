import { existsSync, readFileSync } from "node:fs";
import { describe, expect, it } from "vitest";

function source(relativePath: string): string {
  return readFileSync(new URL(`../${relativePath}`, import.meta.url), "utf8");
}

function frontmatterField(markdown: string, field: string): string {
  const match = markdown.match(
    new RegExp(`^${field}:\\s*(.+)$`, "m")
  );
  if (!match) throw new Error(`missing ${field} frontmatter field`);
  return match[1].trim();
}

function yamlString(yaml: string, field: string): string {
  const match = yaml.match(
    new RegExp(`^\\s*${field}:\\s*["']([^"']+)["']\\s*$`, "m")
  );
  if (!match) throw new Error(`missing quoted ${field} field`);
  return match[1];
}

describe("agent skills", () => {
  for (const skillName of ["maxforge", "maxforge-live"]) {
    it(`${skillName} has valid invocation metadata`, () => {
      const markdown = source(`skills/${skillName}/SKILL.md`);
      const metadata = source(`skills/${skillName}/agents/openai.yaml`);

      expect(markdown).toMatch(/^---\n[\s\S]+?\n---\n/);
      expect(frontmatterField(markdown, "name")).toBe(skillName);
      expect(frontmatterField(markdown, "description").length).toBeGreaterThan(0);

      const shortDescription = yamlString(metadata, "short_description");
      expect(shortDescription.length).toBeGreaterThanOrEqual(25);
      expect(shortDescription.length).toBeLessThanOrEqual(64);
      expect(yamlString(metadata, "default_prompt")).toContain(`$${skillName}`);
    });
  }

  it("documents HTTP discovery instead of a separately installed server", () => {
    const skill = source("skills/maxforge-live/SKILL.md");
    expect(skill).toContain("GET /v1/tools");
    expect(skill).toContain("Authorization: Bearer");
    expect(skill).toContain("maxforge live services");
    expect(skill).not.toContain("--package=maxforge@");
  });

  it("ships setup references inside the independently installable live skill", () => {
    const root = new URL("../skills/maxforge-live/", import.meta.url);
    const markdown = readFileSync(new URL("SKILL.md", root), "utf8");
    const links = [...markdown.matchAll(/\[[^\]]+\]\(([^)]+)\)/g)]
      .map((match) => match[1])
      .filter((link) => !/^(?:[a-z]+:|#)/i.test(link));

    expect(links).toContain("references/setup.md");
    for (const link of links) {
      const target = new URL(link, root);
      expect(target.href.startsWith(root.href)).toBe(true);
      expect(readFileSync(target, "utf8").trim().length).toBeGreaterThan(0);
    }
    expect(existsSync(new URL("../skills/maxforge-mcp/SKILL.md", import.meta.url)))
      .toBe(false);
  });

  it("rejects known fabricated Max signal object names in agent guidance", () => {
    const guidance = [
      source("skills/maxforge/SKILL.md"),
      source("skills/maxforge-live/SKILL.md"),
    ].join("\n");

    expect(guidance).not.toMatch(/`(?:s~|r~)`/);
    expect(guidance).toContain("never invent `inlet~` or `outlet~`");
  });
});
