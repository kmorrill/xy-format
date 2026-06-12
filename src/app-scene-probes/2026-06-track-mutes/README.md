# P2-E — Scene track mute fixtures

> **Status:** captured (scene 1 + scene 2–8)

**Capture procedure:**
[`user_probes/2026-06-track-mutes/README.md`](../../../../user_probes/2026-06-track-mutes/README.md)

### Scene 1 (single-scene)

| File | Muted tracks (slot 0) |
| --- | --- |
| `mute-#-#-#-#.xy` | none |
| `mute-1-3-6-7.xy` | T1, T3, T6, T7 |
| `mute-2-7-8-#.xy` | T2, T7, T8 |
| `mute-3-4-5-6.xy` | T3–T6 |

### Scene 2+ (8-scene baseline `mute#-#-#-#-#.xy`)

| File | Scene | Muted tracks (slot N−1) |
| --- | --- | --- |
| `mute2-1-7-8-#.xy` | 2 | T1, T7, T8 (slot 1) |
| `mute3-1-7-8-#.xy` | 3 | T1, T7, T8 (slot 2) |
| `mute3-2-3-6-7.xy` | 3 | T2, T3, T6, T7 (slot 2) |
| `mute4-6-7-8-#.xy` | 4 | T6–T8 (slot 3; optional re-capture) |
| `mute5-2-4-6-7.xy` | 5 | T2, T4, T6, T7 (slot 4) |
| `mute6-1-7-8-#.xy` | 6 | T1, T7, T8 (slot 5) |
| `mute7-2-3-6-7.xy` | 7 | T2, T3, T6, T7 (slot 6) |
| `mute8-6-7-8-#.xy` | 8 | T6–T8 (slot 7) |

Log: `docs/logs/2026-06-12_scene_track_mute_inspection.md`  
Tests: `tests/test_scene_track_mute_inspection.py`  
API: `scene_mute_storage_slot`, `read_scene_muted_tracks` in `xy/scene_volume_inspection.py`
