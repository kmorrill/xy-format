# Firmware binary field walk: OP-XY 1.1.21+0

Static analysis of the device-derived loader recorded in
`2026-10-23_firmware_source.json`; no device operation or acceptance test.
Fresh disassembly is saved under `research/firmware-1.1.21/fields-*`.
`fields-map.json` records each bulk I/O call's destination/source RAM offset,
wire interval, byte count, and source hash. Addresses below are firmware
addresses, never file offsets. Pattern wire offsets use the virtual leader
origin (actual pattern body starts at +1).

## Read and write entry points

| Structure | Reader | Writer |
|---|---|---|
| Whole latest project | `8d595414` | `8d5847d4` (wrapper and project) |
| Track's pattern vector | `8d595128` | `8d584704` |
| Pattern | `8d594dd4` | `8d584448` |
| 12-byte note payload | `8d594c8e` | `8d5843a0` |
| First three 4-byte-item vectors | `8d594ca4` | `8d5843b8` |
| Fourth 4-byte-item vector | `8d594d3c` | `8d584400` |
| Song entry | `8d59537c` | `8d584764` |

Bulk reads use RLE reader `8d57c60c`; bulk writes use `8d57cc94`.
The latest reader and writer serialize the same fixed field order.
**This is selective field serialization, not a dump of the runtime project
struct.** The runtime pattern occupies `0x53f4` (21,492) bytes; its fixed wire
prefix occupies 17,774 bytes. Runtime padding, counters, and note linkage
are excluded or rebuilt. Runtime track groups reserve sixteen patterns with
a stride of 343,876 bytes; wire groups only contain their live count.

## Every fixed pattern byte, by actual I/O call

Intervals are end-exclusive. These are storage facts, not inferred musical
labels. The machine-readable map preserves smaller calls individually.

| Wire | Runtime offset | Bytes | I/O grouping |
|---|---|---:|---|
| `001–002` | `000` | 1 | scalar |
| `002–006` | `004` | 4 | scalar |
| `006–007` | `008` | 1 | scalar |
| `007–008` | `009` | 1 | scalar |
| `008–009` | `00a` | 1 | scalar |
| `009–00d` | `00c` | 4 | scalar |
| `00d–011` | `010` | 4 | scalar |
| `011–012` | `014` | 1 | state byte, adjusted after load |
| `012–013` | `015` | 1 | scalar |
| `013–014` | `016` | 1 | scalar |
| `014–018` | `018` | 4 | engine ID word |
| `018–01c` | `01c` | 4 | scalar |
| `01c–020` | `020` | 4 | scalar |
| `020–021` | `024` | 1 | scalar |
| `021–025` | `028` | 4 | filter type word |
| `025–026` | `02c` | 1 | scalar |
| `026–24e` | `030` | 552 | configuration block |
| `24e–2c4e` | `258` | 10,752 | 128 rows × 42 signed 16-bit p-lock cells |
| `2c4e–304e` | `2c58` | 1,024 | 128 × 64-bit parameter masks |
| `304e–3056` | `3058` | 8 | aggregate parameter mask |
| `3056–3057` | `3060` | 1 | separately serialized state byte |
| `3057–3857` | `3062` | 2,048 | 128 × 16-byte component records |
| `3857–393f` | `3864` | 232 | 58 parameter words |
| `393f–453f` | `394c` | 3,072 | 24 × 128-byte sample records |
| `453f–456f` | `454c` | 48 | preset-name/path field |

This confirms the corrected sample origin and complete 58-word instrument
parameter allocation. It disproves the previous parameter row origin
`24c` and its purported current-value row. It also disproves describing
the parameter-mask allocations as one activation boolean per step.

## P-lock semantics traced into consumers and setters

Evidence: `fields-plock-get-set.asm` and `fields-plock-consumer.asm`.

`8d597508` reads a resting parameter at `pattern + 3864 + 4*parameter_id`.
The alternate getter `8d597534` uses the same parameter ID to test a bit in
the step's **64-bit mask** (`8d597594–8d5975ac`) and, when enabled, reads:

