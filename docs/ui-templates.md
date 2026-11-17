# UI templates and styles

This is compile-time reuse, not a CSS engine or a constraint solver. Existing
object and connection syntax remains valid. No new Max objects or runtime are
required. The example in `examples/audio-tester/` builds without post-processing.

## Syntax and scope

```maxdsl
const channels = 16
const width = 61
const gap = 10
style ui = @fontname "Arial" @fontsize 12 @presentation 1
style solo extends ui = @bgoncolor 0.96 0.68 0.19 1

template strip(index) {
  label = comment "${index}" using(ui) @presentation_rect 0 0 61 22 at(0, 0)
  solo = textbutton using(solo) @mode 1 @text "Solo" @texton "Solo" @presentation_rect 0 40 61 25 at(0, 40)
}
for i in 1..channels {
  use strip(i) as channel_${i} at(24 + (i-1)*320, 500) present(24 + (i-1)*(width+gap), 145)
}
```

- `const name = expression` declares a numeric constant in the current block.
  Existing arithmetic/interpolation rules apply. Constants cannot redeclare a
  visible name; loop variables and template parameters shadow outer constants
  within their own scope.
- `template name(param, ...) { ... }` is a root-level definition. Arguments are
  positional finite numeric expressions with exact arity, no defaults or eval.
  A definition captures constants and styles at its declaration; caller loop variables
  must be passed explicitly. Define templates before invoking them. Definitions
  may call other templates that exist by invocation time; recursion is rejected.
- `use name(args) as semantic_name [at(x,y)] [present(x,y)]` emits ordinary
  objects/connections. Local names become `semantic_name__local_name`. Nested
  uses compose prefixes. Names inside an actual `p` subpatcher remain local to
  that subpatcher. Connect to emitted names outside a template; template wiring
  cannot implicitly capture caller objects. Duplicate instance aliases in one
  patcher scope are errors even if their templates emit no boxes.
- `at` and `present` offset explicit patching positions and presentation rects
  independently, in the current patcher only. A nonzero patching origin requires
  explicit positions on that template's root boxes. Subpatcher internals retain
  their own coordinates. Width, gap and padding are ordinary constants/arguments.
  `present` leaves boxes without a `presentation_rect` unchanged.
- `style name [extends parent] = @key values ...` defines a root-level named
  style. The parent must already exist. `using(a, b)` after object text and
  arguments (before attributes/position) combines styles left to right; explicit
  attributes always win. There are no selectors, implicit class matching or
  cascading into children. Max's existing `@style` remains a native attribute.
  Escape a literal unquoted Max argument as `\using(name)`; quoted text is
  preserved. Existing object/connection identifiers such as `style`, `use` and
  `patcher` remain valid.
- Styles can contain scalar/flat-array box attributes, not structural keys or
  identity (`varname`). `@text` is a narrow exception for `textbutton` on the
  object itself, not a style; `@texton` remains an ordinary attribute.
- Expansion uses the existing line/iteration budgets plus a template depth
  limit. Unknown names, duplicate definitions, invalid arguments, recursion,
  missing positions, unsafe attributes and duplicate emitted IDs are errors.

## Root settings and text

```maxdsl
patch "Audio tester" | "Safe startup" | 1200x600
patcher @openinpresentation 1 @bglocked 1 @bgcolor 0.025 0.025 0.03 1
```

One root `patcher` directive supports `openinpresentation`, `bglocked` (0/1),
`bgcolor`, `editing_bgcolor`, `locked_bgcolor` (four 0..1 components),
`default_fontname` (one string), and `default_fontsize` (positive number).
Structural root keys and unknown keys are rejected. It is not allowed inside
templates or subpatchers. Plan/live compilation rejects explicitly authored
root settings because protocol v1 manages boxes and connections, not the root
window. Omit the directive for a managed-only source; do not expect a plan to
set the window background or launch mode.
Decompiling a file with nondefault supported root settings now emits this
directive. Remove it deliberately before submitting that source to plan/live,
or use the library decompiler's `omitPatcherAttributes: true` option.

`textbutton @text "Off" @texton "On"` preserves both labels. `@text` still
cannot overwrite newobj/message/comment structural text. `textbutton` is in the
built-in catalog and needs no external declaration.
Label-change plans emit `set text` without replacing the box or its connections.
Planning and round trips are tested. A Max 9 host check of the development build
at `32c29ea` also verified changing both labels through two `set` operations:
no create/delete or replacement, unchanged runtime identity, matching applied
revision and snapshot labels, and no drift. This checks native state, not the
rendered labels or on-state colors; screenshots were not verified.

## Identity and round trips

Changing style values, origins or parameters that do not affect names keeps
semantic IDs stable. Changing instance/local names or loop counts can delete
objects; inspect plans normally. Layout and style changes become ordinary
attribute/geometry operations, not template runtime operations.

Decompile returns **expanded DSL**, never reconstructed templates, constants or
style intent. Supported root settings and textbutton labels are retained. Use
`includeBoxSize: true` in the library for exact non-default patching dimensions;
the CLI decompiler's existing position-only default is unchanged. Managed graph
serialization always includes dimensions. Adoption/merge can replace retained
template source with explicit DSL; keep authored source separately. Opaque Max
attributes and arbitrary native styles remain outside lossless DSL guarantees.

Subpatcher bodies are now expanded once, along with the surrounding source,
instead of running expansion again during recursive parsing. This preserves
definition-time bindings and avoids interpreting expanded literal text twice.
