# 2026-06-12 P2-A — Static mixer fields (f0–f24)

Fixtures: `src/mixer-probes/2026-06-static/`
Operator notes: `src/mixer-probes/2026-06-static/README.md`

Firmware 1.1.4. New project, T1 default engine, no p-locks, no pattern notes.

## Encoding pattern

Most mix knobs use a **4-byte LE u32** with the **high byte** (`u32_start+3`)
holding the level (`0x00` min … default … `0x7F` max). Max often sets the
preceding three bytes to `0xFF` (`u32 = 0x7FFFFFFF`).

Follow-up exact u32 pin (2026-06-13): track mix fields use full-lane min/max
(`0x00000000` / `0x7FFFFFFF`). Master group fields also max to
`0x7FFFFFFF`, but their min captures preserve a nonzero tail:
`0x00A3D70A` (visible byte `0x00`). Tests assert the full u32 lanes so byte-level
normalization does not get flattened to only the UI byte.

## Per-track mix (same offsets on every track struct)

| Control | u32 @ | byte @ | T1 default | min | max |
| --- | --- | --- | --- | --- | --- |
| Volume | `+0x38FB` | `+0x38FE` | `0x60` | `f1`/`f18` → `0x00` | `f2`/`f19` → `0x7F` |
| Pan | `+0x38F7` | `+0x38FA` | `0x40` center | `f3`/`f20` → `0x00` | `f4`/`f21` → `0x7F` |
| Send FX I | `+0x38AF` | `+0x38B2` | `0x00` (T1) | `f7`/`f23` → `0x00` | `f6`/`f22` → `0x7F` |
| Send FX II | `+0x38B3` | `+0x38B6` | `0x00` (T1) | `f9` → `0` | `f8`/`f24` → `0x7F` |

**f16–f24** confirm offsets are **per-track** (T2–T8 edits land on that track's
struct at the same relative offsets as T1).

### Non-zero send defaults on `f0`

Some tracks ship with non-zero FX send bytes on a fresh project (not T1):

| Track | send FX1 | send FX2 |
| --- | --- | --- |
| T4 | `0x00` | `0x1E` |
| T5 | `0x0F` | `0x33` |
| T6 | `0x00` | `0x14` |
| T7 | `0x57` | `0x43` |

`f23` (T7 send FX1 min) clears `+0x38B2` to `0x00` and normalizes the u32
group (6 bytes touched vs 1 on T1 `f7`).

## Master (global header)

| Control | u32 @ | byte @ | f0 default | min | max |
| --- | --- | --- | --- | --- | --- |
| Percussion group | `0x85` | `0x88` | `0x40` | `f10` → `0x00` | `f11` → `0x7F` |
| Melody group | `0x89` | `0x8C` | `0x40` | `f12` → `0x00` | `f13` → `0x7F` |
| Compressor | `0x8D` | `0x90` | `0x0C` | `f14` → `0x00` | `f15` → `0x7F` |
| Master volume | `0x91` | `0x94` | `0x40` | `f16` → `0x00` | `f17` → `0x7F` |

Matches P2-D `s5b` master field.

## Side effects (ignore for decode)

- `track+0x11` pristine u16 `0x08` → `0x00` on most mix edits.
- Visiting master/mix (M4) pages sets `T9..T16` `+0x38F2` and `+0x38F6` to
  `0x40` in many captures — UI-session bytes, not the knob under test.

## API

`xy/mixer_static_inspection.py` — `inspect_static_mixer_bytes`, per-track
`volume` / `pan` / `send_fx1` / `send_fx2`, plus master group fields.

Tests: `tests/test_mixer_static_inspection.py` (30 cases)

## Open

- Write API (`set_track_mixer`, `set_master_mixer`).
- Whether T9–T16 aux/FX tracks use the same offset map (not probed here).
