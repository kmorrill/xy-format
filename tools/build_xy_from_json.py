#!/usr/bin/env python3
"""Compile an agent-editable JSON spec into a binary .xy project."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path
import sys

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYProject
from xy.json_build_spec import build_xy_bytes, load_build_spec


def _sha1(data: bytes) -> str:
    return hashlib.sha1(data).hexdigest()


def _first_mismatch(
    built: bytes, expected: bytes
) -> tuple[int, int | None, int | None] | None:
    limit = min(len(built), len(expected))
    for idx in range(limit):
        if built[idx] != expected[idx]:
            return (idx, built[idx], expected[idx])
    if len(built) != len(expected):
        built_byte = built[limit] if limit < len(built) else None
        expected_byte = expected[limit] if limit < len(expected) else None
        return (limit, built_byte, expected_byte)
    return None


def _build_arg_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Build a .xy file from a JSON spec",
    )
    parser.add_argument(
        "spec",
        type=Path,
        help="Path to JSON build spec",
    )
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=None,
        help="Output .xy path (overrides spec.output)",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Validate and compile without writing output",
    )
    parser.add_argument(
        "--expect",
        type=Path,
        default=None,
        help="Expected .xy file path for byte-match verification",
    )
    return parser


def main() -> int:
    parser = _build_arg_parser()
    args = parser.parse_args()

    spec = load_build_spec(args.spec)
    out_path = args.output if args.output is not None else spec.output

    if not args.dry_run and out_path is None:
        parser.error("output path required: set spec.output or pass --output")

    xy_bytes = build_xy_bytes(spec)

    # Structural sanity check: output must parse and round-trip byte-exactly.
    reparsed = XYProject.from_bytes(xy_bytes)
    if reparsed.to_bytes() != xy_bytes:
        raise ValueError("compiled output failed XYProject round-trip validation")

    match_ok = True
    expect_path = args.expect.expanduser().resolve() if args.expect is not None else None
    if expect_path is not None:
        expected = expect_path.read_bytes()
        mismatch = _first_mismatch(xy_bytes, expected)
        if mismatch is None:
            print(f"expect match: yes  sha1={_sha1(xy_bytes)} file={expect_path}")
        else:
            match_ok = False
            offset, built_byte, expected_byte = mismatch
            built_hex = "EOF" if built_byte is None else f"0x{built_byte:02X}"
            expected_hex = "EOF" if expected_byte is None else f"0x{expected_byte:02X}"
            print("expect match: no")
            print(f"  built:    size={len(xy_bytes)} sha1={_sha1(xy_bytes)}")
            print(
                f"  expected: size={len(expected)} sha1={_sha1(expected)} "
                f"file={expect_path}"
            )
            print(
                f"  first diff @ 0x{offset:06X}: "
                f"built={built_hex} expected={expected_hex}"
            )

    if args.dry_run:
        print(
            f"dry-run OK: mode={spec.mode} tracks={spec.track_count} "
            f"size={len(xy_bytes)}B template={spec.template}"
        )
        return 0 if match_ok else 2

    assert out_path is not None  # checked above
    out_path = out_path.expanduser().resolve()
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_bytes(xy_bytes)

    print(f"Wrote {len(xy_bytes)} bytes -> {out_path}")
    print(f"  mode={spec.mode} tracks={spec.track_count}")
    if spec.mode == "multi_pattern":
        print(f"  descriptor_strategy={spec.descriptor_strategy}")
    if spec.header.has_changes():
        print("  header patch applied")

    return 0 if match_ok else 2


if __name__ == "__main__":
    raise SystemExit(main())
