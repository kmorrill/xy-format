# Descriptor Matrix Experiments

**Goal**: Crack the multi-pattern pre-track descriptor encoding by capturing
a systematic set of device-authored specimens.

**Naming**: Export each as `unnamed NNN.xy` (using your next available number),
then we'll rename to `m01`–`m16` for analysis.

**IMPORTANT**: Start each experiment from a **fresh project** (new empty project).
Do NOT reuse a project from a previous experiment — we've seen that edit history
can change the descriptor (j01→j02 had different descriptors despite same topology).

---

## Phase 1 — Single-Track Blanks (2 patterns)

These establish the baseline descriptor for each track in isolation.
All blank — no notes anywhere.

### m01: T3-only, 2 patterns, blank

1. New project
2. Go to **Track 3** (Prism synth)
3. Add 1 pattern (so you have Pattern A + Pattern B = 2 total)
4. Don't enter any notes — leave both patterns empty
5. Export

### m02: T4-only, 2 patterns, blank

1. New project
2. Go to **Track 4** (EPiano/Pluck)
3. Add 1 pattern (2 total)
4. Leave blank
5. Export

### m03: T7-only, 2 patterns, blank

1. New project
2. Go to **Track 7** (Axis)
3. Add 1 pattern (2 total)
4. Leave blank
5. Export

### m04: T8-only, 2 patterns, blank

1. New project
2. Go to **Track 8** (Multisampler)
3. Add 1 pattern (2 total)
4. Leave blank
5. Export

---

## Phase 2 — Contiguous Multi-Track (2 patterns each, blank)

These reveal how the compact range format works when tracks are contiguous.

### m05: T1+T2, 2 patterns each, blank

1. New project
2. Go to **Track 1** (Drum), add 1 pattern (2 total)
3. Go to **Track 2** (Drum), add 1 pattern (2 total)
4. Leave all patterns blank
5. Export

### m06: T1+T2+T3, 2 patterns each, blank

1. New project
2. Add 1 pattern to each of **T1, T2, T3** (2 total each)
3. Leave all blank
4. Export

### m07: T2+T3, 2 patterns each, blank (no T1!)

1. New project
2. Add 1 pattern to each of **T2, T3** (2 total each)
3. **Do NOT touch Track 1** — it stays at 1 pattern
4. Leave all blank
5. Export

---

## Phase 3 — Non-Contiguous (gaps in the track set)

These reveal how the firmware encodes "missing" tracks in the middle.

### m08: T1+T3, 2 patterns each, blank

1. New project
2. Add 1 pattern to **T1** and **T3** (2 total each)
3. **Do NOT add patterns to T2** — it stays at 1 pattern
4. Leave all blank
5. Export

### m09: T1+T4, 2 patterns each, blank

1. New project
2. Add 1 pattern to **T1** and **T4** (2 total each)
3. T2, T3 stay at 1 pattern
4. Leave all blank
5. Export

### m10: T1+T7, 2 patterns each, blank

1. New project
2. Add 1 pattern to **T1** and **T7** (2 total each)
3. T2–T6, T8 stay at 1 pattern
4. Leave all blank
5. Export

---

## Phase 4 — State Dependency (activation changes descriptor?)

Using T3 as the test subject: same topology, different activation states.
This directly tests whether "which pattern has notes" changes the descriptor
(like we saw with j03 vs j04 on T4).

### m11: T3-only, 2 patterns, note on Pattern 1 (leader)

1. New project
2. Go to **Track 3**, add 1 pattern (2 total)
3. Stay on **Pattern 1** (the first/leader pattern)
4. Enter a single note: **C4 on step 1**
5. Pattern 2 stays blank
6. Export

### m12: T3-only, 2 patterns, note on Pattern 2 (clone)

1. New project
2. Go to **Track 3**, add 1 pattern (2 total)
3. Switch to **Pattern 2** (the second/clone pattern)
4. Enter a single note: **C4 on step 1**
5. Pattern 1 stays blank
6. Export

---

## Phase 5 — Contiguous Pair with Activation

Same topology (T1+T2), testing whether adding notes changes the descriptor.

### m13: T1+T2, 2 patterns each, T1 P1 note only

1. New project
2. Add 1 pattern to **T1** and **T2** (2 total each)
3. On **T1 Pattern 1**: enter a **kick drum (any key) on step 1**
4. All other patterns blank
5. Export

### m14: T1+T2, 2 patterns each, T2 P2 note only

1. New project
2. Add 1 pattern to **T1** and **T2** (2 total each)
3. On **T2 Pattern 2**: enter a **hat (any key) on step 1**
4. All other patterns blank
5. Export

---

## Phase 6 — Non-Contiguous Pair with Activation

### m15: T1+T4, 2 patterns each, T4 P1 note

1. New project
2. Add 1 pattern to **T1** and **T4** (2 total each)
3. On **T4 Pattern 1**: enter **C4 on step 1**
4. All other patterns blank
5. Export

