# Preset JSON and repeated sound state in `.xy`

OP-XY firmware **1.1.21+0** imports a preset JSON document into live pattern
state, and later serializes that state into a project. **The project contains
copied binary sound state per pattern, not embedded copies of `patch.json`.**
The 48-byte preset identity is separate from the values and sample records.
Audio remains external. Loading a named preset, editing its sound and saving a
project therefore need not leave the project identical to the original JSON.

This reference is based on static analysis of the device-derived stock loader,
SHA-256 `acc409d12a73fcf69f17a63084af765c90fee802271c854b4d3eeb6b2c970f86`.
It distinguishes directly traced behavior, existing capture evidence, and
remaining unknowns. No new hardware load/save or audition was performed.

## Evidence and coverage

- [Import: validation, conversions, defaults and application](../logs/2026-10-23_preset_json_import.md).
- [Export: every field, condition and omitted region](../logs/2026-10-23_preset_json_export.md).
- [Filesystem: read, save, samples, cleanup, identity, move and delete](../logs/2026-10-23_preset_json_files.md).
- [Machine-readable export crosswalk](../../research/firmware-1.1.21/preset-export-schema.json):
  76 field paths and 20 sample-region rows, including engine-dependent variants.
- [Binary grammar and full byte partition](serialization.md),
  [native storage lifecycle](../logs/2026-10-23_firmware_storage.md), and
  [binary backward compatibility](backward_compatibility.md).

The trace covers all 58 sound parameter words, all 128 bytes of each of 24
sample records, engine/FX/LFO headers, preset identity, octave, tuning, both
48-byte suffix blocks, and state omitted from JSON. Coverage means every
transfer/omission was inspected; it does not assign a musical meaning to every
opaque byte or establish every downstream DSP behavior.

## The three representations

| Representation | Contains | What it does not establish |
|---|---|---|
| `.preset/patch.json` or supported standalone JSON | Engine and parameter descriptions, sample-region references, optional tuning, track octave | Complete binary pattern state or embedded audio |
| Runtime pattern after applying JSON | Resolved engine/page IDs, defaulted parameters, sample records and preset identity | Byte identity with either the input JSON or a later file |
| Native `.xy` project | Serialized state for every stored pattern, sequence/automation data, global state and songs | Availability of referenced audio, or identity with a fresh load of the named preset |

The same sound can repeat across patterns and tracks because each pattern has
its own serialized parameter and sample blocks. A path/name match is not a
content hash. Compare actual raw state when determining whether two patterns
share the same sound; compare sample contents separately when audio identity
matters. Octave is track-global and is the exception to pattern-local preset
state in this JSON representation.

JSON export is selective and lossy: it truncates parameter words, quantizes
enums, omits some state and compacts empty sample slots. JSON import applies
defaults and normalization. Neither direction is a lossless binary round trip.

## Acceptance, schema versions and property names

The importer requires a string `type` resolving to a registered engine, an
exact string `platform: "OP-XY"`, and a `version` convertible to an integer
**at least 3**. The inspected validator has no upper version bound. The exporter
writes **version 4**. This does not promise support for the semantics of future
schema versions: unknown properties are not generally rejected or preserved
through export.

These version numbers are unrelated to OS **1.1.21** and native binary format
**9.19**. Binary compatibility uses exact reader dispatch and sequential
migrations; preset JSON uses property defaults/aliases and a minimum version
check. Do not upgrade either format by relabeling its version.

Property names and type strings are case-sensitive. For example:

```json
{
  "type": "sampler",
  "platform": "OP-XY",
  "version": 4,
  "engine": {
    "portamento.amount": 0,
    "modulation": {"modwheel": {"target": 0, "amount": 16383}}
  }
}
```

`portamento.amount` is one literal key; `modulation` and `modwheel` are nested
objects. This example illustrates shape, not a complete playable preset.
The parser accepts comments, allows scalar roots, replaces earlier duplicate
object keys with later values, and does not require EOF after the first parsed
value in this entry path. Null or an object lacking required properties is rejected; other non-object
roots and malformed nested containers can reach assertions. Numeric tokens `12` and `12.0` have different types and
can produce different parameter values. Malformed nested inputs can reach
assertions; this is not a strict schema validation service. Exact parser
entry points and qualifications are in the import report.

