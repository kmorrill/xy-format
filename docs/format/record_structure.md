# Record Structure (Canonical)

> Established 2026-06-09 from the record-boundary reframe. Narrative and
> validation detail: `docs/logs/2026-06-09_record_boundary_reframe.md`.
> This document supersedes the framing in `descriptor_encoding.md`,
> `pretrack_pattern_directory.md`, and the preamble portions of
> `track_blocks.md` / `docs/issues/preamble_state_machine.md`.

## 0. The Serialization Model (read this first)

The `.xy` format is **little-endian C structs serialized field-by-field
(vectors count-prefixed), passed through a byte-level RLE**:

> After two consecutive equal bytes, the next byte is an extension count
> (that many additional repeats of the same byte).

This one rule generates most of the format's historical mysteries:
gate "tokens" (`F0 00 00 01` = u32 gate 240), tick "flag bytes" (zero-run
ext counts inside u32 ticks), chord "separators" (zero runs), the
note==velocity "firmware bug" (an unescaped RLE pair — write `[n][n][00]`),
record tail bytes (zero-fill ext of each struct's fixed trailing region),
and the pre-track scene "tags" (trailing zero-run ext inside 33-byte
records). The RAM-side note struct is 12 bytes
(`u32 tick; u32 gate; u8 note; u8 vel; u8 ×2`).

Performance automation decodes under the same rule:
`[first_lane u8]` then consecutive lanes
`[frame_count u8][v0 u16][vmax u16]` + `(t u16, v u16) × (count−1)`,
lane order pitchbend / modwheel / aftertouch (vmax 8191 / 254 / 254);
static lanes are count=1 (verified against unnamed 106–109 linear ramps,
keyframes at exact 480-tick steps).

Open precision items: exact decoder state after an extension (run reset /
chained ext), and a device test writing note==velocity with the proper
`00` extension byte.

## 1. File-Level Grammar

```
file        := global_header  pre_track  record*
pre_track   := fixed_header  RLE( n × 33 scene values )  00 00
               handle_table(36B)  tail(1B)
record(leader) := [pattern_count u8][bars u8][0xF0] <sig> [type] sections… [tail u8]
record(clone)  := [bars u8][0xF0]                   <sig> [type] sections… [tail u8]
sig         := 00 00 01 [track_scale] FF 00 FC 00
```

Key reframing: the old 4-byte "track preamble" `[pre0][count][bars][F0]`
is **two structures**. `count/bars/F0` belong to the *following* record's
header; `pre0` is the **trailing byte of the previous record** (or of the
pre-track region, for Track 1). Clone blocks have no count byte.

Corpus evidence: all 687 "preamble byte[0]" deviations across 206 one-off
files are local to the owning (preceding) record; zero cross-track
exceptions remain. The old "0x64 propagation", "T5 exemption", and "T1
0xB5 multi-pattern marker" rules are artifacts of the wrong boundary.

## 2. Track Signature Contains the Track Scale

The 4th signature byte is **not magic**: `00 00 01 [scale] FF 00 FC 00`.

| value | scale |
|-------|-------|
| 0x01  | ½×    |
| 0x03  | 1× (default) |
| 0x05  | 2×    |
| 0x0E  | 16×   |

(observed in unnamed 20/21/22). Scanners must wildcard this byte;
hardcoding `03` silently misparses scale-changed files.

## 3. Record Tail Byte = Final-Section Code

Every track record ends `… 00 00 [tail]`. The tail value is a
deterministic, slot-independent code of whatever section ends the record:

| tail | final section |
|------|---------------|
| 0x8A | Drum-kit default ending (sample table + preset path) |
| 0x86 | Prism / Drum-T2 / Dissolve default ending |
| 0x83 | Hardsync default ending |
| 0x85 | Axis / Multisampler default ending |
| 0x92 | Axis no-preset ending (preset region wiped) |
| 0x9B | Aux-track default ending |
| 0x2E | s16 param-delta trailer `[0x28|0x08 marker][22×s16][00 00]`; 0x2E = 46 = exact payload length |
| 0x64 | inline note-event section, standard form (gate flag 2/4) |
| 0x63 | inline note-event section, compact form (gate flag 3) |
| 0x61 | performance keyframe slab: pitch-bend / modwheel |
| 0x60 | performance keyframe slab: aftertouch / combined |

Cross-slot proof: unnamed 122's T1/T2 (swapped to a synth engine) carry
0x2E; T4 with events keeps 0x2E because events insert *before* its
engine trailer. Validated over 2224 records with zero unexplained cells.

The pre-track region's tail is the **loader's scene-record count**:
`tail = 0xD6 − 0x21·n`. A tail that disagrees with the actual stream
desynchronizes the loader (assert `num_patterns > 0`).

## 4. Pre-Track Scene Records (FULLY DECODED)

### RLE rule

After **two consecutive equal bytes**, the next byte is an extension
count (that many additional repeats). One continuous stream encodes all
records; runs may span record boundaries.

### The 33-byte record

```c
struct Scene {
    u8 selected_pattern[16];  // 0-based pattern index per track
    u8 mute[16];              // 0 = unmuted, nonzero = muted (T1=idx16 … T16=idx31)
    u8 flags;                 // 0x01 normal, 0x00 on blank rows
};
```

Mute is boolean: device probe 06 confirmed values 1, 2, and 3 **all
display as muted** (no "solo" encoding here). The device writes 2; the
writer emits 2 canonically.

- Record 0 = live/current selection state (the old "descriptor").
- Records 1…n−1 = scenes in order.
- The fixed header's end is anchored by `cd cc cc 00 0c 00 00 01 40`.

Validation: **245/246 corpus files decode byte-exactly; the only
rejected file is `bleez34.xy`, which also crashes the device.**

### Legacy concepts, translated

| legacy concept | reality |
|----------------|---------|
| descriptor token `0x1E − track` | trailing zero-run extension count (`32 − track − 2`) |
| v56 / v57 | first two values of record 0 |
| Scheme A vs B, short/collapsed forms | RLE output for different selection states |
| `j06` body `06 00 00 16` | T1=8, T2=8, ext×6 (all tracks on P9), zero-run |
| bleez `08 08` sub-delimiters | RLE pairs of value 8 (tracks selecting P9) |
| bleez `0x1F` separator | `00 00 1F` = a 33-zero blank record |
| `00 00` at 0x56 in baseline | empty-stream terminator |

### Editing safety rule (explains crashes #8/#12, probes 59–92)

A pre-track byte edit is safe **iff the stream still RLE-decodes to
exactly n×33 values** (with the tail byte matching n). Edits to a value
byte between unequal neighbours are safe; edits that create or break an
equal-pair shift the stream and crash the loader.

## 5. Song Table (file footer, after Track 16)

The file ends with a **14-slot song table** (= the documented 14-song
limit), located after the last `ff 00 00 … 9b` run at the end of Track
16's content:

```
song_slot := [scene_count u8][scene_idx u8 × count (0-based)][loop_word 2B]
default      01 00 00 01      (1 entry: scene 1, loop on)
loop_word := 00 01 = loop ON | 01 00 = loop OFF
```

Device-verified A/B: `unnamed 150 nl` (Song 1 loop off) = `01 00 01 00`;
`unnamed 150 lp` (loop back on) = byte-identical to baseline.
Multi-scene example: `unnamed 155` Song 2 = `03 00 01 02 …` = scenes
1,2,3 chained — matching its documented arrangement. Crash #5's "l01/l02
Track16 structural transplants" were edits to these slots.

Open: expanded (multi-scene) slots carry one extra trailing byte vs the
plain `[list][loop_word]` model; exact field still unplaced.

### Pre-track selection bytes 0x0F–0x11 (partial)

- `0x11` = selected song − 1 when a song is explicitly selected
  (`02_song_select_s2` → `01`, `03 … s3` → `02`); baseline value `0x10`
  is the never-selected/pattern-focus sentinel.
- `0x0F` tracks scene-override ordinal (legacy finding, still holds).
- Other observed values (`00 15 11` in resave probes) belong to the
  UI focus/selection cluster — not fully decoded.

## 6. Tools

- Decoder: `tools/analysis/pretrack_records.py` — prints scenes as
  `sel[T3=P2,T4=P3] mute[T1] flags=0x1` per record.
- Raw block scan: use the scale-tolerant signature regex
  `00 00 01 [\x00-\x0f] FF 00 FC 00` (note `xy/structs.py`'s
  `find_track_blocks` currently misses clone/overflow blocks and
  scale-changed tracks).

## 7. Open Items

- `unnamed 154b` / `unnamed 156` carry one extra pre-track byte beyond
  n×33 (song-coupled / matrix-authored branches).
- Mute value 2 (1 unobserved — solo?).
- Song arrangement (scene order, loop) lives in Track 16, not pre-track.
- Engine-default trailer internals (codes 0x86/0x83/0x85/0x8A/0x9B).
- Keyframe slab layout (0x60/0x61 endings; pointer-21 events).
