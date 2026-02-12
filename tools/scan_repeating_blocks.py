#!/usr/bin/env python3
"""Scan .xy files for repeating fixed-size blocks."""

from __future__ import annotations

import argparse
import glob
import hashlib
from dataclasses import dataclass
from pathlib import Path
import sys
from typing import Iterable, List

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.structs import find_track_blocks  # noqa: E402


@dataclass(frozen=True)
class RepeatBlock:
    size: int
    count: int
    offsets: List[int]
    head: str


@dataclass(frozen=True)
class TrackAlignedBlock:
    size: int
    delta: int
    count: int
    head: str
    digest: str


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


def is_uniform(block: bytes) -> bool:
    return len(set(block)) == 1


def scan_blocks(
    data: bytes,
    track_offsets: List[int],
    *,
    min_size: int,
    max_size: int,
    min_count: int,
    skip_uniform: bool,
) -> tuple[List[RepeatBlock], List[TrackAlignedBlock]]:
    repeating: List[RepeatBlock] = []
    aligned: List[TrackAlignedBlock] = []
    data_len = len(data)
    track_count = len(track_offsets)
    sorted_tracks = sorted(track_offsets)

    for size in range(min_size, max_size + 1):
        blocks: dict[bytes, List[int]] = {}
        limit = data_len - size + 1
        for offset in range(limit):
            block = data[offset : offset + size]
            if skip_uniform and is_uniform(block):
                continue
            blocks.setdefault(block, []).append(offset)

        for block, offsets in blocks.items():
            count = len(offsets)
            if count < min_count:
                continue
            head = block[: min(8, size)].hex()
            repeating.append(
                RepeatBlock(size=size, count=count, offsets=offsets, head=head)
            )

            if track_count and count == track_count:
                sorted_offsets = sorted(offsets)
                deltas = {
                    off - track
                    for off, track in zip(sorted_offsets, sorted_tracks)
                }
                if len(deltas) == 1:
                    delta = deltas.pop()
                    digest = hashlib.blake2b(block, digest_size=8).hexdigest()
                    aligned.append(
                        TrackAlignedBlock(
                            size=size,
                            delta=delta,
                            count=count,
                            head=head,
                            digest=digest,
                        )
                    )

    return repeating, aligned


def format_offsets(offsets: List[int], limit: int = 4) -> str:
    shown = offsets[:limit]
    suffix = "" if len(offsets) <= limit else "..."
    return ", ".join(f"0x{o:04X}" for o in shown) + suffix


def print_file_report(
    path: Path,
    repeating: List[RepeatBlock],
    aligned: List[TrackAlignedBlock],
    *,
    min_count: int,
    max_rows: int,
) -> None:
    print(f"{path}")
    if not repeating and not aligned:
        print("  no repeating blocks found")
        return

    if aligned:
        aligned_sorted = sorted(aligned, key=lambda item: (item.size, item.delta))
        print("  track-aligned blocks:")
        for item in aligned_sorted[:max_rows]:
            print(
                "    "
                f"size={item.size:3d}  "
                f"delta=0x{item.delta:04X}  "
                f"count={item.count:2d}  "
                f"head={item.head}  "
                f"hash={item.digest}"
            )
        if len(aligned_sorted) > max_rows:
            print(f"    ... {len(aligned_sorted) - max_rows} more")

    repeating_sorted = sorted(
        repeating, key=lambda item: (-item.count, item.size, item.head)
    )
    if repeating_sorted:
        print(f"  repeating blocks (count >= {min_count}):")
        for item in repeating_sorted[:max_rows]:
            print(
                "    "
                f"size={item.size:3d}  "
                f"count={item.count:3d}  "
                f"head={item.head}  "
                f"offsets={format_offsets(item.offsets)}"
            )
        if len(repeating_sorted) > max_rows:
            print(f"    ... {len(repeating_sorted) - max_rows} more")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Scan .xy files for repeating fixed-size blocks."
    )
    parser.add_argument(
        "paths",
        nargs="+",
        help="File paths or glob patterns (quotes recommended for wildcards).",
    )
    parser.add_argument("--min-size", type=int, default=4)
    parser.add_argument("--max-size", type=int, default=256)
    parser.add_argument("--min-count", type=int, default=8)
    parser.add_argument("--max-rows", type=int, default=12)
    parser.add_argument(
        "--no-skip-uniform",
        action="store_true",
        help="Include blocks with identical bytes (e.g., all 0x00).",
    )
    parser.add_argument(
        "--aggregate",
        action="store_true",
        help="Aggregate track-aligned blocks across files.",
    )
    args = parser.parse_args(argv)

    targets = collect_paths(args.paths)
    if not targets:
        parser.error("No files matched the provided paths/patterns.")

    skip_uniform = not args.no_skip_uniform
    aggregate: dict[tuple[int, int, str, str], int] = {}
    for path in targets:
        data = path.read_bytes()
        track_offsets = find_track_blocks(data)
        repeating, aligned = scan_blocks(
            data,
            track_offsets,
            min_size=args.min_size,
            max_size=args.max_size,
            min_count=args.min_count,
            skip_uniform=skip_uniform,
        )
        if args.aggregate:
            for item in aligned:
                key = (item.size, item.delta, item.head, item.digest)
                aggregate[key] = aggregate.get(key, 0) + 1
            continue

        print_file_report(
            path,
            repeating,
            aligned,
            min_count=args.min_count,
            max_rows=args.max_rows,
        )

    if args.aggregate:
        print("Aggregate track-aligned blocks:")
        rows = [
            (count, size, delta, head, digest)
            for (size, delta, head, digest), count in aggregate.items()
        ]
        rows.sort(key=lambda item: (-item[0], item[1], item[2]))
        for count, size, delta, head, digest in rows[: args.max_rows]:
            print(
                f"  files={count:3d}  size={size:3d}  "
                f"delta=0x{delta:04X}  head={head}  hash={digest}"
            )
        if len(rows) > args.max_rows:
            print(f"  ... {len(rows) - args.max_rows} more")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
