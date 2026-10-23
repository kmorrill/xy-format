# OP-XY 1.1.21 preset JSON export: complete field crosswalk

This is a static trace of exporter `0x8d4dec6c` in the stock loader whose
SHA-256 is `acc409d12a73fcf69f17a63084af765c90fee802271c854b4d3eeb6b2c970f86`.
Fresh disassembly and a machine-readable field/condition map are in
`research/firmware-1.1.21/preset-export-*`. No device operation was performed.
The exporter uses the selected pattern returned by `0x8d571b2c`; its sound
state is pattern-local. The octave accessor is separately track-global.

The exhaustive crosswalk is `preset-export-schema.json` (76 ordinary field
rows, including the alternate MIDI branch, plus 20 sample-region field rows).
`preset-export-build-schema.py` reproducibly builds that manually audited map.
Pattern wire offsets below use the virtual leader origin; actual pattern
body starts at +1. Parameter `i` is runtime `0x3864 + 4*i`, wire
`0x3857 + 4*i`.

## Exported structure and parameter coverage

| JSON path | Runtime source | Wire source / parameter | Conversion |
|---|---|---|---|
| `type` | pattern `18` | `14` (4 bytes) | registered engine name |
| `platform` | constant | none | `OP-XY` |
| `version` | constant | none | integer 4 |
| `octave` | project `40 + track_index` | global `3d + track_index` | signed byte |
| `engine.params[0..7]` | parameter words | IDs 0..7 | signed word >>16 |
| `envelope.amp` attack/decay/sustain/release | parameter words | IDs 8..11 | >>16 |
| `engine.playmode` | parameter word | ID12 | poly/mono/legato quantization |
| `engine.portamento.amount` | parameter word | ID13 | >>16 |
| `engine.bendrange` | parameter word | ID14 | >>16 |
| `engine.volume` | parameter word | ID15 | >>16 |
| `fx.type` | pattern `28` | `21` (4 bytes) | `filter_types` registry's type |
| `fx.active` | pattern `2c` | `25` (1 byte) | Boolean |
| `fx.params[0..7]` | parameter words | IDs16..23 | >>16 |
| `lfo.type` | pattern `20` | `1c` (4 bytes) | `lfo_types` registry's type |
| `lfo.active` | pattern `24` | `20` (1 byte) | Boolean |
| `lfo.params[0..7]` | parameter words | IDs24..31 | >>16 |
| `envelope.filter` attack/decay/sustain/release | parameter words | IDs32..35 | >>16 |
| `engine.modulation.modwheel` target/amount | parameter words | IDs42/43 | >>16 |
| `engine.modulation.aftertouch` target/amount | parameter words | IDs44/45 | >>16 |
| `engine.modulation.pitchbend` target/amount | parameter words | IDs46/47 | >>16 |
| `engine.velocity.sensitivity` | parameter word | ID48 | >>16 |
| `engine.portamento.type` | parameter word | ID49 | >>16 |
| `engine.tuning.scale` | parameter word | ID50 | >>16 |
| `engine.width` | parameter word | ID51 | >>16 |
| `engine.transpose` | parameter word | ID52 | special integer quantization |
| `engine.tuning.root` | parameter word | ID53 | >>16 |
| `engine.highpass` | parameter word | ID54 | >>16 |
| `engine.modulation.velocity` target/amount | parameter words | IDs55/56 | >>16 |
| `engine.tuning[0..11]` | pattern `5394` | dynamic `pattern.end-96` | packed pitch to JSON float |

Dots inside `portamento.amount`, `velocity.sensitivity`, `tuning.scale`, etc.
are literal key characters. `modulation` really is a nested object containing
controller objects. There is no `engine.pan` key in this exporter: ID52 is
**transpose**. The string stored at `FP-64` is changed to `transpose` at
`4df7ce–ea`, then used at `4dfcb8`; its parameter load is `4dfcc2` and
conversion call is `4dfcd0`. Treating a reused stack slot as its earlier
string caused the misleading pan interpretation in earlier notes.

