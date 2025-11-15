#!/usr/bin/env python3
"""Minimal OP-XY writer prototype.

Usage examples:

    python tools/write_xy.py --template 'src/one-off-changes-from-default/unnamed 1.xy' \\
        --output build/drum.xy --track 1 --trig step=0,note=60,vel=100
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import List

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.structs import find_track_blocks  # noqa: E402
from xy.writer import TrigSpec, activate_track, apply_single_trig  # noqa: E402


def parse_trig(value: str) -> TrigSpec:
    params = {}
    for chunk in value.split(","):
        if "=" in chunk:
            key, raw = chunk.split("=", 1)
        elif ":" in chunk:
            key, raw = chunk.split(":", 1)
        else:
            raise ValueError(f"invalid trig spec {value!r}")
        key = key.strip()
        raw = raw.strip()
        params[key] = raw

    def parse_int(name: str, default: int | None = None) -> int:
        if name not in params:
            if default is None:
                raise ValueError(f"missing {name} in trig spec")
            return default
        raw_val = params[name]
        if raw_val.lower().startswith("0x"):
            return int(raw_val, 16)
        return int(raw_val)

    step = parse_int("step")
    note = parse_int("note")
    velocity = parse_int("vel", 100)
    gate = parse_int("gate", 100)
    gate_ticks = parse_int("gate_ticks", None)
    voice = parse_int("voice", 1)
    return TrigSpec(
        step=step,
        note=note,
        velocity=velocity,
        gate_percent=gate,
        gate_ticks=gate_ticks,
        voice=voice,
    )


def main() -> int:
    parser = argparse.ArgumentParser(description="Write minimal drum trigs into an OP-XY project.")
    parser.add_argument("--template", required=True, type=Path, help="path to baseline .xy file")
    parser.add_argument("--output", required=True, type=Path, help="destination file")
    parser.add_argument("--track", type=int, default=1, help="track index (1-based)")
    parser.add_argument(
        "--trig",
        action="append",
        default=[],
        help="Trig specification (step=0,note=60,vel=100,gate=100,voice=1)",
    )
    args = parser.parse_args()

    template_bytes = args.template.read_bytes()
    buf = activate_track(template_bytes, track_index=args.track)

    trigs: List[TrigSpec] = [parse_trig(spec) for spec in args.trig]
    if len(trigs) > 1:
        raise NotImplementedError("multi-trig writing not implemented yet")

    if trigs:
        blocks = find_track_blocks(buf)
        block = blocks[args.track - 1]
        apply_single_trig(buf, block, args.track, trigs[0])

    args.output.write_bytes(buf)
    print(f"Wrote {args.output} ({len(buf)} bytes)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
