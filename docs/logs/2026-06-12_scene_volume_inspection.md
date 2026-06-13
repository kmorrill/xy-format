# 2026-06-12 P2-D — Scene-stored track volumes

Fixtures: `src/scene-probes/2026-06-volumes/`
Operator notes: `src/scene-probes/2026-06-volumes/README.md`

## Setup

Firmware 1.1.4. Two-scene projects; **s0b** baseline uses distinct patterns
(P1 steps 1–8 vs P2 steps 9–16 on T1) so the device persists both scenes.
The first **s0** attempt (identical patterns) did not isolate scene state —
use **s0b** as canonical.

## Track volume field

Per-track mixer volume is a **4-byte u32** at **track+0x38FB** (volume byte
at **track+0x38FE**, high byte of the little-endian word):

| UI | byte @ +0x38FE | u32 @ +0x38FB |
| --- | --- | --- |
| min | `0x00` | `0x00000000` |
| default | `0x60` | `0x60000000` |
| max | `0x7F` | `0x7FFFFFFF` (low 3 bytes `FF`) |

Default track level `0x60` ≈ 75 on the 0..0x7F scale.

## Master volume

**Global** `+0x91..+0x94` (byte at **+0x94**). Same u32 pattern.

| File | Change |
| --- | --- |
| `s5b-scene1-master-vol.xy` | `0x40` → `0x7F` (operator: UI 50 → 100) |

Master default `0x40` ≈ 50 UI.

## Scene routing (partial)

Volumes are **not** in the 33-byte scene slots (`GLOBAL+0x95`).

| Capture | Scene | Track | Storage | Diff |
| --- | --- | --- | --- | --- |
| `s1b-scene1-t1-vol-low.xy` | 1 | T1 | **T1** `+0x38FE` | `0x60` → `0x00` (1 byte) |
| `s2b-scene2-t1-vol-high.xy` | 2 | T1 | **T2** `+0x38FE` | `0x60` → `0x7F` (+ `FF` prefix bytes) |

Hypothesis: scene `S` track `T` volume → struct **track `T + (S − 1)`** at
`+0x38FB`. Confirmed for `(S,T) = (1,1)` and `(2,1)` only.

`s2b` also changes `GLOBAL+0x06` (later HDR probes identify this byte as the
active scene slot, not a scene count) and allocates empty scene slot 2
(flags `0`).

Follow-up (2026-06-13): the raw global byte is not a populated row count. In
canonical two-scene fixtures, `s0b`, `s1b`, and `s5b` read `GLOBAL+0x06 = 1`
while scene slot flags are `(1, 1, 0, ...)`; `s2b` reads `2` with the same
populated flags. HDR probes close `GLOBAL+0x06` as active scene slot. Use
`present_scene_slots` / `present_scene_count` for populated scene rows.

## Operator playback vs bytes

Operator reports: after scene 1 T1 low, **switching to scene 2 still sounds
low** — audible mix behaves **global**, not per-scene, despite separate bytes
for scene 2 on the T2 struct in `s2b`. Treat scene volume **storage** as
decoded; **playback routing** needs chained captures (edit scene 1, then scene
2 **without** re-opening baseline) or firmware retest.

## Flawed s0 series

`s0`/`s1`/`s2`/`s5` (no distinct patterns): `s2` touches 16+ unrelated
offsets (`0x40` scatter) — do not use for volume decode.

## API

`xy/scene_volume_inspection.py` — `inspect_scene_volumes_bytes`,
`read_scene_track_volume(scene, track)`, `scene_volume_storage_track`.

Tests: `tests/test_scene_volume_inspection.py`

## Open

- Full 16×scene volume matrix / storage track formula for all `S,T`.
- Whether scene 2+ volumes ever drive playback on 1.1.4.
- Pan / send per scene (not probed).
- Write API (`set_track_mix_volume`, `set_master_volume`).
