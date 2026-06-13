# P2-F — Master EQ (bass / mid / treble)

> **Status:** captured · Firmware **1.1.4**

Device-validate global master EQ storage. Fresh project; **Master → EQ**; one band per file. Saturator follows EQ @ `0x75`–`0x84` — see [`../2026-06-saturator/README.md`](../2026-06-saturator/README.md).

## Rules

- Re-open **`eq0` baseline** before each variant.
- Change **one EQ control** per file (bass / mid / treble / blend).
- Do not touch saturator during this pack.

## Capture procedure

1. New project → don't touch EQ → save as `eq0` (`eq0-baseline.xy` on PC).
2. Re-open eq0 → set **one** band → Save As per table.

| PC filename | On-device | UI change |
| --- | --- | --- |
| `eq0-baseline.xy` | eq0 | fresh project (EQ default) |
| `eq1-bass-min.xy` | eq1 | Bass EQ → minimum |
| `eq2-bass-max.xy` | eq2 | Bass EQ → maximum |
| `eq3-mid-min.xy` | eq3 | Mid EQ → minimum |
| `eq4-mid-max.xy` | eq4 | Mid EQ → maximum |
| `eq5-treble-min.xy` | eq5 | Treble EQ → minimum |
| `eq6-treble-max.xy` | eq6 | Treble EQ → maximum |
| `eq7-blend-min.xy` | eq7 | EQ power/blend (4th knob) → minimum |
| `eq8-blend-max.xy` | eq8 | Re-open eq0 → EQ power/blend → maximum |

## Results

| PC filename | `0x68` bass | `0x6C` mid | `0x70` treble | Notes |
| --- | --- | --- | --- | --- |
| `eq0-baseline.xy` | `0x40` | `0x40` | `0x40` | |
| `eq1-bass-min.xy` | `0x00` | `0x40` | `0x40` | |
| `eq2-bass-max.xy` | `0x7F` | `0x40` | `0x40` | sat tail + bass |
| `eq3-mid-min.xy` | `0x40` | `0x00` | `0x40` | |
| `eq4-mid-max.xy` | `0x40` | `0x7F` | `0x40` | |
| `eq5-treble-min.xy` | `0x40` | `0x40` | `0x00` | |
| `eq6-treble-max.xy` | `0x40` | `0x40` | `0x7F` | |
| `eq7-blend-min.xy` | `0x40` | `0x40` | `0x40` | **byte-identical to eq0** |
| `eq8-blend-max.xy` | `0x7F` | `0x7F` | `0x7F` | all bands max |

**Blend / 4th knob:** power min = no header change; power max = all bands `0x7F`. Byte `@0x74` unchanged — likely not a stored 4th param on 1.1.4.

Log: `docs/logs/2026-06-12_master_eq_inspection.md`, `docs/logs/2026-06-12_master_eq_blend_inspection.md`  
Tests: `tests/test_master_eq_inspection.py`  
API: `xy/master_eq_inspection.py`
