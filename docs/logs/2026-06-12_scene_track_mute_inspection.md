# Scene track mute inspection (P2-E)

**Date:** 2026-06-12  
**Firmware:** 1.1.4  
**Fixtures:** `src/scene-probes/2026-06-track-mutes/`
**Operator README:** `src/scene-probes/2026-06-track-mutes/README.md`

## Summary

Per-scene track mutes are **not** stored with mixer volumes on track structs.
They live in the **33-byte scene slot** mute region (`slot + 16 .. slot + 31`),
separate from P2-D volume bytes (`track+0x38FE`).

Muted tracks use byte value **`0x02`**; unmuted = `0x00`. This matches
`build_arrangement` / `tests/test_image_writer.py`.

**Slot routing:** scene **N** → slot **N − 1** (scene 1 → slot 0; scene 2 →
slot 1; …). Same row as that scene's pattern selection. Arrange-view mutes
(scene 2+) store the same bytes as mixer-view mutes (scene 1).

## Slot layout (recap)

| Offset in slot | Field |
| --- | --- |
| `+0..15` | pattern sel per track |
| `+16..31` | mute per track |
| `+32` | row-present flag (`0x01` populated, `0x00` empty trailing row in current fixtures) |

Follow-up local scan (2026-06-13): single-scene mute captures flag only slot 0;
clean two-scene volume captures flag slots 0 and 1; the eight-scene mute baseline
flags slots 0..7. `xy.scene_volume_inspection` exposes this as
`read_scene_slot_flag()` / `read_present_scene_slots()` and
`SceneVolumeInspection.present_scene_slots`.

## Scene 1 captures (single-scene project)

| File | Muted tracks | Storage |
| --- | --- | --- |
| `mute-#-#-#-#.xy` | — | slot 0 all `0` |
| `mute-1-3-6-7.xy` | 1,3,6,7 | slot 0 |
| `mute-2-7-8-#.xy` | 2,7,8 | slot 0 (3 mute bytes only vs baseline) |
| `mute-3-4-5-6.xy` | 3,4,5,6 | slot 0 |

## Scene 2+ captures (8-scene / 8-pattern T1 project)

Baseline: `mute#-#-#-#-#.xy` — 8 patterns on T1 (steps 1–16), no mutes.

| File | Scene | Muted tracks | Slot |
| --- | --- | --- | --- |
| `mute2-1-7-8-#.xy` | 2 | 1,7,8 | 1 |
| `mute3-1-7-8-#.xy` | 3 | 1,7,8 | 2 |
| `mute3-2-3-6-7.xy` | 3 | 2,3,6,7 | 2 |
| `mute4-6-7-8-#.xy` | 4 | 6,7,8 | 3 ⚠️ ~1.5k pattern-region noise |
| `mute5-2-4-6-7.xy` | 5 | 2,4,6,7 | 4 |
| `mute6-1-7-8-#.xy` | 6 | 1,7,8 | 5 |
| `mute7-2-3-6-7.xy` | 7 | 2,3,6,7 | 6 |
| `mute8-6-7-8-#.xy` | 8 | 6,7,8 | 7 |

Touching scene *N* also bumps `GLOBAL+0x6` (stored scene count − 1). Incremental
clone saves can differ in decoded image size vs a fresh baseline re-save; tests
compare **scene-region mute bytes** only.

## API

`xy/scene_volume_inspection.py`:

- `scene_mute_storage_slot(scene)` → 0-based slot index
- `read_scene_slot_mute_bytes(project, scene_slot)`
- `read_scene_muted_tracks(project, scene_slot)` → 1-based track numbers

## Related

- P2-D scene volumes: `docs/logs/2026-06-12_scene_volume_inspection.md`
- Writer: `xy/image_writer.py` (`SCENE_MUTE_VALUE = 2` in arrangement builder)
