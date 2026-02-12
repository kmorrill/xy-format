#!/usr/bin/env python3
"""Index body[0x0E..0x16] (normalized) for every track in every .xy file.

Produces a TSV index showing the mysterious field at body[0x0F] (normalized),
engine_id, event type, and body template pattern for back-testing theories
about event type determination.

Usage:
    python tools/index_track_fields.py                    # all corpus files, instrument tracks
    python tools/index_track_fields.py --all-tracks       # include auxiliary tracks
    python tools/index_track_fields.py --activated-only   # only type-0x07 tracks
    python tools/index_track_fields.py --file unnamed\ 93.xy  # specific file
"""

import sys
import os
import glob
import argparse

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from xy.container import XYProject

ENGINE_NAMES = {
    0x00: "Aux-00",
    0x02: "Sampler",
    0x03: "Drum",
    0x05: "Aux-05",
    0x06: "Aux-06",
    0x07: "EPiano",
    0x12: "Prism",
    0x13: "Hardsync",
    0x14: "Dissolve",
    0x16: "Axis",
    0x1E: "Multi",
    0x1F: "Wavetable",
}

# Default engines per slot (baseline unnamed 1)
DEFAULT_ENGINES = {
    1: 0x03, 2: 0x03, 3: 0x12, 4: 0x07,
    5: 0x14, 6: 0x13, 7: 0x16, 8: 0x1E,
}

# Known event types
EVENT_TYPES = {0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x25, 0x2D}

# Reference templates (from baseline T1 and T2 Drum, normalized body[0x0A:0x17])
T1_DRUM_TEMPLATE = bytes([0x01, 0x03, 0x00, 0x00, 0x05, 0x02, 0x00, 0x00, 0x02, 0x10, 0x00, 0x00, 0x06])
T2_DRUM_TEMPLATE = bytes([0x01, 0x03, 0x00, 0x00, 0x05, 0x01, 0x00, 0x00, 0x02, 0x10, 0x00, 0x00, 0x06])


def normalize_body(body: bytes) -> bytes:
    """Strip type-05 padding to align with type-07 layout."""
    if body[9] == 0x05:
        return body[:10] + body[12:]
    return body


def find_event_type(body: bytes) -> str:
    """Find the note event type byte by validating note event structure.

    A real note event ends at the body tail and has structure:
      [type] [count] ... [note] [vel] [00 00]
    The last 2 bytes of the body are always 00 00 for note events.
    The note byte (body[-4]) should be 0-127 and vel byte (body[-3]) should be 1-127.
    """
    if body[9] != 0x07:
        return "-"

    # Check if the body ends with a note event pattern: ... [note] [vel] 00 00
    if len(body) < 14:
        return "-"

    # The last 2 bytes of a note event are 00 00
    if body[-1] != 0x00 or body[-2] != 0x00:
        return "-"

    # The note and velocity bytes are at -4 and -3
    note_byte = body[-4]
    vel_byte = body[-3]

    # Velocity should be 1-127, note should be 0-127
    if vel_byte < 1 or vel_byte > 127 or note_byte > 127:
        return "-"

    # Now search backwards from the end for the event type header
    # Events are at most ~2000 bytes (120 notes * ~16 bytes each)
    search_start = max(0, len(body) - 2000)
    for pos in range(search_start, len(body) - 12):
        b = body[pos]
        if b in EVENT_TYPES:
            count = body[pos + 1]
            if 1 <= count <= 120:
                # Validate: after type+count, expect [00 00 02] (separator + first-note flag)
                # This pattern is universal for all event types in the corpus
                if pos + 5 <= len(body):
                    if (body[pos + 2] == 0x00 and body[pos + 3] == 0x00
                            and body[pos + 4] == 0x02):
                        return f"0x{b:02X}"
    return "-"


def identify_template(region: bytes, engine_id: int) -> str:
    """Identify which known template the body[0x0A:0x17] matches."""
    if region == T1_DRUM_TEMPLATE:
        return "T1-Drum"
    if region == T2_DRUM_TEMPLATE:
        return "T2-Drum"
    # Check if it matches the engine_id but with different params
    if region[1] == engine_id:
        return "native"
    # Engine ID in region doesn't match current engine
    return f"slot-orig"