Engine registrations: sampler=2, drum=3, organ=6, epiano=7, prism=18,
hardsync=19, dissolve=20, axis=22, midi=29, multisampler=30, wavetable=31,
simple=32. `external` is an import alias for `midi`. Registered internal names
do not imply that every type is offered by the stock preset UI.

## All 58 parameter words

For zero-based parameter index `i`, runtime address is `pattern+0x3864+4*i`;
serialized address is `origin+0x3857+4*i`. `origin` means actual pattern body
start minus one, including for clones; only the group leader has a real count
byte there. All stored words are little-endian 32-bit values.

| IDs | JSON property | Import/export details |
|---|---|---|
| 0–7 | `engine.params[0..7]` | Application resets all eight to `0x40000000` for raw type sampler/drum/multisampler |
| 8–11 | `envelope.amp` attack/decay/sustain/release | Also MIDI CC values 0–3 |
| 12 | `engine.playmode` | poly / mono / legato; MIDI CC number 0 instead |
| 13–15 | `engine.portamento.amount`, `bendrange`, `volume` | MIDI CC numbers 1–3 instead |
| 16–23 | `fx.params[0..7]` | Also MIDI values 4–7 / CC numbers 4–7; non-MIDI application preserves existing ID21 |
| 24–31 | `lfo.params[0..7]` | Eight fixed-position values |
| 32–35 | `envelope.filter` attack/decay/sustain/release | Distinct from root `fx` |
| 36–37 | No JSON property | Zeroed on import; omitted on export |
| 38–39 | No JSON property | Forced to half on import/apply; omitted on export |
| 40–41 | No JSON property; track pan / track volume | Default half / `0x60000000`; preserved when apply-mixer flag is false; omitted on export |
| 42–43 | `engine.modulation.modwheel` target/amount | See presence-sensitive defaults below |
| 44–45 | `engine.modulation.aftertouch` target/amount | Same |
| 46–47 | `engine.modulation.pitchbend` target/amount | Same |
| 48–51 | `engine.velocity.sensitivity`, `portamento.type`, `tuning.scale`, `width` | Ordinary Q31 conversion |
| 52 | `engine.transpose` | Special -36..36 quantization; **not pan** |
| 53–54 | `engine.tuning.root`, `highpass` | Ordinary Q31 conversion |
| 55–56 | `engine.modulation.velocity` target/amount | Presence-sensitive defaults |
| 57 | No JSON property | Zeroed on import; omitted on export |

Ordinary export uses signed `raw >> 16` after asserting all 58 words are
nonnegative. Import accepts null, integer and boolean tags, shifts the integer
left 16 with 32-bit wrap, then takes the signed maximum with zero. Float/string
values give zero. This is not a clamp to 32767: integer 32768 becomes zero,
65537 becomes `0x00010000`, `true` becomes `0x00010000`, and float `12.0`
becomes zero. Preserve raw words when low-bit equality matters.

Playmode imports poly=`15555555`, mono=`3fffffff`, legato=`6aaaaaa9`; unknown
strings fall back to poly, missing/nonstring to zero. Export quantizes
`((raw >> 8)*3)>>23` into those three names. Transpose imports signed integers
clamped to -36..36 with `(n+36)*29417584+14708792`; export computes
`(((raw >> 8)*73)>>23)-36`. Missing transpose inside a present engine object
produces `3ffffff8`; a wholly absent engine leaves ID52 zero.

Parsing clears the staging bank before assigning properties. Modulation amounts
43/45/47/56 start at half; absent routes keep that default, while a present
route with no amount writes zero. Full application copies the bank with the
ID21 and mixer exceptions above. Thus missing fields do not mean “keep the
previous patch.” Import is not a partial parameter-edit API.

The MIDI alternative is **`engine.cc[0..7]` in both directions**, with per-entry
`cc` and `val` keys. These reuse envelope/FX words; there is no separate bank.
CC-number export uses `(((raw >> 8)*129)>>23)-1`; its import and the value
conversion use dedicated arithmetic helpers. Exact target signed bit extraction
for exported values at word boundaries remains qualified in the export report.

## Engine, FX, LFO and configuration headers

| Virtual wire offset | Width | Meaning |
|---|---:|---|
| `0x13` | 1 | Preserved byte absent from JSON export |
| `0x14` | 4 | Engine ID; JSON `type` resolves a name |
| `0x18` | 4 | Preserved word absent from JSON export |
| `0x1c`, `0x20` | 4, 1 | LFO ID and active byte |
| `0x21`, `0x25` | 4, 1 | Filter/JSON `fx` ID and active byte |
| `0x26..0x24d` | 552 | Configuration absent from JSON export |

