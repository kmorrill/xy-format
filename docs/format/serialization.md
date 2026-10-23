# Binary serialization and file I/O — firmware 1.1.21+0

This reference describes format **9.19** from the stock loader's actual readers,
writers, and selected consumers. `xy/serialization.py` walks every decoded byte
without signature searches or backward footer searches. Byte coverage does not
establish every field's musical meaning. The decoded payload is a **serialized
projection of runtime state**, not a RAM dump.

Source: [verified firmware receipt](../logs/2026-10-23_firmware_source.json),
SHA-256 `acc409d12a73fcf69f17a63084af765c90fee802271c854b4d3eeb6b2c970f86`.
Detailed evidence:

- [Field transfers, consumers and bounds](../logs/2026-10-23_firmware_fields.md)
- [RLE, stream I/O and legacy versions](../logs/2026-10-23_firmware_codec_versions.md)
- [Load, validation, save, backups and samples](../logs/2026-10-23_firmware_storage.md)
- [Complete preset JSON crosswalk](preset_json.md)

For version selection, sequential migration and what happens when an older
project is saved again, see [backward compatibility](backward_compatibility.md).
The native 1.1.21 writer always emits 9.19; it does not retain the input format.

## Complete file grammar

```
file = RLE(decoded_header[8] + serialized_project)
decoded_header = magic:u32le + major:u8 + minor:u8 + reserved[2]
serialized_project = globals[3449] + track_group[16] + song[14]
track_group = pattern_count:u8 + pattern[pattern_count]
pattern = fixed[17774] + note_count:u8 + notes[12*note_count]
        + pitchbend + modwheel + aftertouch + sustain
        + tuning[48] + unresolved_tail[48]
lane = count:u8 + items[4*count]
song = count:u8 + scene_indices[count] + scalar_a:u8 + scalar_b:u8
```

Offsets below exclude the eight **decoded** header bytes. Virtual pattern
origin is `body_start - 1`, so existing `+0x...` notation still applies to
clones; only the first pattern has a real group-count byte at that origin.
An empty pattern is 17,875 bytes; an empty one-pattern group is 17,876.
Baseline arithmetic: `3449 + 16*(1+17875) + 14*(1+1+2) = 289521`.
Each note adds 12 bytes, each controller item 4, and each song scene 1.

## Header, compression and stream errors

The entire file, including header, shares one RLE state. A run of k>=2 bytes
is encoded as `value,value,k-2`, at most 257 decoded bytes per run. Singletons
are literal; the extension resets pair state. Runs may cross the decoded
header/body boundary and any field boundary. Splitting physical bytes at 8 is
incorrect even though the corpus happens to allow it.

Decoded magic is `DD CC BB AA`; byte 4 is major, byte 5 minor. This firmware
writes `09 13`, accepts 8.0/8.1 and 9.0 through 9.19, then migrates older inputs
through successive converters. Bytes 6..7 are ignored by its reader; the save
entry initializes only the first 6 bytes before writing 8. Preserve these bytes,
but do not identify a firmware build from them. The new `inspect_preset_state` entry point rejects legacy versions. Existing
`ImageProject` authoring is not a migration implementation.

There is no checksum/total-size field in this native project grammar. Reader
`8d57c60c` carries run state across calls, zero-fills a short request and sets
sticky error; wrapper checks it. It does not require physical EOF after the
last song. Our decoder rejects malformed RLE, and `parse_image` rejects an
unexplained suffix by default; `allow_trailing=True` preserves a decoded suffix
as an explicit span. This is a stricter offline contract, not a firmware emulator.

## Global fields and scenes

| Wire interval | Meaning |
|---|---|
| 000–002 | tempo u16, tenths of BPM (corpus) |
| 002–003 | preserved byte |
| 003–004 | groove type (corpus) |
| 004–005 | click-related value (corpus) |
| 005–006 | preserved byte |
| 006–008 | scene/song state; UI semantics partial |
| 008–055 | configuration, preserved; see exact scalar transfer map |
| 055–065 | sixteen MIDI channel bytes; FF off, otherwise channel−1 |
| 065–095 | twelve u32 parameter words in three 16-byte transfers |
| 095–d79 | 100×33-byte scene records |

