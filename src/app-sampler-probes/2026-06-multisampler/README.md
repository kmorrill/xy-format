# P2-C — Multisampler zones

> **Status:** todo · Firmware **1.1.4**

Zone samples, root keys, boundaries, fill-down. T1 = **Multisampler** (engine 6), factory **`bandpasser`** OK.

## Rules

- Re-open **`h0` baseline** before each variant.
- **One zone field** per file. Note zone number in results table.
- If only factory preset: document which factory zones you edited.

## Capture procedure

| PC filename | On-device | Action |
| --- | --- | --- |
| `h0-baseline-multi.xy` | h0 | Load multisampler preset only |
| `h1-zone1-sample.xy` | h1 | Zone 1 → known built-in sample (write name) |
| `h2-zone2-sample.xy` | h2 | Zone 2 → different sample |
| `h3-zone1-root-c3.xy` | h3 | Zone 1 root → C3 (note MIDI #) |
| `h4-zone2-root-g3.xy` | h4 | Zone 2 root → G3 |
| `h5-zone1-start.xy` | h5 | Zone 1 start point only |
| `h6-fill-down-on.xy` | h6 | Zone fill-down on (if UI exists) |
| `h7-zone2-tune.xy` | h7 | Zone 2 tune only |

## Results

| PC filename | Status | Zone | Sample / field | Notes |
| --- | --- | --- | --- | --- |
| `h0-baseline-multi.xy` | ⬜ | — | | |
| `h1-zone1-sample.xy` | ⬜ | 1 | | |
| `h2-zone2-sample.xy` | ⬜ | 2 | | |
| `h3-zone1-root-c3.xy` | ⬜ | 1 | root | |
| `h4-zone2-root-g3.xy` | ⬜ | 2 | root | |
| `h5-zone1-start.xy` | ⬜ | 1 | start | |
| `h6-fill-down-on.xy` | ⬜ | | fill-down | |
| `h7-zone2-tune.xy` | ⬜ | 2 | tune | |