`fx` resolves through **`filter_types`**, not the separately named `fx_types`
registry. Confirmed names include z lowpass=9, svf=10, ladder=16, z hipass=17.
Import aliases squeal→svf, body→ladder, zfilter→z lowpass; absent/invalid FX
defaults to type10/inactive. LFO registrations include tremolo=0, value=1,
random=2, element=3, duck=6 and internal placeholder names for 4/5;
absent/invalid LFO defaults to type1/inactive. Boolean conversion is broader
than Python's “actual JSON bool only” policy; consult the import report.

Export does **not** force `fx.params[5]` to max. The importer preserves that
existing word for non-MIDI engines, which explains why a baseline's max value
can persist through paired preset loads. A capture invariant is not an
unconditional serialization rule.

## All sample-region bytes

Sample slot `s` is runtime `0x394c+128*s`, wire `0x393f+128*s`, for `s=0..23`.
Full import clears all 3,072 bytes and processes up to 24 JSON regions in
**array order**. `hikey` does not select the slot. Missing regions leave zeroed
records. Export visits slots in order for sampler/drum/multisampler, skips
empty paths, and emits an empty regions array for other engines.

| Slot offset | Stored field | JSON mapping / defaults |
|---|---|---|
| `00` u32 | Frame count | `framecount`, default0 |
| `04` u32 | Sample start | `sample.start`, default0; omitted on export when zero |
| `08` u32 | Sample end | `sample.end`, missing=`ffffffff`; omitted at that sentinel |
| `0c` u32 | Loop start | `loop.start`, default0 |
| `10` u32 | Loop end | `loop.end`, missing=`ffffffff` |
| `14` u32 | Shared fade/crossfade word | Drum selected fade or normalized sampler crossfade |
| `18` u8 | Root/keycenter | `pitch.keycenter`; drum adds `transpose` |
| `19` u8 | Unnamed byte | Cleared by import; absent from export |
| `1a` u8 | High key | `hikey`; not an array index |
| `1b` u8 | Mode/flags | Low six bits mode; bit6 loop-disabled; bit7 release/fade direction |
| `1c` i8 | Fine tune raw byte | `tune`, independent of transpose |
| `1d` i8 | Gain raw byte | `gain`; omitted on export when zero; **not a u32** |
| `1e` i8 | Pan raw byte | Drum `pan`; zeroed/omitted for sampler |
| `1f` u8 | Reverse | `reverse` |
| `20..7f` | 96-byte path | `sample`; importer keeps at most95 bytes plus NUL |

Integer byte fields retain low eight bits rather than clamping to UI ranges.
Missing keycenter is zero in this importer, not an assumed MIDI note60.
Drum export emits keycenter60 plus transpose=`stored_root-60`, and independently
exports signed `tune`. No `lokey` is emitted or stored by this traced path.

Drum playmode strings map gate=0, oneshot=1, group=2, loop=3; missing,
nonstring and unknown strings use1 (`key` therefore also ends up at1).
The shared fade word is `max(fade.in,fade.out,0)`; bit7 is `fade.in < fade.out`.
Equal fades choose the fade-in direction. Export emits the selected direction's
word and zero for the other; both original fades cannot be recovered.

Sampler import derives the crossfade word from integer `loop.crossfade`,
floating-point scaling by `2^31/framecount`, and nonnegative conversion. Zero
framecount produces zero; `sample.end` is not a fallback denominator. Exact ROM
rounding/overflow behavior is not fully recovered. Export uses a target
fractional multiply with framecount; host float arithmetic is not proven
equivalent at every boundary. `loop.enabled: false` sets bit6; `loop.onrelease`
sets bit7. Export omits loop.enabled when enabled and emits false when disabled.

The former “pre-table header / previous voice” boundary interpretation arose
from starting each record 24 bytes too late at `0x3957`. The actual record
starts at `0x393f`; `0x3957` is its keycenter byte. This is why gain, boundaries,
fade and transpose must be interpreted relative to the complete record.

## Octave, tuning, identity and omitted state

- `octave` reads the signed global byte `0x3d + zero_based_track`. Import
  defaults to zero and clamps to -4..4. It is shared by a track's patterns.
