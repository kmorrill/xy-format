# P2-E — Scene-stored track mutes

> **Status:** captured (scene 1 + scene 2–8) · Firmware **1.1.4**

Device-validate per-scene track mute bytes (separate from volumes). Volumes on track struct (`+0x38FE`); mutes in scene slots (`GLOBAL+0x95`).

## Rules

- Filename: `mute<N>-<t1>-<t2>-<t3>-<t4>.xy` — scene **N**, muted tracks **1–8**; `#` = unused slot.
- Re-open **baseline** before each variant when possible.
- Scene 2+ uses **two-scene** project with distinct patterns (same recipe as [`../2026-06-volumes/README.md`](../2026-06-volumes/README.md) series B).

## Capture procedure — Scene 1 (single-scene project)

1. New project, **Scene 1** only, no mutes → `mute-#-#-#-#.xy`.
2. Re-open baseline → mute tracks per table → Save As.

| PC filename | On-device | Scene | Muted tracks |
| --- | --- | --- | --- |
| `mute-#-#-#-#.xy` | mute-#-#-#-# | 1 | *(none)* |
| `mute-1-3-6-7.xy` | mute-1-3-6-7 | 1 | T1, T3, T6, T7 |
| `mute-2-7-8-#.xy` | mute-2-7-8-# | 1 | T2, T7, T8 |
| `mute-3-4-5-6.xy` | mute-3-4-5-6 | 1 | T3, T4, T5, T6 |

## Capture procedure — Scene 2+

**Baseline `mute#-#-#-#-#`:** 8 patterns on T1 for 8 unique scenes — pat1 kick steps 1+2 → scene 1, pat2 steps 3+4 → scene 2, … pat8 steps 15+16 → scene 8. No mutes on any scene.

For each `mute<n>-<a>-<b>-<c>-<d>`: clone baseline, select scene **n**, mute tracks **a–d** via **arrange view** (scene 1 used mixer view — same bytes confirmed).

**Slot index:** scene **N** → slot **N − 1**. Muted byte **`0x02`**.

**Pitfall:** if scene 2 mutes leak into baseline before save, `mute2-*` diffs look noisy. Re-save baseline with no mutes before promoting.

| PC filename | Scene | Muted tracks |
| --- | --- | --- |
| `mute#-#-#-#-#.xy` | — | none (baseline) |
| `mute2-1-7-8-#.xy` | 2 | T1, T7, T8 |
| `mute3-1-7-8-#.xy` | 3 | T1, T7, T8 |
| `mute3-2-3-6-7.xy` | 3 | T2, T3, T6, T7 |
| `mute4-6-7-8-#.xy` | 4 | T6–T8 (optional re-capture) |
| `mute5-2-4-6-7.xy` | 5 | T2, T4, T6, T7 |
| `mute6-1-7-8-#.xy` | 6 | T1, T7, T8 |
| `mute7-2-3-6-7.xy` | 7 | T2, T3, T6, T7 |
| `mute8-6-7-8-#.xy` | 8 | T6–T8 |

## Results

Scene 1: slot 0 mute bytes `0x02` for listed tracks. Scene 2+: slot **N−1**. Only 4 mute bytes change vs baseline per file.

Log: `docs/logs/2026-06-12_scene_track_mute_inspection.md`  
Tests: `tests/test_scene_track_mute_inspection.py`  
API: `scene_mute_storage_slot`, `read_scene_muted_tracks` in `xy/scene_volume_inspection.py`
