# Master EQ inspection (P2-F)

**Date:** 2026-06-12  
**Firmware:** 1.1.4  
**Fixtures:** `src/mixer-probes/2026-06-eq/`
**Operator README:** `src/mixer-probes/2026-06-eq/README.md`

## Summary

Master EQ is **global** in the project header — three adjacent 4-byte LE fields:

| Band | Offset | Default byte |
| --- | --- | --- |
| Bass (low) | `0x68` | `0x40` |
| Mid | `0x6C` | `0x40` |
| Treble (high) | `0x70` | `0x40` |

**Level byte** is the **first byte** of each field (unlike static mixer volumes
where the level byte is at `u32+3`).

| UI | Level byte |
| --- | --- |
| Min | `0x00` |
| Center (default) | `0x40` |
| Max | `0x7F` |

**Min** probes change only the band’s level byte. **Max** probes also set the
upper 3 bytes of the **preceding** 4-byte field to `0xFF`:

- Bass max → `0x65–0x67` (tail of saturator field @ `0x64`) + `0x68 = 0x7F`
- Mid max → `0x69–0x6B` (tail of bass) + `0x6C = 0x7F`
- Treble max → `0x6D–0x6F` (tail of mid) + `0x70 = 0x7F`

The field @ `0x64` (default `0xFF`) is **not** saturator gain — P2-G placed
saturator @ `0x75–0x84`. Bass max tail bytes are spill into the `0x64` u32.

Follow-up exact u32 pin (2026-06-13):

| Capture | prefix `0x64` | bass `0x68` | mid `0x6C` | treble `0x70` | `0x74` |
| --- | --- | --- | --- | --- | --- |
| `eq0` default | `0x000000FF` | `0x00000040` | `0x00000040` | `0x00000040` | `0x99999A40` |
| band min | unchanged | target `0x00000000` | target `0x00000000` | target `0x00000000` | unchanged |
| band max | previous field tail `0xFFFFFF..` | target `0x0000007F` | target `0x0000007F` | target `0x0000007F` | unchanged |
| `eq8` power max | `0xFFFFFFFF` | `0xFFFFFF7F` | `0xFFFFFF7F` | `0x0000007F` | unchanged |

`tests/test_master_eq_inspection.py` now asserts these full lanes so EQ parsing
does not collapse the spill behavior to only three visible UI bytes.

## Corpus cross-check

`src/one-off-changes-from-default/unnamed 14.xy` (bass min) matches:
`0x68 = 0x00`, mid/high remain `0x40`.

## API

`xy/master_eq_inspection.py` — `read_master_eq`, `inspect_master_eq_bytes`

## Writer note

`ImageProject.set_master_eq()` writes plain `u32` values. Max captures include
`0xFF` tail bytes on the previous field; writer may need a follow-up if
byte-exact max authoring is required.

## Tests

`tests/test_master_eq_inspection.py` — 9 cases
