# P2-D — Scene-stored track volumes

> **Status:** captured (s3/s3b optional — not done) · Firmware **1.1.4**

Find per-scene track volume storage (guide claims scenes store volumes).

## Rules

- When editing Scene 2 volumes, **re-open baseline** — do not chain from s1.
- One volume change per file where possible.

## Capture procedure — series A (`s0`, flawed)

Same pattern on both scenes — device may not persist distinct scene state.

1. Create project with **Scene 1 and Scene 2** (same pattern) → `s0-baseline-2scenes.xy`.
2. **s1:** Open s0 → Scene **1** active → T1 volume **low** → save.
3. **s2:** Open **s0** again → Scene **2** active → T1 volume **high** → save.
4. **s3:** Open s0 → Scene 1 → T2 volume low only → save.
5. **s5:** Open s0 → Scene 1 → **master** volume change only → save.
6. **s4:** *(optional)* Toggle scenes on device without resave — sanity only.

| PC filename | On-device | Procedure |
| --- | --- | --- |
| `s0-baseline-2scenes.xy` | s0 | 2 scenes, same pattern, default volumes |
| `s1-scene1-t1-vol-low.xy` | s1 | Scene 1 → T1 vol low |
| `s2-scene2-t1-vol-high.xy` | s2 | Re-open s0 → Scene 2 → T1 vol high |
| `s3-scene1-t2-vol-low.xy` | s3 | Scene 1 → T2 vol low |
| `s4-switch-scene-compare.xy` | s4 | Optional — no resave |
| `s5-scene1-master-vol.xy` | s5 | Scene 1 → master vol change |

## Capture procedure — series B (`s0b`, canonical)

Distinct patterns per scene: P1 steps 1–8 vs P2 steps 9–16 on T1.

1. **s0b** — baseline: 2 scenes, default volumes; T1 has P1 + P2 patterns; scene 1 uses P1, scene 2 uses P2 (Arrange → Clone).
2. **s1b:** Open s0b → Scene **1** active → T1 volume **low** → save.
3. **s2b:** Open **s0b** again → Scene **2** active → T1 volume **high** → save.
4. **s3b:** Open s0b → Scene 1 → T2 volume low only → save.
5. **s5b:** Open s0b → Scene 1 → **master** volume change only → save.

| PC filename | On-device | Procedure |
| --- | --- | --- |
| `s0b-baseline-2scenes.xy` | s0b | 2 scenes, distinct patterns |
| `s1b-scene1-t1-vol-low.xy` | s1b | Scene 1 → T1 vol low |
| `s2b-scene2-t1-vol-high.xy` | s2b | Re-open s0b → Scene 2 → T1 vol high |
| `s3b-scene1-t2-vol-low.xy` | s3b | Scene 1 → T2 vol low |
| `s5b-scene1-master-vol.xy` | s5b | Scene 1 → master vol change |

## Results

### Series A (regression only)

| PC filename | Notes |
| --- | --- |
| `s0-baseline-2scenes.xy` | flawed baseline |
| `s1-scene1-t1-vol-low.xy` | T1 `+0x38FE` → `0x00` |
| `s2-scene2-t1-vol-high.xy` | ⚠️ 16+ spurious diffs — do not use for decode |
| `s5-scene1-master-vol.xy` | master `+0x94` |

### Series B (canonical)

| PC filename | Decoded | Operator playback notes |
| --- | --- | --- |
| `s0b-baseline-2scenes.xy` | T1 vol `0x60`, master `0x40` | |
| `s1b-scene1-t1-vol-low.xy` | Scene 1 T1 → **T1+0x38FE** `0x00` | scene 2 still sounded low |
| `s2b-scene2-t1-vol-high.xy` | Scene 2 T1 → **T2+0x38FE** `0x7F` | |
| `s3b-scene1-t2-vol-low.xy` | ⬜ not captured | |
| `s5b-scene1-master-vol.xy` | global **+0x94** `0x7F` | |

Volumes are **not** in 33-byte scene slots. Scene 2 T1 stores on **T2** struct (`T + S − 1`). Playback may still be global on 1.1.4.

Log: `docs/logs/2026-06-12_scene_volume_inspection.md`  
Tests: `tests/test_scene_volume_inspection.py`  
API: `xy/scene_volume_inspection.py`