```
ram_cell = pattern + 0x258 + 84*step_index + 2*parameter_id
wire_cell = virtual_origin + 0x24e + 84*step_index + 2*parameter_id
```

At `8d5975c6` the cell is loaded with signed halfword semantics and at
`8d5975d0` shifted left sixteen to recover the parameter's Q31 bit pattern.
The corresponding setter `8d5976f8` derives a step index from its time
argument using signed division by 480 (magic constant `0x88888889`, high
product shifted right eight with sign correction). It writes the low sixteen
bits at `8d597762`, ORs `1 << parameter_id` into the full step mask at
`8d597764–772`, and ORs the same mask into both words of the aggregate mask at
`8d597774–784`. Existing bits must survive.

For time zero, the row index is zero. **There is no extra current/resting
row before step one in this block.** The first playable row is wire `24e`.
The separate 58-word resting parameter block is at `3857`.
The 128-row allocation does not itself prove 128 playable UI steps.

This changes the meaning of the prior corpus observations. For example,
`unnamed 35.xy` T3 has mask 1 on actual rows 0 through 15; parameter ID 0
values begin `32767, 20643, 24575, 27524, ...`. The previous reader began at
row 1 and misidentified row 0 as a cosmetic current-value header. In
`unnamed 121.xy`, actual row 0 contains parameter IDs 0..3 at 16,384, followed
by increasing parameter-0 values in later rows. `0x0f0f` step masks are
consistent with independent parameter bits, not a single global activation
byte.

The former API's parameter-column labels cannot simply shift with the row:
its `param1` byte offset 2 compensates an origin two bytes too early, while
its `volume` offset 0 points to the previous row's final cell. The firmware
parameter enumeration must define the updated mapping; corpus prose alone
is insufficient. Parameter-specific reads must check their own mask bit.
Fresh ordinary-CC evidence in `fields-cc-pan-volume.asm` identifies CC10
as parameter 40 (`8d579f28` selects branch, `8d579f8e` sets ID40), and CC7
as parameter 41 (`8d579fc0` comparison, `8d579fe4` sets ID41). These are
track pan and track volume respectively. IDs36..39 remain unnamed here.

## Notes and four variable vectors

The wire note count is one byte and note records are twelve bytes. Runtime
notes are stored in sixteen-byte linked-list nodes: four bytes of linkage
followed by the note payload. The reader initializes/rebuilds free and live
list links and bounds live notes at 120. The writer walks live links, not
all 120 reserved nodes.

After reading twelve bytes through `8d594c8e`, the reader at `8d59500c`
passes length **11**, destination node+4, and the temporary note address to
ROM routine `040230c4`, whose usage is consistent with byte copy. The writer
`8d5843a0` writes twelve bytes starting node+4. Therefore the twelfth wire
byte is read but is not carried into the semantic note by this copy; it is
consistent with runtime padding. This is a strong ABI-level conclusion,
not a trace of that ROM helper: the supplied loader does not map the ROM
address. Preserve it for lossless offline round trips, but do not assert
that nonzero twelfth bytes represent musical flags. Byte ten is retained.

The actual variable suffix is:

```
note_count:u8 + note[note_count]*12
lane0_count:u8 + lane0[count]*4   # capacity 128
lane1_count:u8 + lane1[count]*4   # capacity 128
lane2_count:u8 + lane2[count]*4   # capacity 128
lane3_count:u8 + lane3[count]*4   # capacity 32, sustain (CC64)
fixed_block0[48] + fixed_block1[48]
```

The old 97-byte tail was only valid while lane3 had zero count. The fourth
vector is explicit on both paths, not inferred from a zero byte. Its sustain
meaning is traced in the continuation below. Its runtime
base is `5310`, count at `5390`; earlier vectors are at `4d04`, `4f08`, and
`510c`, with their four-byte counts at base+512. Readers consume all items
advertised by the byte count but stop storing once capacity is reached.
A conservative offline validator may reject excess counts; that is stricter
than firmware consumption and should be stated separately.

