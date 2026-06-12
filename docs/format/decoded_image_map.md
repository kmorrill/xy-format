# Decoded Image Map (Canonical)

> The `.xy` file after its 8-byte header is one RLE stream (see
> `docs/format/record_structure.md` §0 and `xy/rle.py`). This document
> maps the **decoded RAM image** — the firmware's project struct — built
> from a corpus-wide join of decoded diffs × the one-off change log
> (2026-06-09). Offsets are for baseline `unnamed 1.xy`
> (decoded size 289,521 bytes) unless marked track-relative.
>
> **Coverage overview (mapped vs unmapped):**
> [`image_coverage_map.md`](image_coverage_map.md)

## Image Layout

```
0x00000          global header            (3,449 bytes; ends before T1 @ 0x0D79)
0x00D79 + k*0x45D4   track struct k=0..15 (17,876 bytes each)
end − footer     song table               (53 B in older notes; **56 B** in `unnamed 1.xy`)
```

`3,449 + 16×17,876 + 56 = 289,521` on baseline (`unnamed 1.xy`). Older
docs used 53-byte footer — see [`image_coverage_map.md`](image_coverage_map.md) §3. Adding a pattern inserts one
more 17,876-byte struct (clones in raw space were full copies because the
struct *is* the pattern). Track structs grow only via count-prefixed
vectors (notes: +12 bytes each).

## Global Header Fields

| offset | field | evidence |
|---|---|---|
| 0x00 | tempo, u16 LE tenths of BPM (+ related byte at 0x04 region) | u4, u5 |
| 0x03 | groove type | u11, u12 |
| 0x04 | metronome/click volume | u10 |
| 0x06 | song/scene count-ish (songs: u13; scenes: 152/153 touch 0x06–0x07) | u13, u152 |
| 0x07 | selected song/scene ordinal | u149, u151 |
| 0x55–0x64 | per-track MIDI channel array, 1 byte/track (T1=0x55 … T16=0x64) | u41, u54 |
| 0x64–0x67 | global prefix u32 (byte @ 0x64 default `0xFF`; purpose open) | P2-F `eq2` tail |
| 0x68 / 0x6C / 0x70 | **master EQ** bass / mid / treble u32 (level byte @ field start; default `0x40`, max `0x7F`) | u14–u16, P2-F `eq0`–`eq6` |
| 0x74–0x77 | u32 @ 0x74 default `0x40` — **not** the 4th EQ UI knob; power control rewrites band bytes only (`eq7`/`eq8`) | P2-F |
| 0x75 / 0x79 / 0x7D / 0x81 | **saturator** gain / clip / tone / mix u32 | P2-G `sat0`–`sat8` |
| 0x78 / 0x7C / 0x80 / 0x84 | saturator level bytes (`u32+3`; gain/clip default `0x19`, tone `0x40`, mix `0x00`) | P2-G |
| 0x85–0x88 | **master percussion** volume u32 (byte @ 0x88) | P2-A `f10`/`f11` |
| 0x89–0x8C | **master melody** volume u32 (byte @ 0x8C) | P2-A `f12`/`f13` |
| 0x8D–0x90 | **master compressor** u32 (byte @ 0x90; default `0x0C`) | P2-A `f14`/`f15` |
| 0x91–0x94 | **master volume** u32 (byte @ 0x94; max `0x7F` / `0x7FFFFFFF`) | P2-D `s5b` |

(Scene records — the 33-byte structs of `record_structure.md` §4 — also
live in the global region in scene-bearing files.)

## Track Struct (track-relative offsets; track base = header byte 0)

