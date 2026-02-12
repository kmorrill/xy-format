#!/usr/bin/env python3
"""Inspect pre-track descriptor variants in OP-XY `.xy` files.

Usage:
  python tools/analyze_pretrack_descriptors.py \
      --baseline src/one-off-changes-from-default/unnamed\\ 1.xy \
      src/one-off-changes-from-default/j0*.xy
"""

from __future__ import annotations

import argparse
import difflib
from pathlib import Path
import sys
from typing import Iterable

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYProject


def _find_ff_table_start(pre_track: bytes) -> int | None:
    """Return first offset where eight consecutive `ff 00 00` entries begin."""
    for i in range(0x56, len(pre_track) - 24):
        if all(pre_track[i + k * 3 : i + k * 3 + 3] == b"\xff\x00\x00" for k in range(8)):
            return i
    return None


def _format_hex(data: bytes) -> str:
    return data.hex(" ") if data else "(none)"


def _iter_non_equal_ops(a: bytes, b: bytes) -> Iterable[tuple[str, int, int, int, int]]:
    sm = difflib.SequenceMatcher(a=a, b=b, autojunk=False)
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag != "equal":
            yield tag, i1, i2, j1, j2


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("files", nargs="+", help="Input .xy files (supports globs).")
    parser.add_argument(
        "--baseline",
        default="src/one-off-changes-from-default/unnamed 1.xy",
        help="Baseline file used for insertion diffing (default: unnamed 1).",
    )
    args = parser.parse_args()

    baseline_path = Path(args.baseline)
    baseline = XYProject.from_bytes(baseline_path.read_bytes()).pre_track

    expanded: list[Path] = []
    for pat in args.files:
        matches = sorted(Path(".").glob(pat))
        if matches:
            expanded.extend(matches)
        else:
            expanded.append(Path(pat))

    for path in expanded:
        raw = path.read_bytes()
        proj = XYProject.from_bytes(raw)
        pre = proj.pre_track
        table_start = _find_ff_table_start(pre)
        var = pre[0x56:table_start] if table_start is not None else b""

        print(f"\n{path}")
        print(f"  file_size={len(raw)} pre_track={len(pre)}")
        if table_start is None:
            print("  ff_table_start=(not found)")
        else:
            print(f"  ff_table_start=0x{table_start:02x} var_0x56={_format_hex(var)}")

        for tag, i1, i2, j1, j2 in _iter_non_equal_ops(baseline, pre):
            a = baseline[i1:i2]
            b = pre[j1:j2]
            if tag == "insert":
                print(
                    f"  insert base@0x{i1:02x} -> new[0x{j1:02x}:0x{j2:02x}] "
                    f"len={j2 - j1}: {_format_hex(b)}"
                )
            elif tag == "replace":
                print(
                    f"  replace base[0x{i1:02x}:0x{i2:02x}] {_format_hex(a)} "
                    f"with new[0x{j1:02x}:0x{j2:02x}] {_format_hex(b)}"
                )
            elif tag == "delete":
                print(f"  delete base[0x{i1:02x}:0x{i2:02x}] {_format_hex(a)}")

        multi_blocks = []
        for idx, track in enumerate(proj.tracks, start=1):
            preamble = track.preamble
            if preamble[1] > 1:
                multi_blocks.append(
                    f"B{idx:02d}: pre={preamble.hex(' ')} type=0x{track.type_byte:02x} len={len(track.body)}"
                )
        if multi_blocks:
            print("  blocks_with_pattern_count_gt1:")
            for line in multi_blocks:
                print(f"    {line}")


if __name__ == "__main__":
    main()
