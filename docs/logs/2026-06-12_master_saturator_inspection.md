# Master saturator inspection (P2-G)

**Date:** 2026-06-12  
**Firmware:** 1.1.4  
**Fixtures:** `src/mixer-probes/2026-06-saturator/`
**Operator README:** `src/mixer-probes/2026-06-saturator/README.md`

## Summary

Master saturator is **global**, stored immediately **after** master EQ in the
project header. Four u32 fields use the **mixer-style** encoding (level byte at
`u32_start + 3`), not the EQ-style first-byte encoding.

| Control | u32 @ | Level byte | Default | Min | Max |
| --- | --- | --- | --- | --- | --- |
| Gain | `0x75` | `0x78` | `0x19` | `0x00` | `0x7F` |
| Clip | `0x79` | `0x7C` | `0x19` | `0x00` | `0x7F` |
| Tone | `0x7D` | `0x80` | `0x40` | `0x00` | `0x7F` |
| Mix | `0x81` | `0x84` | `0x00` | `0x00` | `0x7F` |

Fresh-project defaults for gain/clip/tone/mix are already present in `sat0`
(identical to `eq0` in the `0x74–0x87` region).

**Mix min** (`sat7`) is byte-identical to baseline — default mix is already `0`.

Follow-up exact u32 pin (2026-06-13): min captures store `0x00000000`, max
captures store `0x7FFFFFFF`. Defaults are:

| Control | Default u32 |
| --- | --- |
| Gain | `0x1999999A` |
| Clip | `0x1999999A` |
| Tone | `0x40000000` |
| Mix | `0x00000000` |

Tests now assert both the UI byte and the full u32 lane for all P2-G captures.

## Correction vs P2-F hypothesis

Bass EQ max (`eq2`) touches `0x65–0x67`, not because saturator lives @ `0x64`,
but because those are tail bytes of the u32 starting @ `0x64` (`0xFF` default
prefix). Saturator knobs start @ `0x75`.

## Neighbour fields

| Offset | Observed default | Notes |
| --- | --- | --- |
| `0x64` | `0xFF` | Untouched by sat probes; purpose open |
| `0x74` | `0x40` | Untouched; possible EQ blend (guide mentions blend) |

## API

`xy/master_saturator_inspection.py` — `read_master_saturator`

## Tests

`tests/test_master_saturator_inspection.py` — 14 cases
