# 2026-06-09: Record-Boundary Reframe — the "Preamble" Is Two Different Structures

## Summary

A C-developer re-reading of the block framing suggests the 4-byte "track
preamble" `[pre0][count][bars][0xF0]` is **not one struct**. The record
boundary sits between `pre0` and `count`:

```
record(leader) := [count u8][bars u8][0xF0] <signature 8B> [type u8] body... [tail u8]
record(clone)  := [bars u8][0xF0]           <signature 8B> [type u8] body... [tail u8]
```

- `count`/`bars`/`F0` are the **header of the following track record**
  (already device-verified semantics: count = pattern count, bars = bar_len<<4).
- `pre0` — the byte previous models treated as "this track's preamble byte[0]"
  with cross-track propagation rules — is actually the **trailing byte of the
  previous record** (or of the pre-track region, for T1).

## Corpus Evidence

Scanned all 206 files in `src/one-off-changes-from-default/` vs `unnamed 1.xy`
(16-block files only):

1. **687 / 687 `pre0` deviations co-occur with a modified preceding record**
   (previous track body differs from baseline, or pre-track region differs for
   T1). **Zero** deviations occur with an untouched preceding record.
2. 95 deviations occur where the track's *own* body is untouched — impossible
   to explain locally under the old framing, trivial under the new one.
3. Byte-level boundary dumps confirm the trailing byte is part of the previous
   record's tail section:
   - baseline T1→T2 boundary: `...drum/boo p 00 00 | 8a | 01 10 f0 <sig>`
   - unnamed 101 (T1 has 48 notes): `...32 7f 00 00 | 64 | 01 10 f0 <sig>` —
     T1's record now ends with note events and its trailing byte is 0x64.
4. **Clone blocks have no count byte.** j05 (T2 3-pattern): T2 leader header
   `03 10 f0`, clones `86 10 f0` (= prev tail 0x86 + `10 f0`). j01/n110
   leaders carry `09 10 f0`; all clone headers are `[tail][10][f0]`. The old
   "clone preamble byte[0]=0x00, byte[1]=next track's preamble" rule was a
   misframed read of `[...00][tail][bars][f0]`.

## What This Dissolves

- **"0x64 propagation rule"** (track after one with events gets 0x64): the
  byte is the previous record's own trailing byte; tracks whose record ends
  with an event section end in 0x64. Purely local — no propagation.
