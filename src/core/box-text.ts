// Plain quoted box text historically treats backslash-n as two characters.
// Mark JSON literals explicitly when control characters require escaping.
export function formatBoxText(value: string): string {
  const quoted = JSON.stringify(value);
  for (const character of value) {
    if (character.charCodeAt(0) < 32) return "json" + quoted;
  }
  return quoted;
}

export function parseBoxText(text: string): string {
  if (text.startsWith('json"')) return JSON.parse(text.slice(4)) as string;
  if (text.startsWith('"') && text.endsWith('"')) {
    return text.slice(1, -1).replace(/\\(["\\])/g, "$1");
  }
  return text;
}
