#!/usr/bin/env python3
"""Delta tests using the CORRECTED runs_adjusted separator formula.

The formula is: when flanking records differ by (type_id, size),
sep[i] = min(adjusted_type_id_runs_in_suffix, max(0, prev-1)).
When same: HOLD.

This should produce device-loadable .xy files.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject, TrackBlock

TEMPLATE = Path("src/one-off-changes-from-default/unnamed 118.xy")
OUTPUT_DIR = Path("output/multistep")
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Load unnamed 118
orig_data = TEMPLATE.read_bytes()
source = XYProject.from_bytes(orig_data)
source_body = source.tracks[0].body

BLOCK_START = 0x00B1  # E4 header offset in body

# Record layout: [bitmask][00][00][type_id][data][00][00] = 7 bytes for standard
# Separator is the byte between records


def rec_offset(step_0based):
    """Body offset of record byte[0] for given step (0-based)."""
    return BLOCK_START + 1 + step_0based * 8  # 7B record + 1B separator


def sep_offset(sep_index):
    """Body offset of separator[i] (between record[i] and record[i+1])."""
    return BLOCK_START + 1 + 7 + sep_index * 8


def compute_seps_formula(type_ids, sizes):
    """Compute separators using the runs_adjusted formula.

    type_ids: list of 16 type_id values (None for Pulse)
    sizes: list of 16 record sizes
    Returns: list of 15 separator values
    """
    base = 11 if type_ids[0] is None else 10
    seps = []

    for i in range(15):
        # Same = both type_id and size match
        same = (type_ids[i] == type_ids[i + 1] and sizes[i] == sizes[i + 1])

        if same:
            if not seps:
                seps.append(base)
            else:
                seps.append(seps[-1])
        else:
            # Count type_id runs in records[i+1..15]
            runs = 1
            for j in range(i + 2, 16):
                if type_ids[j] != type_ids[j - 1]:
                    runs += 1
            # Adjust: subtract 1 if records[i+1] starts a same-type_id run
            starts_run = (i + 2 <= 15 and type_ids[i + 1] == type_ids[i + 2])
            count = runs - (1 if starts_run else 0)
            if not seps:
                seps.append(min(count, base))
            else:
                seps.append(min(count, max(0, seps[-1] - 1)))

    return seps


def make_delta(name, desc, changes):
    """Create a test file with specific byte changes to unnamed 118's body."""
    body = bytearray(source_body)
    for offset, value in changes:
        old = body[offset]
        body[offset] = value
        print(f"    [{offset:#06x}] {old:#04x} -> {value:#04x}")

    tracks = list(source.tracks)
    tracks[0] = TrackBlock(
        index=tracks[0].index,
        preamble=tracks[0].preamble,
        body=bytes(body),
    )
    proj = XYProject(pre_track=source.pre_track, tracks=tracks)
    data = proj.to_bytes()
    outpath = OUTPUT_DIR / f"{name}.xy"
    outpath.write_bytes(data)
    print(f"  -> {outpath.name:40s} {len(data):5d}B  {desc}\n")
    return data


# ═══ Verify unnamed 118 structure ═══
print("=" * 70)
print("  Delta Tests v4 — Using runs_adjusted Separator Formula")
print("=" * 70)

# Verify round-trip
rt_data = source.to_bytes()
if rt_data == orig_data:
    print("\n  unnamed 118 round-trips PERFECTLY")
else:
    print(f"\n  WARNING: round-trip differs!")

# Show current state
print("\n--- Unnamed 118 block structure ---")
print("  All 16 steps are Hold (type_id=0x00), bitmask=0x02, data=0x04")
print("  All 15 separators = 10")

# Verify separators
for i in range(15):
    actual = source_body[sep_offset(i)]
    assert actual == 10, f"sep[{i}] = {actual}, expected 10"
print("  Separator verification: PASS\n")