- **"T5 exemption"** (crash #6/#11): the byte before T5's signature is the
  tail of **T4's record**. T4 is the EPiano-engine track, the only engine with
  a documented 47-byte parameter tail — its record simply *ends differently*
  (tail byte 0x2E, not 0x64). p03 (T4 preset changed away from the EPiano
  body layout → 0x64) confirms it depends on T4's own record content.
- **T9 `0x85` vs `0x64` branch rule** (crash #5 Whitney probes): T8's own
  trailing byte flips when T8's record gains events. Local.
- **T1 `0xB5` "global multi-pattern marker"** and the scene formula
  `pre0 = 0xD6 − n·0x21`: this is the **pre-track region's trailing byte**.
  It responds to scene records / multi-pattern descriptors because those live
  in the pre-track region — nothing to do with T1.

## Open Question: What Is the Trailing Byte?

Working hypothesis: serialized allocator/pool state ("structs dumped to
disk"). Notes:

- Pre-track tail decreases by exactly 0x21 (33) per scene record; scene
  records are 33 bytes. Multi-pattern mode also costs exactly 33 even though
  the serialized descriptor is only 5–9 bytes — consistent with a 33-byte
  in-RAM slot pool whose state (free count / free offset) is serialized.
- Track tails in baseline: T1=0x8A, T2/T3/T5=0x86, T4=0x2E, T6=0x83,
  T7=0x85, T8=0x85, T9–T15=0x9B; 0x64 when the record ends with events;
  0x60/0x61 for live-record families; 0x63 observed on some n110 clone tails.
- Crash evidence (`num_patterns > 0` when the byte is wrong) says the loader
  consumes it sequentially before reading the next record's count byte — so
  it is structural (likely a tag or length of a footer), not advisory.

## Part 2 (same day): Tail-Byte Decode — Final-Section Code Catalog

Corpus-wide attribution (all 206 one-off files, 2224 records via raw signature
scan — note `xy/structs.py:find_track_blocks` silently drops clone/overflow
blocks; a raw scan finds the true totals, e.g. 80/80 in n110, 18/18 in j05).

### Established grammar (raw-scan validated)

```
record(leader) := [count u8][bars u8][0xF0] <sig 8B> [type] sections... [00 00][tail u8]
record(clone)  := [bars u8][0xF0]           <sig 8B> [type] sections... [00 00][tail u8]
```

Every block in every file parses as exactly one of these two shapes.

### Tail value = deterministic code of the record's FINAL section

| tail | final section of the record | evidence |
|------|------------------------------|----------|
| 0x8A | Drum-kit default ending (sample table + preset path) | T1 baseline |
| 0x86 | Prism/Drum-T2/Dissolve default ending | T2/T3/T5 baseline |
| 0x83 | Hardsync default ending | T6 baseline |
| 0x85 | Axis / Multisampler default ending | T7/T8 baseline |
| 0x92 | Axis **no-preset** ending (preset region wiped, `FF 00 00` runs) | unnamed 34 family (T1→Axis, no preset) |
| 0x9B | Aux-track default ending | T9–T15 baseline |
| 0x2E | s16 param-delta struct (`[0x28/0x08 marker][22×s16+2 zeros]`); 0x2E=46 = exact payload length | T4 baseline; **u122 T1/T2 after Drum→synth swap (slot-independent!)**; survives events (insert-before-tail) |
| 0x64 | inline note-event section, standard form (flag 2/4, u16 or token gate) | all note-entry files; constant regardless of note count |
| 0x63 | inline note-event section, compact form (flag 3: 1-byte gate + trailing micro-offset byte) | n110 T1/T8 blocks; flag↔tail verified per block |
| 0x61 | performance keyframe slab: pitch-bend / modwheel | unnamed 39, 106, 108, 120 |
| 0x60 | performance keyframe slab: aftertouch / combined sweeps | unnamed 107, 109 |
| 0xD6−0x21·n | pre-track region: n = number of variable pre-track records | see below |

Slot plays no role: u122 proves a T1 record ending with the s16 struct carries
0x2E, and T4 records ending with events carry 0x64. The old per-slot
"baseline preamble values" were just each slot's default engine's final
section code.

The full cross-tab (slot × modified × has-event → tail) over 2224 records has
**zero unexplained cells** once final-section type is accounted for.

### Event-encoding discovery (from 0x63/0x64 diff)

Two serializations of the same 1-note event (n110 blocks 64 vs 66, same
length):

```
flag=2: 20 01 00 00 02 | e0 01 | 00 00 00 | 35 64 | 00 00      gate = u16 LE (480)
flag=3: 20 01 00 00 03 | 1e    | 00 00 00 | 32 64 02 | 00 00   gate = u8, +1 trailing byte
```

The flag byte after `[type][count][00 00]` selects gate field width; the
trailing extra byte in flag-3 form is likely a micro-offset. Tail = 0x64 for
flag-2/4 records, 0x63 for flag-3 records.

### Pre-track countdown is allocator state, not file length

- 01/02/03_scene (1/2/3 scenes, no overrides): pre-track 129 B, tail 0xB5 —
  **scene count does not consume records**; the single record is the pattern
  descriptor (`1e 01 00 00`).
- 04/12_scene (one scene pattern-override): pre-track 136/137 B, tail 0x94 —
  descriptor + override = 2 records.
- unnamed 6 / j06 (multi-pattern only): tail 0xB5 = 1 record.
- unnamed 13 (empty Song 2): tail 0xD6 = 0 records.

So `tail = 0xD6 − 0x21·(record count)` where serialized records are only
4–12 bytes each. The 33-byte quantum is **not in the file** — it is the slot
size of the runtime pool the records are loaded into. The serializer dumps
the pool's allocation state (or equivalently a pointer low byte) into the
trailing byte. This unifies the old `tag_records` vs `alt/matrix` ±1
formulas: they were counting different subsets of pre-track records.

### Crash-rule reinterpretation

Wrong tail values crash at `num_patterns > 0` because the loader consumes the
tail as part of the record stream before reading the next record's count
byte. Each section type evidently has its own footer reader; a tail that
doesn't match the actual final section desynchronizes the stream. This is why
single-byte scene-token probes (crashes #8–#12) were so fragile: editing
pre-track records without updating the pool-state byte (or vice versa) breaks
the contract.

## Part 3 (same day): Pre-Track Variable Region = One Typed Record Stream

Tool: `tools/analysis/pretrack_records.py`. Validation: **217/222 corpus
files parse with record count exactly matching the tail countdown**
(`tail = 0xD6 − 0x21·n`), across descriptor, scene-override, scene-matrix
(`unnamed 156`), bleez, and j-family files.

### Grammar

```
pre_track := fixed_header   record*   00 00   handle_table(36B)   tail(1B)
record    := [per-track values ...] [00 00] [tag] [0x01]      ; track-array form
            | pair-list form (song family, see below)
tag       := 0x1E − last_track_1based   (0x1D=T1 … 0x16=T8; 0x1E = empty/none)
```

The fixed header's end is anchored by `cd cc cc 00 0c 00 00 01 40`
(tolerates upstream growth: MIDI config at ~0x23, scene ordinals at 0x0F).

### One encoder, three record meanings (C view: `serialize_track_array(u8[16])`)

1. **Pattern-count record** (the old "descriptor", Schemes A+B): per-track
   `pattern_count − 1` values. `j06` = `08 08 06 | 00 00 | 16 01`
   (T1=8, T2=8, then a 6-repeat for T3..T8, tag T8).
2. **Scene-matrix record** (`unnamed 156`, bleez): per-track *pattern index*
   for one scene. `unnamed 156` S1 = `00 01 02 03 04 05 06 07 | 00 00 | 16 01`
   — literally T1..T8 → P1..P8. The old "v56/v57 directory bytes" are just
   the first two values of the first record.
3. **Compact scene-override record** (scene corpus 00–14): sparse form
   `[scene_idx][pattern_idx] [00 00] [track_tag] 01` — e.g. file 14's
   `01 02 00 00 1a 01` = scene 2, pattern 3, track 4.

The bleez "44–111-byte records" are these same records with additional
sub-blocks (`08 08`-prefixed groups, plus a `0x1F`-prefixed record variant in
bleez8) — partially decoded, see open items.

### Song-family records (different value type, same pool)

`unnamed 124/150b/152b/154b/155b` carry `00 00`-separated 2-byte pairs,
e.g. 155b = `(0e,02)(0d,01) (15,02)(06,01) (0e,02)(04,02)(06,01)` with
tail predicting 3 records. Pair second-bytes are small (1–2); meaning not
yet decoded (likely song/scene chaining state). Record boundaries within
the pair stream are the main open question (5 of 222 files mismatch only
in this family + bleez8).

### Track signature contains a field: TRACK SCALE

`unnamed 20/21/22` (track scale 2 / 16 / ½) revealed the block signature's
4th byte is **not magic**: `00 00 01 [scale] ff 00 fc 00` with 0x03 =
default. Observed: 0x05 = scale 2, 0x0E = scale 16, 0x01 = scale ½.
All signature-scanning code that hardcodes `03` silently misparses these
files (e.g. `xy/structs.py` and the previous corpus stats, which treated
T1's whole record as pre-track in these three files).

### Residual anomaly (open): the ±1 zero in track-array values

A handful of array encodings carry one extra `00` in mid-array positions
(`m05` T1+T2: `01 01 00`; `m09` T1+T4: `00 00 01`; `unnamed 156` S2:
`01 00 02 03 04 05 06 07 08`). Likely an RLE/repeat-count element
(cf. `j06`'s `06` repeat byte) not yet pinned down. Needs a systematic
grammar fit across all specimens rather than more eyeballing.

## Part 4 (same day): Pre-Track Record Encoding FULLY DECODED

**Validation: 245/246 corpus files decode byte-exactly. The single failure
is `bleez34.xy` — the file that crashes the device. Our decoder and the
firmware now reject the same input.**

### The encoding

```
pre_track := fixed_header  RLE( n × 33 values )  00 00  handle_table(36B)  tail
n    = (0xD6 − tail) / 0x21          ; loader's record count (load-bearing!)
RLE  : two consecutive equal bytes → next byte = extension count
       (that many additional repeats; one continuous stream, runs may
        span record boundaries)
```

### The 33-byte record is the SCENE struct

```c
struct Scene {
    u8 selected_pattern[16];  // 0-based pattern index per track
    u8 mute[16];              // 0 = unmuted, 2 = muted
    u8 flags;                 // 0x01 normal, 0x00 on blank rows
};
```

- Record 0 = the live/current selection state. Records 1..n−1 = scenes.
- Mute layout verified by the mute-probe ladder: `unnamed 150b` (S1 T1
  muted) → value 2 at index 16; `unnamed 155b` (S1=T1, S2=T8, S3=T1+T8) →
  indices 16 / 23 / both. Selection verified by the whole scene corpus
  (e.g. `07_scene_s3_t4p3` decodes to "S2: T3→P2; S3: T3→P2, T4→P3").

### Everything this dissolves

- **"Descriptor encoding" (Schemes A & B, v56/v57, tokens, short/collapsed
  forms, the 0x40 family marker, collapse triggers)**: all artifacts of
  RLE over the current-selection row. `token = 0x1E − track` is the
  trailing zero-run's extension count (32 − track − 2). "v56/v57" are the
  first two array values. The "leader-active vs blank" branch mysteries
  are literally which pattern was selected on each track at save time
  (`j06` decodes to "all tracks on P9" — the device sat on the last
  created pattern).
- **The `00 00` at 0x56 in baseline**: the empty-stream terminator, not a
  directory header.
- **Scene-record "families" (tag_records / alt_records / matrix_records /
  bleez)**: one encoding. The bleez "08 08 sub-record delimiters" are RLE
  pairs of value 8 (tracks selecting P9); the "0x1F separator" in bleez8
  is `00 00 1F` = a 33-zero blank record.
- **Crash mechanics (crashes #8, #12; probes 59–92)**: a byte edit is safe
  iff the stream still RLE-decodes to exactly n×33 values. Edits that hit
  a value byte between unequal neighbours work (probes 67–69: the
  "rec2[3] selector"); edits that create or break an equal-pair shift the
  stream and desynchronize the loader (`bleez34`'s single-byte crash:
  decode fails mid-stream at region+30, exactly like the device).
  The tail byte is the loader's record count — why `f02/g02`-style tail
  mismatches assert `num_patterns > 0`.

### Tool

`tools/analysis/pretrack_records.py` — decodes any corpus file's pre-track
into human-readable scene rows (`sel[T3=P2,T4=P3] mute[T1] flags=0x1`).

### Still open (pre-track)

- `unnamed 154b` and `unnamed 156` each carry one extra byte vs n×33
  (likely an additional field in the song-coupled / matrix-authored
  branches; both still decode cleanly otherwise).
- Mute value is 2 (not 1) — other values (solo?) unobserved.
- Scene-count ordinal at `pre[0x0F]` vs record count (records store only
  rows; duplicate scenes share rows — file 14's "ordinal=1, 2 records").
- Song arrangement (scene order per song) lives in Track 16, not here.

## Part 5 (same day): THE SERIALIZATION MODEL — the whole file is RLE'd C structs

Following the RLE rule out of the pre-track region revealed it applies to
the **entire file**: track bodies, note events, gates, ticks, performance
lanes, the song table. The format is:

> **Little-endian C structs serialized field-by-field, with count-prefixed
> vectors, passed through a byte-level RLE: any two consecutive equal
> bytes are followed by an extension count (additional repeats).**

### What this single rule explains

| legacy mystery | reality |
|----------------|---------|
| default gate "token" `F0 00 00 01` | RLE of `F0 00 00 00` = u32 gate = **240 ticks** (half step) |
| explicit gate "5 bytes `[u32][00]`" | u32 gate whose `00 00` interior pair carries an ext byte |
| tick "flag bytes 0x00/01/02/04 select field width" | ext counts on the zero run inside u32 ticks (tick=0 → `00 00 [ext]`) |
| chord separators (`00 00 00` new-tick vs `00 00` continuation) | zero runs with/without extension |
| **note==velocity crash (firmware "bug")** | equal adjacent bytes form an RLE pair; writer must emit `[n][n][00]`. Our velocity nudge avoided the pair instead of escaping it |
| step-component "alloc byte formula" / "runs_adjusted separators" | RLE extension counts |
| record tail bytes (0x64/0x63/0x60/0x61/0x2E/0x8A/0x86/0x92/0x9B/…) | `00 00 [ext]` zero-fill of the struct's fixed trailing region. 0x64 vs 0x63 = flag-3 events end with one extra nonzero byte; 0x92 vs 0x8A = 8-byte preset field zeroed |
| pre-track scene records "tags" | trailing zero-run ext inside fixed 33-byte records |

### Quantitative checks

- RLE-decoding whole track records: decoded size grows by ~12 bytes per
  note across u2/u80/u101 → RAM note struct = 12 bytes
  (`u32 tick; u32 gate; u8 note; u8 vel; u8 ×2`).
- Performance lanes (unnamed 106–109) decode as
  `[first_lane_idx u8]` then consecutive lanes
  `[count u8][v0 u16][vmax u16][frame: t u16, v u16 × (count−1)]`,
  lanes = 0:pitchbend (vmax 8191), 1:modwheel, 2:aftertouch (vmax 254);
  the linear MIDI-harness ramps decode to exact 480-tick keyframes and
  linear values. Static lanes are count=1. (This closes the
  0x60/0x61 tail family and most of the pointer-tail issue's scope.)

### Open precision items

1. Exact decoder state rule after an extension (does the run reset
   pair-detection? chained extensions for runs > 257?). The naive rule
   validated 245/246 pre-track streams but whole-body decodes need the
   corner cases pinned against device captures.
2. Device test: write note==velocity WITH the `00` ext byte — prediction:
   loads fine, removing the need for the velocity nudge.
3. Map the decoded (RAM-space) track struct layout: engine params,
   sample tables (the `FF 00 00` regions), step components, p-locks —
   all should become plain fixed-offset fields in decoded space.

## Part 6 (same day): ROUND-TRIP PASSED — the container layer is solved

The decisive test from `docs/state_of_understanding.md` ran and passed on
the first decoder variant (C-style input-pairing, extension byte resets
the pair state, greedy canonical encoder chunked at 257):

- **245/246 `src/` files round-trip byte-identically** as ONE continuous
  RLE stream from offset 8 (after magic+firmware header) to EOF.
- The test is not vacuous: non-canonical run encodings exist and would
  fail it. Every device-saved file is canonical-greedy.
- The sole failure, `bleez.xy`, *decodes* fine but contains ~648 bytes of
  non-greedy run splits (3 zeros as `00 00 00` + `00` instead of
  `00 00 01`) — unique in the corpus, including its own bleez1–36
  siblings; believed tool-assembled somewhere in its lineage.

Codec: `xy/rle.py` (+ `tests/test_rle.py`, corpus-parameterized).
Workhorse: `tools/analysis/decoded_diff.py`.

### Decoded space behaves exactly as predicted

Baseline decodes to a **289,521-byte RAM image** (30× expansion). One-off
changes become pure substitutions at fixed offsets / exact struct growth:

| change (file) | Δlen | decoded diff |
|---|---|---|
| tempo 40 / 121.2 (u4, u5) | 0 | u16 tenths at **0x0** (+1 related byte at 0x4) |
| groove type / amount (u11, u12) | 0 | 1 byte at **0x3** |
| click volume (u10) | 0 | 1 byte at **0x4** |
| empty Song 2 (u13) | 0 | 1 byte at **0x6** |
| MIDI channels (u41) | 0 | bytes at **0x55 / 0x64** |
| T1 bars (u17/u19) | 0 | 1 byte at **0xd7a** (+ status byte 0xd8a) |
| T1 track scale (u20/u22) | 0 | 1 byte at **0xd7f** |
| pulse component step 1 vs 9 (u8, u59) | 0 | 3 bytes at **0x3dd0** vs **0x3e50** → **16-byte per-step slots** |
| all 14 components on step 9 (u63) | 0 | 16 bytes at 0x3e50 (one slot) |
| notes (u2/u3/u80/u81) | **+12 per note** | event vector + step-map regions |
| new blank pattern (u6/u7) | **+17,875 per pattern** | the pattern struct size |
| engine swap, no preset (u34) | **0** | in-place substitutions — param block is fixed-size |
| scene mute (150b) | 0 | scene structs at ~0x275xx + flags at 0x7/0xa5/0xb5 |

Step components, which took a 14-type two-bank encoder and crash ladder
to map in raw space, are a 16-byte-stride array lookup in decoded space.

### Status

**The container layer is solved.** Remaining work is field mapping inside
the decoded image (a corpus-wide decoded-diff × change-log join), then a
struct-level writer (build image, `encode_project`) replacing scaffold
transplants.

## Suggested Follow-Ups

1. ~~Re-express stats per-record~~ DONE (Part 2): zero unexplained cells.
2. ~~Map tail ← final-section type~~ DONE (Part 2): full catalog above.
3. Characterize the default final-section structs per engine (what exactly
   are the 0x86/0x83/0x85/0x8A/0x9B-coded endings — likely each engine's
   param/preset trailer; the s16 case is already exact at 46 bytes).
4. Decode the pre-track variable records as typed records consumed into the
   33-byte-slot pool (descriptor vs scene-override vs song records), and test
   whether tail arithmetic alone predicts all bleez/matrix branch values.
5. Audit `xy/container.py` framing: parse records as
   `[hdr][sig][type][sections][tail]`; raw-scan block discovery instead of
   the filtered `find_track_blocks` (which drops clones/overflow blocks).
6. Decode the remaining section internals: event flag-3 trailing byte
   (micro-offset?), keyframe slab layout (0x60/0x61 endings), engine-default
   trailers.