All 58 parameter words are checked for nonnegative signed values at
`4deca6–b4`; failure calls the assertion path at `4e0708`. The ordinary
conversion helper `4ddb86` shifts right sixteen, losing the low sixteen bits.
The exporter emits ordinary zero values too; it does not generally omit
parameters merely because they equal a default. There is no export-side
special case forcing `fx.params[5]` to max: the loop reads all eight raw words
at `4df5b8–61a`. Any observed normalization belongs elsewhere in the lifecycle.

`4ddb96` exports transpose as `(((raw >> 8) * 73) >> 23) - 36`, giving
-36..36 for nonnegative Q31 words. `4dec2a` maps
`((raw >> 8) * 3) >> 23` to 0=poly, 1=mono, 2=legato, with poly fallback.
These operations and ordinary Q31 truncation are lossy; successful JSON
round-trip does not imply byte-identical binary sound state.

## MIDI engine alternative

When engine ID is 29 (`midi`), the branch at `4df294–29c` replaces the four
ordinary engine playmode/portamento/bendrange/volume fields with eight
`engine.cc` entries:

- `cc[0..3].val` reads IDs8..11; `cc[4..7].val` reads IDs16..19.
- `cc[0..3].cc` reads IDs12..15; `cc[4..7].cc` reads IDs20..23.

The values use helper `4ddc32` (shift by eight then signed EXTRACT with control
`0x1009`); CC numbers use `4ddbb0`,
`(((raw >> 8) * 129) >> 23) - 1`. The exact signed extraction behavior at a
word boundary should remain expressed as the target instruction until
qualified. Envelope and FX objects are still emitted and reuse those
parameter words. This is not a second independent bank of MIDI values.

## Type registries

`4fe46c` clears the 33-entry engine registry and registers these names through
`4fe1b4`; the literal names begin at `84043b60`. `4fd09c` obtains the name at
`846df650 + 48*engine_id + 16`, and `5a2220` copies it for export.

| ID | Name | ID | Name |
|---:|---|---:|---|
| 2 | sampler | 3 | drum |
| 6 | organ | 7 | epiano |
| 18 | prism | 19 | hardsync |
| 20 | dissolve | 22 | axis |
| 29 | midi | 30 | multisampler |
| 31 | wavetable | 32 | simple |

Other entries remain empty in this initializer. Zero-filled loader RAM alone
cannot reveal the populated registry; the registration calls establish this
mapping. This does not establish that every registered internal engine is
available as a stock user-facing preset type.

The FX exporter calls `4dae0c` with `filter_types`, finds an entry by numeric
ID, and copies its `type` property. Effect registration `4fe67c` corroborates
9=`z lowpass`, 10=`svf`, 16=`ladder`, 17=`z hipass`. It also registers other
FX names, but the exporter explicitly chooses the filter registry, not
`fx_types`.

LFO initializer `5a35dc` fills `(name,id)` pairs at `86bd609c`: tremolo/0,
value/1, random/2, element/3, duck/6, and placeholder `x-x-x-x-` for IDs4 and5.
The names begin at `840a73ac`. The JSON exporter separately resolves the
`lfo_types` registry; placeholder/internal entries are not claimed to be
user-facing types. The loaded JSON registry data itself was not recovered
from the loader image.

## Sample regions and omission rules

The exporter creates a `regions` array for every engine. It visits the 24
runtime sample records only for IDs2,3,30 (sampler, drum, multisampler), in
slot order. Empty NUL-terminated paths are skipped (`4dff22–3e`); the result
has no explicit source-slot index. Thus a sparse array cannot alone preserve
which empty slots preceded each sample. Other engine types emit an empty
array, regardless of any stale sample bytes in their binary state.

Let `S` be runtime `394c + 128*slot`, wire `393f + 128*slot`:

