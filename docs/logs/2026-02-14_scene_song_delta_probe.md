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
