# Decoded Image Map (Canonical)

> The `.xy` file after its 8-byte header is one RLE stream (see
> `docs/format/record_structure.md` §0 and `xy/rle.py`). This document
> maps the **decoded RAM image** — the firmware's project struct — built
> from a corpus-wide join of decoded diffs × the one-off change log
> (2026-06-09). Offsets are for baseline `unnamed 1.xy`
> (decoded size 289,521 bytes) unless marked track-relative.
>
> For a contiguous decoded-vs-opaque byte map, see
> `docs/format/spatial_coverage_ledger.md`.
> **Coverage overview (mapped vs unmapped):**
> [`image_coverage_map.md`](image_coverage_map.md)

## Image Layout

```
0x00000          global header            (firmware-dependent; see below)
track_base + …   track/pattern structs    (17,876-byte base plus vectors/growth)
end − footer     song table               (firmware-dependent variable-length slots)
```

`3,449 + 16×17,876 + 56 = 289,521` on baseline (`unnamed 1.xy`), but this
is one firmware family rather than a universal layout. Real-device corpus
evidence reported in [issue #19](https://github.com/kmorrill/xy-format/issues/19)
establishes this Track 1 base mapping from container header byte 5:

| header[5] | Track 1 base |
|---|---:|
| `0x0E`, `0x0F` | 3,933 |
| `0x10`, `0x11` | 3,433 |
| `0x13` | 3,449 |

Adding a pattern inserts one
more 17,876-byte struct (clones in raw space were full copies because the
struct *is* the pattern). Programmed notes add 12 bytes each. Live recording
can append additional per-pattern automation data, so 17,876 plus note-vector
bytes is not a universal stride.

## Global Header Fields

| offset | field | evidence |
|---|---|---|
| 0x00 | tempo, u16 LE tenths of BPM (+ related byte at 0x04 region) | u4, u5 |
| 0x02 | groove amount, signed i8 (`0` default; one detent = ±2 except extrema; min `0x81` = −127, max `0x7F` = +127) | HDR `hdr-grv-*` |
| 0x03 | groove type enum (`0` shuffle, `1` half-shuffle, `2` danish, `3` bombora, `4` wobbly, `5` gaussian, `6` accents, `7` island nod, `8` disfunk, `9` roll over, `10` prophetic) | PCFG `prjconf-t-grv-*` |
| 0x04 | metronome/click volume (`0x00` min/off, baseline `0xA8`, `0xFF` max); no separate on/off bit moved in HDR toggle probes | u10, HDR `hdr-mclk-*` |
| 0x06 | active scene slot, zero-based (`0` scene 1, `1` scene 2, `2` scene 3) | HDR `hdr-arr-act*` |
| 0x07 | active song slot, zero-based when explicitly selected (`0x01` = Song 2); fresh/default Song 1 reads `0x10` sentinel | HDR `hdr-arr-song*` |
| 0x08 | project-config scene length mode (`0` longest, `1` shortest, `2` time signature) | PCFG `prjconf-g-slen-*` |
| 0x1B | project transpose, signed i8 semitones (`0xE8` = −24, `0xFF` = −1, `0x18` = +24) | PCFG `prjconf-g-x*` |
| 0x1C | time signature enum (`0x10` 3/4, `0x11` 4/4, `0x12` 5/4, `0x13` 6/8, `0x14` 7/8, `0x15` 12/8) | PCFG `prjconf-t-sig-*` |
| 0x4D–0x54 | T1–T8 voice allocation, 1 byte/track (`0` auto, `1`–`8` fixed voices; project-wide UI cap 24) | PCFG `prjconf-v-*` |
| 0x55–0x64 | per-track MIDI channel array, 1 byte/track (T1=0x55 … T16=0x64; `0xFF` off, `0x00`–`0x0F` = channel 1–16) | PCFG `prjconf-m-*` |
| 0x64–0x67 | global prefix u32 (default `0x000000FF`; EQ max spill can set `0xFFFFFFFF`; purpose open) | P2-F `eq2`/`eq8` tail |
| 0x68 / 0x6C / 0x70 | **master EQ** bass / mid / treble u32 (level byte @ field start; default `0x00000040`, min `0x00000000`, max target `0x0000007F`; previous-field spill can make earlier maxed bands `0xFFFFFF7F`) | u14–u16, P2-F `eq0`–`eq8` |
| 0x74–0x77 | u32 @ 0x74 default `0x99999A40` — **not** the 4th EQ UI knob; power control rewrites band bytes only (`eq7`/`eq8`) | P2-F |
| 0x75 / 0x79 / 0x7D / 0x81 | **saturator** gain / clip / tone / mix u32 | P2-G `sat0`–`sat8` |
| 0x78 / 0x7C / 0x80 / 0x84 | saturator level bytes (`u32+3`; gain/clip default `0x19`, tone `0x40`, mix `0x00`) | P2-G |
| 0x85–0x88 | **master percussion** volume u32 (byte @ 0x88) | P2-A `f10`/`f11` |
| 0x89–0x8C | **master melody** volume u32 (byte @ 0x8C) | P2-A `f12`/`f13` |
| 0x8D–0x90 | **master compressor** u32 (byte @ 0x90; default `0x0C`) | P2-A `f14`/`f15` |
| 0x91–0x94 | **master volume** u32 (byte @ 0x94; max `0x7F` / `0x7FFFFFFF`) | P2-D `s5b` |

Scene records — the 33-byte structs of `record_structure.md` §4 — also
live in the global region in scene-bearing files. Present scene count is
derived from scene row flags, not from `0x06`.

## Track Struct (track-relative offsets; track base = header byte 0)

| offset | field | evidence |
|---|---|---|
| +0x00 | pattern count (leader) | header decode |
| +0x01 | pattern length in sequencer steps (`steps = (bar_count - 1) * 16 + final_bar_steps`; `0x10`/`0x20`/`0x30`/`0x40` = full 1/2/3/4 bars) | BAR-LEN |
| +0x02 | default step length, u16 LE ticks (`240` = UI 50, min capture `4`, max `480`) | BAR `bar-l-*` |
| +0x03–0x0A | early header bytes; formerly used as a signature, but BAR fields can mutate this range | BAR |
| +0x06 | **track scale** (0x01=½, 0x03=1, 0x05=2, 0x0E=16) | u20–u22 |
| +0x07 | bar-page quantization raw byte; UI display is `floor(raw * 100 / 255)` (`0x00` UI 0, `0x80/0x81` UI 50, `0xFE` UI 99, `0xFF` UI 100) | BAR `bar-q-*` |
| +0x08 | per-track groove override index byte (`signed_raw = 3 * index` into the UI sequence, saturated to signed i8 at ±99) | BAR `bar-g*` |
| +0x09 | **T9 Brain route mask** (`bit0=T1` … `bit7=T8`; default `0xFC` routes T3–T8, `0x00` none, `0xFF` all) | AUX-BRAIN |
| +0x11 | u16: **8 = pristine, 0 = edited** — the raw "type 0x05/0x07 + `08 00` padding" was this field's RLE shadow; sticky (never returns to 8) | u51, u53, every edit file |
| +0x1C | M4/LFO type selector (5 bytes change on LFO swap) | u32 |
| +0x20 | M4 page on/off | u31, u33 |
| +0x21 | filter type (SVF/Ladder) | u28 |
| +0x38A7 | **send to T13 External Audio aux output** u32, stored on the source track | AUX-T13 |
| +0x38AB | **send to T14 Tape** u32, stored on the source track | AUX-T14 |
| +0x38AF | **send FX I** u32 (byte @ +0x38B2) | P2-A `f6`/`f7` |
| +0x38B3 | **send FX II** u32 (byte @ +0x38B6) | P2-A `f8`/`f9` |
| +0x38F7 | **track pan** u32 (byte @ +0x38FA; center `0x40`) | P2-A `f3`–`f5` |
| +0x38FB | **track mix volume** u32 (byte @ +0x38FE; default `0x60`) | P2-A/P2-D |
| +0x25 | filter on/off | u29 |
| +0x3056 | bar-page p-lock interpolation/shape raw byte (`0x00` default/min, `0x04`/`0x08` min+1/+2, `0xFF` max) | BAR `bar-s-*` |
| +0x3057 + 16×(step−1) | **step-component slot, 16 bytes per step**, one byte per component type within the slot (portamento +9, bend +10, tonality +11, jump +12, param +13, conditional +14, …) | u8/u9, u59–u77 |
| +0x3857 | engine parameter block: eight 4-byte q16-ish values for synth engines; tonal sampler keeps these centered at `0x40000000` even when preset `engine.params` are unique | u23–u25, u96, 2026-06-15 unique sampler preset |
| +0x3857 / +0x385B / +0x385F / +0x3863 | **T9 Brain parameter words**: raw key/mode/scale/link fields are located; candidate bucket interpretations for `+0x385B` and `+0x385F` fit device-authored captures but still need PC-generated → device-verified confirmation | AUX-BRAIN |
| +0x3857 / +0x385B / +0x385F | **T11 External MIDI M1**: channel, bank, program u32 words. Channel uses 16 buckets (index+1 = channel); bank/program use 129 buckets (0=off, 1-128=value). Device detents fit the hypothesized `floor(raw*N/0x80000000)` mapping, but bucket boundaries are unverified and not boundary-safe for PC authoring. | AUX-T11 |
| +0x3857 / +0x385B / +0x3863 / +0x38FB | **T13 External Audio M1**: source, drive, mix, level. Source detents confirmed for mic/headset/line/USB-C/main; drive/level/mix endpoints or anchors captured. Display/bucket boundaries remain unverified. | AUX-T13 |
| +0x3857 / +0x385B / +0x385F / +0x3863 | **T14 Tape M1**: pitch, speed, length, mix. Device-authored anchors captured; display/bucket boundaries remain unverified. | AUX-T14 |
| +0x3877 | M2 amp envelope ADSR (16 bytes) | u26 |
| +0x3897 | M3 filter/FX knobs: at least eight 4-byte lanes in sampler presets; unique capture maps params 0-4 and 6-7, while lane 5 serialized as `0x7FFFFFFF` | u30, 2026-06-15 unique sampler preset |
| +0x38B7 | M4/LFO values: eight 4-byte q16 lanes in sampler presets | u32, u33, 2026-06-15 unique sampler preset |
| +0x3877..+0x3896 | **T11 External MIDI CC map table**: eight u32 words touched by M2/M3 CC assignment captures. Table location and bucket-readable values confirmed; exact CC number vs CC message ownership remains partial. | AUX-T11 |
| +0x3897 / +0x389B / +0x389F / +0x38A3 | **Aux M3 filter words**: HPF, param 2, param 3, LPF for T13–T16. T13 captures confirm HPF min/default `0x00000000`, HPF max `0x7FFFFFFF`; LPF min `0x00000000`, LPF max/default `0x7FFFFFFF`; param 2 mid `0x7C28F2FF`; param 3 mid `0x3570CA40`. Param 2/3 semantics remain unknown. | AUX-FILTER |
| +0x38B7 / +0x38BB / +0x38BF / +0x38C3 | **Aux M4 LFO words**: speed, amount, destination, param-dest. T13 generic captures confirm speed min/default `0x40000000`, max `0x7FFFFFFF`; amount min/zero/max `0x00000000`/`0x40000000`/`0x7FFFFFFF`; generic dest syn/filter/amp `0x00000000`/`0x4AAAAAA9`/`0x75555553`; param targets 1-4 `0x07FFFFFF`/`0x27FFFFFD`/`0x47FFFFFB`/`0x77FFFFF8`. T11 MIDI-only dest off/cc1/cc2 uses `+0x38BF` values `0x00000000`/`0x3AAAAAA7`/`0x7AAAAAA3`. Bucket boundaries remain unverified for PC authoring. | AUX-LFO |
| +0x38D7 | filter envelope ADSR (16 bytes) | u27 |
| +0x38FF–0x393B | modulation/performance matrix: modwheel, aftertouch, pitchbend, velocity target/amount, velocity sensitivity, portamento type, width, high-pass | u83, u84, 2026-06-15 unique sampler preset |
| +0x3917 / +0x392F | velocity sensitivity / track high-pass filter | u82, u40 |
| +0x38F2 / +0x38F6 | T9–T16 project-config save side-effect (`0x00`→`0x40` in every PCFG variant; not the edited setting) | PCFG |
| +0x3CBF | 2-byte UI-state (last-touched?) — co-changes with edits | u40, u66, u82 |
| ~+0x456F | **note event area**: `[count u8]` + 12-byte note records `{i32 tick; u32 gate; u8 note; u8 vel; u8 flags[2]}` (tick 480/16th, gate 240 = default). Negative ticks encode pickup notes before the bar. Live-recording flag bytes are not constrained to zero; preserve arbitrary values when reading/round-tripping. The writer emits 0,0 for newly programmed notes. | u81 decode; corpus scan; issue #19; probe 07; AUX-BRAIN; AUX-T10; AUX-T12 |
| end | trailing zero region (raw-space "tail byte" = its run extension) | — |

**Aux tracks**: T15 = FX1, T16 = FX2 — FX type changes substitute in the
same engine-param offsets (+0x3857…) of those structs (u36, u37).
Engine swaps are size-preserving (param block fixed-size, u34).

## Footer (firmware-dependent, ends at EOF)

The 14-slot song table (`record_structure.md` §5):
`[scene_count][scene_ids...][loop][reserved]` per song; song 2/3 edits land at
FOOTER+0x2/+0xA (u149, u151–153).

## Method

`tools/analysis/decoded_diff.py` against the baseline, joined with
`src/one-off-changes-from-default/op-xy_project_change_log.md`. Most
one-off files are pure substitutions of 1–16 bytes at the offsets above.
Programmed notes add 12 bytes and ordinary clones add a 17,876-byte base;
live-recorded automation can add further per-pattern growth.

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
- **Preset path string at track+0x453F** (48-byte field, null-padded; short
  `category/preset-name` form). P1-B fixtures (`e0`…`e5`):
  `drum/boop` (new-project default), `drum/pp`, `drum/nt-aeroplane`,
  `bass/nt-106 bass`, `wind/nt-accord`; engine swap w/o preset → `/`.
  Older corpus: `bass/shoulder` baseline T3. Read API:
  `xy/preset_path_inspection.py`. The string's end is where the pre-count
  zero gap begins.
- Engine parameter cells: 4-byte values from +0x3857 (current values;
  preset load rewrites them — copy from a corpus donor per preset).
- Current-value mirrors for several shift/mix lanes are now pinned from the
  CC-map captures:
  - M2 shift lanes at `+0x3887/+0x388B/+0x388F/+0x3893` =
    poly/play mode, portamento, pitch-bend range, engine volume
    (`unnamed 122`, CC28-31).
  - M3 shift lanes at `+0x38A7/+0x38AB/+0x38AF/+0x38B3` =
    send ext, send tape, send FX I, send FX II (`unnamed 123`, CC36-39;
    send-tape lane inferred by order because baseline already matched the
    recorded value).
  - M4 visible/CC lanes at `+0x38B7/+0x38BB` = LFO CC40/CC41 current values
    (`unnamed 124`; UI labels depend on LFO/track type).
  - Mixer lanes at `+0x38F7/+0x38FB` = pan and track volume (`unnamed 99` and
    `unnamed 124`).
  - LFO tail `+0x38D3..+0x38D6` is the strongest current candidate for
    shape/type-specific shift state (`unnamed 33`; exact enum pending).

### Sample table (drum/sampler) — structure decoded

The nominal sample/region table starts at **track+0x3957**. In the
2026-06-15 tonal sampler captures, one-zone sampler state uses an 8-byte
slot header at `+0x3957` (`3c 00 3c 80 00 00 00 00`) and the sample path
string starts at `+0x395F`.

Tonal sampler project-local window values are stored just before that table,
inside `track+0x393F..+0x3956`. The 2026-06-15 unique preset capture confirms
these values are copied from preset `regions[0]` when a sampler preset is
loaded:

| track offset | captured meaning |
|---|---|
| +0x393F | frame count |
| +0x3943 | sample/window start |
| +0x3947 | sample/window end |
| +0x394B | loop start |
| +0x394F | loop end |
| +0x3953 | loop crossfade raw u32; preset `loop.crossfade` frames normalized by `framecount` to a q31-like word using single-precision float math |

Do not use tonal sampler `patch.json engine.params` as sample-window state:
the unique capture intentionally set non-default `engine.params`, but
`track+0x3857..+0x3876` remained centered defaults. Generated projects should
author the pre-slot window block directly.

Exact `patch.json` preset-load lane map from
`src/sampler-project-state/2026-06-15/smp07_t7_unique_sampler_preset_loaded.xy`:

| track offsets | patch.json source |
|---|---|
| `+0x3877..+0x3883` | `envelope.amp.attack/decay/sustain/release` |
| `+0x388B` | `engine.portamento.amount` |
| `+0x388F` | `engine.bendrange` |
| `+0x3893` | `engine.volume` |
| `+0x3897..+0x38B3` | `fx.params[0..7]`, except lane 5 (`+0x38AB`) became `0x7FFFFFFF` in the active ladder capture rather than `fx.params[5]` |
| `+0x38B7..+0x38D3` | `lfo.params[0..7]` |
| `+0x38D7..+0x38E3` | `envelope.filter.attack/decay/sustain/release` |
| `+0x38FF..+0x3913` | modwheel, aftertouch, pitchbend target/amount pairs |
| `+0x3917` | `engine.velocity.sensitivity` |
| `+0x391B` | `engine.portamento.type` |
| `+0x3923` | `engine.width` |
| `+0x392F` | `engine.highpass` |
| `+0x3933..+0x3937` | velocity modulation target/amount |
| `+0x393F..+0x3953` | region frame/window/crossfade values |
| `+0x3957` | sampler `regions[0].pitch.keycenter` root/key byte; conflict probes show this wins over `hikey` |
| `+0x395A` | sampler patch-load loop bits: `0x40` from `loop.enabled=false`, `0x80` from `loop.onrelease=true` |
| `+0x395B` | sampler `regions[0].tune` signed cents byte |
| `+0x395C` | sampler `regions[0].gain` byte |
| `+0x395E` | sampler `regions[0].reverse` direction byte |

Preset name field follows the table. (The "amb kit" sampler corpus referenced
in older notes is not present in the repo; slot internals can be mapped from
baseline + kit-change one-offs when needed.)

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
| +0x03 | **play mode** | u8; patch.json string labels confirmed by preset-load experiment: `gate=0`, `key=1`, `oneshot=1`, `group=2`, `loop=3`; numeric JSON values are not preserved as raw bytes |
| +0x05 | *(unused in M3 probes)* | stays 0 when pan/fade edited on v23 |
| +0x06 | **pan** | signed byte, device ±100 (`d1`/`d2` captures) |
| +0x7C | **gain / loop-crossfade (fade)** | u32; pad fade UI on v23 → **v22** `+0x7C`; encode `ui×0x0147AF00`, max `0x7FFFFFFF`; decode `(u32>>8)//0x0147AF` — M3 log |
| +0x07 | **sample direction** | u8: 0=forward, 1=backward |
| +0x08 | sample path string | null-padded |
| +0x68 | **sample start** | u32, default 0 |
| +0x6C | **sample loop start** | u32 candidate; `cap_drum_params` voice 10 = `0x00001011` |
| +0x70 | **sample end** | u32, default 0xFFFFFFFF (per-sample length) |
| +0x7c | **sample gain** | u32, default 0, max 0x7FFFFFFF |

Clean single-param voices pin it: clap moved only +0x68 (start), ride
only +0x70 (end), shaker/ch-b moved +0x00 (tune ±48), ht +0x03
(play mode), lc +0x07 (direction), cow +0x7c (gain max). The +0x68/+0x70
pair co-moving on several voices is a loop/fade side-effect, not start vs
end. Voice 10 also pins the intervening `+0x6C` lane as a likely loop-start
u32 (`0x1011`), though a clean loop-start-only capture is still pending.
`ImageProject.set_drum_voice()` writes tune/play_mode/direction/
start/loop_start/end/gain (validated: tune reproduces the capture byte-exact).
Read API: `xy/drum_sample_inspection.py` (`DrumVoiceSample`,
`inspect_drum_samples`).

Preset-loaded clean 24-region drum kits use a shifted sample-window layout:
voice 0 `framecount`/start/end/loop words live in the pre-table header
`track+0x393F/+0x3943/+0x3947/+0x394B/+0x394F`, while voices 1-23 duplicate
their `sample.end`/`framecount` values into the previous slot at both `+0x68`
and `+0x70`. This is distinct from the direct edit-field writer/read API above.

### One-shot Sampler (`0x02`) — sample-edit header (P2-B)

Voice-0 path still @ `track+0x3957`, slot `+0x08`. **Start/end/loop** for
Sampler are **not** at drum `slot+0x68`/`+0x70`; they precede the table:

| track offset | field | probes |
|---|---|---|
| `+0x393F` | framecount u32 LE | `g0`, preset corpus |
| `+0x3943` | sample start u32 LE | `g3`, preset corpus |
| `+0x3947` | sample end u32 LE | `g4`, preset corpus |
| `+0x394B` | loop start u32 LE | `g5`, preset corpus |
| `+0x394F` | loop end u32 LE | `g6`, preset corpus |
| `+0x3953` | loop crossfade raw u32 | `g11` = `0x60000000` (`96` high byte ≈ 75% UI); preset-load `loop.crossfade` uses single-precision float normalization by `framecount` |
| `+0x3956` | loop crossfade high byte | legacy/coarse UI view of `+0x3953` |
| `+0x3957` | tune/root u8 | direct sample edit tune byte; patch.json preset loads use `pitch.keycenter` as root/key byte here |
| `+0x395B` | tune aux u8 | direct sample edit tune aux; patch.json preset loads use signed `regions[0].tune` cents here (`4 -> +0.04`, `-5 -> -0.05` / `0xFB`) |
| `+0x395A` | loop type u8 | direct sampler edit labels: `0x80` infinite · `0x40` off · `0x00` until-release; patch.json preset loads compose bits `0x40` from `loop.enabled=false` and `0x80` from `loop.onrelease=true` |
| `+0x395C` | gain u8 | `g8`/`g9` |
| `+0x395E` | direction u8 | `g7` |

API: `xy/sampler_sample_inspection.py`. Log:
`docs/logs/2026-06-12_sampler_oneshot_inspection.md`.

### Preset assignment (validated low-level primitive)

Loading a kit/preset = copying the donor's preset-identity regions into
the target struct at the same offsets:
`(0x13–0x2A0) ∪ (0x3457–0x456F) ∪ (0x4570–end)` — i.e. everything
except header, pristine flag, p-lock table, step components, and the
note vector. Validated against u116 (boop kit on T4/T7/T8): donor-copy
reproduces the device file except UI-session bytes.
`ImageProject.set_preset()` implements this.

The donor must be a pristine single-pattern, zero-note preset-load track.
Generated project tracks are not safe preset donors because `+0x4570..end`
is post-note-count storage; copying it from a track with events creates a
target whose note count and note-tail bytes disagree. `ImageProject.set_preset()`
now rejects non-pristine donors instead of producing that impossible state.

This is a fallback for exact device-authored preset-load state, not the
preferred generated-authoring abstraction. As sampler, drum, pattern, scene,
and song fields become decoded, JSON/spec authoring should compile those
semantic fields into image edits directly and reserve donor-copy for fields
that are still opaque but known to be internally coherent.

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
