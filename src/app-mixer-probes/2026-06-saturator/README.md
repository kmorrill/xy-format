# P2-G — Master saturator (gain / clip / tone / mix)

> **Status:** captured · Firmware **1.1.4**

Device-validate global master saturator storage. Fresh project; **Master → Saturator**; one control per file.

## Rules

- Re-open **`sat0` baseline** before each variant.
- Change **one** saturator knob per file.
- Do not touch EQ during this pack.

## Capture procedure

1. New project → don't touch saturator → `sat0` (`sat0-baseline.xy` on PC).
2. Re-open sat0 → set **one** control → Save As per table.

| PC filename | On-device | UI change |
| --- | --- | --- |
| `sat0-baseline.xy` | sat0 | fresh project |
| `sat1-gain-min.xy` | sat1 | Gain → minimum |
| `sat2-gain-max.xy` | sat2 | Gain → maximum |
| `sat3-clip-min.xy` | sat3 | Clip → minimum |
| `sat4-clip-max.xy` | sat4 | Clip → maximum |
| `sat5-tone-min.xy` | sat5 | Tone → minimum |
| `sat6-tone-max.xy` | sat6 | Tone → maximum |
| `sat7-mix-min.xy` | sat7 | Mix → minimum |
| `sat8-mix-max.xy` | sat8 | Mix → maximum |

## Results

| PC filename | Gain `@0x78` | Clip `@0x7C` | Tone `@0x80` | Mix `@0x84` |
| --- | --- | --- | --- | --- |
| `sat0-baseline.xy` | `0x19` | `0x19` | `0x40` | `0x00` |
| `sat1-gain-min.xy` | `0x00` | `0x19` | `0x40` | `0x00` |
| `sat2-gain-max.xy` | `0x7F` | `0x19` | `0x40` | `0x00` |
| `sat3-clip-min.xy` | `0x19` | `0x00` | `0x40` | `0x00` |
| `sat4-clip-max.xy` | `0x19` | `0x7F` | `0x40` | `0x00` |
| `sat5-tone-min.xy` | `0x19` | `0x19` | `0x00` | `0x00` |
| `sat6-tone-max.xy` | `0x19` | `0x19` | `0x7F` | `0x00` |
| `sat7-mix-min.xy` | `0x19` | `0x19` | `0x40` | `0x00` (= baseline) |
| `sat8-mix-max.xy` | `0x19` | `0x19` | `0x40` | `0x7F` |

**Encoding:** four u32 groups; level byte at `u32+3`. Min=`0x00`, max=`0x7F`.

Log: `docs/logs/2026-06-12_master_saturator_inspection.md`  
Tests: `tests/test_master_saturator_inspection.py`  
API: `xy/master_saturator_inspection.py`
