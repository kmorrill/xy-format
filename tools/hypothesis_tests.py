#!/usr/bin/env python3
"""Corpus-backed hypothesis tests and serializer model scoring for OP-XY files.

This script is intended to replace ad-hoc "looks right" checks with repeatable
measurements against real `.xy` files.

Examples
--------
  python tools/hypothesis_tests.py h4-signature
  python tools/hypothesis_tests.py h10-padding
  python tools/hypothesis_tests.py h2-preamble
  python tools/hypothesis_tests.py h7-pretrack
  python tools/hypothesis_tests.py event-models
"""

from __future__ import annotations

import argparse
from collections import Counter
import glob
from dataclasses import dataclass
from difflib import SequenceMatcher
from pathlib import Path
import statistics
import sys
from typing import Callable, Iterable, Sequence

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYProject
from xy.note_events import DEFAULT_GATE, Note, STEP_TICKS, build_event
from xy.note_reader import KNOWN_EVENT_TYPES, find_event
from xy.structs import TRACK_SIGNATURE_HEAD, TRACK_SIGNATURE_TAIL
from tools.corpus_lab import _extract_logical_entries

DEFAULT_GLOBS = (
    "src/one-off-changes-from-default/*.xy",
    "src/*.xy",
)
BASELINE_PATH = REPO_ROOT / "src" / "one-off-changes-from-default" / "unnamed 1.xy"


def collect_paths(patterns: Sequence[str]) -> list[Path]:
    seen: set[Path] = set()
    out: list[Path] = []
    for pattern in patterns:
        for raw in sorted(glob.glob(pattern)):
            path = Path(raw).resolve()
            if path in seen or not path.is_file():
                continue
            seen.add(path)
            out.append(path)
    return out


def _safe_project(path: Path) -> XYProject | None:
    try:
        return XYProject.from_bytes(path.read_bytes())
    except Exception:
        return None


def run_h4_signature(paths: Sequence[Path]) -> int:
    checked = 0
    bad: list[str] = []
    for path in paths:
        project = _safe_project(path)
        if project is None:
            continue
        for idx, track in enumerate(project.tracks, start=1):
            checked += 1
            sig = track.body[:8]
            head_ok = sig[:3] == TRACK_SIGNATURE_HEAD
            tail_ok = sig[4:8] == TRACK_SIGNATURE_TAIL
            if not (head_ok and tail_ok):
                bad.append(
                    f"{path.name}:T{idx} sig={sig.hex()}"
                )
    print("[H4] Track signature constant check")
    print(f"Checked track blocks: {checked}")
    print(f"Mismatches: {len(bad)}")
    for line in bad[:20]:
        print(f"  - {line}")
    if len(bad) > 20:
        print(f"  ... {len(bad) - 20} more")
    return 0 if not bad else 1


def run_h10_padding(paths: Sequence[Path]) -> int:
    checked = 0
    bad: list[str] = []
    for path in paths:
        project = _safe_project(path)
        if project is None:
            continue
        for idx, track in enumerate(project.tracks, start=1):
            if track.type_byte != 0x05:
                continue
            checked += 1
            if len(track.body) < 12:
                bad.append(f"{path.name}:T{idx} short body len={len(track.body)}")
                continue
            pad = track.body[10:12]
            if pad != b"\x08\x00":
                bad.append(f"{path.name}:T{idx} pad={pad.hex()}")
    print("[H10] Type-0x05 padding sentinel check")
    print(f"Checked type-0x05 tracks: {checked}")
    print(f"Mismatches: {len(bad)}")
    for line in bad[:20]:
        print(f"  - {line}")
    if len(bad) > 20:
        print(f"  ... {len(bad) - 20} more")
    return 0 if not bad else 1


def run_h2_preamble(paths: Sequence[Path]) -> int:
    baseline = _safe_project(BASELINE_PATH)
    baseline_vals = (
        [t.preamble[0] for t in baseline.tracks] if baseline is not None else [None] * 16
    )

    per_track_values: list[set[int]] = [set() for _ in range(16)]
    per_track_nonbaseline: list[int] = [0] * 16
    files_used = 0

    for path in paths:
        project = _safe_project(path)
        if project is None:
            continue
        files_used += 1
        for idx, track in enumerate(project.tracks):
            value = track.preamble[0]
            per_track_values[idx].add(value)
            if baseline_vals[idx] is not None and value != baseline_vals[idx]:
                per_track_nonbaseline[idx] += 1

    print("[H2] Preamble byte[0] slot-stability check")
    print(f"Files parsed: {files_used}")
    print("Per-track distinct values (vs baseline unnamed 1):")
    for idx in range(16):
        values = sorted(per_track_values[idx])
        values_hex = ", ".join(f"0x{v:02X}" for v in values) if values else "(none)"
        baseline_repr = (
            f"0x{baseline_vals[idx]:02X}" if baseline_vals[idx] is not None else "n/a"
        )
        changed = per_track_nonbaseline[idx]
        print(
            f"  T{idx+1:02d}: baseline={baseline_repr}  "
            f"distinct=[{values_hex}]  non-baseline-files={changed}"
        )
    return 0


def _iter_logical_rows(paths: Sequence[Path]) -> tuple[list[dict[str, int]], int]:
    rows: list[dict[str, int]] = []
    parse_failures = 0
    for path in paths:
        project = _safe_project(path)
        if project is None:
            parse_failures += 1
            continue
        try:
            entries = _extract_logical_entries(project)
        except Exception:
            parse_failures += 1
            continue

        has_event_by_idx: list[int] = []
        for entry in entries:
            if int(entry["active"]) != 1:
                has_event_by_idx.append(0)
                continue
            track = int(entry["track"])
            body = entry["body"]
            try:
                has_event = 1 if find_event(body, track) is not None else 0
            except Exception:
                has_event = 0
            has_event_by_idx.append(has_event)

        for idx, entry in enumerate(entries):
            prev = entries[idx - 1] if idx > 0 else None
            rows.append(
                {
                    "track": int(entry["track"]),
                    "pattern": int(entry["pattern"]),
                    "pattern_count": int(entry["pattern_count"]),
                    "is_clone": int(entry["is_clone"]),
                    "is_leader": int(entry["is_leader"]),
                    "active": int(entry["active"]),
                    "prev_active": int(entry["prev_active"]),
                    "pre0": int(entry["pre0"]),
                    "prev_track": int(prev["track"]) if prev is not None else 0,
                    "prev_pre0": int(prev["pre0"]) if prev is not None else -1,
                    "prev_is_clone": int(prev["is_clone"]) if prev is not None else 0,
                    "has_event": has_event_by_idx[idx],
                    "prev_has_event": has_event_by_idx[idx - 1] if idx > 0 else 0,
                }
            )
    return rows, parse_failures


