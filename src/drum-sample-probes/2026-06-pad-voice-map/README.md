# M6 — Pad → voice map (non-`pp` kit)

> **Status:** todo · Firmware **1.1.4**

Confirm pad→voice index on drum kit **`nt-aeroplane`** (same procedure as Mission 1 / `pp`).

## Rules

- Re-open **`k0` baseline** before each pad swap.
- **One pad** sample change per file.
- Use **built-in** samples with readable names (like `chi box`).
- No pattern notes.

## Capture procedure

1. T1 Drum → **`nt-aeroplane`** → `k0-baseline-aeroplane.xy` (`k0`).
2. Re-open k0 → change **one pad** sample → save:

| PC filename | On-device | Pad | Sample (built-in) |
| --- | --- | --- | --- |
| `k0-baseline-aeroplane.xy` | k0 | — | kit defaults |
| `k1-pad01-lowf-sample.xy` | k1 | 1 (leftmost low F) | e.g. chi box |
| `k2-pad02-sample.xy` | k2 | 2 | different sample |
| `k3-pad03-sample.xy` | k3 | 3 | different sample |

## Results (compare to `pp` map: pad1=v23, pad2=v0, pad3=v1)

| PC filename | Status | Pad | Key | Voice | Path in struct |
| --- | --- | --- | --- | --- | --- |
| `k0-baseline-aeroplane.xy` | ⬜ | — | — | — | all aeroplane paths |
| `k1-pad01-lowf-sample.xy` | ⬜ | 1 | | | |
| `k2-pad02-sample.xy` | ⬜ | 2 | | | |
| `k3-pad03-sample.xy` | ⬜ | 3 | | | |
