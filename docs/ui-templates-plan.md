# UI templates implementation plan

Status: core design agreed; implementation authorized by Claude's conditional
review after incorporating B1/B2 below (2026-11-17).
Branch: `codex/ui-templates`, base `c2521a4` (v0.6.3).

## Goal and acceptance gate

Generate the supplied 16-channel audio tester entirely from DSL: reusable channel
strips, independent patching/presentation placement, black theme, amber Solo and
red Mute state colors, both button labels, and Presentation startup. The same
strip definition must work for eight channels. Preserve the existing compiler,
semantic IDs, and managed graph editing behavior.

The user requires a Claude planning review before further implementation, then
a Claude implementation review after completion. Approximately 80% agreement
means agreement on the core contract below with **no unresolved correctness or
data-loss blocker**; minor wording/ergonomic suggestions may remain explicitly
deferred. It is not a numeric score that overrides a blocking finding.

There is already an uncommitted prototype in this worktree. It is not approved,
not fully tested, and is subject to replacement following review. Do not treat
its existence as a reason to accept its design. Codex owns implementation;
Claude reviews without editing the same files unless ownership is reassigned.

## Proposed contract

1. **Compile-time templates.** Root-only `template strip(index) { ... }` and
   `use strip(i) as channel_${i}` expand into ordinary boxes and connections.
   Numeric positional arguments only, exact arity, no eval/import/runtime.
   Constants are block scoped and captured at definition; loop variables must
   be passed explicitly. Template/style names occupy separate registries.
   Definitions must exist at invocation time; recursion and excessive depth
   fail. Numeric parameters can shadow captured constants, whereas a `const`
   cannot redefine a visible binding.
2. **Identity and scope.** Root objects become `instance__local`; nested template
   instances compose prefixes. Actual `p` subpatcher internals retain their own
   names and coordinates. Template connections cannot capture caller objects;
   callers connect explicitly to emitted IDs. Duplicate emitted IDs are errors,
   including alias/local-name delimiter collisions. Style and origin changes
   preserve IDs. Renaming or shrinking a loop may delete objects as today.
3. **Two coordinate systems.** Invocation `at(x,y)` and `present(x,y)` offset
   only root box patching positions and presentation rectangles respectively.
   Expressions use the existing bounded numeric expression evaluator. A nonzero
   patching origin requires explicit root positions; no implicit auto-layout
   grouping. `present` does not enable presentation or invent missing rects.
   Width/gap/padding use constants and interpolation. Finite arithmetic and
   positive rectangle dimensions are validated.
4. **Styles.** Root-only `style name [extends parent] = @attrs...`, combined via
   `using(base, role)` after object text/arguments, before attributes and `at`.
   Parent must already exist. Merge precedence: parent, child; then `using`
   left-to-right; then explicit attributes. No implicit selectors or child
   cascade. Preserve native Max `@style`. Reject structural keys and `varname`
   in style declarations, unknown styles, malformed/duplicate clauses. Parse
   syntax outside quotes and preserve escaped literal `@` atoms. Ordinary Max
   attribute support stays scalar/flat-array; do not claim full Max validation.
5. **Root patcher settings.** A single root `patcher @...` directive with a small
   allowlist: `openinpresentation`/`bglocked` 0 or 1; three background colors as
   four finite 0..1 values; nonempty font name and positive finite font size.
   Reject unknown/structural keys, nested/template directives, duplicates.
   Validate public AST compilation too, not just parsed source.
6. **Textbutton.** Add the real native class to the built-in catalog using Max
   bundled reference/help evidence. Allow direct `@text` only for textbutton
   with one string, retain `@texton`, and continue rejecting structural text
   overwrites on other classes. Preserve the off label in decompile, managed
   graph serialization, and snapshot reconciliation. Check native apply/set
   behavior before claiming live support; no native update merely for setup.
7. **Live boundary.** Templates/styles flatten before graph compilation and use
   existing operations. Protocol v1 has no root/window attributes: explicitly
   reject a `patcher` directive in plan/live compilation rather than dropping
   settings. Root backgrounds/startup are file-generation capabilities in this
   iteration. This is a deliberate scope limit requiring reviewer agreement.
8. **Round trip.** Decompile preserves expanded box/connection semantics,
   supported nondefault root settings, and both textbutton labels, not template
   source intent. Exact patching dimensions use `includeBoxSize: true`; CLI
   default stays unchanged. Nested/managed serialization must not synthesize
   forbidden root directives. Preserve authored DSL separately from adopted
   expanded source; do not promise source-level inverse compilation.
9. **Bounded failure.** Reuse line/loop bounds, add template call depth and total
   expansion-work bounds (including nested empty bodies). Fail with useful
   original declaration/invocation context where practical. Quotes, comments,
   braces, nested subpatchers, numeric/string distinctions, and prototype-like
   keys need explicit regression coverage. Do not introduce code execution.

Detailed draft syntax: [ui-templates.md](ui-templates.md).

## Implementation sequence after agreement

Mandatory review amendments:

- B1: Existing `IDENT = ...` and connection statements take precedence over new
  keyword statements. Exercise keyword names through both file and managed
  graph decompile/recompile; keywords are not globally reserved identifiers.
- B2: Use source-offset tokens, not quote-masking regular expressions, for
  rewriting. Object text outside the removed `using(...)` clause is unchanged.
  Braces inside quotes/comments do not affect nesting. `using(...)` is the
  final object-text suffix before attributes/position; literal newobj arguments
  use `\using(...)`, which decompile emits and parsing restores.