def run_h2_automaton(paths: Sequence[Path]) -> int:
    """Test if preamble byte[0] behaves like a small deterministic state machine."""
    rows, parse_failures = _iter_logical_rows(paths)
    if not rows:
        print("[H2-automaton] No logical rows parsed.")
        return 1

    key_specs: list[tuple[str, Callable[[dict[str, int]], tuple[int, ...]]]] = [
        (
            "track+clone+prev_active",
            lambda r: (r["track"], r["is_clone"], r["prev_active"]),
        ),
        (
            "track+clone+prev_active+pattern_count",
            lambda r: (r["track"], r["is_clone"], r["prev_active"], r["pattern_count"]),
        ),
        (
            "track+clone+prev_active+active",
            lambda r: (r["track"], r["is_clone"], r["prev_active"], r["active"]),
        ),
        (
            "track+clone+prev_active+prev_track+prev_pre0",
            lambda r: (
                r["track"],
                r["is_clone"],
                r["prev_active"],
                r["prev_track"],
                r["prev_pre0"],
            ),
        ),
    ]

    print("[H2-automaton] Preamble byte[0] state-machine test")
    print(f"Logical rows: {len(rows)}")
    print(f"Parse failures/skips: {parse_failures}")
    print("")

    for name, key_fn in key_specs:
        key_to_vals: dict[tuple[int, ...], Counter[int]] = {}
        for row in rows:
            key = key_fn(row)
            counter = key_to_vals.get(key)
            if counter is None:
                counter = Counter()
                key_to_vals[key] = counter
            counter[row["pre0"]] += 1

        total = len(rows)
        exact_rows = 0
        ambiguous_keys = 0
        ambiguous_rows = 0
        max_conflicts: list[tuple[int, tuple[int, ...], Counter[int]]] = []

        for key, vals in key_to_vals.items():
            key_total = sum(vals.values())
            key_best = max(vals.values())
            exact_rows += key_best
            if len(vals) > 1:
                ambiguous_keys += 1
                ambiguous_rows += key_total
                max_conflicts.append((key_total, key, vals))

        accuracy = exact_rows / total
        print(f"{name}:")
        print(
            f"  keys={len(key_to_vals)}  "
            f"majority-accuracy={accuracy:.1%}  "
            f"ambiguous-keys={ambiguous_keys}  ambiguous-rows={ambiguous_rows} ({ambiguous_rows/total:.1%})"
        )
        if max_conflicts:
            print("  top ambiguous keys:")
            for key_total, key, vals in sorted(max_conflicts, reverse=True)[:5]:
                parts = ", ".join(f"0x{k:02X}:{v}" for k, v in sorted(vals.items()))
                print(f"    n={key_total:3d} key={key} -> {parts}")
        print("")

    # Evaluate the current explicit writer rule as a concrete automaton.
    baseline = _safe_project(BASELINE_PATH)
    baseline_pre0 = {idx + 1: int(track.preamble[0]) for idx, track in enumerate(baseline.tracks)} if baseline else {}

    def predict_rule(row: dict[str, int]) -> int:
        # Track 1 multi-pattern leader branch
        if row["track"] == 1 and row["pattern"] == 1 and row["pattern_count"] > 1:
            return 0xB5
        # Clone semantics in current writer paths
        if row["is_clone"]:
            return 0x00
        # 0x64 propagation with T5 exemption
        if row["prev_active"] and row["track"] != 5:
            return 0x64
        return baseline_pre0.get(row["track"], row["pre0"])

    misses: list[dict[str, int]] = []
    correct = 0
    for row in rows:
        pred = predict_rule(row)
        if pred == row["pre0"]:
            correct += 1
        else:
            miss = dict(row)
            miss["pred"] = pred
            misses.append(miss)
    print("explicit_rule(track/clone/prev_active + T1/T5 branches):")
    print(f"  accuracy={correct/len(rows):.1%}  misses={len(misses)}/{len(rows)}")
    if misses:
        miss_counter: Counter[tuple[int, int, int, int, int]] = Counter(
            (
                m["track"],
                m["is_clone"],
                m["prev_active"],
                m["pred"],
                m["pre0"],
            )
            for m in misses
        )
        print("  top miss clusters (track,is_clone,prev_active,pred,actual):")
        for key, count in miss_counter.most_common(8):
            print(f"    n={count:3d}  {key}")

    def predict_event_gated(row: dict[str, int]) -> int:
        if row["track"] == 1 and row["pattern"] == 1 and row["pattern_count"] > 1:
            return 0xB5
        if row["is_clone"]:
            return 0x00
        if row["prev_has_event"] and row["track"] != 5:
            return 0x64
        return baseline_pre0.get(row["track"], row["pre0"])

    misses2: list[dict[str, int]] = []
    correct2 = 0
    for row in rows:
        pred = predict_event_gated(row)
        if pred == row["pre0"]:
            correct2 += 1
        else:
            miss = dict(row)
            miss["pred"] = pred
            misses2.append(miss)
    print("event_gated_rule(track/clone/prev_has_event + T1/T5 branches):")
    print(f"  accuracy={correct2/len(rows):.1%}  misses={len(misses2)}/{len(rows)}")
    if misses2:
        miss_counter2: Counter[tuple[int, int, int, int, int, int]] = Counter(
            (
                m["track"],
                m["is_clone"],
                m["prev_active"],
                m["prev_has_event"],
                m["pred"],
                m["pre0"],
            )
            for m in misses2
        )
        print(
            "  top miss clusters "
            "(track,is_clone,prev_active,prev_has_event,pred,actual):"
        )
        for key, count in miss_counter2.most_common(8):
            print(f"    n={count:3d}  {key}")

    return 0


