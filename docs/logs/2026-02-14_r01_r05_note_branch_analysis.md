# 2026-02-14 Analysis: `r01`-`r05` Note-Branch Captures

## Captures Ingested

Device exports (`unnamed 129`-`unnamed 133`) were renamed/moved to:

- `r01_t2_p2_p1note_s1.xy`
- `r02_t2_p2_p2note_s1.xy`
- `r03_t5_p2_p1note_s1.xy`
- `r04_t5_p2_p2note_s1.xy`
- `r05_t6_p2_p2note_s1.xy`

## Exact Decoded Results

| File | Topology | Active block | Note trig | `descriptor_var_hex` |
|---|---|---|---|---|
| r01_t2_p2_p1note_s1 | `T2x2` | T2 P1 (`0x07`) | T2 P1 S1 note=60 | `00 00 1e 01 00 00` |
| r02_t2_p2_p2note_s1 | `T2x2` | T2 P2 (`0x07`) | T2 P2 S1 note=60 | `00 01 00 00 1c 01 00 00` |
| r03_t5_p2_p1note_s1 | `T5x2` | T5 P1 (`0x07`) | T5 P1 S1 note=72 | `40 00 00 1e 01 00 00` |
| r04_t5_p2_p2note_s1 | `T5x2` | T5 P2 (`0x07`) | T5 P2 S1 note=72 | `40 00 00 02 01 00 00 19 01 00 00` |
| r05_t6_p2_p2note_s1 | `T6x2` | T6 P2 (`0x07`) | T6 P2 S1 note=72 | `00 00 03 01 00 00 18 01 00 00` |

Note: `r05` is clone-active on T6 (P2 note), not leader-active (P1 note).

## What This Proves

1. T2 has both long-form and short-form descriptor branches at x2.
- Clone-active (`r02`) keeps long-form: `00 01 00 00 1c 01 00 00`.
- Leader-active (`r01`) switches to short-form: `00 00 1e 01 00 00`.

2. T5 has an additional `0x40` family marker in pre-track.
- Both `r03` and `r04` carry `v56=0x40`.
- `r03` (leader-active) uses short-form branch.
- `r04` (clone-active) uses long-form T5 body under the same `0x40` family.

3. T6 clone-active behavior at x2 is long-form Scheme A.
- `r05` confirms expected `gap=3` descriptor body with active clone.

## What This Changes In The Model

1. Short-form is now confirmed outside T4/T1+T3 contexts.
- T2 leader-active is a clean short-form specimen (`r01`).

2. Descriptor selection is even more branchy than a single topology formula.
- Same topology (`T2x2`, `T5x2`) changes descriptor family by leader vs clone activation.

3. The `0x40` pre-track family is real and recurring.
- Seen in these new T5 captures and legacy one-offs (`unnamed 41/113/116`).

## Follow-Up Status

This remaining set was captured and ingested as `r06`-`r10`.
See `docs/logs/2026-02-14_r06_r10_and_multipattern_corpus_consolidation.md`
for the completed matrix and consolidated corpus-level analysis.
