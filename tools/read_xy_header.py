#!/usr/bin/env python3
"""Inspect the OP-XY project header for tempo / groove / metronome fields."""

from __future__ import annotations

import argparse
import glob
from pathlib import Path
from typing import Iterable, List


HEADER_REQUIRED_BYTES = 24  # we rely on offsets up to 0x17


def collect_paths(patterns: Iterable[str]) -> List[Path]:
    paths: List[Path] = []
    for pattern in patterns:
        matches = sorted(Path(p) for p in glob.glob(pattern, recursive=True))
        if matches:
            paths.extend(matches)
        else:
            # Treat literal path when glob finds nothing.
            candidate = Path(pattern)
            if candidate.exists():
                paths.append(candidate)
    # Deduplicate while preserving order.
    seen: set[Path] = set()
    unique_paths: List[Path] = []
    for path in paths:
        resolved = path.resolve()
        if resolved not in seen:
            seen.add(resolved)
            unique_paths.append(path)
    return unique_paths


def parse_header(data: bytes) -> dict[str, int | float]:
    if len(data) < HEADER_REQUIRED_BYTES:
        raise ValueError(
            f"File too short ({len(data)} bytes); need at least {HEADER_REQUIRED_BYTES}."
        )

    tempo_word = int.from_bytes(data[8:12], "little")
    tempo_tenths = tempo_word & 0xFFFF
    groove_flags = (tempo_word >> 16) & 0xFF
    groove_type = (tempo_word >> 24) & 0xFF

    groove_amount = data[0x0C]
    metronome_level = data[0x0D]

    field_0x0C = int.from_bytes(data[12:16], "little")
    field_0x10 = int.from_bytes(data[16:20], "little")
    field_0x14 = int.from_bytes(data[20:24], "little")

    return {
        "tempo_tenths": tempo_tenths,
        "tempo_bpm": tempo_tenths / 10.0,
        "groove_type": groove_type,
        "groove_flags": groove_flags,
        "groove_amount": groove_amount,
        "metronome_level": metronome_level,
        "field_0x0C": field_0x0C,
        "field_0x10": field_0x10,
        "field_0x14": field_0x14,
    }


def fmt_hex(value: int, width: int) -> str:
    return f"0x{value:0{width}X}"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Show tempo / groove / metronome fields for OP-XY project files."
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

    rows = []
    for path in targets:
        data = path.read_bytes()
        try:
            info = parse_header(data)
        except ValueError as err:
            rows.append(
                [
                    str(path),
                    "ERR",
                    str(err),
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ]
            )
            continue

        rows.append(
            [
                str(path),
                f"{info['tempo_bpm']:5.1f}",
                fmt_hex(info["tempo_tenths"], 4),
                fmt_hex(info["groove_type"], 2),
                fmt_hex(info["groove_flags"], 2),
                fmt_hex(info["groove_amount"], 2),
                fmt_hex(info["metronome_level"], 2),
                fmt_hex(info["field_0x0C"], 8),
                fmt_hex(info["field_0x10"], 8),
                fmt_hex(info["field_0x14"], 8),
            ]
        )

    header = [
        "File",
        "Tempo",
        "Raw",
        "GrooveType",
        "GrooveFlags",
        "GrooveAmt",
        "MetVol",
        "Field@0x0C",
        "Field@0x10",
        "Field@0x14",
    ]

    widths = [
        max(len(row[i]) for row in ([header] + rows))
        for i in range(len(header))
    ]

    def fmt_row(row: list[str]) -> str:
        return "  ".join(cell.ljust(widths[i]) for i, cell in enumerate(row))

    print(fmt_row(header))
    print("  ".join("-" * w for w in widths))
    for row in rows:
        print(fmt_row(row))

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
