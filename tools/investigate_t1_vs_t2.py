#!/usr/bin/env python3
"""Investigate structural differences between Track 1 and Track 2
to understand why the pure-append recipe crashes Track 1 but works for Track 2."""

import sys
sys.path.insert(0, "/Users/kevinmorrill/Documents/xy-format")

from xy.container import XYProject

CORPUS = "/Users/kevinmorrill/Documents/xy-format/src/one-off-changes-from-default"
OUTPUT = "/Users/kevinmorrill/Documents/xy-format/output"


def load(path):
    with open(path, "rb") as f:
        return XYProject.from_bytes(f.read())


def hex_dump(data, offset=0, length=None):
    """Pretty hex dump of bytes."""
    if length is not None:
        data = data[offset:offset + length]
    else:
        data = data[offset:]
    lines = []
    for i in range(0, len(data), 16):
        chunk = data[i:i + 16]
        hex_part = " ".join(f"{b:02x}" for b in chunk)
        ascii_part = "".join(chr(b) if 32 <= b < 127 else "." for b in chunk)
        lines.append(f"  {i:04x}: {hex_part:<48s}  {ascii_part}")
    return "\n".join(lines)


def compare_bodies(label_a, body_a, label_b, body_b, max_diff_lines=60):
    """Compare two track bodies byte-by-byte."""
    print(f"\n  {label_a} length: {len(body_a)}")
    print(f"  {label_b} length: {len(body_b)}")

    min_len = min(len(body_a), len(body_b))
    diffs = []
    for i in range(min_len):
        if body_a[i] != body_b[i]:
            diffs.append((i, body_a[i], body_b[i]))

    if diffs:
        print(f"\n  Byte differences in shared region (0..{min_len - 1}):")
        for pos, old, new in diffs[:max_diff_lines]:
            print(f"    offset 0x{pos:04x} ({pos:4d}): {old:02x} -> {new:02x}")
        if len(diffs) > max_diff_lines:
            print(f"    ... and {len(diffs) - max_diff_lines} more differences")
        print(f"  Total differing bytes in shared region: {len(diffs)}")
    else:
        print(f"  No differences in shared region (0..{min_len - 1})")

    if len(body_b) > len(body_a):
        extra = body_b[len(body_a):]
        print(f"\n  Appended bytes ({len(extra)} bytes) in {label_b}:")
        print(hex_dump(extra))
    elif len(body_a) > len(body_b):
        extra = body_a[len(body_b):]
        print(f"\n  Extra bytes ({len(extra)} bytes) in {label_a} (truncated in {label_b}):")
        print(hex_dump(extra))


def print_track_info(label, track):
    print(f"\n--- {label} ---")
    print(f"  Index:        {track.index}")
    print(f"  Engine ID:    {track.engine_id}")
    print(f"  Type byte:    0x{track.type_byte:02x}")
    print(f"  Has padding:  {track.has_padding}")
    print(f"  Preamble:     {track.preamble.hex()}")
    print(f"  Preamble word: 0x{track.preamble_word:08x}")
    print(f"  Body length:  {len(track.body)}")
    print(f"  Body[0:32]:")
    print(hex_dump(track.body, 0, 32))
    print(f"  Body[8:12] (type/pointer area):")
    print(hex_dump(track.body, 8, 4))


# ==========================================================================
# PART 1: Baseline Track 1 vs Track 2
# ==========================================================================
print("=" * 80)
print("PART 1: BASELINE -- Track 1 vs Track 2")
print("=" * 80)

baseline = load(f"{CORPUS}/unnamed 1.xy")
t1_base = baseline.tracks[0]
t2_base = baseline.tracks[1]

print_track_info("Baseline Track 1 (index 0)", t1_base)
print_track_info("Baseline Track 2 (index 1)", t2_base)

# Check if bodies are identical
if t1_base.body == t2_base.body:
    print("\n  >>> Track 1 and Track 2 bodies are IDENTICAL in baseline")
