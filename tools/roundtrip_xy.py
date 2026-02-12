#!/usr/bin/env python3
"""Round-trip OP-XY projects via the container parser."""

from __future__ import annotations

import argparse
import glob
from pathlib import Path
import sys
from typing import Iterable, List, Tuple

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYContainer  # noqa: E402


def collect_paths(patterns: Iterable[str]) -> List[Path]:
    paths: List[Path] = []
    for pattern in patterns:
        matches = sorted(Path(p) for p in glob.glob(pattern, recursive=True))
        if matches:
            paths.extend(matches)
        else:
            candidate = Path(pattern)
            if candidate.exists():
                paths.append(candidate)
    seen: set[Path] = set()
    unique_paths: List[Path] = []
    for path in paths:
        resolved = path.resolve()
        if resolved not in seen:
            seen.add(resolved)
            unique_paths.append(path)
    return unique_paths


def first_diff(a: bytes, b: bytes) -> Tuple[int | None, int | None, int | None]:
    limit = min(len(a), len(b))
    for idx in range(limit):
        if a[idx] != b[idx]:
            return idx, a[idx], b[idx]
    if len(a) != len(b):
        return limit, None, None
    return None, None, None


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Decode + re-encode .xy files and report mismatches."
    )
    parser.add_argument(
        "paths",
        nargs="+",
        help="File paths or glob patterns (quotes recommended for wildcards).",
    )
    args = parser.parse_args(argv)

    targets = collect_paths(args.paths)
    if not targets:
        parser.error("No files matched the provided paths/patterns.")

    failures = 0
    for path in targets:
        data = path.read_bytes()
        try:
            container = XYContainer.from_bytes(data)
        except ValueError as exc:
            failures += 1
            print(f"ERR  {path}: {exc}")
            continue

        rebuilt = container.to_bytes()
        offset, left, right = first_diff(data, rebuilt)
        if offset is None:
            print(f"OK   {path}")
            continue

        failures += 1
        if left is None and right is None:
            print(
                f"FAIL {path}: size mismatch (orig={len(data)} new={len(rebuilt)})"
            )
        else:
            print(
                f"FAIL {path}: diff at 0x{offset:04X} (orig=0x{left:02X} new=0x{right:02X})"
            )

    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
