#!/usr/bin/env python3
"""Generate multi-pattern .xy files for device testing.

Usage:
    python tools/write_multi_pattern.py output/multi_test.xy

Generates a file matching the unnamed 105 layout:
  T1 pattern 2: C4 at step 1 (0x25 drum event)
  T3 pattern 2: E3 at step 2 (0x21 Prism event)
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject
from xy.note_events import Note
from xy.project_builder import build_multi_pattern_project

TEMPLATE = Path("src/one-off-changes-from-default/unnamed 1.xy")


def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <output.xy>")
        sys.exit(1)

    output_path = Path(sys.argv[1])
    template = TEMPLATE.read_bytes()
    project = XYProject.from_bytes(template)

    # Reproduce unnamed 105: T1 and T3 each have 2 patterns,
    # notes only in pattern 2.
    result = build_multi_pattern_project(project, {
        1: [None, [Note(step=1, note=60, velocity=100)]],   # T1 pat2: C4
        3: [None, [Note(step=2, note=52, velocity=100)]],   # T3 pat2: E3
    })

    raw = result.to_bytes()
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_bytes(raw)

    # Verify round-trip
    reparsed = XYProject.from_bytes(raw)
    assert reparsed.to_bytes() == raw, "round-trip failed"
    assert len(reparsed.tracks) == 16

    print(f"Wrote {len(raw)} bytes to {output_path}")
    print(f"  T1: leader (blank) + clone (C4 step 1)")
    print(f"  T3: leader (blank) + clone (E3 step 2)")
    print(f"  Block layout: {len(reparsed.tracks)} blocks, overflow in block 15")

    # Show block summary
    for i, t in enumerate(reparsed.tracks):
        marker = ""
        if t.preamble[0] == 0x00:
            marker = " [clone]"
        elif t.type_byte == 0x07:
            marker = " [activated]"
        print(f"    Block[{i:2d}] preamble={t.preamble.hex()} "
              f"type=0x{t.type_byte:02X} body={len(t.body):5d}B{marker}")


if __name__ == "__main__":
    main()