- Capture styles at template definition along with constants. Loop variables
  and template parameters explicitly shadow captured numeric constants.
  Diagnose duplicate instance aliases at their invocation within each patcher
  scope; nested template-local aliases remain isolated.
- B3: Verify textbutton label changes produce native `set text` operations,
  preserving ID/connections, with host evidence where available. If unsupported,
  reject that live mutation rather than silently recreating the box.
- Document that decompiling an existing nondefault root now emits `patcher`;
  remove that line deliberately for live-managed sources. Keep an external copy
  of authored templates before adoption in the live skill's workflow.
- For the eight-strip variant, test the Solo truth table with eight unused zero
  inputs. Document the example's 1..16 channel limit.

1. Finish expansion/scoping and quote-aware syntax handling, revising the
   prototype's text rewrite boundaries where necessary. Cover constants,
   templates, namespaces, placement, styles, malformed input and work bounds.
2. Finish root attribute AST/compiler/decompiler handling, textbutton catalog,
   and live text preservation. Test rejection boundaries and graph round trips.
3. Migrate the 16ch tester to `examples/audio-tester/`. Remove UI postprocessing
   and external-catalog workaround. Keep OUTPUT off and all gains -100 at
   startup; retain Solo trigger ordering, multiple Solo and Mute priority.
   Demonstrate eight instances from the same template. A fixed 16-output DAC
   and 16-input Solo aggregator may remain with unused channels silent for the
   8ch variation; document that explicitly rather than adding list syntax.
4. Update syntax/agent documentation and the relevant repository skill. Include
   the new guide in npm files and update exhaustive example/artifact manifests.
5. Run focused regressions, build, test type checking, full existing tests,
   catalog audit, documentation links and package checks appropriate to these
   changes. Test the generated Max patch in an available host without replacing
   the installed package. Distinguish visual/load evidence, control behavior,
   and physical 16-channel audio (not established by static tests).
6. Send final diff + evidence to Claude. Fix blockers and concrete regressions,
   rerun affected tests, then request follow-up review. Commit only the intended
   feature/docs/tests with an English subject and detailed body. Exclude local
   `.codex/` agmsg settings. No release or publication is part of this task.

## Minimum verification matrix

- Existing examples, parser/compiler snapshots, library and CLI regressions.
- 16 and 8 instances: unique IDs, expected ports/connections, independent
  coordinate origins, nested use and real-subpatcher isolation.
- Captured constants versus caller locals; recursion/arity/undefined names;
  duplicate definitions/IDs, malformed origins and expansion exhaustion.
- Style inheritance/order/explicit overrides; quoted labels containing syntax;
  literal escaped @; malformed/duplicate using; structural attributes blocked.
- Root allowed/invalid values, duplicate and nested directives, direct AST;
  file round trip and explicit plan/live rejection.
- Textbutton off/on labels, native metadata, managed graph serialize/recompile,
  snapshot adoption/reconciliation and planned text/style edits without ID churn.
- Generated example matches checked-in artifact; theme/presentation and safe
  startup assertions. Host checks recorded separately with actual limitations.

## Review log

- Initial plan submitted to Claude via agmsg; response 2026-11-17T13:55:49Z.
- Agreement: core direction AGREE; conditional start permitted after adding
  B1/B2 as invariants. Both incorporated above. B3 remains a completion gate.
- Implementation review: Claude APPROVE (over 80% agreement), 2026-11-17
  14:16 UTC. Independently ran all 488 then-current tests and both type checks;
  checked keyword compatibility, quoting, capture, aliases, nested origins,
  root rejection, textbutton labels and metadata. No concrete blocker.
- Independent code lane: APPROVE after fixing literal `\using` corruption,
  adjacent opening-brace compatibility and repeated over-limit range work.
  Architecture lane: WATCH for duplicated lexical handling; no remaining
  design blocker. Keep these regression cases before adding syntax.
- B3 limitation accepted by Claude as non-blocking with explicit documentation:
  native label mutation is unverified. The installed package symlink points to
  an old checkout without the external; the existing repository build contains
  native v0.6.3 metadata with a v0.6.2 service and refuses startup. No installed
  package or bundled binary/service was changed. Repair requires a separately
  authorized complete-package update with Max closed.
- Added 8/16-channel example checks for startup defaults, DAC routes, Solo
  trigger ordering and emitted gate truth table (none/one/multiple Solo,
  Mute priority, eight unused zero inputs). Physical audio is not tested.
- Max visually loaded the generated 16-channel patch in dark Presentation mode
  with pink source, -20 dB source level, -100 dB trims and OUTPUT off. Solo/Mute
  click behavior and on-state colors were not established by this visual check.
- npm pack/install smoke, catalog audit (320 entries, 179778 observations,
  zero errors/warnings), and Markdown links passed. See the final validation
  record below for counts after the additional example tests.

## Final validation (2026-11-17)

- Build and `typecheck:tests`: passed.
- Full suite: 29 files, 490 tests passed. Socket tests ran outside the
  filesystem/network sandbox because its loopback listen restriction causes
  EPERM; no test was skipped to obtain this result.
- UI/template suite: 48 tests passed, including both real example variants.
- `test:package`: packed, installed into a temporary project, verified template
  documentation/example artifacts, then validated and compiled the installed
  audio tester with the installed CLI.
- Catalog audit: 320 entries / 179778 observations, zero errors or warnings.
- Markdown links and whitespace checks: passed.
- Native label apply, Solo/Mute host interaction and physical audio remain
  unverified. No release, installation replacement or publication performed.
