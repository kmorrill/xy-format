# 2026-02-14 Deep Analysis: `p01`-`p10`

## Scope
This log analyzes the ten targeted device captures:

- `p01_t4_touch_noevent.xy`
- `p02_t4_note_event.xy`
- `p03_t4_preset_note.xy`
- `p04_desc_t2_2pat_blank.xy`
- `p05_desc_t2t3_2pat_blank.xy`
- `p06_desc_t1t7_2pat_blank.xy`
- `p07_desc_t1p2_t3p3_blank.xy`
- `p08_desc_t3p2_p1note_s1.xy`
- `p09_mp_t1t3_p3_t1p2_t3p1_s1.xy`
- `p10_mp_t1t3_p4_t1p2_t3p1_s1.xy`

Primary goals:

1. Test which current writer assumptions are principle-level vs overfit heuristics.
2. Extract stable serializer rules worth promoting into canonical docs.

## Methods Used
- `python tools/corpus_lab.py index --db /tmp/p10.sqlite ...`
- `python tools/corpus_lab.py sql --db /tmp/p10.sqlite "..."`
- `python tools/analyze_pretrack_descriptors.py --baseline ... p0*.xy`
- `python - <<'PY' ... build_multi_pattern_project(...) ... PY` (direct writer-vs-device comparisons)
- `python - <<'PY' ... hypothesis_tests.run_h7_pretrack/run_h7_compositional/run_h2_automaton ... PY`

## Structural Snapshot

| File | Topology | `descriptor_var_hex` (pre@0x56..FF-table) |
|---|---|---|
| p01 | single-pattern | `00 00` |
| p02 | single-pattern | `00 00` |
| p03 | single-pattern | `00 00` |
| p04 | `T2x2` | `00 01 00 00 1c 01 00 00` |
| p05 | `T2x2 + T3x2` | `00 01 01 00 00 00 1b 01 00 00` |
| p06 | `T1x2 + T7x2` | `01 00 00 03 01 00 00 17 01 00 00` |
| p07 | `T1x2 + T3x3` | `01 00 02 00 00 1b 01 00 00` |
| p08 | `T3x2` (leader note active) | `00 00 00 01 00 00 1b 01 00 00` |
| p09 | `T1x3 + T3x3` (T1P2 + T3P1 notes) | `01 00 00 1d 01 00 00` |
| p10 | `T1x4 + T3x4` (same note layout as p09) | `01 00 00 1d 01 00 00` |

## What This Proves

1. Pre-track edits remain compositional.
- On this set, `h7-pretrack` reports zero delete ops.
- `h7-compositional` reports each file as 0 or 1 structural op from baseline pre-track.

2. Multi-pattern mode sets Track 1 preamble `byte[0]` to `0xB5` globally.
- In every multi-pattern capture above (`p04`-`p10`), T1 pre0 is `0xB5`.
- This holds even when T1 is not itself multi-pattern (`p04`, `p05`, `p08`).

3. Scheme B supports dynamic non-T1 maxslot bytes in long form.
- `p07` (`T1x2 + T3x3`) uses `... 02 00 00 1b 01 00 00`.
- The `0x02` byte tracks T3 `maxslot` for x3, not a fixed hardcoded value.

4. `T1+T3` descriptor collapse (`...00 1D 01 00 00`) is broader than `105b`.
- `p09` and `p10` use collapse form at x3/x4, not just x2.
- Same collapse as `unnamed 105b`, but now with larger pattern counts.

5. `p03` is a real preset branch, not just "note present vs absent".
- `p02` (default preset note) matches writer default behavior exactly.
- `p03` (preset-changed note) diverges strongly: shorter T4 body, event type `0x1A`, and T5 pre0 `0x64`.

## What This Disproves (Current Builder Heuristics)

1. Overfit: `_is_105b_mode` is too narrow.
- Current condition requires exactly two patterns on T1/T3.
- `p09` and `p10` show the same collapse branch appears at x3/x4.

2. Overfit: strict descriptor lookup is incomplete for real topologies.
- `build_multi_pattern_project(..., strict)` currently rejects valid topologies seen on device:
  - `T2+T3` (`p05`)
  - `T1+T7` (`p06`)

3. Overfit: fixed `T1+T3` descriptor body byte (`0x01`) is wrong.
- `p07` requires `0x02` for `T3x3`; generator still emits `0x01`.

4. Overfit: universal "v56 = T1 max_slot" is false.
- `p09` (`T1x3`) and `p10` (`T1x4`) still store `v56 = 0x01` in the collapsed branch.

5. Overfit: absolute T5 exemption from `0x64` propagation is false.
- `p01`/`p02` keep T5 `0x2E`, but `p03` sets T5 `0x64`.
- This aligns with existing outliers (`unnamed 113`, `unnamed 116`, `unnamed 117`).

6. Overfit: generic "T3+ leader-active => short descriptor" is false.
- `p08` is `T3x2` with leader note active, but stays in normal long Scheme A form.
- Contrast: `j03` (`T4x2` leader-active) uses short form `00 00 1e 01 00 00`.

## Writer-vs-Device Rebuild Check (Strict Strategy)

Device-matching descriptor results from direct rebuild tests:

- Match: `p04`, `p08`
- Mismatch: `p07`, `p09`, `p10`
- Unsupported topology errors: `p05`, `p06`

First-order implication: current writer can still hit some examples, but does not yet encode the underlying serializer branching generally.

## Immediate Modeling Direction

1. Treat descriptor selection as a state machine over topology and leader/clone activation patterns, not only track-set lookup.
2. Split Scheme B into at least two branches:
- long form (with dynamic per-track maxslot bytes)
- collapsed `0x1D` form (now confirmed beyond x2)
3. Move T1 `0xB5` behavior from T1-only branch logic to a global "has any multi-pattern track" rule.
4. Add preset/event-family context to preamble propagation (T5 non-exempt branch, as in p03).