@dataclass(frozen=True)
class PretrackDelta:
    file_name: str
    pre_len: int
    signature: str
    has_delete: bool


@dataclass(frozen=True)
class PretrackOps:
    file_name: str
    ops: tuple[tuple[str, int, int, int], ...]  # (tag, i1, a_len, b_len)


def _pretrack_signature(base: bytes, other: bytes) -> tuple[str, bool]:
    matcher = SequenceMatcher(a=base, b=other, autojunk=False)
    parts: list[str] = []
    has_delete = False
    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        if tag == "equal":
            continue
        a_len = i2 - i1
        b_len = j2 - j1
        parts.append(f"{tag}@0x{i1:02X}(a{a_len}->b{b_len})")
        if tag == "delete":
            has_delete = True
    return ";".join(parts) if parts else "identical", has_delete


def run_h7_pretrack(paths: Sequence[Path]) -> int:
    baseline = _safe_project(BASELINE_PATH)
    if baseline is None:
        print("[H7] Unable to parse baseline file; aborting.")
        return 1

    rows: list[PretrackDelta] = []
    for path in paths:
        project = _safe_project(path)
        if project is None:
            continue
        sig, has_delete = _pretrack_signature(baseline.pre_track, project.pre_track)
        rows.append(
            PretrackDelta(
                file_name=path.name,
                pre_len=len(project.pre_track),
                signature=sig,
                has_delete=has_delete,
            )
        )

    hist: dict[str, int] = {}
    delete_count = 0
    for row in rows:
        hist[row.signature] = hist.get(row.signature, 0) + 1
        if row.has_delete:
            delete_count += 1

    print("[H7] Pre-track growth pattern check")
    print(f"Files analyzed: {len(rows)}")
    print(f"Rows with delete operations (against baseline pre-track): {delete_count}")
    print("Top delta signatures:")
    for signature, count in sorted(hist.items(), key=lambda item: (-item[1], item[0]))[:20]:
        print(f"  {count:4d}  {signature}")

    if delete_count:
        print("Examples with delete ops:")
        shown = 0
        for row in rows:
            if not row.has_delete:
                continue
            print(f"  - {row.file_name}: len={row.pre_len}  {row.signature}")
            shown += 1
            if shown >= 20:
                break
    return 0 if delete_count == 0 else 1


def _pretrack_struct_ops(base: bytes, other: bytes) -> tuple[tuple[str, int, int, int], ...]:
    matcher = SequenceMatcher(a=base, b=other, autojunk=False)
    out: list[tuple[str, int, int, int]] = []
    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        if tag == "equal":
            continue
        out.append((tag, i1, i2 - i1, j2 - j1))
    return tuple(out)


def run_h7_compositional(paths: Sequence[Path]) -> int:
    baseline = _safe_project(BASELINE_PATH)
    if baseline is None:
        print("[H7-compositional] Unable to parse baseline file; aborting.")
        return 1

    rows: list[PretrackOps] = []
    for path in paths:
        project = _safe_project(path)
        if project is None:
            continue
        rows.append(
            PretrackOps(
                file_name=path.name,
                ops=_pretrack_struct_ops(baseline.pre_track, project.pre_track),
            )
        )

    script_counter: Counter[tuple[tuple[str, int, int, int], ...]] = Counter()
    atom_counter: Counter[tuple[str, int, int, int]] = Counter()
    op_count_counter: Counter[int] = Counter()
    insert_sites: Counter[tuple[int, int]] = Counter()  # (offset, b_len)
    replace_sites: Counter[tuple[int, int, int]] = Counter()  # (offset, a_len, b_len)
    delete_sites: Counter[tuple[int, int]] = Counter()  # (offset, a_len)

    for row in rows:
        script_counter[row.ops] += 1
        op_count_counter[len(row.ops)] += 1
        for atom in row.ops:
            atom_counter[atom] += 1
            tag, i1, a_len, b_len = atom
            if tag == "insert":
                insert_sites[(i1, b_len)] += 1
            elif tag == "replace":
                replace_sites[(i1, a_len, b_len)] += 1
            elif tag == "delete":
                delete_sites[(i1, a_len)] += 1

    total = len(rows)
    if total == 0:
        print("[H7-compositional] No parseable rows.")
        return 1

    top_atoms = [atom for atom, _ in atom_counter.most_common(16)]
    top_atom_set = set(top_atoms)
    covered_by_top_atoms = sum(
        1 for row in rows if all(atom in top_atom_set for atom in row.ops)
    )
    small_op_rows = sum(1 for row in rows if len(row.ops) <= 2)
    has_delete_rows = sum(1 for row in rows if any(atom[0] == "delete" for atom in row.ops))
    top_script_coverage = sum(count for _, count in script_counter.most_common(8))

    print("[H7-compositional] Pre-track compositionality test")
    print(f"Files analyzed: {total}")
    print(f"Distinct structural scripts: {len(script_counter)}")
    print(f"Distinct structural atoms:   {len(atom_counter)}")
    print("")
    print("Op-count distribution (structural ops per file):")
    for op_count in sorted(op_count_counter):
        count = op_count_counter[op_count]
        print(f"  ops={op_count:2d}: {count:4d} ({count/total:.1%})")

    print("")
    print("Most frequent structural atoms:")
    for (tag, off, a_len, b_len), count in atom_counter.most_common(16):
        print(
            f"  {count:4d}  {tag:7s} @0x{off:02X}  a{a_len}->b{b_len}"
        )

    print("")
    print("Most frequent insertion sites:")
    for (off, b_len), count in insert_sites.most_common(10):
        print(f"  {count:4d}  insert @0x{off:02X} len={b_len}")

    print("")
    print("Most frequent replacement sites:")
    for (off, a_len, b_len), count in replace_sites.most_common(10):
        print(f"  {count:4d}  replace @0x{off:02X} a{a_len}->b{b_len}")

    if delete_sites:
        print("")
        print("Delete sites:")
        for (off, a_len), count in delete_sites.most_common(10):
            print(f"  {count:4d}  delete @0x{off:02X} len={a_len}")

    print("")
    print("Coverage summary:")
    print(
        f"  <=2 structural ops:         {small_op_rows:4d}/{total} ({small_op_rows/total:.1%})"
    )
    print(
        f"  Top-8 scripts cover:        {top_script_coverage:4d}/{total} ({top_script_coverage/total:.1%})"
    )
    print(
        f"  Top-16 atoms cover files:   {covered_by_top_atoms:4d}/{total} ({covered_by_top_atoms/total:.1%})"
    )
    print(
        f"  Files with delete ops:      {has_delete_rows:4d}/{total} ({has_delete_rows/total:.1%})"
    )

    # Heuristic verdict only; this is a measurement tool.
    strong = (
        (small_op_rows / total) >= 0.85
        and (top_script_coverage / total) >= 0.90
        and (has_delete_rows / total) <= 0.05
    )
    partial = (
        (small_op_rows / total) >= 0.65
        and (top_script_coverage / total) >= 0.75
    )
    if strong:
        verdict = "STRONG support"
    elif partial:
        verdict = "PARTIAL support"
    else:
        verdict = "WEAK support"
    print("")
    print(f"Verdict: {verdict} for baseline+compositional pre-track hypothesis.")
    return 0


