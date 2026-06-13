# 2026-06-12 P1-B — Structural preset path @ track `+0x453F`

Fixtures: `src/preset-probes/2026-06-preset-path/`
API: `xy/preset_path_inspection.py`

## Capture

Firmware 1.1.4. T1 only, pattern P1, **no notes** (pattern type `0x05`, not
`0x07`). One engine/preset change per file vs re-opened baseline.

## Decoded strings @ `track_start(1) + 0x453F`

| File | Engine | Path string |
| --- | --- | --- |
| `e0-baseline-empty.xy` | Drum `0x03` | `drum/boop` (factory default) |
| `e1-t1-drum-pp.xy` | Drum | `drum/pp` |
| `e2-t1-drum-aeroplane.xy` | Drum | `drum/nt-aeroplane` |
| `e3-t1-sampler-106bass.xy` | Sampler `0x02` | `bass/nt-106 bass` |
| `e4-t1-axis-accord.xy` | Axis `0x16` | `wind/nt-accord` |
| `e5-t1-engine-only-no-preset.xy` | Prism `0x12` | `/` (engine swap, no preset) |

Format is **short** `category/preset-name`, not the long
`/fat32/presets/...` paths seen in drum voice slots.

Category prefix varies by engine/preset bank (`drum`, `bass`, `wind`), not
only the track engine id.

## vs `project_inspection`

Heuristic body scan (`[Pattern Presets]`) only runs on **active** patterns
(`type_byte == 0x07`). These blank captures stay `0x05`, so fragment inference
returns nothing — structural read at `+0x453F` is required for preset
identity on empty patterns.

## Tests

`tests/test_preset_path_structural.py`

## Open

- Write API: `set_track_preset_path(track, path)` (null-pad at `+0x453F`).
- Whether T2–T16 default paths on a fresh project follow the same grammar.
