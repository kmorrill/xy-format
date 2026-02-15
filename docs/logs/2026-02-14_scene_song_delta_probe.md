# 2026-02-14 Scene/Song Delta Probe

## Scope

Investigate scene/song storage using existing one-off fixtures that were
previously treated as arrangement candidates:

- `unnamed 6.xy`
- `unnamed 13.xy`
- `unnamed 15.xy`

Method:

1. Compare against baseline `unnamed 1.xy`.
2. Isolate **pre-track-only** deltas using `XYProject` + `SequenceMatcher`.
3. Confirm whether track blocks changed.

## Key Findings

1. `unnamed 13.xy` is the only clean song-mode delta in the one-off set.
- Track blocks are byte-identical to baseline.
- Single pre-track edit:
  - `A[0x0F:0x11] = 00 00` -> `B[0x0F:0x10] = 01`
  - Net file/pre-track delta: `-1` byte
  - First track signature shifts `0x0080 -> 0x007F`

2. `unnamed 15.xy` behaves like EQ-mid, not song structure.
- It matches the same structural family as `unnamed 14.xy` (EQ low) and
  `unnamed 16.xy` (EQ high):
  - `A[0x29:0x2E] -> 05` (low)
  - `A[0x2D:0x32] -> 05` (mid)
  - `A[0x31:0x36] -> 05` (high)
- All three are `5-byte -> 1-byte` replacements with `-4` byte file delta.

3. `unnamed 6.xy` is not a scene/song-specific fixture.
- It is byte-identical to `01_t1_p2_blank.xy` (multi-pattern topology capture).

