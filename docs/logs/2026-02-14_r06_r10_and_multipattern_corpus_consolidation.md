# 2026-02-14 Analysis: `r06`-`r10` + Multi-Pattern Corpus Consolidation

## Captures Ingested

Device exports (`unnamed 134`-`unnamed 138`) were renamed/moved to:

- `r06_t6_p2_p1note_s1.xy`
- `r07_t7_p2_p1note_s1.xy`
- `r08_t7_p2_p2note_s1.xy`
- `r09_t8_p2_p1note_s1.xy`
- `r10_t8_p2_p2note_s1.xy`

## Exact Decoded Results

| File | Topology | Active block | Note trig | `descriptor_var_hex` |
|---|---|---|---|---|
| `r06_t6_p2_p1note_s1` | `T6x2` | T6 P1 (`0x07`) | T6 P1 S1 note=72 (`C5`) vel=100 | `00 00 1e 01 00 00` |
| `r07_t7_p2_p1note_s1` | `T7x2` | T7 P1 (`0x07`) | T7 P1 S1 note=72 (`C5`) vel=100 | `40 00 00 1e 01 00 00` |
| `r08_t7_p2_p2note_s1` | `T7x2` | T7 P2 (`0x07`) | T7 P2 S1 note=72 (`C5`) vel=100 | `40 00 00 04 01 00 00 17 01 00 00` |
| `r09_t8_p2_p1note_s1` | `T8x2` | T8 P1 (`0x07`) | T8 P1 S1 note=72 (`C5`) vel=100 | `00 00 1e 01 00 00` |
| `r10_t8_p2_p2note_s1` | `T8x2` | T8 P2 (`0x07`) | T8 P2 S1 note=72 (`C5`) vel=100 | `00 00 05 01 00 00 16 01 00 00` |

## What `r06`-`r10` Prove

1. The x2 leader-active short-form branch is now confirmed on T6 and T8.
- T6 leader-active (`r06`) and T8 leader-active (`r09`) both use `... 1e 01 00 00`.

2. T7 mirrors T5 in the `0x40` family behavior.
- T7 leader-active (`r07`) uses `40 00 00 1e 01 00 00`.
- T7 clone-active (`r08`) uses long-form under `40 00`, with an extra leading `00` in body (`00 04 01 00 00 ...`).

3. Single-track x2 note branch coverage is now complete for T2-T8.
- We now have blank, leader-active, and clone-active captures for every track except T3 (clone-active still missing, but T3 leader-active is captured in `p08`).

## Device-Corpus-Wide Multi-Pattern Snapshot (Not Just New Files)

Scope: all `src` + `src/one-off-changes-from-default` captures indexed with `tools/corpus_lab.py`.

- Multi-pattern files in device corpus: **51**
- Max observed pattern count on tracks 1-8: **9**

Pattern-count coverage by track (device corpus):

- T1: `[2, 3, 4, 9]`
- T2: `[2, 3, 9]`
- T3: `[2, 3, 4, 9]`
- T4: `[2, 9]`
- T5: `[2, 9]`
- T6: `[2, 9]`
- T7: `[2, 9]`
- T8: `[2, 9]`

Topological facts now stable:

1. Track/pattern expansion is deterministic and track-major.
- Logical order is always `T1 P1..Pn`, then `T2 P1..Pn`, ..., then aux tracks.
- Overflow packing (when logical blocks >16) is consistent with this logical order.

2. Descriptor token remains tied to highest multi-pattern track in long-form branches.
- `token = 0x1E - last_multi_track_1based` holds on verified long forms.

3. Descriptor branching is stateful for x2 single-track captures.
- T2/T4/T6/T8 leader-active -> short-form (`token=0x1E`, `v56/v57` not maxslot).
- T5/T7 note-bearing branches -> `v56=0x40` family plus short/long switching.
- T3 leader-active (`p08`) remains long-form (important counterexample).

4. Pre-track edits stay compositional.
- `h7-compositional` over one-off corpus: **97.3%** of files are explained by <=2 structural ops.

5. Preamble pattern-count signaling is stable even when descriptor branches vary.
- Leader block `pre1` tracks pattern count (`0x02`, `0x03`, `0x09` seen).
- Clone blocks stay in the inline rotation sequence; descriptor differences do not
  change logical ordering semantics.

## What This Says About "Any Track, Any Pattern Count 1-9"

### Proven enough to treat as principles now

1. Block rotation itself is not the blocker.
- We can lay out arbitrary per-track counts in logical order; this is well supported.

2. Scheme A (`T3+` only) with `maxslot` pairs is robust for low counts.
- Fully confirmed at x2 across T3-T8.

3. We have stable, real-device templates for the two high-value anchor regimes.
- Small-count mixed regimes (`x2/x3/x4`) via `p04`-`p10`, `m05`, `m06`, `m09`.
- High-count all-track regime (`x9` all tracks) via `j06/j07/n110`.

### Still not fully principled (current blockers)

1. Counts `5-8` are under-sampled in device captures for tracks 1-8.
- We can interpolate in some branches, but not yet claim fully decoded serializer intent.

2. Partial 9-pattern topologies are branchy.
- `j01` (blank) vs `j02` (sparse notes) on the same topology produce different descriptor families.

3. `0x40` family trigger is not decoded.
- T5/T7 note-bearing x2 captures show it clearly, but trigger conditions are still unknown.

## Generator Fit Check (Current `strict` Branch)

Using a descriptor-only reconstruction pass against all 51 device multi-pattern files:

- exact descriptor match: **36 / 51**
- topology unsupported errors: **4 / 51**
- topology supported but wrong branch selection: **11 / 51**

Unsupported topologies in `strict` today:

- `T2x2 + T3x2` (`p05`)
- `T1x2 + T7x2` (`p06`)
- `T1x9 + T2x9 + T3x9 + T4x9 + T7x9` (`j01`, `j02`)

Supported but branch-wrong cases (overfit symptoms):

- leader-active short-form not modeled: `j03`, `r01`, `r06`, `r09`
- `0x40` family not modeled: `r03`, `r04`, `r07`, `r08`
- mixed-count/collapsed `T1+T3` branches not generalized: `p07`, `p09`, `p10`

This is the concrete gap between current generator heuristics and corpus-backed
serializer behavior.

## Practical Authoring Stance Right Now

1. For deterministic authoring today, use scaffold-driven writing per topology family.
- Avoid pure descriptor synthesis in unexplained branches.

2. For goal coverage "1-9 on tracks 1-8", we can now do this reliably with scaffold transfer:
- exact branch-matched scaffold for target topology/count,
- then pattern-body edits only.

3. Full synthesis (without topology scaffolds) still needs two things:
- decode of `0x40` family trigger,
- additional captures at counts `5-8` to validate descriptor behavior outside current anchors.

## Follow-Up Status

Count-8 follow-up captures (`s05`-`s09`) are now complete and analyzed in:
`docs/logs/2026-02-14_s04_s09_minimal_plan_progress.md`.