def run_h8_t5_exemption(paths: Sequence[Path]) -> int:
    """Test H8: T5 preamble exemption from 0x64 propagation."""
    files = 0
    parse_failures = 0

    leader5_pre0: Counter[int] = Counter()
    leader6_pre0: Counter[int] = Counter()

    t5_after_active_t4_total = 0
    t5_after_active_t4_pre0: Counter[int] = Counter()

    t6_after_active_t5_total = 0
    t6_after_active_t5_pre0: Counter[int] = Counter()

    for path in paths:
        project = _safe_project(path)
        if project is None:
            parse_failures += 1
            continue
        try:
            entries = _extract_logical_entries(project)
        except Exception:
            parse_failures += 1
            continue
        files += 1

        leader5_idx = None
        leader6_idx = None
        for idx, entry in enumerate(entries):
            if entry["track"] == 5 and entry["pattern"] == 1 and leader5_idx is None:
                leader5_idx = idx
            if entry["track"] == 6 and entry["pattern"] == 1 and leader6_idx is None:
                leader6_idx = idx
            if leader5_idx is not None and leader6_idx is not None:
                break

        if leader5_idx is not None:
            entry5 = entries[leader5_idx]
            p0_5 = int(entry5["pre0"])
            leader5_pre0[p0_5] += 1
            if leader5_idx > 0:
                prev = entries[leader5_idx - 1]
                if prev["track"] == 4 and int(prev["active"]) == 1:
                    t5_after_active_t4_total += 1
                    t5_after_active_t4_pre0[p0_5] += 1

        if leader6_idx is not None:
            entry6 = entries[leader6_idx]
            p0_6 = int(entry6["pre0"])
            leader6_pre0[p0_6] += 1
            if leader6_idx > 0:
                prev = entries[leader6_idx - 1]
                if prev["track"] == 5 and int(prev["active"]) == 1:
                    t6_after_active_t5_total += 1
                    t6_after_active_t5_pre0[p0_6] += 1

    def fmt_counter(counter: Counter[int]) -> str:
        if not counter:
            return "(none)"
        return ", ".join(
            f"0x{k:02X}:{v}" for k, v in sorted(counter.items(), key=lambda item: item[0])
        )

    print("[H8] T5 preamble exemption hypothesis test")
    print(f"Files parsed: {files}")
    print(f"Parse failures/skips: {parse_failures}")
    print("")
    print(f"Leader T5 pre0 distribution: {fmt_counter(leader5_pre0)}")
    print(f"Leader T6 pre0 distribution: {fmt_counter(leader6_pre0)}")
    print("")
    print(
        "Cases where leader T5 follows active T4 "
        f"(prev logical entry track=4 active=1): {t5_after_active_t4_total}"
    )
    print(f"  T5 pre0 in those cases: {fmt_counter(t5_after_active_t4_pre0)}")
    print("")
    print(
        "Cases where leader T6 follows active T5 "
        f"(prev logical entry track=5 active=1): {t6_after_active_t5_total}"
    )
    print(f"  T6 pre0 in those cases: {fmt_counter(t6_after_active_t5_pre0)}")
    print("")

    t5_after_active_t4_is_2e = t5_after_active_t4_pre0.get(0x2E, 0)
    t5_after_active_t4_is_64 = t5_after_active_t4_pre0.get(0x64, 0)
    t6_after_active_t5_is_64 = t6_after_active_t5_pre0.get(0x64, 0)

    if t5_after_active_t4_total:
        print(
            "T5 after active T4 -> 0x2E rate: "
            f"{t5_after_active_t4_is_2e}/{t5_after_active_t4_total} "
            f"({t5_after_active_t4_is_2e / t5_after_active_t4_total:.1%})"
        )
        print(
            "T5 after active T4 -> 0x64 rate: "
            f"{t5_after_active_t4_is_64}/{t5_after_active_t4_total} "
            f"({t5_after_active_t4_is_64 / t5_after_active_t4_total:.1%})"
        )
    if t6_after_active_t5_total:
        print(
            "T6 after active T5 -> 0x64 rate: "
            f"{t6_after_active_t5_is_64}/{t6_after_active_t5_total} "
            f"({t6_after_active_t5_is_64 / t6_after_active_t5_total:.1%})"
        )

    # For this corpus check we don't fail hard on mixed outcomes.
    return 0


