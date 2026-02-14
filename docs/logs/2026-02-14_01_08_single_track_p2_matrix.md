# 2026-02-14 Analysis: `01`-`08` Single-Track `P2` Blank Matrix

## Captures

Device-exported files (`unnamed 121`-`unnamed 128`) were renamed to:

- `01_t1_p2_blank.xy`
- `02_t2_p2_blank.xy`
- `03_t3_p2_blank.xy`
- `04_t4_p2_blank.xy`
- `05_t5_p2_blank.xy`
- `06_t6_p2_blank.xy`
- `07_t7_p2_blank.xy`
- `08_t8_p2_blank.xy`

All eight are clean single-track 2-pattern blank topologies with no note events.

## Exact Pre-Track Results

| File | Topology | `var_0x56` |
|---|---|---|
| 01_t1_p2_blank | `T1x2` | `01 00 00 1d 01 00 00` |
| 02_t2_p2_blank | `T2x2` | `00 01 00 00 1c 01 00 00` |
| 03_t3_p2_blank | `T3x2` | `00 00 00 01 00 00 1b 01 00 00` |
| 04_t4_p2_blank | `T4x2` | `00 00 01 01 00 00 1a 01 00 00` |
| 05_t5_p2_blank | `T5x2` | `00 00 02 01 00 00 19 01 00 00` |
| 06_t6_p2_blank | `T6x2` | `00 00 03 01 00 00 18 01 00 00` |
| 07_t7_p2_blank | `T7x2` | `00 00 04 01 00 00 17 01 00 00` |
| 08_t8_p2_blank | `T8x2` | `00 00 05 01 00 00 16 01 00 00` |

## What This Resolves

1. Full Scheme A gap map for T3-T8 at x2 is now device-captured.
- gap(T3..T8) = `00,01,02,03,04,05` confirmed on real device exports.

2. We no longer need broad "blank-only" captures across all tracks for pattern-count=2.
- This matrix already gives the canonical baseline for blank topologies per track.

3. The previous "predicted-only" items for T5/T6/T8 single-track Scheme A can be promoted to confirmed.

## Do We Still Need The Remaining Large Matrix?

Not the full matrix.

The expensive part left is not blank topology; it is **note-bearing multi-pattern behavior** for tracks/families still under-covered.

Current major one-off gaps:

- T2 multi-pattern with notes (x2) is missing.
- T5/T6/T7/T8 multi-pattern with notes (x2) is missing.

These are the captures that still buy high-value abstraction.

## Follow-Up Status

The reduced follow-up set has now been captured as `r01`-`r10` and ingested.

- `r01`/`r02` covered T2 leader/clone note branches.
- `r03`/`r04` covered T5 leader/clone note branches.
- `r05`/`r06` covered T6 clone/leader note branches.
- `r07`/`r08` covered T7 leader/clone note branches.
- `r09`/`r10` covered T8 leader/clone note branches.

See `docs/logs/2026-02-14_r06_r10_and_multipattern_corpus_consolidation.md`
for the consolidated branch matrix and corpus-level implications.