4. No scene-only fixture is currently labeled in one-off.
- `op-xy_project_change_log.md` has no explicit `scene` entry.
- Songs are mentioned only for `unnamed 13` and `unnamed 15` (with `15` likely
  mislabeled per finding #2).

## Addendum: `unnamed 149` / `unnamed 150` (user-confirmed intent)

- Intent mapping from latest capture pass:
  - `unnamed 150.xy` = "01 baseline empty situation", loop off.
  - `unnamed 149.xy` = "02 Song 2 initialized/selected", loop off.

Byte-level confirmation against baseline (`unnamed 1.xy`):

1. `unnamed 150.xy` is byte-identical to baseline.
- Size/pre-track match: `9499 B`, pre-track `124`.
- `SequenceMatcher` pre-track ops: `0`.

2. `unnamed 149.xy` is a compact global/pre-track mutation.
- Size/pre-track: `9495 B`, pre-track `120` (delta `-4` vs baseline).
- Single pre-track replacement:
  - `A[0x10:0x15] = 00 10 00 00 12` -> `B[0x10:0x11] = 15`
- Track delta: only Track 16 tail lane toggles:
  - `track16+0x0161: 00 -> 01`
  - `track16+0x0162: 01 -> 00`
  - `track16+0x0165: 00 -> 01`
  - `track16+0x0166: 01 -> 00`

This pair is currently the cleanest controlled `Song1 vs Song2` fixture set in
the corpus.

## Addendum: `unnamed 151` / `unnamed 152` (user-confirmed intent)

- Intent mapping from latest capture pass:
  - `unnamed 151.xy` = "03 Song 3 created/selected", loop off.
  - `unnamed 152.xy` = "04 Scene 2 initialized", no note/mix edits.

### `unnamed 151.xy` (Song 3)

Against `unnamed 150` (Song 1 control):

- Size/pre-track: unchanged (`9499 B`, pre-track `124`).
- Pre-track replacement:
  - `A[0x11] = 0x10` -> `B[0x11] = 0x02`
- Track delta: only Track 16 tail lane toggles:
  - `track16+0x0169: 00 -> 01`
  - `track16+0x016A: 01 -> 00`

### `unnamed 152.xy` (Scene 2)

Against `unnamed 150` (Song 1 control):

- Size/pre-track: `9499 -> 9497`, pre-track `124 -> 122` (delta `-2`).
- Pre-track ops:
  - insert `0x01` at `B[0x0F]`
  - `A[0x11:0x15] = 10 00 00 12` -> `B[0x12] = 13`
- Track delta: only Track 16 tail lane toggles:
  - `track16+0x0161: 00 -> 01`
  - `track16+0x0162: 01 -> 00`

Interpretation:

- Song selection and Scene initialization both touch compact pre-track control
  fields and a tiny Track-16 tail bit-lane region.
- This reinforces that arrangement metadata is not in the fixed transport header
  alone; at least part of it is coordinated with the Track-16 tail region.

## Addendum: `unnamed 154` (user-confirmed `05`: Song 2 + Scene 2)

- Intent mapping from latest capture pass:
  - `unnamed 154.xy` = "05 both Scene 2 and Song 2 initialized", loop off.

Against `unnamed 150` (Song 1 baseline control):

- Size/pre-track: `9499 -> 9501`, pre-track unchanged (`124`).
- Pre-track same-offset byte changes:
  - `0x0F: 00 -> 01`
  - `0x10: 00 -> 01`
  - `0x11: 10 -> 00`
- Track delta: Track 16 tail structural rewrite (length `407 -> 409`):
  - insert at `track16+0x0163`: `02 00 01 01 00 00`
  - delete tail bytes `track16+0x0193:0x0197`: `01 00 00 01`

Interpretation:

- The corrected combined-state fixture (`154`) is larger than a simple
  two-byte toggle pair in Track 16; it introduces a small tail-structure reshape.
- This further supports a split storage model: compact pre-track control bytes
  coordinated with Track-16 tail bit lanes, rather than a single fixed-header
  field.

## Addendum: `unnamed 155` (user-confirmed `07`: Song 2 with 3 scenes, loop on)

- Intent mapping from latest capture pass:
  - `unnamed 155.xy` = `07` submission: Song 2 has three scenes in arrangement,
    loop intentionally left on.

Against `unnamed 150` (Song 1 baseline control):

- Size/pre-track: `9499 -> 9501`, pre-track `124 -> 123`.
- Pre-track structural edit:
  - `A[0x0F:0x12] = 00 00 10` -> `B[0x0F:0x11] = 02 01`
- Track delta: Track 16 tail structural rewrite (length `407 -> 410`):
  - insert at `track16+0x0163`: `03 00 01 02 00 00 00`
  - delete tail bytes `track16+0x0193:0x0197`: `01 00 00 01`

Interpretation:

- Compared with `154` (combined Song2+Scene2, loop off), `155` keeps the same
  narrow change scope (pre-track + Track16 tail only) but with a distinct
  structural variant consistent with added song content and loop-state change.
- This capture is a useful loop-on arrangement fixture and should be treated as
  a separate branch from the loop-off progression (`150/149/151/152/154`).

## Addendum: `unnamed 150b/152b/154b/155b` (scene mute probes)

Intent mapping from latest mute-capture pass:

- `unnamed 150b.xy` (from `150`): Scene 1 mute `T1`
- `unnamed 152b.xy` (from `152`): Scene 2 mute `T1`
- `unnamed 154b.xy` (from `154`): Scene 2 mute `T1+T8`
- `unnamed 155b.xy` (from `155`): Song2 3-scene mute map
  - Scene 1: `T1`
  - Scene 2: `T8`
  - Scene 3: `T1+T8`

Shared structural effects across all four `b` captures:

- File size rises substantially (`+68` to `+92` bytes).
- Pre-track grows (`+4` to `+28` bytes) with inserted record payloads around the
  pre-track `0x50` area.
- Tracks `9..16` all apply the same structural rewrite (`len +8` each):
  - `... 19 40 00 00 01 60 ...` -> `... 11 40 00 00 01 40 00 00 01 40 00 00 01 60 ...`
- Track 1 changes only at byte 0 of the preamble (pointer shift side-effect).

Per-file pre-track inserted payload words (little-endian 32-bit):

- `150 -> 150b`: `0x0000020e`, `0x0000010d`
- `152 -> 152b`: `0x0000022f`, `0x0000010d`
- `154 -> 154b`: `0x0000022f`, `0x00000203`, `0x00000107`
- `155 -> 155b`: `0x0000020e`, `0x0000010d`, `0x00000215`, `0x00000106`,
  `0x0000020e`, `0x00000204`, `0x00000106`

Interpretation (current confidence: medium-high):

- Scene mute state is definitely serialized; it is not just UI/transient state.
- Mute writes involve a pre-track record list (variable-length words above) plus
  a shared Track `9..16` branch activation/normalization.
- Exact token-to-track mapping is not fully decoded yet (single-mute cases are
  clear; combined mute records still show topology-dependent encoding).

Loop on/off status after mute pass:

- Still not isolated to a single field with high confidence.
- `155` (loop-on fixture) to `155b` includes many mute-driven structural edits;
  this confounds direct loop-bit attribution.
- A clean same-arrangement loop-only pair is still needed for definitive decode.

## Addendum: `unnamed 150 nl` / `unnamed 154 loop` / `unnamed 154 nl`

Intent mapping from latest loop-capture pass:

- `unnamed 150 nl.xy`: from `150`, Song 1 loop flipped off (user-reported base had loop on).
- `unnamed 154 loop.xy`: from `154`, Song 2 loop flipped on.
- `unnamed 154 nl.xy`: from `154 loop`, Song 2 loop flipped back off.

### `154 loop` -> `154 nl` (clean loop-only pair)

- File size unchanged: `9565 -> 9565`.
- Pre-track unchanged: `124 -> 124` with no non-equal ops.
- Exactly one byte changes in entire file:
  - file offset `0x252A`: `00 -> 01`
  - same location in Track 16: `track16+0x016E`

Interpretation (confidence: medium-high):

- In the normalized arrangement branch, Song-2 loop toggle appears to map to a
  single byte at `track16+0x016E`.
- With the user-provided intent labels, provisional polarity is:
  - `00` = loop on
  - `01` = loop off

### `150` -> `150 nl` (Song 1 loop-off capture)

- Not loop-only: includes a broader branch rewrite.
- Size/pre-track: `9499 -> 9559` (delta `+60`), pre-track `124 -> 120`.
- Pre-track collapses to the compact `Song2`-like token (`A[16:21]=00 10 00 00 12 -> B[16]=15`).
- Tracks `9..16` all undergo the same `+8` structural rewrite seen in the
  normalized branch family.

Interpretation:

- `150 nl` confirms Song-1 loop edits are entangled with branch normalization in
  this path, so it does not provide a single-byte Song-1 loop isolate by itself.
- The `154 loop`/`154 nl` pair is currently the strongest direct loop signal.

## Addendum: `unnamed 150 lp` (Song 1 loop flip back on)

Intent mapping from latest capture pass:

- `unnamed 150 lp.xy`: from `unnamed 150 nl`, Song 1 loop flipped back on.

Against `unnamed 150 nl`:

- File size unchanged: `9559 -> 9559`.
- Pre-track unchanged: `120 -> 120` with no non-equal ops.
- Exactly two bytes change in entire file:
  - file `0x2521` / `track16+0x0169`: `01 -> 00`
  - file `0x2522` / `track16+0x016A`: `00 -> 01`

Interpretation (confidence: medium-high):

- Song 1 loop in this normalized branch appears to be encoded as a 2-byte
  selector pair at `track16+0x0169/+0x016A` (`01 00` vs `00 01`).
- Combined with the Song 2 pair (`154 loop` -> `154 nl` at `track16+0x016E`),
  this is strong evidence loop state is per-song and stored in Track 16 control
  bytes, with song-slot-specific offsets.

## Addendum: `unnamed 151 nl` (Song 3 loop on capture)

Intent mapping:

- `unnamed 151 nl.xy`: from `unnamed 151` (Song 3 baseline), loop flipped on.

Observed diffs vs `unnamed 151`:

- Size: `9499 -> 9563` (`+64`)
- Pre-track length unchanged (`124 -> 124`) with no non-equal ops.
- Tracks `9..16` all undergo the normalized-branch `+8` structural rewrite.
- Header fields stay stable (`field_0x0C=0x0000a800`, `field_0x10=0x00000200`,
  `field_0x14=0x00001112`).

Cross-check:

- `unnamed 151 nl` and `unnamed 150 lp` have identical track data; they differ in
  pre-track song-selection byte (`0x11: 0x02` vs `0x15`), consistent with
  Song 3 vs Song 1 selection.

Interpretation (confidence: medium):

- This confirms Song 3 loop-on state can be represented in the same normalized
  branch, but this file alone is not a clean on/off isolate for Song 3 because
  entering the branch rewrites Tracks `9..16`.
- The follow-up pair in the next section (`151 nl` -> `151 lp`) provides the
  clean Song 3 on/off isolate.

## Addendum: `unnamed 151 lp` (Song 3 loop flip back off)

Intent mapping:

- `unnamed 151 lp.xy`: from `unnamed 151 nl`, Song 3 loop flipped back off.

Against `unnamed 151 nl`:

- File size unchanged: `9563 -> 9563`.
- Pre-track unchanged: `124 -> 124` with no non-equal ops.
- Exactly two bytes change in entire file:
  - file `0x252D` / `track16+0x0171`: `00 -> 01`
  - file `0x252E` / `track16+0x0172`: `01 -> 00`

Interpretation (confidence: high):

- Song 3 loop in the normalized branch is a 2-byte selector pair at
  `track16+0x0171/+0x0172` (`00 01` vs `01 00`).
- Current normalized-branch loop map across songs:
  - Song 1: `track16+0x0169/+0x016A` (`01 00` off, `00 01` on)
  - Song 2: `track16+0x016E` (`01` off, `00` on)
  - Song 3: `track16+0x0171/+0x0172` (`01 00` off, `00 01` on)

## Global-Only Baseline Diff Table

Files with track blocks identical to `unnamed 1.xy`:

| File | Pre-track Delta | Baseline Span | New Span | Interpretation |
|---|---:|---|---|---|
| `unnamed 11.xy` | `-1` | `A[0x0B:0x0D] = 00 00` | `08` | Groove type variant |
| `unnamed 12.xy` | `-1` | `A[0x0B:0x0D] = 00 00` | `03` | Groove type variant |
| `unnamed 13.xy` | `-1` | `A[0x0F:0x11] = 00 00` | `01` | Song-mode candidate (Song 2 pointer/index hypothesis) |
| `unnamed 14.xy` | `-4` | `A[0x29:0x2E] = 01 40 00 00 01` | `05` | EQ low change |
| `unnamed 15.xy` | `-4` | `A[0x2D:0x32] = 01 40 00 00 01` | `05` | EQ mid change (likely mislabeled) |
| `unnamed 16.xy` | `-4` | `A[0x31:0x36] = 01 40 00 00 01` | `05` | EQ high change |

## Hypothesis (Current Confidence: Medium)

- `unnamed 13` likely changed a compact pre-track control field representing
  current song slot/index (`0x01` plausibly Song 2 in zero-based form).
- This does **not** localize full scene/song tables; it may only change a
  pointer/selection field while the main arrangement region remains untouched.

## Immediate Next Capture Set (High Value)

Use short sortable names and test in this exact order:

1. `a01_song2_empty.xy` - create/select Song 2, no other edits.
2. `a02_song3_empty.xy` - create/select Song 3, no other edits.
3. `a03_song2_scene2_empty.xy` - in Song 2, add Scene 2 to timeline, no notes.
4. `a04_song2_scene2_scene3_empty.xy` - Song 2 timeline with Scene 2 then 3.
5. `a05_scene2_only.xy` - create Scene 2 outside song timeline edits.

These are the minimum captures needed to separate:

- current-song pointer/index field,
- scene allocation metadata,
- song timeline list storage.
