# P1-B — Structural preset path @ `+0x453F`

> **Status:** captured · Firmware **1.1.4**

Pin exact null-padded preset string at track `+0x453F`. T1 only, pattern P1, **no notes**.

## Rules

- Re-open **`e0` baseline** before each variant.
- Change **only** T1 engine/preset — no notes, no other tracks.

## Capture procedure

1. New project → Save As **`e0`** → rename to `e0-baseline-empty.xy`.
2. For each row: open **e0** from project list → change T1 only → Save As.

| PC filename | On-device | Action |
| --- | --- | --- |
| `e0-baseline-empty.xy` | e0 | New project, defaults |
| `e1-t1-drum-pp.xy` | e1 | T1 Drum → preset **`pp`** |
| `e2-t1-drum-aeroplane.xy` | e2 | T1 Drum → **`nt-aeroplane`** |
| `e3-t1-sampler-106bass.xy` | e3 | T1 Sampler → **`nt-106 bass`** |
| `e4-t1-axis-accord.xy` | e4 | T1 Axis → **`nt-accord`** |
| `e5-t1-engine-only-no-preset.xy` | e5 | T1 Prism — **no preset pick** |

## Results

| PC filename | String @ T1 `+0x453F` | `project_inspection`? |
| --- | --- | --- |
| `e0-baseline-empty.xy` | `drum/boop` (factory default) | empty (pattern `0x05`) |
| `e1-t1-drum-pp.xy` | `drum/pp` | empty |
| `e2-t1-drum-aeroplane.xy` | `drum/nt-aeroplane` | empty |
| `e3-t1-sampler-106bass.xy` | `bass/nt-106 bass` | empty |
| `e4-t1-axis-accord.xy` | `wind/nt-accord` | empty |
| `e5-t1-engine-only-no-preset.xy` | `/` | empty |

Short `category/name` form — not `/fat32/presets/...`. Blank patterns need structural read at `+0x453F`; body heuristics stay empty.

Log: `docs/logs/2026-06-12_preset_path_structural.md`  
Tests: `tests/test_preset_path_structural.py`  
API: `xy/preset_path_inspection.py`
