#!/usr/bin/env python3
"""Binary diff tool for OP-XY project files.

Compares two .xy files and reports differences with context awareness
(header, track blocks, etc.).
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import List, Tuple

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.structs import find_track_blocks, find_track_handles

def fmt_hex(data: bytes) -> str:
    return " ".join(f"{b:02X}" for b in data)

def get_context(offset: int, track_blocks: List[int]) -> str:
    if offset < 0x80:
        return "Header"
    
    for i, start in enumerate(track_blocks):
        # Estimate end of block as start of next, or end of file
        end = track_blocks[i+1] if i + 1 < len(track_blocks) else float('inf')
        if start <= offset < end:
            rel = offset - start
            return f"Track {i+1} (offset +0x{rel:04X})"
            
    return "Unknown"

def main() -> int:
    parser = argparse.ArgumentParser(description="Diff two OP-XY project files.")
    parser.add_argument("file1", type=Path, help="Baseline file")
    parser.add_argument("file2", type=Path, help="Modified file")
    args = parser.parse_args()

    if not args.file1.exists():
        print(f"Error: {args.file1} not found", file=sys.stderr)
        return 1
    if not args.file2.exists():
        print(f"Error: {args.file2} not found", file=sys.stderr)
        return 1

    data1 = args.file1.read_bytes()
    data2 = args.file2.read_bytes()

    # Map track blocks for context from the baseline file
    # (Assuming structure doesn't change drastically for context mapping)
    track_blocks = find_track_blocks(data1)

    # Simple byte-by-byte comparison
    len1 = len(data1)
    len2 = len(data2)
    max_len = max(len1, len2)
    
    if len1 != len2:
        print(f"Size mismatch: {len1} bytes vs {len2} bytes")

    diffs = []
    i = 0
    while i < max_len:
        b1 = data1[i] if i < len1 else None
        b2 = data2[i] if i < len2 else None

        if b1 != b2:
            start = i
            # Group consecutive diffs
            chunk1 = []
            chunk2 = []
            while i < max_len:
                c1 = data1[i] if i < len1 else None
                c2 = data2[i] if i < len2 else None
                if c1 == c2:
                    # Look ahead a bit to see if it's just a small gap of matching bytes?
                    # For now, strict consecutive grouping.
                    break
                chunk1.append(c1)
                chunk2.append(c2)
                i += 1
            
            diffs.append((start, chunk1, chunk2))
        else:
            i += 1

    if not diffs:
        print("Files are identical.")
        return 0

    print(f"Found {len(diffs)} difference chunks:")
    for start, c1, c2 in diffs:
        context = get_context(start, track_blocks)
        
        # Format bytes
        # Handle None (end of file)
        hex1 = " ".join(f"{b:02X}" if b is not None else "--" for b in c1)
        hex2 = " ".join(f"{b:02X}" if b is not None else "--" for b in c2)
        
        print(f"\nOffset 0x{start:04X} | {context}")
        print(f"  < {hex1}")
        print(f"  > {hex2}")

    return 0

if __name__ == "__main__":
    raise SystemExit(main())