| offset | field | evidence |
|---|---|---|
| +0x00 | pattern count (leader) | header decode |
| +0x01 | pattern length in sequencer steps (`0x10`/`0x20`/`0x30`/`0x40` = 1/2/3/4 bars). Whole-bar values are device-captured; non-multiple values are the inferred storage for the guide's final-bar sequence-length control and still need a direct device capture. | u17–u19 |
| +0x02 | 0xF0 marker | — |
| +0x03 | signature `00 00 00 [scale] FF 00 FC 00` | — |
| +0x06 | **track scale** (0x01=½, 0x03=1, 0x05=2, 0x0E=16) | u20–u22 |
| +0x11 | u16: **8 = pristine, 0 = edited** — the raw "type 0x05/0x07 + `08 00` padding" was this field's RLE shadow; sticky (never returns to 8) | u51, u53, every edit file |
| +0x1C | M4/LFO type selector (5 bytes change on LFO swap) | u32 |
| +0x20 | M4 page on/off | u31, u33 |
| +0x21 | filter type (SVF/Ladder) | u28 |
| +0x38AF | **send FX I** u32 (byte @ +0x38B2) | P2-A `f6`/`f7` |
| +0x38B3 | **send FX II** u32 (byte @ +0x38B6) | P2-A `f8`/`f9` |
| +0x38F7 | **track pan** u32 (byte @ +0x38FA; center `0x40`) | P2-A `f3`–`f5` |
| +0x38FB | **track mix volume** u32 (byte @ +0x38FE; default `0x60`) | P2-A/P2-D |
| +0x25 | filter on/off | u29 |
| +0x3057 + 16×(step−1) | **step-component slot, 16 bytes per step**, one byte per component type within the slot (portamento +9, bend +10, tonality +11, jump +12, param +13, conditional +14, …) | u8/u9, u59–u77 |
| +0x3857 | engine parameter block: 4-byte values (param1 +0x3857, param4 +0x3863, …) | u23–u25, u96 |
| +0x3877 | M2 amp envelope ADSR (16 bytes) | u26 |
| +0x3897 | M3 filter knobs (16 bytes) | u30 |
| +0x38B7 | M4 values (16 bytes + extras) | u32, u33 |
| +0x38D7 | filter envelope ADSR (16 bytes) | u27 |
| +0x3900–0x393B | modulation routing matrix (modwheel/aftertouch/pitchbend targets & amounts) | u83, u84 |
| +0x3919 / +0x392F | velocity sensitivity / track high-pass filter | u82, u40 |
| +0x3CBF | 2-byte UI-state (last-touched?) — co-changes with edits | u40, u66, u82 |
| ~+0x456F | **note event area**: `[count u8]` + 12-byte note records `{u32 tick; u32 gate; u8 note; u8 vel; u8 flags[2]}` (tick 480/16th, gate 240 = default). Micro-timing lives in `tick` (non-grid values, u79/u87), not the flags. `flags[1]` always 0 in corpus; `flags[0]` 0 for programmed notes, 2 on some MIDI-recorded drum notes (n110); firmware **does** read them (device probe 07: `flags[0]=127` caused a note retrigger), but out-of-range values misbehave — writer emits 0,0 (device default). | u81 decode; corpus scan; probe 07 |
| end | trailing zero region (raw-space "tail byte" = its run extension) | — |

**Aux tracks**: T15 = FX1, T16 = FX2 — FX type changes substitute in the
same engine-param offsets (+0x3857…) of those structs (u36, u37).
Engine swaps are size-preserving (param block fixed-size, u34).

## Footer (last 53 bytes)

The 14-slot song table (`record_structure.md` §5):
`[scene_count][scene_ids…][loop_word]` per song; song 2/3 edits land at
FOOTER+0x2/+0xA (u149, u151–153).

## Method

`tools/analysis/decoded_diff.py` against the baseline, joined with
`src/one-off-changes-from-default/op-xy_project_change_log.md`. Most
one-off files are pure substitutions of 1–16 bytes at the offsets above;
files that add notes/patterns grow by exactly 12 / 17,876 bytes.

## The "Event Type" Byte: RESOLVED — it never existed

