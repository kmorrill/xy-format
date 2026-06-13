# Master EQ blend / power inspection (P2-F extension)

**Date:** 2026-06-12  
**Firmware:** 1.1.4  
**Fixtures:** `eq7-blend-min.xy`, `eq8-blend-max.xy` in `src/mixer-probes/2026-06-eq/`

## Operator hypothesis (why this was a late probe)

The guide’s **4th EQ knob** (labeled blend in docs) was initially **skipped**
from the `eq1`–`eq6` sweep because it likely does **not** persist as its own
scalar. Operator model:

- Behaves like **EQ power**, not a wet/dry blend between two curves.
- **Down** → bands return toward default / neutral.
- **Up** → bands move toward a more extreme version of their **current** values.
- Only the three band bytes (`0x68` / `0x6C` / `0x70`) should change on save.

## Device evidence (captures from `eq0` baseline)

| Capture | Global header effect |
| --- | --- |
| `eq7` power **min** | **No change** vs `eq0` (bands remain `0x40`) |
| `eq8` power **max** | Bass + mid + treble all → `0x7F` (`0x65–0x70`) |

`0x74` (legacy “blend” u32 in map) stays **`0x40`** on both — no separate 4th
stored parameter touched by this UI control on 1.1.4.

From default center, power-max is indistinguishable from “all bands max” in
storage. **Not yet tested:** power-max after custom band settings (e.g. bass
min only) — would distinguish proportional push vs clamp-to-`0x7F`.

## Read API note

`read_master_eq_blend()` reads `@0x74` for map completeness; **authoring and
inspection should use the three band bytes** for EQ state. Do not treat `0x74`
as the power knob unless a future probe proves otherwise.

## Tests

`tests/test_master_eq_inspection.py` — `test_blend_min_matches_baseline`,
`test_blend_max_sets_all_bands`
