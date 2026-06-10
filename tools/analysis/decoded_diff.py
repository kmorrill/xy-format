#!/usr/bin/env python3
"""Diff two `.xy` files in decoded (RAM-image) space.

This is the post-RLE workhorse: in decoded space, UI state changes are
pure substitutions at fixed offsets and vector growth is exact struct
sizes (12 B/note, 17,875 B/pattern), so diffs read like annotated struct
fields instead of shifting byte soup.

Usage:
    python tools/analysis/decoded_diff.py A.xy B.xy [--gap N] [--context N]
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from xy.rle import decode_project  # noqa: E402


def diff_regions(a: bytes, b: bytes, gap: int = 8) -> list[tuple[int, int]]:
    """Contiguous differing regions (merging gaps < `gap` equal bytes)."""
    n = min(len(a), len(b))
    regs: list[tuple[int, int]] = []
    i = 0
    while i < n:
        if a[i] != b[i]:
            j = i
            last = i
            while j < n:
                if a[j] != b[j]:
                    last = j
                elif j - last >= gap:
                    break
                j += 1
            regs.append((i, last + 1))
            i = j
        else:
            i += 1
    return regs


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("file_a")
    ap.add_argument("file_b")
    ap.add_argument("--gap", type=int, default=8, help="merge regions separated by < N equal bytes")
    ap.add_argument("--context", type=int, default=4, help="context bytes shown around each region")
    ap.add_argument("--max-regions", type=int, default=40)
    args = ap.parse_args()

    _, a = decode_project(open(args.file_a, "rb").read())
    _, b = decode_project(open(args.file_b, "rb").read())

    print(f"A: {args.file_a}  decoded {len(a)} bytes")
    print(f"B: {args.file_b}  decoded {len(b)} bytes   Δlen = {len(b) - len(a):+d}")

    regs = diff_regions(a, b, args.gap)
    print(f"diff regions: {len(regs)}")
    c = args.context
    for i, (s, e) in enumerate(regs[: args.max_regions]):
        print(f"\n@0x{s:06x}+{e - s}")
        print(f"  A: {a[max(0, s - c):s].hex(' ')} | {a[s:e].hex(' ')} | {a[e:e + c].hex(' ')}")
        print(f"  B: {b[max(0, s - c):s].hex(' ')} | {b[s:e].hex(' ')} | {b[e:e + c].hex(' ')}")
    if len(regs) > args.max_regions:
        print(f"\n... {len(regs) - args.max_regions} more regions")
    if len(a) != len(b):
        print(f"\ntail beyond common length differs by {abs(len(a) - len(b))} bytes")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