The legacy event-type taxonomy (raw bytes 0x1C–0x2D; "preset-specific
factory IDs"; crash #2) is an RLE artifact. In decoded space there is no
type byte: the note vector is `[count u8]` at **track+0x456F** followed
by 12-byte records, preceded by a zero gap that runs back to the end of
the **preset-name string** (~track+0x4547–0x4550). The raw "type byte"
is that zero-run's extension count: `gap − 2`. Verified 24/24 across
unnamed 2/81/91/92/93/113/116/117 — e.g. "0x25" = 39-zero gap ending at
'p' (drum/boo**p**), "0x21" = 35 ending at 'r' (shoulde**r**), and the
"0x2D engine-swap fallback" = 47-zero gap ending at '/' (a stripped
preset path). **The type was the length of the preset's filename.**
Crash #2's mechanism: writing "0x21" on T1 claims a 35-zero gap where
the struct has 39 → the count lands 4 bytes early → `fixed_vector`
assert. The legacy event-form taxonomy (inline / fine-tick /
pointer-tail / hybrid) is likewise just tick/gate values changing the
RLE shapes.

## Image-Based Authoring (validated)

`xy/image_writer.py` edits the decoded image the way the firmware would
(set fields, splice vector elements, flip the pristine flag) and
re-encodes. **Byte-exact replication of device-saved captures:**
unnamed 2, 81, 19, 92 (`tests/test_image_writer.py`). Files that don't
replicate from their change-log description alone differ only in UI
session bytes (e.g. last-touched fields at +0x3CBF) — the file
remembering the musician's hands, not format semantics.

Device probe pack (untested): `output/image-probes/01..03` — includes
the note==velocity probe written with its RLE extension byte
(`3c 3c 00`), which the old "firmware bug" model predicts crashes and
this model predicts loads.

## Tier-1 Field Sweeps (2026-06-09, corpus-only)

### Step-component slot — FULLY DECODED

16 bytes per step at track+0x3057 + 16×(step−1):

```c
struct StepComponents {
    u16 enabled_mask;   // LE bitfield, one bit per component type
    u8  value[14];      // one config byte per type, same bit order
};
```

| bit | component | value example (corpus) |
|-----|-----------|------------------------|
| 0 | pulse | 01 = 1 repeat; 00 = max/random (u8/9/59/60) |
| 1 | hold | 01 = min (u61) |
| 2 | multiply | 04 = ÷4 (u66) |
| 3 | velocity | 00 = random (u67) |
| 4 | ramp up | 08 = 4 steps/3 oct (u68) |
| 5 | ramp down | 02 = 3 steps/1 oct (u69) |
| 6 | random | 03 = 4 steps/1 oct (u70) |
| 7 | portamento | 07 = 70% (u71) |
| 8 | bend | 01 = up/down shape (u72) |
| 9 | tonality | 04 = +5th (u73) |
| 10 | jump | 04 = →step 13 from 9 (u74) |
| 11 | param | 04 = 4 toggles (u75) |
| 12 | conditional A | 02 = 1:2 (u76) |
| 13 | conditional B / trigger | 04 = every 4th (u62); 09 = 1:9 (u77) |

`ff 3f` = all 14 enabled (u63). The legacy "two banks / alloc-byte
formula / only steps 1&9 work" lore was RLE artifacts plus our own
encoder bugs.

### P-lock (per-step parameter lock) table — structure decoded

Per-step lock rows at **track+0x2A0**, **84 bytes per step** (×64),
**u16 cell per parameter column** (42 columns):

```
cell(step, param) = track + 0x2A0 + 84·(step−1) + 2·param_col
```

**Automation requires flags** (decoded 2026-06-10 from `unnamed 35` +
device-passed `plock_drum_t2`). The value cell alone is inert; the
firmware also reads:
- per-step active flag at `track+0x2C4E + 8·(step−1)` = `0x01` — GLOBAL
  per step (any param; param1 and param2 captures share these offsets),
- a per-track master flag at `track+0x304E` = `0x01`.
`ImageProject.automate_param()` / `set_plock()` write all three.
(A UI current-value header at `track+0x24C + 2·col` and the resting
engine value mirror the lane but are cosmetic, not needed for playback.)

Verified with the device-passed `plock_drum_t2.xy` (alternating
256/32767 on known steps, uniform 84 stride) and the cc_map captures.
The column index is the device's master per-track parameter
enumeration (u16 byte-offsets within the row, from u121/123/124/126):

| offset | col | parameter | | offset | col | parameter |
|--------|-----|-----------|-|--------|-----|-----------|
| 0  | 0  | Volume       | | 38 | 19 | Filter Env amount |
| 2  | 1  | Param 1      | | 40 | 20 | Key tracking |
| 4  | 2  | Param 2      | | 42 | 21 | Send Ext |
| 6  | 3  | Param 3      | | 44 | 22 | Send Tape |
| 8  | 4  | Param 4      | | 46 | 23 | Send FX I |
| 18 | 9  | Amp Attack   | | 48 | 24 | Send FX II |
| 20 | 10 | Amp Decay    | | ~50/52 | 25/26 | LFO param/dest (paired field 0x162F) |
| 22 | 11 | Amp Sustain  | | 82 | 41 | Pan |
| 24 | 12 | Amp Release  | | | | |

Completed from u122/u123 (same-project diff isolates each lane):
Poly=+26, Porto=+28, PitchBend=+30, EngineVol=+32, Cutoff=+34,
Reso=+36, FilterEnvA/D/S/R=+66/68/70/72. CC9 "mute" is never recorded,
matching the capture notes. The old raw-space "param_id" bytes and
3/5/9/18-byte entry formats were RLE artifacts.

### Engine / preset region

- **Engine ID at track+0x14** (u85: 0x12 Prism → 0x1F Wavetable;
  matches the known engine-id enum).
- **Preset path string at track+0x453F** (null-padded, max 64 B; short
  `category/preset-name` form). P1-B fixtures (`e0`…`e5`):
  `drum/boop` (new-project default), `drum/pp`, `drum/nt-aeroplane`,
  `bass/nt-106 bass`, `wind/nt-accord`; engine swap w/o preset → `/`.
  Older corpus: `bass/shoulder` baseline T3. Read API:
  `xy/preset_path_inspection.py`. The string's end is where the pre-count
  zero gap begins.
- Engine parameter cells: 4-byte values from +0x3857 (current values;
  preset load rewrites them — copy from a corpus donor per preset).

### Drum sampler table — per-voice parameter slot (device-decoded)

24 voice slots × 128 bytes at **track+0x3957**; voice `v` at
`+0x3957 + 0x80·v`. Decoded from a device capture
(`output/image-probes/cap_drum_params.xy`) cross-referenced with the
OP-XY drum-knob manual (8 knobs: tune / start / end / play-mode, and
shift: direction / pan / fade / gain). Voices map to drum sounds in key
order (v0 kick a … v23 chi).

| slot offset | field | encoding |
|---|---|---|
| +0x00 | **tune** | u8 root note, default 0x3c, **±48 semitones** |
| +0x02 | key assignment | u8 (MIDI key this voice triggers) |
| +0x03 | **play mode** | u8: 1=key, 2=oneshot, 3=mute group, 4=loop |
| +0x05 | *(unused in M3 probes)* | stays 0 when pan/fade edited on v23 |
| +0x06 | **pan** | signed byte, device ±100 (`d1`/`d2` captures) |
| +0x7C | **gain / loop-crossfade (fade)** | u32; pad fade UI on v23 → **v22** `+0x7C`; encode `ui×0x0147AF00`, max `0x7FFFFFFF`; decode `(u32>>8)//0x0147AF` — M3 log |
| +0x07 | **sample direction** | u8: 0=forward, 1=backward |
| +0x08 | sample path string | null-padded |
| +0x68 | **sample start** | u32, default 0 |
| +0x70 | **sample end** | u32, default 0xFFFFFFFF (per-sample length) |
| +0x7c | **sample gain** | u32, default 0, max 0x7FFFFFFF |

Clean single-param voices pin it: clap moved only +0x68 (start), ride
only +0x70 (end), shaker/ch-b moved +0x00 (tune ±48), ht +0x03
(play mode), lc +0x07 (direction), cow +0x7c (gain max). The +0x68/+0x70
pair co-moving on several voices is a loop/fade side-effect, not start vs
end. `ImageProject.set_drum_voice()` writes tune/play_mode/direction/
start/end/gain (validated: tune reproduces the capture byte-exact).

### One-shot Sampler (`0x02`) — sample-edit header (P2-B)

Voice-0 path still @ `track+0x3957`, slot `+0x08`. **Start/end/loop** for
Sampler are **not** at drum `slot+0x68`/`+0x70`; they precede the table:

| track offset | field | probes |
|---|---|---|
| `+0x3943` | sample start u16 LE | `g3` |
| `+0x3947` | sample end u16 LE | `g4` |
| `+0x394B` | loop start u16 LE | `g5` |
| `+0x394F` | loop end u16 LE | `g6` |
| `+0x3956` | loop crossfade u8 | `g11` (`96` ≈ 75% UI) |
| `+0x3957` | tune u8 | `g1`/`g2` (+ aux @ `+0x395B` on max) |
| `+0x395A` | loop type u8 | `0x80` infinite · `0x40` off · `0x00` until-release |
| `+0x395C` | gain u8 | `g8`/`g9` |
| `+0x395E` | direction u8 | `g7` |

API: `xy/sampler_sample_inspection.py`. Log:
`docs/logs/2026-06-12_sampler_oneshot_inspection.md`.

### Preset assignment (validated)

Loading a kit/preset = copying the donor's preset-identity regions into
the target struct at the same offsets:
`(0x13–0x2A0) ∪ (0x3457–0x456F) ∪ (0x4570–end)` — i.e. everything
except header, pristine flag, p-lock table, step components, and the
note vector. Validated against u116 (boop kit on T4/T7/T8): donor-copy
reproduces the device file except UI-session bytes.
`ImageProject.set_preset()` implements this.

## Open

- Sample-slot internal fields (per-drum-voice tune/level/envelope) —
  not in the corpus and **not needed for authoring**: `set_preset`
  copies the whole sample table (paths + per-sample defaults) when a kit
  is assigned. Only relevant if we ever expose per-drum-voice tweaking;
  one device capture (edit one sample's tune, save, diff) would map it.
- UI session fields (+0x3B3F/+0x3CBF/+0x3DBF/+0x423F families) —
  imitate, don't derive.
- Naive differ misaligns after insertions; an alignment-aware decoded
  diff would clean up note-file attributions.