### m16: T1+T4, 2 patterns each, T4 P2 note

1. New project
2. Add 1 pattern to **T1** and **T4** (2 total each)
3. On **T4 Pattern 2**: enter **C4 on step 1**
4. All other patterns blank
5. Export

---

## Summary Matrix

| ID  | Tracks      | Patterns | Notes           | Status      | Tests                          |
|-----|-------------|----------|-----------------|-------------|--------------------------------|
| m01 | T3          | 2 each   | none            | **CAPTURED** | single-track baseline          |
| m02 | T4          | 2 each   | none            | **CAPTURED** | single-track baseline          |
| m03 | T7          | 2 each   | none            | **CAPTURED** | single-track baseline          |
| m04 | T8          | 2 each   | none            | SKIPPED     | predicted by Scheme A formula  |
| m05 | T1+T2       | 2 each   | none            | **CAPTURED** | contiguous pair                |
| m06 | T1+T2+T3    | 2 each   | none            | **CAPTURED** | contiguous triple — CONFIRMED  |
| m07 | T2+T3       | 2 each   | none            | SKIPPED     | low priority                   |
| m08 | T1+T3       | 2 each   | none            | had unnamed 105 | already verified            |
| m09 | T1+T4       | 2 each   | none            | **CAPTURED** | non-contiguous (gap: T2-T3)    |
| m10 | T1+T7       | 2 each   | none            | SKIPPED     | low priority (Scheme B)        |
| m11 | T3          | 2 each   | T3 P1 step 1    | SKIPPED     | j03/j04 already shows pattern  |
| m12 | T3          | 2 each   | T3 P2 step 1    | SKIPPED     | clone activation irrelevant    |
| m13 | T1+T2       | 2 each   | T1 P1 step 1    | SKIPPED     | low priority                   |
| m14 | T1+T2       | 2 each   | T2 P2 step 1    | SKIPPED     | low priority                   |
| m15 | T1+T4       | 2 each   | T4 P1 step 1    | SKIPPED     | low priority                   |
| m16 | T1+T4       | 2 each   | T4 P2 step 1    | SKIPPED     | low priority                   |
| n110 | T1-T8 all  | 9 each   | 1 note per pat  | **CAPTURED** | full 9-pat clone body analysis |

## Results

### Phase 1 — Single-Track Blanks

**Scheme A encoding fully cracked.** All three captured specimens (m01, m02,
m03) confirmed the gap/maxslot pair format:

```
body = [gap maxslot] [00 00] [token] [01] [00 00]
gap = track_1based - 3    (T3→0, T4→1, T7→4)
token = 0x1E - track_1based
```

m04 (T8) was SKIPPED because the formula is now confirmed with 3 data points
spanning gap values 0, 1, and 4. T8 (gap=5) is confidently predicted.

### Phase 2 — Contiguous Multi-Track

m05 (T1+T2) confirmed that **v56 and v57 are independent per-track bytes**
(NOT a u16 LE pair). v56=T1 max_slot, v57=T2 max_slot.

### Phase 3 — Non-Contiguous

m09 (T1+T4) confirmed the Scheme B gap encoding: non-multi T3+ tracks
contribute `[00 00]` (2 bytes) to the body, while multi T3+ tracks contribute
`[maxslot] [00 00]` (3 bytes).

### Key Finding: Clone Activation Irrelevant

m02 (T4×2, blank) produced byte-identical descriptor to j04 (T4×2, clone has
note). Clone activation does NOT change the descriptor. Only **leader**
activation triggers the short form (j03).

### Phase 2b — m06 (T1+T2+T3) CONFIRMED

m06 (`src/unnamed 109.xy` → `m06_t1t2t3_2pat_blank.xy`) confirmed the
prediction **byte-for-byte**: v56=01, v57=01, insert@0x58 = `01 00 00 1B 01 00 00`.

This was the final high-value experiment. The Scheme B body for T3+ multi-pattern
tracks uses `[maxslot 00 00]` identically whether T1-only or T1+T2 are present.
All descriptor matrix experiments are now complete or confidently skipped.

## What Each Phase Answers

- **Phase 1** (m01–m04): Is the descriptor structure consistent across all single tracks? Do T3/T7/T8 use the same format as T4 (j03/j04)?
- **Phase 2** (m05–m07): How does the compact range format encode contiguous multi-pattern tracks? Does 0x57 always hold T2's max_slot?
- **Phase 3** (m08–m10): How are gaps in the track set encoded? Is there explicit gap metadata or is the end-token sufficient?
- **Phase 4** (m11–m12): Does T3 show the same state-dependent format split as T4 (j03 vs j04)?
- **Phase 5** (m13–m14): Does activation change the descriptor for contiguous PAIRS?
- **Phase 6** (m15–m16): Does activation change the descriptor for non-contiguous pairs? Compares directly with m09 (blank version).
