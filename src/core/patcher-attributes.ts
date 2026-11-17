import { AttrValue, PatcherJSON } from "./types.js";
import { formatAttr } from "./attributes.js";

export const PATCHER_ATTRIBUTE_DEFAULTS = {
  openinpresentation: 0, bglocked: 0, default_fontname: "Arial", default_fontsize: 12,
  bgcolor: undefined, editing_bgcolor: undefined, locked_bgcolor: undefined,
} as const;

export function validatePatcherAttributes(attrs: Record<string, AttrValue[]>): string[] {
  const errors: string[] = [];
  for (const [key, values] of Object.entries(attrs)) {
    let valid = false;
    if (key === "openinpresentation" || key === "bglocked") {
      valid = values.length === 1 && (values[0] === 0 || values[0] === 1);
    } else if (key === "default_fontname") {
      valid = values.length === 1 && typeof values[0] === "string" && values[0].length > 0;
    } else if (key === "default_fontsize") {
      valid = values.length === 1 && typeof values[0] === "number" && Number.isFinite(values[0]) && values[0] > 0;
    } else if (["bgcolor", "editing_bgcolor", "locked_bgcolor"].includes(key)) {
      valid = values.length === 4 && values.every((value) => typeof value === "number" && Number.isFinite(value) && value >= 0 && value <= 1);
    }
    if (!valid) errors.push(`Unsupported or invalid patcher attribute @${key}`);
  }
  return errors;
}

export function serializePatcherAttributes(patcher: PatcherJSON["patcher"]): string | undefined {
  const attributes: string[] = [];
  for (const key of Object.keys(PATCHER_ATTRIBUTE_DEFAULTS) as (keyof typeof PATCHER_ATTRIBUTE_DEFAULTS)[]) {
    const value = patcher[key];
    if (value === undefined || value === PATCHER_ATTRIBUTE_DEFAULTS[key]) continue;
    const values = Array.isArray(value) ? value : [value];
    if (validatePatcherAttributes({ [key]: values }).length === 0) attributes.push(formatAttr(key, value)!);
  }
  return attributes.length ? `patcher ${attributes.join(" ")}` : undefined;
}
