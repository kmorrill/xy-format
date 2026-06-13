# 2026-06 Sample path probes (Mission 1)

> **Status:** captured · Firmware **1.1.4**

Track **1**, drum engine, kit preset **`pp`**. No pattern notes on any file.

## Round 1 (canonical) — built-in `perc` samples

On-device names were `c1-1` … `c1-4`; renamed on PC after MTP.

### Capture procedure

1. **`c1-baseline-pp.xy`** — New project → Save As baseline. T1 drum, preset `pp`, do not edit samples or add notes.
2. For each pad variant, **re-open the baseline**, change **one** pad's sample only, Save As.

| PC filename | On-device | Pad | Keyboard | Voice | MIDI key | Sample |
| --- | --- | --- | --- | --- | --- | --- |
| `c1-baseline-pp.xy` | c1-1 | — | — | — | — | `pp` defaults |
| `c1-pad01-lowf-v23-chi-box.xy` | c1-2 | 1 (leftmost) | low F | **23** | 53 (F3) | `perc` / chi box |
| `c1-pad02-v00-chi-cham.xy` | c1-3 | 2 | F# | **0** | 54 | `perc` / chi cham |
| `c1-pad03-v01-chi-flet.xy` | c1-4 | 3 | G | **1** | 55 | `perc` / chi flet |

### Decoded path strings

Stored at drum voice slot `+0x08` (128-byte slots × 24 @ track `+0x3957`).

| File | Changed voice | Path in struct |
| --- | --- | --- |
| baseline | — | all `/fat32/presets/drum/pp.preset/unnamed-….wav` |
| pad01 | 23 | `content/samples/perc/chi box.wav` |
| pad02 | 0 | `content/samples/perc/chi cham.wav` |
| pad03 | 1 | `content/samples/perc/chi flet.wav` |

### Findings

**Pad index ≠ voice index.** Leftmost pad (low F) = **voice 23**, not voice 0. Pad 2 → v0, pad 3 → v1. Only **24 voices (0–23)**.

**Two path families:** kit-embedded (`…/drum/pp.preset/unnamed-…`) vs factory picks (`content/samples/perc/…`). Track kit identity stays `drum/pp` @ `+0x453F`.

Each variant differs in **exactly one** voice slot path.

## Round 0 (superseded)

User preset `nt-z-fx` — see [`../archive-round0-nt-z-fx/README.md`](../archive-round0-nt-z-fx/README.md).

Log: `docs/logs/2026-06-12_drum_sample_path_inspection.md`  
Tests: `tests/test_drum_sample_inspection.py`
