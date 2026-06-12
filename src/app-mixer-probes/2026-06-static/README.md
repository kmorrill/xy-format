# P2-A — Static mixer (vol / pan / fx1/fx2 send) and master

> **Status:** captured (f0–f24) · Firmware **1.1.4**

Find current-value bytes for mix knobs (not p-lock table only). New project; T1 any engine; **no p-locks**.

## Rules

- Re-open **`f0` baseline** before each variant. (When two fixtures alter the same values sequentially, may derive from each other instead of f0.)
- **One knob** per file. Record UI value in table.
- Do not add pattern notes.

## Capture procedure

1. New project → don't touch mix → `f0-baseline-mix-default.xy` (on-device `f0`).
2. Re-open f0 → change **one** control → Save As per table.

| PC filename | On-device | UI change (T1 unless noted) |
| --- | --- | --- |
| `f0-baseline-mix-default.xy` | f0 | — |
| `f1-t1-vol-min.xy` | f1 | Track volume → min |
| `f2-t1-vol-max.xy` | f2 | Track volume → max |
| `f3-t1-pan-hard-left.xy` | f3 | Pan → hard left |
| `f4-t1-pan-hard-right.xy` | f4 | Pan → hard right |
| `f5-t1-pan-center.xy` | f5 | Pan → center |
| `f6-t1-send-fx1-max.xy` | f6 | Send FX1 max |
| `f7-t1-send-fx1-min.xy` | f7 | Send FX1 min |
| `f8-t1-send-fx2-max.xy` | f8 | Send FX2 max |
| `f9-t1-send-fx2-min.xy` | f9 | Send FX2 min |
| `f10-master-perc-vol-0.xy` | f10 | Master percussion volume 0 |
| `f11-master-perc-vol-100.xy` | f11 | Master percussion volume 100 |
| `f12-master-melody-vol-0.xy` | f12 | Master melody volume 0 |
| `f13-master-melody-vol-100.xy` | f13 | Master melody volume 100 |
| `f14-master-compressor-min.xy` | f14 | Master compressor min |
| `f15-master-compressor-max.xy` | f15 | Master compressor max |
| `f16-master-master-vol-0.xy` | f16 | Master master volume 0 |
| `f17-master-master-vol-100.xy` | f17 | Master master volume 100 |
| `f18-t2-vol-min.xy` | f18 | T2 volume min |
| `f19-t3-vol-max.xy` | f19 | T3 volume max |
| `f20-t4-pan-left.xy` | f20 | T4 pan hard left |
| `f21-t5-pan-right.xy` | f21 | T5 pan hard right |
| `f22-t6-send-fx1-max.xy` | f22 | T6 send FX1 max |
| `f23-t7-send-fx1-min.xy` | f23 | T7 send FX1 min |
| `f24-t8-send-fx2-max.xy` | f24 | T8 send FX2 max |

## Results

| PC filename | Decoded |
| --- | --- |
| `f0-baseline-mix-default.xy` | T1 vol `0x60`, pan `0x40`, sends `0` |
| `f1-t1-vol-min.xy` | T1 `+0x38FE` → `0x00` |
| `f2-t1-vol-max.xy` | T1 `+0x38FE` → `0x7F` |
| `f3-t1-pan-hard-left.xy` | T1 `+0x38FA` → `0x00` |
| `f4-t1-pan-hard-right.xy` | T1 `+0x38FA` → `0x7F` |
| `f5-t1-pan-center.xy` | T1 `+0x38FA` → `0x40` |
| `f6-t1-send-fx1-max.xy` | T1 `+0x38B2` → `0x7F` |
| `f7-t1-send-fx1-min.xy` | T1 `+0x38B2` → `0` |
| `f8-t1-send-fx2-max.xy` | T1 `+0x38B6` → `0x7F` |
| `f9-t1-send-fx2-min.xy` | T1 `+0x38B6` → `0` |
| `f10`–`f17` | global `+0x88`/`+0x8C`/`+0x90`/`+0x94` |
| `f18`–`f24` | per-track struct offsets confirmed T2–T8 |

**Side effect (ignore):** visiting M4/master pages can set `T9..T16` `+0x38F2`/`+0x38F6` → `0x40`.

Log: `docs/logs/2026-06-12_mixer_static_inspection.md`  
Tests: `tests/test_mixer_static_inspection.py`  
API: `xy/mixer_static_inspection.py`