## The two 48-byte blocks

First block is runtime `5394`. JSON preset serializer `8d4dff40` scans its
twelve words and, when any is nonzero, writes a twelve-entry `tuning` array.
The string is at `84036408`; fresh excerpt is `fields-tuning.asm`.
`8d5a903c` converts each word using signed upper sixteen bits and unsigned
low eight bits, the latter multiplied by float constant `0x3c23d70a` (0.01).
Its ROM arithmetic calls are not included in the loader; this supports a
whole-unit plus hundredths representation, not generic Q31. Do not flatten
its packed fields into a normal signed 32-bit scalar without that conversion.

Second block is runtime `53c4`, independently read/written for 48 bytes.
Its semantic meaning is still unresolved. Preserve it. Searching its direct
16-bit offset references found serialization/conversion paths only; that
negative search does not establish that it is unused.

## Globals, scenes, songs, and capacity distinctions

The project reader and writer both serialize 3,449 decoded global bytes.
The global runtime prefix has a three-byte gap: runtime byte 8 is followed
by runtime word 12. Later fields therefore live at runtime offset wire+3.
MIDI-channel wire range `55–65` maps to runtime `58–68`; three 16-byte
parameter groups at runtime `68`, `78`, `88` map to wire `65`, `75`, `85`.
Thus the corrected EQ word starts `65/69/6d` agree with aligned runtime
words, although this trace alone does not label their low/mid/high meanings.
Scenes are a single 3,300-byte bulk transfer at runtime `98`, wire `95`.

Exactly sixteen track groups follow, then fourteen song entries. The latest
track reader asserts count > 0 and checks runtime capacity sixteen on append;
its storage limit is not the previously assumed corpus/UI limit nine. Each
song is a count byte, that many individual scene bytes, and two separately
serialized scalar bytes. Runtime capacity is 96 entries and the reader permits
count zero. The second scalar's musical interpretation remains unresolved.

## Limits of this result

This traces all latest binary field transfers and their read/write symmetry,
plus p-lock consumers, note reconstruction, and tuning JSON linkage. It does
not establish every field's UI meaning, all migration versions, ROM helper
implementations, or device acceptance. Unknown configuration fields and the second 48-byte block remain explicit. Fresh decoder
output still contains unsupported instructions outside the cited operations;
Blackfin+ absolute-load controls and immediate hardware-loop fields must not
be interpreted using classic Blackfin assumptions. Broader I/O and migration
analysis is coordinated in the other firmware investigation reports.


## Continued consumer trace: fourth vector is sustain

Fresh `fields-sustain-*.asm` provides an end-to-end static path:

1. Ordinary CC handler `8d579f02–08` compares the CC number to 64 and branches
   to `8d57a008`, which calls `8d579d80`.
2. `8d579d8c–9a` compares value against 63, forms the Boolean result, and
   calls `8d582f64` at `8d579da4`.
3. `8d582f6c–7a` maps this Boolean to 0 or 255. `8d582f9a` selects the current
   pattern's `5310` vector, and `8d582fc0` calls `8d582ed4` with that vector,
   timing state, and value.
4. `8d582ed4` updates the live control state and, when recording conditions
   hold, calls the vector-recording helper `8d582178`. The surrounding
   `8d582fce–8d583038` path handles releasing held notes and type-3 control
   events as sustain is released or engaged.
5. UI `8d549b3e–5c` selects the same vector and passes it to specialized
   renderer `8d5497b6`, with displayed bounds 0..255. The other three vectors
   use the separate common renderer.

This establishes sustain independently of a filename or corpus label. The
raw count/items should still be preserved because recording simplification,
interpolation and the internal tick representation have not been completely
traced. It is appropriate to name the fourth vector `sustain` while retaining
its raw four-byte item API.

