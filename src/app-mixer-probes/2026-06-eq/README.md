# P2-F — Master EQ fixtures

> **Status:** captured

**Capture procedure:**
[`user_probes/2026-06-eq/README.md`](../../../../user_probes/2026-06-eq/README.md)

9 files. Global header `0x68` / `0x6C` / `0x70`; level byte @ field start.

| File | Bass | Mid | Treble |
| --- | --- | --- | --- |
| `eq0-baseline.xy` | `0x40` | `0x40` | `0x40` |
| `eq1-bass-min.xy` | `0x00` | | |
| `eq2-bass-max.xy` | `0x7F` | | |
| `eq3-mid-min.xy` | | `0x00` | |
| `eq4-mid-max.xy` | | `0x7F` | |
| `eq5-treble-min.xy` | | | `0x00` |
| `eq6-treble-max.xy` | | | `0x7F` |
| `eq7-blend-min.xy` | `0x40` | `0x40` | `0x40` (= baseline) |
| `eq8-blend-max.xy` | `0x7F` | `0x7F` | `0x7F` |

Log: `docs/logs/2026-06-12_master_eq_inspection.md`, `docs/logs/2026-06-12_master_eq_blend_inspection.md`  
Tests: `tests/test_master_eq_inspection.py`  
API: `xy/master_eq_inspection.py`