Each scene has 16 pattern indices,16 mute bytes and one flag byte. Slot 0 is
live/current,1..99 saved. Scene allocation is fixed, not count-prefixed.
EQ low/mid/high words start 65/69/6d (baseline 40000000); former 68/6c/70 were
most-significant bytes. UI coefficient scaling is not established by the
binary transfer. Complete per-call global RAM/wire mapping is in
`research/firmware-1.1.21/fields-map.json`.

## Every fixed pattern region

| Virtual wire interval | Runtime offset | Meaning |
|---|---|---|
| 001–013 | 000..015, selective scalars | length/timing/scale/edit state |
| 013–026 | 016..02c, selective scalars | engine u32 at 014, page/filter state |
| 026–24e | 030 | 552-byte configuration block |
| 24e–2c4e | 258 | 128×42 signed 16-bit p-lock cells |
| 2c4e–304e | 2c58 | 128×64-bit parameter masks |
| 304e–3056 | 3058 | 64-bit aggregate parameter mask |
| 3056–3057 | 3060 | separate state byte |
| 3057–3857 | 3062 | 128×16-byte component records |
| 3857–393f | 3864 | 58 parameter words (232 bytes) |
| 393f–453f | 394c | 24×128-byte sample records |
| 453f–456f | 454c | 48-byte preset path/name |

These intervals account for all 17,774 fixed bytes. Runtime pattern size is
21,492 bytes; runtime lists and padding differ from the wire representation.
The detailed report separates all scalar transfers within the first 38 bytes.
Engine/filter IDs use full u32 storage even where known IDs fit a byte.
Marking a pattern edited clears only bit 3 at wire 011, preserving the other
bits and the independent byte 012 (setter8d573538). Unknown bytes are preserved, not declared padding.

### Parameter locks and components

`wire_cell = origin + 0x24e + 84*(step-1) + 2*parameter_id`.
The first row is musical step 1 (time 0), **not current/resting state**. There
are 128 serialized rows; the current API offers 64 playable steps. Resting
parameters are separate at 3857. Each step mask and the aggregate mask are
little-endian u64, with bit `parameter_id`. Setters OR the bit into both masks;
readers return only enabled parameter cells, including enabled zero values.
The runtime getter sign-extends each cell and shifts left 16 to Q31; the Python
API preserves its raw u16 bit pattern.

IDs 0..7 engine controls,8..11 amp ADSR,12 playmode,13 portamento,14 bend,
15 engine volume,16..23 filter/send controls,24..31LFO controls,
32..35 filter ADSR,40 pan,41 track volume. IDs 36..39 remain unnamed. Some LFO
labels depend on LFO type. These firmware IDs and row origins differ from assumptions in the existing
`ImageProject` writer; this reference does not certify its p-lock authoring.

Components contain a u16 enabled mask and 14 value bytes. Bits 0..13 have
corpus-backed component labels. The allocation contains 128 records; spare
mask bits and records beyond the API's64-step range are preserved.

### Sample records and parameter state

Each sample record is at `origin+393f+128*voice`, voice 0..23:

| Slot bytes | Meaning |
|---|---|
| 00..03 | frame count u32 |
| 04..07 | sample.start u32 |
| 08..0b | sample.end u32; FFFFFFFF sentinel |
| 0c..0f,10..13 | loop.start, loop.end u32 |
| 14..17 | shared fade/crossfade word; not gain |
| 18 | root/keycenter byte; drum JSON transpose subtracts 60 |
| 19 | unresolved byte |
| 1a | high key |
| 1b | playmode low6bits; high2bits are flags |
| 1c | signed tune byte |
| 1d | signed gain byte |
| 1e | signed pan byte |
| 1f | reverse boolean |
| 20..7f | 96-byte sample path |

See the sample crosswalk for exact JSON property addresses and branch-dependent
fade semantics. Samples are external references, not embedded audio. Preset application limits paths to 95 bytes plus NUL. Save canonicalization
zeros path remainders; the raw inspector retains all 96 stored bytes.

