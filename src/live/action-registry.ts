import * as z from "zod/v4";

export interface ActionResult {
  content: Array<{ type: "text"; text: string }>;
  structuredContent?: Record<string, unknown>;
  isError?: boolean;
}

interface Definition {
  title: string;
  description: string;
  inputSchema: z.ZodType;
  outputSchema: z.ZodType;
  annotations: Record<string, boolean>;
}

/** Transport-independent, validated live actions. No client SDK or session state. */
export class ActionRegistry {
  private readonly actions = new Map<string, {
    definition: Definition;
    call: (input: unknown) => Promise<ActionResult>;
  }>();

  registerTool<Input extends z.ZodType>(
    name: string,
    definition: Omit<Definition, "inputSchema"> & { inputSchema: Input },
    handler: (input: z.output<Input>) => Promise<ActionResult>
  ): void {
    if (this.actions.has(name)) throw new Error(`Duplicate action: ${name}`);
    this.actions.set(name, {
      definition,
      call: async (input) => {
        const result = await handler(definition.inputSchema.parse(input));
        if (!result.isError) definition.outputSchema.parse(result.structuredContent);
        return result;
      },
    });
  }

  list() {
    return [...this.actions].map(([name, { definition }]) => ({
      ...definition,
      name,
      inputSchema: z.toJSONSchema(definition.inputSchema, { io: "input" }),
      outputSchema: z.toJSONSchema(definition.outputSchema),
    }));
  }

  async call(name: string, input: unknown): Promise<ActionResult> {
    const action = this.actions.get(name);
    if (!action) throw new Error(`Unknown action: ${name}`);
    return action.call(input);
  }
}