else:
    print("\n  >>> Track 1 and Track 2 bodies DIFFER in baseline")
    compare_bodies("Track 1", t1_base.body, "Track 2", t2_base.body)

# Also show all 16 tracks' key properties
print("\n\n--- All 16 tracks summary ---")
print(f"  {'Idx':>3s}  {'EngID':>5s}  {'Type':>4s}  {'Pad':>5s}  {'BodyLen':>7s}  {'Preamble':>10s}")
for t in baseline.tracks:
    print(f"  {t.index:3d}  {t.engine_id:5d}  0x{t.type_byte:02x}  {str(t.has_padding):>5s}  {len(t.body):7d}  {t.preamble.hex()}")


# ==========================================================================
# PART 2: Working file -- drum_t2_only.xy Track 2 vs baseline Track 2
# ==========================================================================
print("\n\n" + "=" * 80)
print("PART 2: WORKING FILE -- drum_t2_only.xy Track 2 vs Baseline Track 2")
print("=" * 80)

try:
    working = load(f"{OUTPUT}/drum_t2_only.xy")
    t2_work = working.tracks[1]
    print_track_info("drum_t2_only Track 2", t2_work)
    compare_bodies("Baseline T2", t2_base.body, "drum_t2_only T2", t2_work.body)

    # Also check if Track 1 was modified
    t1_work = working.tracks[0]
    if t1_work.body == t1_base.body and t1_work.type_byte == t1_base.type_byte:
        print("\n  Track 1 in drum_t2_only is UNCHANGED from baseline")
    else:
        print("\n  Track 1 in drum_t2_only was ALSO modified:")
        print_track_info("drum_t2_only Track 1", t1_work)
except FileNotFoundError:
    print("  drum_t2_only.xy not found in output/")


# ==========================================================================
# PART 3: Crashing file -- drum_t1_only.xy Track 1 vs baseline Track 1
# ==========================================================================
print("\n\n" + "=" * 80)
print("PART 3: CRASHING FILE -- drum_t1_only.xy Track 1 vs Baseline Track 1")
print("=" * 80)

try:
    crashing = load(f"{OUTPUT}/drum_t1_only.xy")
    t1_crash = crashing.tracks[0]
    print_track_info("drum_t1_only Track 1", t1_crash)
    compare_bodies("Baseline T1", t1_base.body, "drum_t1_only T1", t1_crash.body)

    # Also check Track 2
    t2_crash = crashing.tracks[1]
    if t2_crash.body == t2_base.body and t2_crash.type_byte == t2_base.type_byte:
        print("\n  Track 2 in drum_t1_only is UNCHANGED from baseline")
    else:
        print("\n  Track 2 in drum_t1_only was ALSO modified:")
        print_track_info("drum_t1_only Track 2", t2_crash)
except FileNotFoundError:
    print("  drum_t1_only.xy not found in output/")


# ==========================================================================
# PART 4: Cross-compare the MODIFICATIONS (what exactly changed in each)
# ==========================================================================
print("\n\n" + "=" * 80)
print("PART 4: CROSS-COMPARISON -- Modifications side-by-side")
print("=" * 80)