@dataclass(frozen=True)
class EventCase:
    path: Path
    track: int
    event_type: int
    notes: tuple[Note, ...]
    raw: bytes


class EventParseError(ValueError):
    pass


def _parse_event_blob(body: bytes, offset: int) -> tuple[int, list[Note], bytes]:
    if offset < 0 or offset + 2 > len(body):
        raise EventParseError("offset out of range")

    event_type = body[offset]
    count = body[offset + 1]
    if event_type not in KNOWN_EVENT_TYPES:
        raise EventParseError(f"unsupported event type 0x{event_type:02X}")
    if not (1 <= count <= 120):
        raise EventParseError(f"invalid count {count}")

    pos = offset + 2
    prev_tick = 0
    notes: list[Note] = []

    for i in range(count):
        if i == 0:
            if pos + 3 > len(body):
                raise EventParseError("short first-note tick/flag")
            tick = int.from_bytes(body[pos : pos + 2], "little", signed=False)
            pos += 2
            flag = body[pos]
            pos += 1
            if flag == 0x00:
                if pos + 2 > len(body):
                    raise EventParseError("short first-note pad")
                pos += 2
            elif flag != 0x02:
                raise EventParseError(f"unexpected first-note flag 0x{flag:02X}")
        else:
            if pos + 3 > len(body):
                raise EventParseError("short continuation prelude")
            pos += 2  # prior note trail
            cont = body[pos]
            pos += 1

            if cont == 0x00:
                if pos + 3 > len(body):
                    raise EventParseError("short cont=0x00 tick/flag")
                tick = int.from_bytes(body[pos : pos + 2], "little", signed=False)
                pos += 2
                flag = body[pos]
                pos += 1
                if flag == 0x00:
                    if pos + 2 > len(body):
                        raise EventParseError("short cont=0x00 pad")
                    pos += 2
                elif flag != 0x02:
                    raise EventParseError(f"unexpected cont=0x00 flag 0x{flag:02X}")
            elif cont == 0x01:
                if pos + 2 > len(body):
                    raise EventParseError("short cont=0x01 tick_hi/flag")
                tick_hi = body[pos]
                pos += 1
                tick = tick_hi << 8
                flag = body[pos]
                pos += 1
                if flag == 0x00:
                    if pos + 2 > len(body):
                        raise EventParseError("short cont=0x01 pad")
                    pos += 2
                elif flag != 0x02:
                    raise EventParseError(f"unexpected cont=0x01 flag 0x{flag:02X}")
            elif cont == 0x04:
                tick = prev_tick
            else:
                raise EventParseError(f"unsupported continuation byte 0x{cont:02X}")

        if pos >= len(body):
            raise EventParseError("missing gate byte")
        gate_byte = body[pos]
        if gate_byte == 0xF0:
            if pos + 4 > len(body):
                raise EventParseError("short default gate")
            pos += 4
            gate_ticks = 0
        else:
            if pos + 5 > len(body):
                raise EventParseError("short explicit gate")
            gate_ticks = int.from_bytes(body[pos : pos + 2], "little", signed=False)
            pos += 5

        if pos + 2 > len(body):
            raise EventParseError("missing note/velocity")
        note = body[pos]
        velocity = body[pos + 1]
        pos += 2
        if note > 0x7F or velocity > 0x7F:
            raise EventParseError("out-of-range note/velocity")

        step = (tick // STEP_TICKS) + 1
        tick_offset = tick % STEP_TICKS
        notes.append(
            Note(
                step=step,
                note=note,
                velocity=velocity,
                tick_offset=tick_offset,
                gate_ticks=gate_ticks,
            )
        )
        prev_tick = tick

    # Most captures include a final 2-byte trail at the end of the event.
    if pos + 2 <= len(body) and body[pos : pos + 2] == b"\x00\x00":
        pos += 2

    return event_type, notes, body[offset:pos]


def extract_event_cases(paths: Sequence[Path]) -> tuple[list[EventCase], int]:
    cases: list[EventCase] = []
    parse_failures = 0

    for path in paths:
        project = _safe_project(path)
        if project is None:
            continue

        for track_index, track in enumerate(project.tracks, start=1):
            if track.type_byte != 0x07:
                continue
            event_offset = find_event(track.body, track_index)
            if event_offset is None:
                continue
            try:
                event_type, notes, raw = _parse_event_blob(track.body, event_offset)
            except EventParseError:
                parse_failures += 1
                continue
            if not notes or not raw:
                continue
            cases.append(
                EventCase(
                    path=path,
                    track=track_index,
                    event_type=event_type,
                    notes=tuple(notes),
                    raw=raw,
                )
            )
    return cases, parse_failures


def _sorted_notes(notes: Iterable[Note]) -> list[Note]:
    return sorted(
        notes,
        key=lambda n: ((n.step - 1) * STEP_TICKS + n.tick_offset, n.note, n.velocity),
    )


def _maybe_nudge_velocity(note: int, velocity: int, enabled: bool) -> int:
    vel = velocity & 0x7F
    if enabled and (note & 0x7F) == vel:
        return vel + 1 if vel < 127 else vel - 1
    return vel


def encode_writer_style(
    event_type: int,
    notes: Sequence[Note],
    *,
    nudge_equal_note_velocity: bool,
    explicit_gate_u16: bool,
) -> bytes:
    ordered = _sorted_notes(notes)
    buf = bytearray((event_type, len(ordered)))
    for idx, note in enumerate(ordered):
        ticks = (note.step - 1) * STEP_TICKS + note.tick_offset

        if ticks == 0:
            buf.extend(ticks.to_bytes(2, "little", signed=False))
        else:
            buf.extend(ticks.to_bytes(4, "little", signed=False))
        buf.append(0x02 if ticks == 0 else 0x00)

        if note.gate_ticks > 0:
            if explicit_gate_u16:
                if note.gate_ticks > 0xFFFF:
                    raise ValueError("gate out of u16 range")
                buf.extend(note.gate_ticks.to_bytes(2, "little", signed=False))
                buf.extend(b"\x00\x00\x00")
            else:
                buf.extend(note.gate_ticks.to_bytes(4, "little", signed=False))
                buf.append(0x00)
        else:
            buf.extend(DEFAULT_GATE)

        note_byte = note.note & 0x7F
        vel_byte = _maybe_nudge_velocity(
            note_byte,
            note.velocity,
            enabled=nudge_equal_note_velocity,
        )
        buf.append(note_byte)
        buf.append(vel_byte)
        buf.extend(b"\x00\x00" if idx == len(ordered) - 1 else b"\x00\x00\x00")
    return bytes(buf)


def encode_compact_style(
    event_type: int,
    notes: Sequence[Note],
    *,
    use_escape: bool,
    use_chord_continuation: bool,
    nudge_equal_note_velocity: bool,
) -> bytes:
    ordered = _sorted_notes(notes)
    buf = bytearray((event_type, len(ordered)))
    prev_tick = 0

    for idx, note in enumerate(ordered):
        tick = (note.step - 1) * STEP_TICKS + note.tick_offset
        if tick > 0xFFFF:
            raise ValueError("tick out of compact u16 range")

        if idx == 0:
            buf.extend(tick.to_bytes(2, "little", signed=False))
            flag = 0x02 if tick == 0 else 0x00
            buf.append(flag)
            if flag == 0x00:
                buf.extend(b"\x00\x00")
        else:
            buf.extend(b"\x00\x00")
            if use_chord_continuation and tick == prev_tick:
                buf.append(0x04)
            elif use_escape and tick != 0 and (tick & 0xFF) == 0:
                buf.append(0x01)
                buf.append((tick >> 8) & 0xFF)
                buf.append(0x00)
                buf.extend(b"\x00\x00")
            else:
                buf.append(0x00)
                buf.extend(tick.to_bytes(2, "little", signed=False))
                flag = 0x02 if tick == 0 else 0x00
                buf.append(flag)
                if flag == 0x00:
                    buf.extend(b"\x00\x00")

        if note.gate_ticks > 0:
            if note.gate_ticks > 0xFFFF:
                raise ValueError("gate out of compact u16 range")
            buf.extend(note.gate_ticks.to_bytes(2, "little", signed=False))
            buf.extend(b"\x00\x00\x00")
        else:
            buf.extend(DEFAULT_GATE)

        note_byte = note.note & 0x7F
        vel_byte = _maybe_nudge_velocity(
            note_byte,
            note.velocity,
            enabled=nudge_equal_note_velocity,
        )
        buf.append(note_byte)
        buf.append(vel_byte)
        prev_tick = tick

    buf.extend(b"\x00\x00")
    return bytes(buf)


@dataclass(frozen=True)
class ModelResult:
    name: str
    cases: int
    exact: int
    mean_similarity: float
    median_similarity: float
    encode_failures: int
    wins: int


def _byte_similarity(a: bytes, b: bytes) -> float:
    max_len = max(len(a), len(b))
    if max_len == 0:
        return 1.0
    shared = sum(1 for x, y in zip(a, b) if x == y)
    return shared / max_len


def _tick_for_note(note: Note) -> int:
    return (note.step - 1) * STEP_TICKS + note.tick_offset


@dataclass(frozen=True)
class DispatchFeatures:
    path: Path
    track: int
    event_type: int
    note_count: int
    first_tick: int
    max_tick: int
    has_nonzero_tick: bool
    has_tick_mod256_zero: bool
    has_chord: bool
    has_explicit_gate: bool


def _dispatch_features(case: EventCase) -> DispatchFeatures:
    ticks = [_tick_for_note(n) for n in case.notes]
    unique_tick_count = len(set(ticks))
    return DispatchFeatures(
        path=case.path,
        track=case.track,
        event_type=case.event_type,
        note_count=len(case.notes),
        first_tick=ticks[0] if ticks else 0,
        max_tick=max(ticks) if ticks else 0,
        has_nonzero_tick=any(t > 0 for t in ticks),
        has_tick_mod256_zero=any(t > 0 and (t & 0xFF) == 0 for t in ticks),
        has_chord=unique_tick_count < len(ticks),
        has_explicit_gate=any(n.gate_ticks > 0 for n in case.notes),
    )


def run_event_dispatch(paths: Sequence[Path], *, show_examples: int) -> int:
    """Evaluate the two primary serializer families and infer dispatch clues."""
    cases, parse_failures = extract_event_cases(paths)
    if not cases:
        print("[event-dispatch] No parseable event cases found.")
        return 1

    writer = lambda et, ns: build_event(list(_sorted_notes(ns)), event_type=et)
    compact = lambda et, ns: encode_compact_style(
        et,
        ns,
        use_escape=True,
        use_chord_continuation=True,
        nudge_equal_note_velocity=False,
    )

    bucket_cases: dict[str, list[tuple[EventCase, DispatchFeatures]]] = {
        "both": [],
        "compact_only": [],
        "writer_only": [],
        "neither": [],
    }

    for case in cases:
        feat = _dispatch_features(case)
        try:
            raw_writer = writer(case.event_type, case.notes)
            writer_exact = raw_writer == case.raw
        except Exception:
            writer_exact = False
        try:
            raw_compact = compact(case.event_type, case.notes)
            compact_exact = raw_compact == case.raw
        except Exception:
            compact_exact = False

        if compact_exact and writer_exact:
            bucket = "both"
        elif compact_exact:
            bucket = "compact_only"
        elif writer_exact:
            bucket = "writer_only"
        else:
            bucket = "neither"
        bucket_cases[bucket].append((case, feat))

    total = len(cases)
    both = len(bucket_cases["both"])
    compact_only = len(bucket_cases["compact_only"])
    writer_only = len(bucket_cases["writer_only"])
    neither = len(bucket_cases["neither"])

    print("[event-dispatch] Two-serializer dispatch test")
    print(f"Corpus files considered: {len(paths)}")
    print(f"Event cases parsed: {total}")
    print(f"Event parse failures (skipped): {parse_failures}")
    print("")
    print("Exact-match partition:")
    print(f"  both exact:        {both:4d}  ({both/total:.1%})")
    print(f"  compact only:      {compact_only:4d}  ({compact_only/total:.1%})")
    print(f"  writer only:       {writer_only:4d}  ({writer_only/total:.1%})")
    print(f"  neither exact:     {neither:4d}  ({neither/total:.1%})")

    def summarize_bucket(label: str) -> None:
        entries = bucket_cases[label]
        if not entries:
            print(f"\n{label}: no cases")
            return
        ev_counter = Counter((f.event_type, f.track, f.note_count) for _, f in entries)
        print(f"\n{label}: top (event_type, track, note_count) clusters")
        for (etype, track, ncount), count in ev_counter.most_common(12):
            print(
                f"  {count:3d}  et=0x{etype:02X}  T{track}  notes={ncount}"
            )

    summarize_bucket("compact_only")
    summarize_bucket("writer_only")
    summarize_bucket("neither")

    decisive = (
        [("compact", feat) for _, feat in bucket_cases["compact_only"]]
        + [("writer", feat) for _, feat in bucket_cases["writer_only"]]
    )
    print("")
    print(f"Decidable cases (exactly one model wins): {len(decisive)}")

    if decisive:
        predicates: list[tuple[str, Callable[[DispatchFeatures], bool]]] = [
            ("always_compact", lambda f: True),
            ("always_writer", lambda f: False),
            ("has_nonzero_tick", lambda f: f.has_nonzero_tick),
            ("has_chord", lambda f: f.has_chord),
            ("note_count_gt_1", lambda f: f.note_count > 1),
            ("has_tick_mod256_zero", lambda f: f.has_tick_mod256_zero),
            ("event_type_25", lambda f: f.event_type == 0x25),
            ("track_1", lambda f: f.track == 1),
            ("first_tick_nonzero", lambda f: f.first_tick > 0),
            ("has_explicit_gate", lambda f: f.has_explicit_gate),
            (
                "chord_or_tickmod256zero",
                lambda f: f.has_chord or f.has_tick_mod256_zero,
            ),
            (
                "multi_note_and_nonzero_tick",
                lambda f: f.note_count > 1 and f.has_nonzero_tick,
            ),
        ]

        pred_rows: list[tuple[float, int, str, int, int]] = []
        for name, pred in predicates:
            correct = 0
            compact_pred_count = 0
            writer_pred_count = 0
            for truth, feat in decisive:
                pred_compact = pred(feat)
                if pred_compact:
                    compact_pred_count += 1
                else:
                    writer_pred_count += 1
                pred_label = "compact" if pred_compact else "writer"
                if pred_label == truth:
                    correct += 1
            accuracy = correct / len(decisive)
            pred_rows.append(
                (accuracy, correct, name, compact_pred_count, writer_pred_count)
            )

        pred_rows.sort(reverse=True)
        print("Best simple dispatch predicates on decidable cases:")
        for acc, correct, name, ccount, wcount in pred_rows[:8]:
            print(
                f"  {name:28s}  acc={acc:.1%}  "
                f"({correct}/{len(decisive)})  predict_compact={ccount} predict_writer={wcount}"
            )

    examples: list[str] = []
    for label in ("compact_only", "writer_only", "neither"):
        for case, feat in bucket_cases[label]:
            if len(examples) >= show_examples:
                break
            examples.append(
                f"{label}: {case.path.name}:T{case.track} et=0x{case.event_type:02X} "
                f"notes={feat.note_count} first_tick={feat.first_tick} max_tick={feat.max_tick} "
                f"chord={'y' if feat.has_chord else 'n'} tick_mod256_zero={'y' if feat.has_tick_mod256_zero else 'n'} "
                f"explicit_gate={'y' if feat.has_explicit_gate else 'n'}"
            )
        if len(examples) >= show_examples:
            break
    if examples:
        print("\nExample non-trivial assignments:")
        for line in examples:
            print(f"  - {line}")

    return 0


def run_event_models(paths: Sequence[Path], *, show_examples: int) -> int:
    cases, parse_failures = extract_event_cases(paths)
    if not cases:
        print("[event-models] No parseable event cases found.")
        return 1

    models: list[tuple[str, Callable[[int, Sequence[Note]], bytes]]] = [
        (
            "writer_u32_gate32_nudge",
            lambda et, ns: build_event(list(_sorted_notes(ns)), event_type=et),
        ),
        (
            "writer_u32_gate32_rawvel",
            lambda et, ns: encode_writer_style(
                et,
                ns,
                nudge_equal_note_velocity=False,
                explicit_gate_u16=False,
            ),
        ),
        (
            "compact_escape_chord_u16gate",
            lambda et, ns: encode_compact_style(
                et,
                ns,
                use_escape=True,
                use_chord_continuation=True,
                nudge_equal_note_velocity=False,
            ),
        ),
        (
            "compact_escape_chord_u16gate_nudge",
            lambda et, ns: encode_compact_style(
                et,
                ns,
                use_escape=True,
                use_chord_continuation=True,
                nudge_equal_note_velocity=True,
            ),
        ),
        (
            "compact_no_escape_chord_u16gate",
            lambda et, ns: encode_compact_style(
                et,
                ns,
                use_escape=False,
                use_chord_continuation=True,
                nudge_equal_note_velocity=False,
            ),
        ),
        (
            "compact_escape_no_chord_u16gate",
            lambda et, ns: encode_compact_style(
                et,
                ns,
                use_escape=True,
                use_chord_continuation=False,
                nudge_equal_note_velocity=False,
            ),
        ),
    ]

    per_model_sim: dict[str, list[float]] = {name: [] for name, _ in models}
    per_model_exact: dict[str, int] = {name: 0 for name, _ in models}
    per_model_fail: dict[str, int] = {name: 0 for name, _ in models}
    per_model_wins: dict[str, int] = {name: 0 for name, _ in models}

    examples: list[str] = []
    for case in cases:
        scored: list[tuple[str, float, bool]] = []
        for name, fn in models:
            try:
                cand = fn(case.event_type, case.notes)
            except Exception:
                per_model_fail[name] += 1
                continue
            sim = _byte_similarity(case.raw, cand)
            exact = case.raw == cand
            per_model_sim[name].append(sim)
            if exact:
                per_model_exact[name] += 1
            scored.append((name, sim, exact))

        if not scored:
            continue

        best_name, best_sim, best_exact = max(
            scored,
            key=lambda item: (item[2], item[1], -len(item[0])),
        )
        per_model_wins[best_name] += 1

        if len(examples) < show_examples:
            note_steps = [n.step for n in case.notes]
            examples.append(
                f"{case.path.name}:T{case.track} et=0x{case.event_type:02X} "
                f"notes={len(case.notes)} steps={note_steps[:6]}{'...' if len(note_steps) > 6 else ''} "
                f"best={best_name} sim={best_sim:.3f} exact={'yes' if best_exact else 'no'}"
            )

    rows: list[ModelResult] = []
    for name, _ in models:
        sims = per_model_sim[name]
        rows.append(
            ModelResult(
                name=name,
                cases=len(sims),
                exact=per_model_exact[name],
                mean_similarity=(statistics.fmean(sims) if sims else 0.0),
                median_similarity=(statistics.median(sims) if sims else 0.0),
                encode_failures=per_model_fail[name],
                wins=per_model_wins[name],
            )
        )

    rows.sort(
        key=lambda row: (
            row.exact,
            row.mean_similarity,
            row.wins,
            -row.encode_failures,
        ),
        reverse=True,
    )

    print("[event-models] Event serializer hypothesis scoring")
    print(f"Corpus files considered: {len(paths)}")
    print(f"Event cases parsed: {len(cases)}")
    print(f"Event parse failures (skipped): {parse_failures}")
    print("")
    print(
        "model".ljust(38)
        + "cases".rjust(8)
        + "exact".rjust(8)
        + "mean".rjust(10)
        + "median".rjust(10)
        + "wins".rjust(8)
        + "enc_fail".rjust(10)
    )
    print("-" * 92)
    for row in rows:
        print(
            row.name.ljust(38)
            + str(row.cases).rjust(8)
            + str(row.exact).rjust(8)
            + f"{row.mean_similarity:.4f}".rjust(10)
            + f"{row.median_similarity:.4f}".rjust(10)
            + str(row.wins).rjust(8)
            + str(row.encode_failures).rjust(10)
        )

    if examples:
        print("")
        print("Sample best-model assignments:")
        for line in examples:
            print(f"  - {line}")

    best = rows[0]
    print("")
    print(
        f"Best by exact-match count: {best.name} "
        f"(exact={best.exact}/{best.cases}, mean={best.mean_similarity:.4f})"
    )
    return 0


def _add_common_glob_args(parser: argparse.ArgumentParser) -> None:
    parser.add_argument(
        "--glob",
        action="append",
        default=list(DEFAULT_GLOBS),
        help="Glob pattern for input .xy files (repeatable).",
    )


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="cmd", required=True)

    h4 = sub.add_parser("h4-signature", help="Check track signature constant hypothesis.")
    _add_common_glob_args(h4)

    h10 = sub.add_parser("h10-padding", help="Check type-0x05 padding sentinel hypothesis.")
    _add_common_glob_args(h10)

    h2 = sub.add_parser("h2-preamble", help="Check preamble byte[0] slot-stability hypothesis.")
    _add_common_glob_args(h2)

    h2a = sub.add_parser(
        "h2-automaton",
        help="Test whether preamble byte[0] is generated by a small deterministic state machine.",
    )
    _add_common_glob_args(h2a)

    h7 = sub.add_parser("h7-pretrack", help="Check pre-track insertion/growth hypothesis.")
    _add_common_glob_args(h7)

    h7c = sub.add_parser(
        "h7-compositional",
        help="Test whether pre-track edits are compositional (few repeated structural ops).",
    )
    _add_common_glob_args(h7c)

    h8 = sub.add_parser(
        "h8-t5-exemption",
        help="Test T5 preamble exemption hypothesis using logical-entry mapping.",
    )
    _add_common_glob_args(h8)

    dispatch = sub.add_parser(
        "event-dispatch",
        help=(
            "Test two-serializer dispatch hypothesis "
            "(writer-style vs compact continuation serializer)."
        ),
    )
    _add_common_glob_args(dispatch)
    dispatch.add_argument(
        "--examples",
        type=int,
        default=10,
        help="Number of example cases to print.",
    )

    event = sub.add_parser(
        "event-models",
        help="Score multiple event serializer hypotheses against corpus bytes.",
    )
    _add_common_glob_args(event)
    event.add_argument(
        "--examples",
        type=int,
        default=10,
        help="Number of sample best-model assignments to print.",
    )

    args = parser.parse_args(argv)
    paths = collect_paths(args.glob)
    if not paths:
        print("No files matched the provided glob patterns.")
        return 1

    if args.cmd == "h4-signature":
        return run_h4_signature(paths)
    if args.cmd == "h10-padding":
        return run_h10_padding(paths)
    if args.cmd == "h2-preamble":
        return run_h2_preamble(paths)
    if args.cmd == "h2-automaton":
        return run_h2_automaton(paths)
    if args.cmd == "h7-pretrack":
        return run_h7_pretrack(paths)
    if args.cmd == "h7-compositional":
        return run_h7_compositional(paths)
    if args.cmd == "h8-t5-exemption":
        return run_h8_t5_exemption(paths)
    if args.cmd == "event-dispatch":
        return run_event_dispatch(paths, show_examples=max(0, args.examples))
    if args.cmd == "event-models":
        return run_event_models(paths, show_examples=max(0, args.examples))

    raise AssertionError(f"unhandled command {args.cmd}")


if __name__ == "__main__":
    raise SystemExit(main())
