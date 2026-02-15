#!/usr/bin/env python3
"""Systematic analysis of multi-step separator formulas.

Parses all 3 ground-truth specimens (unnamed 118, 118b, 119) and tests
multiple formula candidates against actual separator values.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject

CORPUS = Path("src/one-off-changes-from-default")

# --- Parser (copied from verify_sep_formula.py) ---

TYPE_NAMES = {
    None: "Pulse", 0x00: "Hold", 0x01: "Chance", 0x02: "Ratchet",
    0x03: "Roll", 0x04: "Retrig", 0x05: "Random", 0x06: "Glide",
    0x07: "Tonal", 0x08: "Param", 0x09: "Cond", 0x0a: "Trigger",
}

TYPE_SIZES = {
    0x00: [7], 0x01: [7], 0x02: [7], 0x03: [7], 0x04: [7],
    0x05: [7], 0x06: [7], 0x07: [7, 9], 0x08: [8], 0x09: [9],
    0x0a: [7, 8],
}
VALID_SEP = set(range(12))  # 0x00-0x0B


def parse_block(body, offset=0xB1):
    """Parse multi-step block using backtracking."""
    if body[offset] != 0xE4:
        return None, None
    start = offset + 1

    def solve(step, pos):
        if step == 16:
            return [], []
        candidates = []
        # Check Pulse (5B)
        if (pos + 5 <= len(body) and
            body[pos + 1] == 0x00 and
            body[pos + 3] == 0x00 and
            body[pos + 4] == 0x00):
            candidates.append((None, 5))
        # Check Standard
        if (pos + 7 <= len(body) and
            body[pos + 1] == 0x00 and
            body[pos + 2] == 0x00):
            type_id = body[pos + 3]
            if type_id <= 0x0A:
                for size in TYPE_SIZES.get(type_id, [7]):
                    if pos + size <= len(body):
                        candidates.append((type_id, size))
        for type_id, size in candidates:
            rec = body[pos:pos + size]
            if step < 15:
                if pos + size >= len(body):
                    continue
                sep = body[pos + size]
                if sep not in VALID_SEP:
                    continue
                result = solve(step + 1, pos + size + 1)
                if result is not None:
                    recs, seps = result
                    recs.insert(0, (type_id, size, rec))
                    seps.insert(0, sep)
                    return recs, seps
            else:
                return [(type_id, size, rec)], []
        return None

    result = solve(0, start)
    return result if result else (None, None)


def load_specimen(name, filename):
    """Load and parse a specimen file."""
    path = CORPUS / filename
    if not path.exists():
        print(f"  WARNING: {path} not found")
        return None
    data = path.read_bytes()
    proj = XYProject.from_bytes(data)
    body = proj.tracks[0].body
    records, seps = parse_block(body)
    if records is None:
        print(f"  WARNING: Could not parse {name}")
        return None
    return {"name": name, "records": records, "seps": seps, "body": body}


def display_specimen(spec):
    """Display parsed records and separators for a specimen."""
    print(f"\n{'='*75}")
    print(f"  {spec['name']}")
    print(f"{'='*75}")
    print(f"  Step  Type       Size  Bitmask  Data          Sep")
    print(f"  {'─'*68}")
    records = spec["records"]
    seps = spec["seps"]
    for i, (type_id, size, raw) in enumerate(records):
        tname = TYPE_NAMES.get(type_id, f"0x{type_id:02x}" if type_id is not None else "???")
        bm = raw[0]
        if type_id is None:
            # Pulse: [bm][00][param][00][00]
            data_str = f"param={raw[2]:#04x}"
        else:
            # Standard: [bm][00][00][type_id][data...][00][00]
            data_bytes = raw[4:-2] if size > 6 else b""
            data_str = data_bytes.hex(' ') if data_bytes else "-"
        sep_str = f"{seps[i]:3d}" if i < 15 else "  -"
        print(f"  {i+1:3d}   {tname:10s}  {size}B   {bm:#04x}    {data_str:<14s} {sep_str}")


# --- Formula candidates ---

def formula_old_hold_dec(records, seps_actual):
    """OLD formula: hold if same, decrement by 1 if different."""
    pred = []
    # Base
    if records[0][0] is None:
        pred.append(11)
    else:
        pred.append(10)
    for i in range(1, 15):
        lt, ls = records[i][0], records[i][1]
        rt, rs = records[i + 1][0], records[i + 1][1]
        if lt == rt and ls == rs:
            pred.append(pred[-1])
        else:
            pred.append(max(pred[-1] - 1, 0))
    return pred


def formula_dec_by_type_size(records, seps_actual):
    """Decrement by 1 when (type_id, size) differs, clamped at 0."""
    pred = []
    if records[0][0] is None:
        pred.append(11)
    else:
        pred.append(10)
    for i in range(1, 15):
        lt, ls = records[i][0], records[i][1]
        rt, rs = records[i + 1][0], records[i + 1][1]
        same = (lt == rt and ls == rs)
        if same:
            pred.append(pred[-1])
        else:
            pred.append(max(pred[-1] - 1, 0))
    return pred


def formula_unique_suffix(records, seps_actual):
    """sep[i] = |unique type_ids in records[i+1..15] excl Pulse|."""
    pred = []
    for i in range(15):
        suffix_types = set()
        for j in range(i + 1, 16):
            if records[j][0] is not None:
                suffix_types.add(records[j][0])
        pred.append(len(suffix_types))
    return pred


def formula_new_in_suffix(records, seps_actual):
    """sep[i] = |new type_ids in records[i+1..15] not in records[0..i], excl Pulse|."""
    pred = []
    for i in range(15):
        prefix_types = set()
        for j in range(0, i + 1):
            if records[j][0] is not None:
                prefix_types.add(records[j][0])
        suffix_types = set()
        for j in range(i + 1, 16):
            if records[j][0] is not None:
                suffix_types.add(records[j][0])
        new_types = suffix_types - prefix_types
        pred.append(len(new_types))
    return pred


def formula_min_unique_dec(records, seps_actual):
    """min(|unique suffix types excl Pulse|, prev_sep - delta).
    delta=1 if different (type_id, size), 0 if same."""
    pred = []
    # Base
    if records[0][0] is None:
        base = 11
    else:
        base = 10
    for i in range(15):
        suffix_types = set()
        for j in range(i + 1, 16):
            if records[j][0] is not None:
                suffix_types.add(records[j][0])
        unique_count = len(suffix_types)
        if i == 0:
            prev = base + 1  # so prev-1 = base for first comparison
            lt, ls = records[0][0], records[0][1]
            rt, rs = records[1][0], records[1][1]
            # For base: if Pulse, base=11; if standard, base=10
            # The "decrement" part: always base for first sep
            dec_val = base
        else:
            prev = pred[-1]
            lt, ls = records[i][0], records[i][1]
            rt, rs = records[i + 1][0], records[i + 1][1]
            same = (lt == rt and ls == rs)
            dec_val = prev if same else max(prev - 1, 0)
        pred.append(min(unique_count, dec_val))
    return pred


def formula_unique_suffix_when_diff(records, seps_actual):
    """When same: hold prev. When different: |unique type_ids in suffix excl Pulse|."""
    pred = []
    if records[0][0] is None:
        base = 11
    else:
        base = 10
    for i in range(15):
        if i == 0:
            # First sep: use base logic
            lt, ls = records[0][0], records[0][1]
            rt, rs = records[1][0], records[1][1]
            same = (lt == rt and ls == rs)
            if same:
                pred.append(base)
            else:
                suffix_types = set()
                for j in range(1, 16):
                    if records[j][0] is not None:
                        suffix_types.add(records[j][0])
                pred.append(len(suffix_types))
        else:
            lt, ls = records[i][0], records[i][1]
            rt, rs = records[i + 1][0], records[i + 1][1]
            same = (lt == rt and ls == rs)
            if same:
                pred.append(pred[-1])
            else:
                suffix_types = set()
                for j in range(i + 1, 16):
                    if records[j][0] is not None:
                        suffix_types.add(records[j][0])
                pred.append(len(suffix_types))
    return pred


def formula_unique_suffix_pairs_when_diff(records, seps_actual):
    """When same: hold prev. When different: |unique (type_id,size) pairs in suffix excl Pulse|."""
    pred = []
    if records[0][0] is None:
        base = 11
    else:
        base = 10
    for i in range(15):
        if i == 0:
            lt, ls = records[0][0], records[0][1]
            rt, rs = records[1][0], records[1][1]
            same = (lt == rt and ls == rs)
            if same:
                pred.append(base)
            else:
                suffix_pairs = set()
                for j in range(1, 16):
                    if records[j][0] is not None:
                        suffix_pairs.add((records[j][0], records[j][1]))
                pred.append(len(suffix_pairs))
        else:
            lt, ls = records[i][0], records[i][1]
            rt, rs = records[i + 1][0], records[i + 1][1]
            same = (lt == rt and ls == rs)
            if same:
                pred.append(pred[-1])
            else:
                suffix_pairs = set()
                for j in range(i + 1, 16):
                    if records[j][0] is not None:
                        suffix_pairs.add((records[j][0], records[j][1]))
                pred.append(len(suffix_pairs))
    return pred


def formula_new_types_when_diff(records, seps_actual):
    """When same: hold prev. When different: |new type_ids in suffix not in prefix, excl Pulse|."""
    pred = []
    if records[0][0] is None:
        base = 11
    else:
        base = 10
    for i in range(15):
        lt, ls = records[i][0], records[i][1]
        rt, rs = records[i + 1][0], records[i + 1][1]
        same = (lt == rt and ls == rs)
        if i == 0:
            if same:
                pred.append(base)
            else:
                prefix_types = {records[0][0]} - {None}
                suffix_types = set()
                for j in range(1, 16):
                    if records[j][0] is not None:
                        suffix_types.add(records[j][0])
                pred.append(len(suffix_types - prefix_types))
        else:
            if same:
                pred.append(pred[-1])
            else:
                prefix_types = set()
                for j in range(0, i + 1):
                    if records[j][0] is not None:
                        prefix_types.add(records[j][0])
                suffix_types = set()
                for j in range(i + 1, 16):
                    if records[j][0] is not None:
                        suffix_types.add(records[j][0])
                pred.append(len(suffix_types - prefix_types))
    return pred


def formula_remaining_distinct_transitions(records, seps_actual):
    """sep[i] = number of type transitions in records[i+1..15]."""
    pred = []
    for i in range(15):
        transitions = 0
        for j in range(i + 1, 15):
            lt, ls = records[j][0], records[j][1]
            rt, rs = records[j + 1][0], records[j + 1][1]
            if lt != rt or ls != rs:
                transitions += 1
        pred.append(transitions)
    return pred


def formula_11_minus_seen(records, seps_actual):
    """sep[i] = 11 - |unique non-Pulse type_ids in records[0..i]|."""
    pred = []
    for i in range(15):
        seen = set()
        for j in range(0, i + 1):
            if records[j][0] is not None:
                seen.add(records[j][0])
        pred.append(11 - len(seen))
    return pred


def formula_11_minus_seen_plus1(records, seps_actual):
    """sep[i] = 11 - |unique non-Pulse type_ids in records[0..i+1]|."""
    pred = []
    for i in range(15):
        seen = set()
        for j in range(0, i + 2):
            if records[j][0] is not None:
                seen.add(records[j][0])
        pred.append(11 - len(seen))
    return pred


def formula_unique_suffix_minus_1_when_diff(records, seps_actual):
    """When same: hold. When diff: max(0, |unique suffix types| - 1)."""
    pred = []
    if records[0][0] is None:
        base = 11
    else:
        base = 10
    for i in range(15):
        lt, ls = records[i][0], records[i][1]
        rt, rs = records[i + 1][0], records[i + 1][1]
        same = (lt == rt and ls == rs)
        if i == 0:
            if same:
                pred.append(base)
            else:
                suffix_types = set()
                for j in range(1, 16):
                    if records[j][0] is not None:
                        suffix_types.add(records[j][0])
                pred.append(max(0, len(suffix_types) - 1))
        else:
            if same:
                pred.append(pred[-1])
            else:
                suffix_types = set()
                for j in range(i + 1, 16):
                    if records[j][0] is not None:
                        suffix_types.add(records[j][0])
                pred.append(max(0, len(suffix_types) - 1))
    return pred


def formula_min_new_and_remaining_transitions(records, seps_actual):
    """sep[i] = min(|new types in suffix|, |transitions in suffix| + 1) for diff, hold for same."""
    pred = []
    if records[0][0] is None:
        base = 11
    else:
        base = 10
    for i in range(15):
        lt, ls = records[i][0], records[i][1]
        rt, rs = records[i + 1][0], records[i + 1][1]
        same = (lt == rt and ls == rs)
        if same and i > 0:
            pred.append(pred[-1])
        elif same and i == 0:
            pred.append(base)
        else:
            # Count unique types in suffix
            suffix_types = set()
            for j in range(i + 1, 16):
                if records[j][0] is not None:
                    suffix_types.add(records[j][0])
            unique_count = len(suffix_types)
            # Count transitions in suffix
            transitions = 0
            for j in range(i + 1, 15):
                a_t, a_s = records[j][0], records[j][1]
                b_t, b_s = records[j + 1][0], records[j + 1][1]
                if a_t != b_t or a_s != b_s:
                    transitions += 1
            pred.append(min(unique_count, transitions + 1))
    return pred


def formula_runs_adjusted(records, seps_actual):
    """When same: HOLD. When diff: min(adjusted_runs_in_suffix, prev-1).

    Runs = consecutive groups of same type_id in suffix.
    Adjustment: if records[i+1] starts a multi-element run (same type_id as
    records[i+2]), subtract 1 from runs count.
    Base: 10 for standard first, 11 for Pulse first.
    For sep[0] when diff: min(count, base) [no prev-1 decrement].
    """
    base = 11 if records[0][0] is None else 10
    pred = []
    for i in range(15):
        lt, ls = records[i][0], records[i][1]
        rt, rs = records[i + 1][0], records[i + 1][1]
        same = (lt == rt and ls == rs)
        if same:
            if not pred:
                pred.append(base)
            else:
                pred.append(pred[-1])
        else:
            # Count type_id runs in records[i+1..15]
            runs = 1
            for j in range(i + 2, 16):
                if records[j][0] != records[j - 1][0]:
                    runs += 1
            # Adjust: if records[i+1] starts a same-type_id run with records[i+2]
            starts_run = (i + 2 <= 15 and records[i + 1][0] == records[i + 2][0])
            count = runs - (1 if starts_run else 0)
            if not pred:
                pred.append(min(count, base))
            else:
                pred.append(min(count, max(0, pred[-1] - 1)))
    return pred


FORMULAS = [
    ("old_hold_dec", formula_old_hold_dec),
    ("dec_by_type_size", formula_dec_by_type_size),
    ("unique_suffix", formula_unique_suffix),
    ("new_in_suffix", formula_new_in_suffix),
    ("min_unique_dec", formula_min_unique_dec),
    ("unique_when_diff", formula_unique_suffix_when_diff),
    ("pairs_when_diff", formula_unique_suffix_pairs_when_diff),
    ("new_types_when_diff", formula_new_types_when_diff),
    ("remaining_transitions", formula_remaining_distinct_transitions),
    ("11_minus_seen", formula_11_minus_seen),
    ("11_minus_seen+1", formula_11_minus_seen_plus1),
    ("unique-1_when_diff", formula_unique_suffix_minus_1_when_diff),
    ("min_new_trans", formula_min_new_and_remaining_transitions),
    ("runs_adjusted", formula_runs_adjusted),
]


def test_formula(name, formula_fn, specimens):
    """Test a formula against all specimens, return match counts."""
    results = {}
    for spec in specimens:
        pred = formula_fn(spec["records"], spec["seps"])
        matches = sum(1 for a, p in zip(spec["seps"], pred) if a == p)
        mismatches = []
        for idx, (a, p) in enumerate(zip(spec["seps"], pred)):
            if a != p:
                mismatches.append((idx, a, p))
        results[spec["name"]] = (matches, 15, pred, mismatches)
    return results


def main():
    print("=" * 75)
    print("  Multi-Step Separator Formula Analysis")
    print("=" * 75)

    # Load specimens
    specimens = []
    for name, filename in [
        ("unnamed 118", "unnamed 118.xy"),
        ("unnamed 118b", "unnamed 118b.xy"),
        ("unnamed 119", "unnamed 119.xy"),
    ]:
        spec = load_specimen(name, filename)
        if spec:
            specimens.append(spec)

    if not specimens:
        print("No specimens loaded!")
        return 1

    # Display all specimens
    for spec in specimens:
        display_specimen(spec)

    # Test all formulas
    print(f"\n\n{'='*75}")
    print(f"  FORMULA COMPARISON")
    print(f"{'='*75}")

    all_results = {}
    for fname, ffn in FORMULAS:
        all_results[fname] = test_formula(fname, ffn, specimens)

    # Summary table
    spec_names = [s["name"] for s in specimens]
    header = f"  {'Formula':<25s}"
    for sn in spec_names:
        header += f"  {sn:>14s}"
    header += "  Total"
    print(f"\n{header}")
    print(f"  {'─'*len(header)}")

    for fname, _ in FORMULAS:
        results = all_results[fname]
        row = f"  {fname:<25s}"
        total = 0
        for sn in spec_names:
            m, n, _, _ = results[sn]
            total += m
            row += f"  {m:>3d}/{n:<3d}       "
        row += f"  {total:>3d}/{15*len(specimens)}"
        print(row)

    # Show details for best formulas
    print(f"\n\n{'='*75}")
    print(f"  DETAILED MISMATCHES FOR TOP FORMULAS")
    print(f"{'='*75}")

    # Sort by total matches
    ranked = []
    for fname, _ in FORMULAS:
        total = sum(all_results[fname][sn][0] for sn in spec_names)
        ranked.append((total, fname))
    ranked.sort(reverse=True)

    for total, fname in ranked[:5]:
        print(f"\n--- {fname} ({total}/{15*len(specimens)}) ---")
        results = all_results[fname]
        for sn in spec_names:
            m, n, pred, mismatches = results[sn]
            if mismatches:
                print(f"  {sn}: {m}/{n}")
                for idx, actual, predicted in mismatches:
                    print(f"    sep[{idx:2d}]: actual={actual:2d} predicted={predicted:2d}")
            else:
                print(f"  {sn}: {m}/{n} PERFECT")

    # Also show actual vs predicted for each specimen with best formula
    best_total, best_name = ranked[0]
    if best_total < 15 * len(specimens):
        print(f"\n\n{'='*75}")
        print(f"  BEST FORMULA: {best_name} ({best_total}/{15*len(specimens)})")
        print(f"  (No perfect formula found yet)")
        print(f"{'='*75}")
        for spec in specimens:
            pred = all_results[best_name][spec["name"]][2]
            actual = spec["seps"]
            print(f"\n  {spec['name']}:")
            print(f"  {'Pos':>5s}  {'Actual':>6s}  {'Pred':>6s}  {'OK':>3s}  L_type  R_type")
            for i in range(15):
                lt = TYPE_NAMES.get(spec["records"][i][0], "?")
                rt = TYPE_NAMES.get(spec["records"][i+1][0], "?")
                ls = spec["records"][i][1]
                rs = spec["records"][i+1][1]
                ok = "✓" if actual[i] == pred[i] else "✗"
                print(f"  [{i:2d}]  {actual[i]:6d}  {pred[i]:6d}  {ok:>3s}  {lt}({ls}B) → {rt}({rs}B)")

    return 0


if __name__ == "__main__":
    sys.exit(main())
