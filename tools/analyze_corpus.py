#!/usr/bin/env python3
"""Automated corpus analysis script.

Iterates through the change log, diffs each file against the baseline,
and generates a summary report.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path
from typing import List, Tuple

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.structs import find_track_blocks

CHANGE_LOG_PATH = REPO_ROOT / "src" / "one-off-changes-from-default" / "op-xy_project_change_log.md"
CORPUS_DIR = REPO_ROOT / "src" / "one-off-changes-from-default"
BASELINE_FILE = CORPUS_DIR / "unnamed 1.xy"

def load_change_log() -> List[Tuple[str, str]]:
    try:
        text = CHANGE_LOG_PATH.read_text()
    except FileNotFoundError:
        print(f"Error: {CHANGE_LOG_PATH} not found", file=sys.stderr)
        return []
    
    # Regex to find lines like "- **unnamed_4** — Changed tempo..."
    pattern = re.compile(r"-\s+\*\*(.+?)\*\*\s+—\s+(.+)")
    entries = []
    for line in text.splitlines():
        match = pattern.search(line)
        if match:
            filename = match.group(1).replace("_", " ") + ".xy"
            description = match.group(2)
            entries.append((filename, description))
    return entries

def get_context(offset: int, track_blocks: List[int]) -> str:
    if offset < 0x80:
        return "Header"
    
    for i, start in enumerate(track_blocks):
        end = track_blocks[i+1] if i + 1 < len(track_blocks) else float('inf')
        if start <= offset < end:
            rel = offset - start
            return f"Track {i+1} (offset +0x{rel:04X})"
            
    return "Unknown"

def diff_files(file1: Path, file2: Path) -> List[Tuple[int, List[int], List[int]]]:
    if not file1.exists() or not file2.exists():
        return []
        
    data1 = file1.read_bytes()
    data2 = file2.read_bytes()
    
    len1 = len(data1)
    len2 = len(data2)
    max_len = max(len1, len2)
    
    diffs = []
    i = 0
    while i < max_len:
        b1 = data1[i] if i < len1 else None
        b2 = data2[i] if i < len2 else None

        if b1 != b2:
            start = i
            chunk1 = []
            chunk2 = []
            while i < max_len:
                c1 = data1[i] if i < len1 else None
                c2 = data2[i] if i < len2 else None
                if c1 == c2:
                    break
                chunk1.append(c1)
                chunk2.append(c2)
                i += 1
            diffs.append((start, chunk1, chunk2))
        else:
            i += 1
    return diffs

def main() -> int:
    entries = load_change_log()
    if not entries:
        print("No entries found in change log.")
        return 1
        
    if not BASELINE_FILE.exists():
        print(f"Baseline file {BASELINE_FILE} not found.")
        return 1
        
    baseline_data = BASELINE_FILE.read_bytes()
    track_blocks = find_track_blocks(baseline_data)
    
    print(f"# Corpus Analysis Report\n")
    print(f"Baseline: {BASELINE_FILE.name}\n")
    
    for filename, description in entries:
        if filename == "unnamed 1.xy":
            continue
            
        target_file = CORPUS_DIR / filename
        if not target_file.exists():
            print(f"## {filename} (MISSING)\n")
            continue
            
        print(f"## {filename}")
        print(f"**Description**: {description}\n")
        
        diffs = diff_files(BASELINE_FILE, target_file)
        if not diffs:
            print("No differences found.\n")
            continue
            
        print("```")
        for start, c1, c2 in diffs:
            context = get_context(start, track_blocks)
            hex1 = " ".join(f"{b:02X}" if b is not None else "--" for b in c1)
            hex2 = " ".join(f"{b:02X}" if b is not None else "--" for b in c2)
            
            # Truncate long hex strings for readability
            if len(hex1) > 60:
                hex1 = hex1[:57] + "..."
            if len(hex2) > 60:
                hex2 = hex2[:57] + "..."
                
            print(f"0x{start:04X} | {context}")
            print(f"  < {hex1}")
            print(f"  > {hex2}")
            print()
        print("```\n")
        
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