The 58 resting parameter words include engine 0..7, amp 8..11, filter 16..23,
LFO 24..31, filter-envelope 32..35, and routing/mixer fields. A whole block transfer
does not prove every UI label or scaling law. JSON preset application is a
separate replacement path: it clears 58 words before assigning properties.

## Notes, four lanes and suffix

Notes are `i32 tick,u32 gate,u8 note,u8 velocity,u8 flags,u8 padding`
(the tick is transferred as a raw 32-bit word; captures include negative ticks).
The latest loader consumes 12 bytes but copies only 11 into its runtime node;
wire byte 11 is not retained musical state. Its nonzero corpus values must still
be preserved for lossless offline editing. Load validation clears bit 1 of the
retained flags byte. The writer's tick resolution is 480 per sixteenth.

PB/MW/AT/sustain each have one count byte even when empty. Every 4-byte item
is `tick:u16,value:i16`, including the first. Firmware consumer581abc compares
the first tick and reads its signed value, disproving the old initial/limit
header interpretation. There is no serialized `limit` field or synthetic range event. Firmware
capacity is 128 items for each of the first three and 32 for sustain; excess
wire items are consumed and discarded on load. The new raw walker consumes
all declared items without emulating that normalization. Existing authoring
APIs have not all been reconciled with these firmware findings. Sustain is confirmed by the CC 64 handler
and runtime vector 5310, with threshold>63 mapped to 0/255.

Then two 48-byte transfers occur. First is 12 tuning words at runtime 5394;
JSON emits an `engine.tuning` array when any word is nonzero. Its conversion uses signed upper 16 bits plus
unsigned low 8 bits times 0.01, not generic Q31. Second 48-byte block is treated as a NUL-terminated text buffer during save,
but its user-facing meaning remains unresolved. Copying preset sound state uses these fixed96bytes after all lanes;
it must not overwrite notes, sustain data, p-locks or components.

## Counts, validation, storage and acceptance

Track pattern count is 1..16 (runtime capacity), notes 0..120, song scenes 0..96.
Fourteen songs always follow the last track; their final two bytes are retained
separately. The baseline has 14 four-byte songs,56 bytes total. A timing byte
sequence observed in fixtures is not a firmware magic signature and is no
longer required by our walker.

Native load deserializes into an inactive buffer, then normalizes each track
before publishing the pending/current pointer. It repairs selected scale,
engine/filter/page values, a legacy piano sample path, and note flags. This
invalidates the old blanket statement that firmware only asserts, never
validates. Counts may still trigger assertions; the tool is not a guarantee of
reachable or safe runtime state.

Save snapshots the runtime project, zero-fills string remainders, serializes
to `path.tmp` using a4096-byte stream buffer, closes, then renames. Higher-level
save first moves the previous project into numbered backups (retention 20).
Failure ordering and workspace recovery are documented in the storage report;
this sequence does not establish power-loss atomicity or fsync durability.

## Verification and remaining boundaries

All **893** current `src/**/*.xy` files have header format 9.19, walk through
exact EOF and reassemble unchanged using the count-driven parser. This corpus
includes repeated captures and generated fixtures; it is not 893 independent
hardware trials. The new inspector is read-only and preserves raw fields.

Every current-format transfer and native load/save stage listed here has been
inspected statically. Some field meanings, ROM/OS helper internals, malformed
input outcomes and power-loss recovery remain unproven. The reader does not
normalize state, resolve samples or perform legacy migrations. Existing
`ImageProject` authoring still has assumptions predating this trace, notably
sample-field ownership and controller/p-lock semantics. Do not interpret this
reference as qualification of every existing writer method.

```sh
python3 -m pytest -q tests/test_preset_state.py tests/test_rle.py
python3 tools/inspect_preset_state.py "src/one-off-changes-from-default/unnamed 1.xy"
python3 research/firmware-1.1.21/codec-probe.py
```

See the [preset JSON reference](preset_json.md) for the full external-to-binary
sound crosswalk and its remaining validation boundaries. No new physical-device
test occurred during this investigation.
