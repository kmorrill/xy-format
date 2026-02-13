# Pre-Track Pattern Directory

## Current Canonical Model
- Pre-track ends immediately before first track signature.
- A contiguous 36-byte handle table (`12 x 3-byte entries`) is present at the end of pre-track.
- Descriptor bytes are inserted ahead of that handle table when pattern topology requires it.

## Legacy Early Model (T1-Centric, Narrow Scope)
- Early captures (`unnamed 6/7/102/103/104/105/105b`) were modeled as:
  - `0x56-0x57`: `pattern_max_slot` (`u16 LE`)
  - descriptors at `0x58`
- Keep this only as a compatibility rule for that capture family.

## Updated Variant Model (Preferred)
- Descriptor insertion point is topology/state dependent (`0x56`, `0x57`, or `0x58` observed).
- `0x56-0x57` is not globally safe as a single `u16` field.
- Writers should preserve scaffold bytes and avoid recomputing descriptor blobs heuristically.

## Observed Descriptor Variants (Highlights)
- `unnamed 6/102/103/105b`: insert at `0x56`, bytes `01 00 00 1d 01` (T1, 2 patterns).
- `unnamed 7/104`: insert at `0x56`, bytes `02 00 00 1d 01` (T1, 3 patterns).
- `unnamed 105`: insert at `0x56`, bytes `01 00 01 00 00 1b 01` (T1+T3, 2 patterns).
- `j05_t2_p3_blank`: insert at `0x57`, bytes `02 00 00 1c 01 00`.
- `j06/j07`: insert at `0x56`, bytes `08 08 06 00 00 16 01` (all-16 scaffold family).

## Practical Rules
1. Parse descriptor and handle-table region from observed bytes, not a fixed offset formula.
2. Keep handle-table grouping as 3-byte entries (`FF 00 00` = unused).
3. For writing, treat device-authored scaffold pre-track bytes as authoritative per topology.

## Related
- Multi-pattern storage: `docs/format/multi_pattern_block_rotation.md`
- Legacy deep details: `docs/logs/2026-02-13_agents_legacy_snapshot.md`