# ═══ Test V4_A: Reproduce unnamed 118b exactly ═══
# Change step 5 bitmask to 0x40, step 6 to Random, steps 7-16 to Trigger
# with correct formula separators
print("=== V4_A: Reproduce unnamed 118b pattern ===")
# Build type_id and size arrays for the target configuration
target_types_a = [0x00]*5 + [0x05] + [0x0a]*10  # Hold×5, Random, Trigger×10
target_sizes_a = [7]*16  # all 7B
target_seps_a = compute_seps_formula(target_types_a, target_sizes_a)
print(f"  Formula seps: {target_seps_a}")
# Expected from 118b: [10, 10, 10, 10, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
assert target_seps_a == [10, 10, 10, 10, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \
    f"Formula mismatch! Got {target_seps_a}"
print("  Matches unnamed 118b ground truth: YES")

changes_a = []
# Step 5 (idx 4): bitmask 0x02→0x40 (Hold type stays)
changes_a.append((rec_offset(4) + 0, 0x40))  # bitmask
# Step 6 (idx 5): type_id 0x00→0x05 (Random), bitmask 0x02→0x04, data 0x04→0x02
changes_a.append((rec_offset(5) + 0, 0x04))  # bitmask
changes_a.append((rec_offset(5) + 3, 0x05))  # type_id
changes_a.append((rec_offset(5) + 4, 0x02))  # data
# Steps 7-16 (idx 6-15): type_id 0x00→0x0a (Trigger), bitmask→0x04, data→0x02
for step in range(6, 16):
    changes_a.append((rec_offset(step) + 0, 0x04))  # bitmask
    changes_a.append((rec_offset(step) + 3, 0x0a))  # type_id
    changes_a.append((rec_offset(step) + 4, 0x02))  # data
# Set separators per formula
for i in range(15):
    if target_seps_a[i] != 10:  # only change what differs
        changes_a.append((sep_offset(i), target_seps_a[i]))
make_delta("v4a_reproduce_118b", "Reproduce 118b pattern with formula seps", changes_a)


# ═══ Test V4_B: Single type change (step 5 → Random) ═══
# Minimal change: only change one step's type_id with correct seps
print("=== V4_B: Minimal single type change (step 5 → Random) ===")
target_types_b = [0x00]*4 + [0x05] + [0x00]*11
target_sizes_b = [7]*16
target_seps_b = compute_seps_formula(target_types_b, target_sizes_b)
print(f"  Formula seps: {target_seps_b}")

changes_b = [
    (rec_offset(4) + 3, 0x05),  # type_id of step 5: Hold → Random
]
for i in range(15):
    if target_seps_b[i] != 10:
        changes_b.append((sep_offset(i), target_seps_b[i]))
make_delta("v4b_single_type", "Step 5 type→Random + formula seps (bitmask unchanged)", changes_b)


# ═══ Test V4_C: Last step → Random ═══
print("=== V4_C: Last step (16) → Random ===")
target_types_c = [0x00]*15 + [0x05]
target_sizes_c = [7]*16
target_seps_c = compute_seps_formula(target_types_c, target_sizes_c)
print(f"  Formula seps: {target_seps_c}")

changes_c = [
    (rec_offset(15) + 3, 0x05),  # type_id of step 16
]
for i in range(15):
    if target_seps_c[i] != 10:
        changes_c.append((sep_offset(i), target_seps_c[i]))
make_delta("v4c_last_step_random", "Step 16 type→Random + formula seps", changes_c)


# ═══ Test V4_D: Two different types (steps 5+10) ═══
print("=== V4_D: Two type changes (step 5 → Random, step 10 → Trigger) ===")
target_types_d = [0x00]*4 + [0x05] + [0x00]*4 + [0x0a] + [0x00]*6
target_sizes_d = [7]*16
target_seps_d = compute_seps_formula(target_types_d, target_sizes_d)
print(f"  Formula seps: {target_seps_d}")

changes_d = [
    (rec_offset(4) + 3, 0x05),   # step 5 → Random
    (rec_offset(9) + 3, 0x0a),   # step 10 → Trigger
]
for i in range(15):
    if target_seps_d[i] != 10:
        changes_d.append((sep_offset(i), target_seps_d[i]))
make_delta("v4d_two_types", "Steps 5+10 type changes + formula seps", changes_d)


# ═══ Test V4_E: Alternating types ═══
print("=== V4_E: Alternating Hold/Random ===")
target_types_e = []
for s in range(16):
    target_types_e.append(0x05 if s % 2 == 1 else 0x00)
target_sizes_e = [7]*16
target_seps_e = compute_seps_formula(target_types_e, target_sizes_e)
print(f"  Formula seps: {target_seps_e}")

changes_e = []
for step in range(16):
    if target_types_e[step] != 0x00:
        changes_e.append((rec_offset(step) + 3, target_types_e[step]))
for i in range(15):
    if target_seps_e[i] != 10:
        changes_e.append((sep_offset(i), target_seps_e[i]))
make_delta("v4e_alternating", "Alternating Hold/Random + formula seps", changes_e)


# ═══ Test V4_F: All different types (first 11 standard types) ═══
print("=== V4_F: All different types (11 standard + 5 Hold) ===")
all_types = list(range(11))  # 0x00 through 0x0a
target_types_f = all_types + [0x00]*5  # pad with Hold
target_sizes_f = [7]*16  # all 7B (simplified — some types normally use 8/9B)
# Note: this is a theoretical test. Types like Param (0x08) and Cond (0x09)
# normally have larger records. Using 7B might be incorrect for the firmware.
# But it tests the separator formula in isolation.
target_seps_f = compute_seps_formula(target_types_f, target_sizes_f)
print(f"  Formula seps: {target_seps_f}")

changes_f = []
for step in range(16):
    if target_types_f[step] != 0x00:
        changes_f.append((rec_offset(step) + 3, target_types_f[step]))
for i in range(15):
    if target_seps_f[i] != 10:
        changes_f.append((sep_offset(i), target_seps_f[i]))
make_delta("v4f_all_types", "11 standard types + 5 Hold + formula seps", changes_f)


# ═══ Summary ═══
print("=" * 70)
print("  TEST PRIORITY")
print("=" * 70)
print("""
  CRITICAL (test first — validates the formula):
    v4a_reproduce_118b    — exact 118b pattern, should match device output
    v4b_single_type       — minimal single type change

  IMPORTANT:
    v4c_last_step_random  — edge case: last step change
    v4d_two_types         — two non-adjacent type changes

  EXPLORATORY:
    v4e_alternating       — stress test: alternating types
    v4f_all_types         — WARNING: record sizes may be wrong for some types
""")