The note capacity is an **append assertion**, not an up-front wire count
check. `8d594ff2` loads 120, `8d594ff6` checks signed used-size < 120, and
failure reaches `8d595110`, whose string at `8409a5ac` says
`../src/shared/fixed_list.h:264 used_size < CAPACITY`. The next assertion
checks free-head < capacity (`8409a5e0`). Counts through 120 fit; a 121st
append violates the former assertion. Strict parsing at <=120 is consistent
with runtime capacity, although the runtime failure mechanism differs from
returning a normal parse error.

Further searches for the final 48-byte block found no new consumer label.
Direct offset references, and scaled immediate loads/stores in its numeric
range, mostly identify serializers or unrelated larger runtime objects.
The tuning getter `8d5721bc` returns pattern+5394, but setter `8d572260` passes
R2=0xc0 to unavailable ROM helper `040201c4`. Assuming a conventional 192-byte
copy here would extend beyond the verified runtime pattern stride; that call
is therefore **not used as evidence of tuning field size**. The explicit
binary transfers and twelve-word JSON traversal remain the grounded sizes.


The runtime tuning consumer also corroborates the first-block size:
`8d582e52` calls the tuning getter and forwards its pointer to `8d4d65fa`.
That helper copies twelve words into a message containing one track byte
plus 48 tuning bytes, then transmits a 49-byte body with internal message
ID `0xc0` (`fields-tuning-send.asm`). It does not consume the final 48-byte
block. The versions investigation independently found both 48-byte blocks
introduced together by the 9.3→9.4 migration and subsequently preserved;
see the separate version evidence for that historical claim.


## Review follow-up: controller records have no range header

Fresh evidence: `fields-controller-consumer.asm` (`8d581abc`) and
`fields-sustain-consumer.asm` (`8d581c88`). Every four-byte vector item has
identical shape, including item zero:

```
tick:u16 little-endian + value:i16 little-endian
```

At `8d581b8e`, the common playback consumer reads the **first** item's
unsigned halfword and compares it against the current time (`8d581b90`).
It then walks backward in four-byte strides to find the last item whose tick
is no greater than the current time (`8d581b94–b6`). At `8d581bb8` it reads
the selected item's second halfword with sign extension and stores that
value into live controller state (`8d581bc0`). There is no special first-item
range or limit field. The sustain simplifier also reads the second halfword
with sign extension at `8d581ca6`, including the first item, and compares it
with the preceding value to remove redundant changes.

Consequently, bytes `00 00 ff 1f` mean tick 0, value 8191. The previous API's
interpretation as initial value 0 plus limit 8191 could reproduce these bytes
while giving them the wrong meaning. For sustain, treating `00 00 ff 00` as
initial 0 plus limit 255 reverses the intended initial pedal state. Correct
API handling separates the first tick and its value or simply exposes a
homogeneous event list. Negative signed values must retain their raw bits.
The consumer trace supports chronological records; remaining recording
simplification and clock conversion details are separate questions.

## Review follow-up: edited state is one bit, not two zero bytes

Fresh evidence: `fields-edited-bit.asm` (`8d573538`) and
`fields-tuning-edited-bit.asm` (window containing `8d5722e0`). After writing
an ordinary parameter word, `8d573566` loads pattern runtime byte `14`,
`8d57356a` clears bit 3, and `8d57356c` writes that same byte back. The tuning
setter independently uses the same load/bit-clear/store at `8d5722e0–e6`.
Runtime `14` is wire `11`. Therefore marking a pattern edited should perform:

```
wire[0x11] &= ~0x08
```

Other bits of wire `11` survive, and the independently serialized wire `12`
byte is not involved. Baseline `08 00` concealed the previous implementation's
overwrite of both bytes with zero. No semantic label for the other bits is
claimed here. Engine ID at wire `14` and filter type at wire `21` also need
full four-byte reads/writes as shown by the binary transfer map above;
zero upper bytes in the corpus do not change the serialized field widths.
