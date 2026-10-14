# Runtime UI control (API v1, runtime_ui_v1)

This capability is available from Max package v0.6.2. Discover it rather than
requiring the skill or optional CLI to have the same version. Supported messages
operate the **left inlet**; arbitrary native methods, attribute writes, scripts,
other inlets, scheduled batches, and outlet interception are not exposed.

## Route and execute

1. Discover `/v1/tools`; list patches and require `versionCompatible: true` and
   `runtime_ui_v1`. Retain `patcherId`, `scope`, and this lifetime's `instanceId`.
2. Inspect with `detail: "full"`. Copy `structureToken` and the selected box's
   `targetPath`, `runtimeId`, `varName`, and `maxclass`. Paths include named or
   unnamed subpatchers; names are not globally unique. Reopening invalidates the
   instance and runtime IDs. Do not route by title, filename, or coordinates.
3. Call `maxforge_read_runtime` with the following shape, replacing placeholders
   with the discovered values. All four target fields are required, including an
   empty `varName` or `targetPath` when that is what inspection returned.

   ```json
   {
     "patcherId": "COPY_FROM_LIST",
     "scope": "COPY_FROM_LIST",
     "instanceId": "COPY_FROM_LIST",
     "expectedStructureToken": "COPY_FROM_INSPECTION",
     "target": {
       "targetPath": [],
       "runtimeId": "COPY_FROM_INSPECTION",
       "varName": "COPY_FROM_INSPECTION",
       "maxclass": "COPY_FROM_INSPECTION"
     }
   }
   ```

4. Read `supportedMessages` and `state` from `structuredContent`. For a send,
   use `maxforge_send_message` with the same routing fields plus, for example,
   `"message": {"selector": "float", "atoms": [0.25]}`. A bang is
   `{"selector":"bang","atoms":[]}`. Check the class-specific table below.
5. Verify downstream state separately when the task depends on output. Runtime
   calls are serialized with other operations on that patch; wait for one call
   to complete before starting another on the same patch.

`allowUnmanaged` defaults to false. Set it true only for an explicitly selected
human-created target. It does not rename the object, adopt ownership, or change
the DSL. The runtime value itself does not update structural revision or token.
Downstream patch logic may still edit structure or produce audio, MIDI, file,
network, or other effects: authorize those effects before triggering it.

## Supported classes

The messages below are the API's deliberate subset, not every message Max accepts.
`int` takes one integral JSON number, `float` one finite JSON number; numerical
atoms must be within ±(2^53−1). At most 256 atoms; symbols at most 1024 characters
(native UTF-8 byte limit also applies). No NULs. Configured Max ranges, clipping,
rounding, change suppression, and mode behavior remain in effect.

| Class | Output/trigger messages | Silent value messages | State and limits |
|---|---|---|---|
| number, flonum | int, float, bang | set value | One value; number converts to integer |
| button, live.button | bang, int, float, nonempty list | None | Momentary trigger; state unavailable |
| toggle, live.toggle | int/float 0 or 1; bang flips | set 0/1 | One state; prefer explicit 0/1 |
| textbutton, live.text | bang, int/float 0/1; symbol matching text/texton in toggle mode | set 0/1, setsymbol matching label (toggle mode only) | One state; mode=0 momentary, mode=1 toggle |
| slider, dial, pictctrl | int, float, bang | set value | One value; configured range/mode applies |
| rslider | int, float, list low high, bang | set low high | Two values; only left inlet exposed |
| pictslider | int, float, list x y, bang | set x y | Two values; API requires a full pair for set/list |
| multislider | list values, bang | setlist values; set index value | Values list; index is **1-based**; list length must equal existing size (no resizing) |
| kslider | int/float note, bang | set note; clear | Native getter state, note in 0..127; clear can leave the last note value; velocity/right inlet not exposed |
| umenu, tab | int, float, bang | set index | 0-based selection; menu/tab contents are structural |
| radiogroup | int, list, bang | set | Radio: scalar index; checkbox (`itemtype=1, flagmode=0`): exact-size 0/1 list; flag mode: scalar mask |
| matrixctrl | list col row value triplets; bang; clear | set triplets | 0-based coordinates and integer values checked against dimensions/range; native sparse triplet state, `[0,0,0]` for empty; **clear emits** |
| message | bang | None | State unavailable; inspect structural text. Text substitution/editing not exposed |
| gain~ | int, float, bang | set value | Slider value; duplicate-value suppression can prevent output. Silent set still changes audio gain |
| incdec | inc, dec, bang | int, float, set value | One value; numeric input itself is silent |
| live.dial, live.slider, live.numbox | int, float, bang | set value | Host-domain value, not normalized 0..1 |
| live.menu, live.tab | int, float, bang | set index | Parameter enum's 0-based selection; requires configured items |
| live.gain~ | int, float, bang | set value | Gain parameter, not audio sample/meter state; set still changes audio |

`supportedMessages` lists class-level possibilities, not proof that every one
is valid in the current mode. Unsupported modes/messages and invalid shapes
are rejected without substitution. In momentary mode, `live.text` numeric zero
releases the button without output; use bang or 1 to trigger. Other classes (including attrui, textedit,
function, itable, swatch, preset, pict/image editors, meters, waveform~/Jitter
views, and other live.* classes) are outside this capability. Do not claim all
Max UI classes or arbitrary third-party externals are supported.

Read uses Max's side-effect-free `getvalueof`, never bang. Available values are
native getter atoms, not a universal UI serialization. An unsupported getter,
opaque/oversized state, or target removed during downstream execution yields
`state.status: "unavailable"` with a reason, not zero. State is bounded to 16384
atoms. Runtime state persistence remains the class's normal Max behavior;
maxforge does not turn every transient UI value into saved patch data.

## Acknowledgements and failures

- `execution: "completed"`: native main-thread dispatch/read finished. This is
  not merely an HTTP acceptance, nor a guarantee of deferred output, downstream
  delivery, audio completion, or saving.
- `execution: "not_executed"`: validation/routing rejected this request before
  dispatch. Codes include `INVALID_ARGUMENT`, `TARGET_NOT_FOUND`, `STALE_TARGET`,
  `STALE_STRUCTURE`, `UNMANAGED_TARGET`, `UNSUPPORTED_CLASS`,
  `UNSUPPORTED_MESSAGE`, `UNSUPPORTED_MODE`, and `RUNTIME_UNAVAILABLE`.
- `execution: "unknown"`: timeout, transport loss, or a dispatch failure that
  may already have caused effects. **Never blindly resend.** Re-list/inspect and
  read state, then decide on a fresh action. There is no exactly-once guarantee
  and no automatic retry. `requestId` correlates a call, not a replay key.

Check HTTP status and `isError`: native failures use a tool error's
`structuredContent`; input-schema errors use HTTP 400 with `code` and
`execution`. A client-side/network timeout is unknown even with no JSON reply.

## Verification scope

The reusable `scripts/runtime-ui-smoke.mjs` in the source repository checks
standard Max UI plus the listed live.* controls in standalone Max: actual outlet
counters, silent reads/sets, multiple patches, same-name nested boxes, managed
DSL no-op, error cases, and save/reopen. live.* fixtures configure parameters
and enum items. This does not verify Ableton Live automation, DSP/audio samples,
every UI mode, or Windows host behavior; native/TypeScript CI tests are separate.