def process_file(filepath: str, args) -> list:
    """Process one .xy file and return rows of data."""
    try:
        data = open(filepath, "rb").read()
        proj = XYProject.from_bytes(data)
    except Exception as e:
        return [{"error": str(e), "file": os.path.basename(filepath)}]

    fname = os.path.basename(filepath)
    rows = []
    max_track = 16 if args.all_tracks else 8

    for i, block in enumerate(proj.tracks[:max_track]):
        track_num = i + 1
        body = block.body
        type_byte = body[9]

        if args.activated_only and type_byte != 0x07:
            continue

        norm = normalize_body(body)
        engine_id = norm[0x0B]
        ename = ENGINE_NAMES.get(engine_id, f"0x{engine_id:02X}")

        # The region of interest
        region = norm[0x0A:0x17]
        field_0e = norm[0x0E] if len(norm) > 0x0E else -1
        field_0f = norm[0x0F] if len(norm) > 0x0F else -1

        # Event type (only for activated tracks)
        event_type = find_event_type(body)

        # Template identification
        template = identify_template(region, engine_id)

        # Is this engine the default for this slot?
        default_eng = DEFAULT_ENGINES.get(track_num, -1)
        is_default = "yes" if engine_id == default_eng else "SWAP"
        if track_num > 8:
            is_default = "aux"

        # Region hex
        region_hex = " ".join(f"{b:02X}" for b in region)

        preamble_hex = block.preamble.hex()

        rows.append({
            "file": fname,
            "track": f"T{track_num}",
            "type": f"0x{type_byte:02X}",
            "engine": ename,
            "eng_id": f"0x{engine_id:02X}",
            "default": is_default,
            "f0E": f"0x{field_0e:02X}",
            "f0F": f"0x{field_0f:02X}",
            "event": event_type,
            "template": template,
            "body_sz": len(body),
            "preamble": preamble_hex,
            "region": region_hex,
        })

    return rows


def main():
    parser = argparse.ArgumentParser(description="Index track body fields across .xy corpus")
    parser.add_argument("--all-tracks", action="store_true", help="Include aux tracks T9-T16")
    parser.add_argument("--activated-only", action="store_true", help="Only show type-0x07 tracks")
    parser.add_argument("--file", help="Process a specific file (name only, searched in corpus)")
    parser.add_argument("--tsv", action="store_true", help="Output as TSV (default is aligned table)")
    parser.add_argument("--summary", action="store_true", help="Print summary statistics")
    args = parser.parse_args()

    # Collect files
    corpus_dirs = [
        "src/one-off-changes-from-default",
    ]
    # Also check for amb kit files
    amb_dir = "src/amb-kit"
    if os.path.isdir(amb_dir):
        corpus_dirs.append(amb_dir)

    files = []
    for d in corpus_dirs:
        if not os.path.isdir(d):
            continue
        for f in sorted(glob.glob(os.path.join(d, "*.xy"))):
            if args.file:
                if args.file in os.path.basename(f):
                    files.append(f)
            else:
                files.append(f)

    if not files:
        print(f"No .xy files found (searched: {corpus_dirs})")
        sys.exit(1)

    # Process all files
    all_rows = []
    for f in files:
        all_rows.extend(process_file(f, args))

    # Filter out error rows
    errors = [r for r in all_rows if "error" in r]
    rows = [r for r in all_rows if "error" not in r]

    if errors:
        print(f"# {len(errors)} files had errors", file=sys.stderr)

    # Output
    columns = ["file", "track", "type", "engine", "default", "f0E", "f0F", "event", "template", "body_sz", "preamble", "region"]

    if args.tsv:
        print("\t".join(columns))
        for r in rows:
            print("\t".join(str(r.get(c, "")) for c in columns))
    else:
        # Aligned table (truncate file name for readability)
        hdr = f"{'file':>20s}  {'trk':>3s}  {'type':>4s}  {'engine':>10s}  {'def':>4s}  {'f0E':>4s}  {'f0F':>4s}  {'event':>5s}  {'template':>9s}  {'body':>5s}"
        print(hdr)
        print("-" * len(hdr))
        for r in rows:
            fname = r["file"]
            if len(fname) > 20:
                fname = "..." + fname[-17:]
            print(f"{fname:>20s}  {r['track']:>3s}  {r['type']:>4s}  {r['engine']:>10s}  {r['default']:>4s}  {r['f0E']:>4s}  {r['f0F']:>4s}  {r['event']:>5s}  {r['template']:>9s}  {r['body_sz']:>5d}")

    # Summary
    if args.summary or not args.tsv:
        print()
        print("=" * 60)
        print("SUMMARY: field[0x0F] vs event type (activated tracks only)")
        print("=" * 60)

        # Group by (engine, f0F, event_type) for activated tracks
        from collections import Counter, defaultdict
        combos = Counter()
        for r in rows:
            if r["type"] == "0x07" and r["event"] != "-":
                key = (r["engine"], r["f0F"], r["event"])
                combos[key] += 1

        if combos:
            print(f"\n{'engine':>10s}  {'f0F':>4s}  {'event':>5s}  {'count':>5s}")
            print("-" * 30)
            for (eng, f0f, evt), count in sorted(combos.items()):
                print(f"{eng:>10s}  {f0f:>4s}  {evt:>5s}  {count:>5d}")

        # Also show field[0x0F] distribution across all tracks
        print(f"\n{'engine':>10s}  {'f0E':>4s}  {'f0F':>4s}  {'tracks (baseline)':>20s}")
        print("-" * 45)
        seen = set()
        for r in rows:
            if r["file"] == "unnamed 1.xy":
                key = (r["engine"], r["f0E"], r["f0F"])
                if key not in seen:
                    seen.add(key)
                    print(f"{r['engine']:>10s}  {r['f0E']:>4s}  {r['f0F']:>4s}  {r['track']:>20s}")


if __name__ == "__main__":
    main()
