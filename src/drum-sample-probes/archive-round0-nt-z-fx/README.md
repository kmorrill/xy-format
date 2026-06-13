# Round 0 — user preset `nt-z-fx` sample swaps (superseded)

> **Status:** captured · Firmware **1.1.4**

Track 1, drum kit **`pp`**. Samples from user FX preset **`nt-z-fx`**. Superseded by round 1 ([`../2026-06-sample-paths/README.md`](../2026-06-sample-paths/README.md)) which uses readable `chi *` names — still decoded and shows **family B** paths.

## Capture procedure

Same as round 1: re-open baseline between pad swaps; one pad per file. Assign samples from **`nt-z-fx`** user preset instead of built-in `perc`.

| PC filename | Pad | Voice | MIDI | Slot path after change |
| --- | --- | --- | --- | --- |
| `c0-baseline-pp.xy` | — | — | — | all `…/drum/pp.preset/unnamed-….wav` |
| `c0-pad01-lowf-v23-nt-z-fx-a2-3.xy` | 1, low F | **23** | F3 | `/fat32/presets/fx/nt-z-fx.preset/unnamed-a2-3.wav` |
| `c0-pad02-v00-nt-z-fx-a3-3.xy` | 2 | **0** | F#3 | `/fat32/presets/fx/nt-z-fx.preset/unnamed-a3-3.wav` |
| `c0-pad03-v01-nt-z-fx-b2-4.xy` | 3 | **1** | G3 | `/fat32/presets/fx/nt-z-fx.preset/unnamed-b2-4.wav` |

UI showed `nt-z-fx/unnamed-a2-3` — full decoded path includes preset bundle.

## Findings

1. Track kit stays **`pp`** @ `+0x453F` even when pad uses `nt-z-fx` sample.
2. Slot path uses category **`fx`**: `/fat32/presets/fx/nt-z-fx.preset/unnamed-<id>.wav`
3. Same pad→voice map as round 1: pad1=v23, pad2=v0, pad3=v1.

Log: `docs/logs/2026-06-12_round0_nt-z-fx_sample_paths.md`  
Tests: `tests/test_drum_sample_inspection_round0.py`
