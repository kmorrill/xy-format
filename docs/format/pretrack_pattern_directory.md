# Pre-Track Pattern Directory

> **Superseded**: The authoritative reference is now
> `docs/format/descriptor_encoding.md`, which documents the fully cracked
> Scheme A encoding and all verified Scheme B descriptors. This file is
> retained for legacy context.

## Current Canonical Model
- Pre-track ends immediately before first track signature.
- A contiguous 36-byte handle table (`12 x 3-byte entries`) is present at the end of pre-track.
- Descriptor bytes are inserted ahead of that handle table when pattern topology requires it.

## Key Corrections (from m-series experiments)
- **0x56 and 0x57 are independent bytes**: v56 = T1 max_slot, v57 = T2 max_slot.
  NOT a u16 LE pair. The legacy u16 LE model was wrong for any topology
  involving T2 or T3+-only tracks.
- **Scheme A (T3+-only)**: fully cracked gap/maxslot pair encoding.
- **Scheme B (T1/T2 involved)**: 7 device-verified topologies in strict lookup.

## Legacy Early Model (T1-Centric, Narrow Scope)
- Early captures (`unnamed 6/7/102/103/104/105/105b`) were modeled as:
  - `0x56-0x57`: `pattern_max_slot` (`u16 LE`) -- **INCORRECT**, see above
  - descriptors at `0x58`
- This accidentally worked for T1-only and T1+T3 because v57=0 in both cases.

## Observed Descriptor Variants (Highlights)
- `unnamed 6/102/103/105b`: v56=01, v57=00, insert@0x58 `00 1d 01 00 00` (T1, 2 pat).
- `m05`: v56=01, v57=01, insert@0x58 `00 00 00 1c 01 00 00` (T1+T2, 2 pat).
- `m01`: v56=00, v57=00, insert@0x58 `00 01 00 00 1b 01 00 00` (T3-only, 2 pat).
- `m09`: v56=01, v57=00, insert@0x58 `00 00 01 00 00 1a 01 00 00` (T1+T4, 2 pat).
- `j06/j07`: v56=08, v57=08, insert@0x58 `06 00 00 16 01 00 00` (all 8 tracks, 9 pat).

## Related
- **Authoritative reference**: `docs/format/descriptor_encoding.md`
- Multi-pattern storage: `docs/format/multi_pattern_block_rotation.md`
- Experiment matrix: `docs/experiments/descriptor_matrix.md`
- Legacy deep details: `docs/logs/2026-02-13_agents_legacy_snapshot.md`
