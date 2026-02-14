# 2026-02-14 Analysis: `s04`-`s09` (Minimal Plan Progress)

## Captures Ingested

Device exports were renamed/moved to:

- `s04_t1t3_p2_t3leader_only.xy`
- `s05_t1_p8_blank.xy`
- `s06_t2_p8_blank.xy`
- `s07_t3_p8_blank.xy`
- `s08_t2p8_t3p8_blank.xy`
- `s09_t1p8_t7p8_blank.xy`

## Exact Decoded Outcomes

| File | Topology | Active blocks | Notes | `descriptor_var_hex` |
|---|---|---|---|---|
| `s04` | `T1x2 + T3x2` | `T3 P1` only | `T3 P1 S1 note=48 (C3)` | `01 00 00 1d 01 00 00` |
| `s05` | `T1x8` | none | none | `07 00 00 1d 01 00 00` |
| `s06` | `T2x8` | none | none | `00 07 00 00 1c 01 00 00` |
| `s07` | `T3x8` | none | none | `00 00 00 07 00 00 1b 01 00 00` |
| `s08` | `T2x8 + T3x8` | none | none | `00 07 07 00 00 00 1b 01 00 00` |
| `s09` | `T1x8 + T7x8` | none | none | `07 00 00 03 07 00 00 17 01 00 00` |

## What This Proves

1. Pattern-count scaling to `8` is real for Scheme B and Scheme A branches.
- `s05`, `s06`, `s07` confirm maxslot `7` behavior on single-track T1/T2/T3.
- `s08`, `s09` confirm the same scaling inside mixed topologies.

2. `T1+T3` descriptor choice is a state machine, not a simple topology formula.
- `s03` (from prior batch): both leaders active -> short-form `...1e 01 00 00`.
- `s04`: only T3 leader active -> collapsed `...1d 01 00 00` with `v56=01`.

3. We now have direct evidence for two previously unsupported mixed topologies:
- `T2+T3` at high count (`s08`)
- `T1+T7` at high count (`s09`)

## What This Disproves About Current Writer Heuristics

Using descriptor-only reconstruction against 60 device multi-pattern files
(`src` + `oneoff`):

- exact match: `38/60`
- mismatch: `16/60`
- unsupported topologies (hard error): `6/60`

Newly highlighted overfit points:

1. `strict` fast-path lookup for `{T3}` is count-overfit.
- `s07` should encode slot `7`, but lookup pins x2 bytes (`slot=1`).

2. `T1+T3` state branching is under-modeled.
- `s03`/`s04` diverge from single-rule `T1+T3` assumptions.

3. Mixed high-count topologies still require explicit branch support.
- `s08` (`T2+T3` x8) and `s09` (`T1+T7` x8) currently error in strict mode.

## Step-Back Conclusion

The corpus now strongly supports this serializer model:

- base scaffold + small structural pre-track ops,
- deterministic block rotation,
- descriptor emitted by a branchy state machine keyed by:
  - topology,
  - maxslot/count,
  - leader/clone activation state,
  - and at least one extra family flag (`0x40` branches).

So the project is no longer blocked on "unknown global structure". It is
blocked on finishing a finite descriptor branch table/state machine.

## Remaining High-Value Gaps

1. `s10` / `s11` pair (`T1,T2,T3,T4,T7` at x9 blank vs sparse) to close the
   partial-9 branch split seen in `j01` vs `j02`.
2. Decode trigger conditions for the `0x40` family (T5/T7).
3. Promote the now-confirmed x8 branch rules into writer strict mode.