| JSON region member | Source relative to S | Export condition / conversion |
|---|---|---|
| `sample` | `20..7f` | NUL-terminated path |
| `framecount` | `00` u32 | always |
| `pitch.keycenter` | `18` u8 | sampler/multisampler; drum emits constant60 |
| `transpose` | `18` u8 | drum only, source-60 |
| `tune` | `1c` i8 | always |
| `hikey` | `1a` u8 | always |
| `playmode` | low six bits of `1b` | drum only: gate/oneshot/group/loop for0..3; fallback oneshot |
| `pan` | `1e` i8 | drum only |
| `fade.in` | `14` word + `1b` bit7 | drum only: word when bit7 clear, otherwise0 |
| `fade.out` | same | drum only: word when bit7 set, otherwise0 |
| `loop.start` | `0c` word | sampler/multisampler only |
| `loop.end` | `10` word | sampler/multisampler only |
| `loop.crossfade` | `14` word and `00` framecount | sampler/multisampler only, target fractional multiply `(T)` |
| `loop.onrelease` | `1b` bit7 | sampler/multisampler Boolean |
| `loop.enabled` | `1b` bit6 | emitted as false only when bit6 is set |
| `sample.start` | `04` word | omitted when zero |
| `sample.end` | `08` word | omitted when `ffffffff` |
| `gain` | `1d` i8 | omitted when zero |
| `reverse` | `1f` byte | always Boolean |

There is no emitted `lokey`; byte `19` is not read by this exporter. No sample
content or audio hash is emitted. Paths alone do not prove the referenced
sample data is present or unchanged. `loop.crossfade` export uses the target
fractional multiply at `4e04e2`; exact rounding/saturation is not proved by
substituting a host float formula. The importer and audio-loading paths can
further normalize these values.

## Tuning and binary state absent from JSON

The exporter checks all twelve tuning words at runtime `5394` and omits
`engine.tuning` only when they are all zero. Otherwise it emits all twelve
entries, converting with `5a903c`: signed upper16 plus unsigned low8 times
0.01 via ROM arithmetic helpers. This is not an ordinary Q31 array. The
remaining bits in each word are not represented by that conversion.

The following serialized state has no emitted field in this exporter:

- Runtime `16` / wire `13` (one byte); runtime `1c` / wire `18` (four bytes).
- Runtime `30..257` / wire `26..24d`: the entire 552-byte configuration block.
- Parameter IDs36..41 and57. IDs40/41 include track pan/volume; preset
  `engine.volume` is the separate ID15.
- Preset identity/path at runtime `454c`, wire `453f`, 48 bytes.
- The final48-byte block at runtime `53c4`, dynamic wire `pattern.end-48`.
- Notes, p-lock values/masks, step components, performance vectors, timing
  and edit state; sample fields/empty slots excluded by the rules above.

There is also no exported top-level `name`. The type string, parameter
integers, and sample strings do not carry every raw binary byte. For auditing
repeated sound state, retain the raw 58 parameter words, all 24 complete
sample records, relevant configuration, preset identity, and both48-byte
suffix blocks in addition to the JSON projection. Equality of exported JSON
alone is insufficient evidence that two binary patterns have identical sound
state. The final48-byte block remains semantically unnamed.

## Comparison with current upstream adapter

Inspected clean upstream `7a74acc` at `/tmp/xy-format-preset-json-20261023`,
including `xy/patch_json.py`, `xy/patch_sound_state.py`, and
`docs/format/patch_json_adapter.md`. Its known common parameter offsets agree
with this trace; its `engine.transpose` name is correct. The firmware adds:

- Proof of the general transpose conversion and the optional tuning array's
  exact location, resolving two documented limitations of the corpus map.
- Four-byte widths for engine, FX, and LFO IDs; byte-only reads are incomplete.
- Additional registered MIDI/multisampler names and the alternate MIDI CC
  schema, without implying that the existing adapter safely supports them.
- The exact omit-default rules and empty-slot compaction described above.
- A distinction between the adapter's supported partial writes and firmware
  JSON replacement/load behavior, which is traced separately in the import
  report. Export coverage does not establish safe synthesis of omitted state.

No changes to the adapter or core binary writer were made by this subtask.
