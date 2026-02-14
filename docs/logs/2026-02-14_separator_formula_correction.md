# 2026-02-14: Multi-Step Separator Formula Correction

## Context

The original separator formula (simple hold/decrement) was verified 30/30 against unnamed 118 (all-Hold) and unnamed 119 (all-different types). However, it **crashed on device** when used to generate test files. The user captured `unnamed 118b.xy` — a device-generated file with an intermediate type pattern — which proved the formula wrong.

## Ground Truth: unnamed 118b

Starting from unnamed 118 (all-Hold), the user changed steps 6-16 on device:
- Step 5 bitmask: 0x02 → 0x40
- Step 6: Hold → Random (type_id 0x05)
- Steps 7-16: Hold → Trigger (type_id 0x0a)

The firmware produced separators: `[10, 10, 10, 10, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]`

The old formula predicted: `[10, 10, 10, 9, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8]` — completely wrong.

## Why The Old Formula Appeared Correct

The hold/decrement formula happened to produce correct results for the two extremes:
- All-same (unnamed 118): all separators = 10 (trivially correct, always HOLD)
- All-different (unnamed 119): monotonically decreasing 11→0 (coincidentally matched the runs formula because every suffix element is unique)

It failed for any intermediate case because the actual separator encodes **suffix complexity** (how many distinct type_id groups remain), not just local transition count.

## Derivation Process

13 candidate formulas were tested against all three specimens using `tools/analyze_sep_formulas.py`:
- Best initial candidates scored 35/45
- The winning formula (runs_adjusted) was derived by observing that sep values in unnamed 118b correlate with the number of distinct type_id runs remaining in the suffix

## The Correct Formula: runs_adjusted

```
base = 11 if records[0] is Pulse, else 10

For each separator sep[i] (i = 0..14):
  same = (records[i].type_id == records[i+1].type_id AND records[i].size == records[i+1].size)

  if same:
      sep[i] = base (if first) or sep[i-1] (HOLD)
  else:
      1. Count type_id runs in suffix records[i+1..15]
      2. Subtract 1 if records[i+1] starts a multi-element run
      3. sep[i] = min(adjusted, base) if first
               = min(adjusted, max(0, sep[i-1]-1)) otherwise
```

Score: **45/45** (15/15 on all three specimens). No other formula achieved this.

## Generated Test Files

`tools/write_delta_tests_v4.py` generates 6 test files from unnamed 118:
- `v4a_reproduce_118b.xy` — exact 118b pattern, formula seps match ground truth
- `v4b_single_type.xy` — minimal: one step type change
- `v4c_last_step_random.xy` — edge case: last step
- `v4d_two_types.xy` — two non-adjacent type changes
- `v4e_alternating.xy` — stress test: alternating types
- `v4f_all_types.xy` — 11 standard types (WARNING: some types normally use 8B/9B records, this test uses 7B for all)

## v4 Device Results: CRASH

Both v4a and v4b crashed on device despite correct separator values. The v4 approach modified E4 block bytes **in-place** without changing body length.

## Root Cause: Missing Post-E4 Structural Insertion

Full diff of unnamed 118 vs 118b (Track 1 body) revealed:
- **E4 block**: same 128-byte size, records changed in-place (type_id, bitmask, data, seps) — this part was correct
- **+4 bytes inserted after E4 block** (body ~0x131): `00 04 00 00` before the FF sentinel table
- **+5 bytes in sample metadata** (body ~0x675): conga/lc entry modified
- **+8 bytes in each of 8 aux tracks**: structural insertions (NOT required for loading)

## v5 Transplant Tests: ALL LOAD

Created isolation tests by transplanting regions from 118b into 118:
- `v5a_full_transplant.xy` (B's T1 + B's aux) — LOADS (= byte-identical to 118b)
- `v5b_t1_body_only.xy` (B's T1 only, A's aux) — LOADS (T1 body alone is sufficient)
- `v5c_aux_only.xy` (A's T1, B's aux) — LOADS (aux changes don't affect T1)

**Conclusion**: The separator formula is correct but insufficient. Multi-step type changes require the full T1 body structure (including post-E4 insertions), not just in-place E4 record edits. The +4 byte insertion after the E4 block is the likely crash trigger.