- Twelve tuning words live in the first 48 bytes after the four controller
  vectors: `pattern.end-96`, runtime `0x5394`. Import clears them, then fills
  twelve values only when the supplied tuning length is twelve. Export omits
  `engine.tuning` if all raw words are zero; otherwise it emits twelve floats.
  Packed pitch uses signed upper16 and a hundredths component, not Q31.
  Export uses the low8 fraction; exact negative/boundary import rounding calls
  external ROM and remains unresolved.
- Preset identity occupies wire `0x453f..0x456e`, runtime `0x454c`, 48 bytes.
  File loading derives it from the path/category/name. There is no top-level
  `name` emitted by this exporter, and identity is not a substitute for state.
- The final 48-byte suffix, runtime `0x53c4`, is persisted and treated as text
  during binary save. Its user-facing meaning remains unnamed; it is not
  proven to be another preset identity or JSON document.

JSON omits notes, p-lock cells/masks, step components, controller vectors,
timing/edit state, the 552-byte configuration block, parameter IDs36–41/57,
the extra header fields and final text block. It also omits low parameter bits,
sample path bytes after NUL, empty sample positions and engine-specific sample
fields. A faithful project editor must retain those independently.

## Filesystem loading and saving

The disk reader parses JSON, derives identity from the filename and applies
the same DOM-level field handling used by in-memory callers. A remote JSON
transport is not by itself a file operation. Queued disk loads have per-track
request sequence checks so superseded requests are not applied.

Only a sample string with **no slash anywhere** is joined to the directory
containing patch.json. `kick.wav` is joined; `sub/kick.wav`, `/fat32/...`,
`content/...` and `<samples>/...` are left as references. The paths then pass
through DLC alias compression; later sample loading expands shortcuts. This
is not ordinary POSIX relative-path handling.

Saving exports the selected pattern, ensures a preset folder, and processes
samples. DLC samples remain external alias references. Other samples use
destination/basename; existing destination files are reused without a visible
content hash comparison, otherwise copying is attempted. Copy success/reuse
rewrites JSON to a basename. Copy failure logs and retains the old reference
while continuing toward JSON writing, so successful JSON save does not prove
all audio was copied.

Overwrite cleanup keeps patch.json and referenced non-DLC sample basenames,
and deletes unlisted files in the preset directory. Saving then queues a reload
of the written preset. JSON persistence writes a temporary file and replaces
the destination using remove-then-rename; neither atomic replacement nor
power-loss durability is established. The filesystem report records exact
temporary paths, path grammar, DB guards, operation order and failure checks.

## Repository APIs and remaining work

`xy.patch_json` remains a **partial editing adapter**, not an emulator of the
firmware's preset replacement. Its existing caller behavior is documented in
[adapter coverage](patch_json_adapter.md). It does not implement the complete
validation/defaulting/coercion lifecycle above. In particular it still uses a
drum key-based mapping, handles only the first sampler region, preserves
omitted state and contains sample-writing assumptions that need reconciliation.
This investigation corrects its sample-prefix rule without silently changing
the rest of that API's contract. Synth/MIDI/multisampler writing is not newly
qualified by this work.

Use the new read-only inspector for comprehensive raw comparisons:

```sh
python3 tools/inspect_preset_state.py project.xy > preset-state.json
```

`xy.preset_state.inspect_preset_state(bytes)` checks format 9.19, follows all
counted patterns/notes/four controller vectors, and returns all 58 parameter
words, all 24 complete sample records, full-width IDs, configuration, identity,
octave, tuning and the unresolved suffix for every pattern. It retains raw hex
alongside decoded text/fields; it does not resolve audio, normalize state or
pretend its output is a loadable patch.json. The underlying layout reader
partitions every decoded byte and reassembles losslessly.

All 893 current repository `.xy` fixtures walk to exact EOF and reassemble
unchanged. Independent review also checked all 24 factory captures (384 patterns,
649 nonempty sample records) and multiple clone layouts. Synthetic regressions
cover nonempty controller lanes, clones, final sample-slot boundaries, signed
bytes, raw suffixes, version rejection and RLE spanning the header boundary.
These are offline checks, not new physical-device acceptance.

Still unresolved: unnamed binary fields, exact external ROM arithmetic edges,
every malformed/range-exceeding input assertion, some runtime registry/DB and
DSP behavior, and packed ROMFS internals. Full import emulation, migration and
broader writer corrections need separate implementation and device qualification.