try:
    # Show the raw bytes around the type byte area for both modified files
    print("\n--- drum_t2_only.xy: raw bytes around Track 2 modification area ---")
    t2w = working.tracks[1]
    print(f"  Type byte: 0x{t2w.type_byte:02x}, has_padding: {t2w.has_padding}")
    print(f"  Body first 48 bytes:")
    print(hex_dump(t2w.body, 0, 48))

    print("\n--- drum_t1_only.xy: raw bytes around Track 1 modification area ---")
    t1c = crashing.tracks[0]
    print(f"  Type byte: 0x{t1c.type_byte:02x}, has_padding: {t1c.has_padding}")
    print(f"  Body first 48 bytes:")
    print(hex_dump(t1c.body, 0, 48))

    # Compare the two modifications structurally
    print("\n--- Structural comparison of the two modifications ---")
    print(f"  Track 2 (works):  type=0x{t2w.type_byte:02x}, padding={t2w.has_padding}, body_len={len(t2w.body)}, engine={t2w.engine_id}")
    print(f"  Track 1 (crash):  type=0x{t1c.type_byte:02x}, padding={t1c.has_padding}, body_len={len(t1c.body)}, engine={t1c.engine_id}")
    print(f"  Baseline T2:      type=0x{t2_base.type_byte:02x}, padding={t2_base.has_padding}, body_len={len(t2_base.body)}, engine={t2_base.engine_id}")
    print(f"  Baseline T1:      type=0x{t1_base.type_byte:02x}, padding={t1_base.has_padding}, body_len={len(t1_base.body)}, engine={t1_base.engine_id}")

    # Delta sizes
    t2_delta = len(t2w.body) - len(t2_base.body)
    t1_delta = len(t1c.body) - len(t1_base.body)
    print(f"\n  Track 2 body delta: {t2_delta:+d} bytes")
    print(f"  Track 1 body delta: {t1_delta:+d} bytes")
except Exception as e:
    print(f"  Error: {e}")


# ==========================================================================
# PART 5: Corpus files with Track 1 notes (unnamed 2, 52, 81)
# ==========================================================================
print("\n\n" + "=" * 80)
print("PART 5: CORPUS FILES WITH TRACK 1 NOTES")
print("=" * 80)

for num in [2, 52, 81]:
    path = f"{CORPUS}/unnamed {num}.xy"
    try:
        proj = load(path)
        t1 = proj.tracks[0]
        print(f"\n--- unnamed {num}.xy Track 1 ---")
        print_track_info(f"unnamed {num} Track 1", t1)

        if t1.body == t1_base.body:
            print(f"  Body is IDENTICAL to baseline Track 1")
        else:
            compare_bodies("Baseline T1", t1_base.body, f"unnamed {num} T1", t1.body)

        # Also check preamble differences
        if t1.preamble != t1_base.preamble:
            print(f"  Preamble differs: baseline={t1_base.preamble.hex()} vs {t1.preamble.hex()}")
    except FileNotFoundError:
        print(f"  unnamed {num}.xy not found")
    except Exception as e:
        print(f"  Error loading unnamed {num}.xy: {e}")


# ==========================================================================
# PART 6: Raw file -- handle table and preamble area
# ==========================================================================
print("\n\n" + "=" * 80)
print("PART 6: RAW FILE -- Handle table and preamble area")
print("=" * 80)

with open(f"{CORPUS}/unnamed 1.xy", "rb") as f:
    raw = f.read()

print(f"Total file size: {len(raw)} bytes")
print(f"\nHandle table area (0x58-0x7F):")
print(hex_dump(raw, 0x58, 0x28))
print(f"\nFirst track preamble area (0x7C-0x83):")
print(hex_dump(raw, 0x7C, 8))

# Also show where each track body starts in the raw file
print("\n\nTrack body offsets in raw file:")
for t in baseline.tracks:
    pos = raw.find(t.body[:32])
    if pos >= 0:
        print(f"  Track {t.index:2d}: body starts at raw offset 0x{pos:06x} ({pos}), length {len(t.body)}")
    else:
        print(f"  Track {t.index:2d}: body NOT found in raw data (first 32 bytes)")

# Show the preamble bytes just before each track body
print("\n\nPreamble bytes (4 bytes before each track body):")
for t in baseline.tracks:
    pos = raw.find(t.body[:32])
    if pos >= 0 and pos >= 4:
        pre = raw[pos - 4:pos]
        print(f"  Track {t.index:2d}: preamble at 0x{pos - 4:06x} = {pre.hex()}  body at 0x{pos:06x}")
