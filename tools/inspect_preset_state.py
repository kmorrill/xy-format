#!/usr/bin/env python3
"""Dump all stored preset fields in every pattern of a format 9.19 .xy file."""
from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from xy.preset_state import inspect_preset_state


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project", type=Path)
    args = parser.parse_args()
    try:
        result = inspect_preset_state(args.project.read_bytes())
    except (OSError, ValueError) as error:
        parser.exit(2, f"{args.project}: {error}\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
