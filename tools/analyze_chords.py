#!/usr/bin/env python3
"""Deep analysis of chord vs single-note event serialization in .xy files.

Compares chord files against single-note reference files and the pristine
baseline to determine how simultaneous notes (chords) are encoded.
"""

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from xy.container import XYProject

BASE = "src/one-off-changes-from-default"

FILES = {
    "baseline":   f"{BASE}/unnamed 1.xy",   # Pristine, no notes
    # Single-note references
    "single_s1":  f"{BASE}/unnamed 2.xy",   # Single note T1 step 1
    "single_s9":  f"{BASE}/unnamed 81.xy",  # Single C4 T1 step 9
    "single_8t":  f"{BASE}/unnamed 93.xy",  # Single C4 on all 8 tracks
    # Chord files
    "chord_CEG":  f"{BASE}/unnamed 3.xy",   # C-E-G triad T1 step 1
    "chord_mix":  f"{BASE}/unnamed 80.xy",  # Singles at 1/5/9 + chord at 13, T1
    "chord_midi": f"{BASE}/unnamed 94.xy",  # MIDI chord C4+E4+G4 on T3 + notes on T1/T5/T7
}


def load(path):
    with open(path, "rb") as f:
        return f.read()


def hex_line(data, offset=0, width=16):
    """Format a hex dump line."""
    hex_part = " ".join(f"{b:02X}" for b in data[offset:offset+width])
    ascii_part = "".join(chr(b) if 32 <= b < 127 else "." for b in data[offset:offset+width])
    return f"  {offset:04X}: {hex_part:<{width*3}}  |{ascii_part}|"


def hex_dump(data, label="", offset_base=0):
    """Full hex dump of data."""
    if label:
        print(f"\n  --- {label} ({len(data)} bytes) ---")
    for i in range(0, len(data), 16):
        chunk = data[i:i+16]
        hex_part = " ".join(f"{b:02X}" for b in chunk)
        ascii_part = "".join(chr(b) if 32 <= b < 127 else "." for b in chunk)
        print(f"  {offset_base+i:04X}: {hex_part:<48}  |{ascii_part}|")


def annotate_event(data, label=""):
    """Parse and annotate an event blob byte-by-byte."""
    if label:
        print(f"\n  === {label} ===")

    if len(data) < 2:
        print(f"  [too short: {len(data)} bytes]")
        return

    event_type = data[0]
    note_count = data[1]
    print(f"  Byte 0:    0x{event_type:02X}  -- event type")
    print(f"  Byte 1:    0x{note_count:02X}  -- note count = {note_count}")

    pos = 2
    for n in range(note_count):
        print(f"\n  --- Note {n+1}/{note_count} ---")
        if pos >= len(data):
            print(f"  [unexpected end at byte {pos}]")
            break

        # Tick field: 2 bytes if tick==0, 4 bytes otherwise
        # Heuristic: if the value at pos is 0x0000 (2-byte), it's tick=0
        # Otherwise it's a 4-byte LE u32
        if pos + 2 <= len(data):
            tick_2 = int.from_bytes(data[pos:pos+2], "little")
        else:
            tick_2 = None

        # Try to determine tick encoding
        # For tick=0, we see: 00 00 02 (flag=0x02)
        # For tick>0, we see: [u32 LE] 00 (flag=0x00)
        # The flag byte helps distinguish

        # Look ahead for the flag byte
        # If tick is 0: bytes are [00 00] [02] -> 3 bytes total for tick+flag
        # If tick > 0: bytes are [u32 LE 4 bytes] [00] -> 5 bytes total for tick+flag

        # Check: does byte at pos+2 == 0x02? Then tick=0 (2-byte encoding)
        if pos + 3 <= len(data) and data[pos] == 0 and data[pos+1] == 0 and data[pos+2] == 0x02:
            tick = 0
            flag = data[pos+2]
            print(f"  [{pos:3d}] {data[pos]:02X} {data[pos+1]:02X}        -- tick = {tick} (2 bytes, step 1)")
            print(f"  [{pos+2:3d}] {flag:02X}              -- flag = 0x{flag:02X}")
            pos += 3
        elif pos + 5 <= len(data):
            tick = int.from_bytes(data[pos:pos+4], "little")
            flag = data[pos+4]
            step = tick // 480 + 1
            print(f"  [{pos:3d}] {data[pos]:02X} {data[pos+1]:02X} {data[pos+2]:02X} {data[pos+3]:02X}  -- tick = {tick} (4 bytes, step {step})")
            print(f"  [{pos+4:3d}] {flag:02X}              -- flag = 0x{flag:02X}")
            pos += 5
        else:
            print(f"  [insufficient bytes for tick at pos {pos}]")
            break

        # Gate field
        if pos < len(data) and data[pos] == 0xF0:
            # Default gate: F0 00 00 01
            if pos + 4 <= len(data):
                gate_raw = data[pos:pos+4]
                print(f"  [{pos:3d}] {' '.join(f'{b:02X}' for b in gate_raw)}     -- default gate (F0 00 00 01)")
                pos += 4
            else:
                print(f"  [insufficient bytes for default gate at pos {pos}]")
                break
        else:
            # Explicit gate: u32 LE + 00
            if pos + 5 <= len(data):
                gate_val = int.from_bytes(data[pos:pos+4], "little")
                gate_term = data[pos+4]
                gate_raw = data[pos:pos+5]
                print(f"  [{pos:3d}] {' '.join(f'{b:02X}' for b in gate_raw)}  -- explicit gate = {gate_val} ticks ({gate_val/480:.2f} steps) + terminator 0x{gate_term:02X}")
                pos += 5
            else:
                print(f"  [insufficient bytes for explicit gate at pos {pos}]")
                break

        # Note and velocity
        if pos + 2 <= len(data):
            note = data[pos]
            vel = data[pos+1]
            # MIDI note name
            note_names = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
            octave = (note // 12) - 2  # MIDI convention: C4 = 60
            name = f"{note_names[note % 12]}{octave}"
            print(f"  [{pos:3d}] {note:02X}              -- note = {note} ({name})")
            print(f"  [{pos+1:3d}] {vel:02X}              -- velocity = {vel}")
            pos += 2
        else:
            print(f"  [insufficient bytes for note/vel at pos {pos}]")
            break

        # Trailing bytes
        is_last = (n == note_count - 1)
        if is_last:
            # Last note: 2 trailing bytes
            if pos + 2 <= len(data):
                trail = data[pos:pos+2]
                print(f"  [{pos:3d}] {' '.join(f'{b:02X}' for b in trail)}           -- trailing (last note, 2 bytes)")
                pos += 2
            elif pos + 1 <= len(data):
                print(f"  [{pos:3d}] {data[pos]:02X}              -- trailing (last note, only 1 byte?)")
                pos += 1
        else:
            # Non-last note: 3 trailing bytes
            if pos + 3 <= len(data):
                trail = data[pos:pos+3]
                print(f"  [{pos:3d}] {' '.join(f'{b:02X}' for b in trail)}        -- trailing (non-last, 3 bytes)")
                pos += 3
            elif pos + 2 <= len(data):
                trail = data[pos:pos+2]
                print(f"  [{pos:3d}] {' '.join(f'{b:02X}' for b in trail)}           -- trailing ({len(trail)} bytes)")
                pos += 2

    if pos < len(data):
        remaining = data[pos:]
        print(f"\n  Remaining {len(remaining)} bytes after parsed notes:")
        hex_dump(remaining, offset_base=pos)

    print(f"\n  Total event size: {len(data)} bytes (parsed {pos} bytes)")


def compare_tracks(baseline_proj, test_proj, test_name):
    """Compare all tracks between baseline and test, show diffs."""
    print(f"\n{'='*80}")
    print(f"FILE: {test_name}")
    print(f"{'='*80}")

    activated = []
    for i in range(16):
        bt = baseline_proj.tracks[i]
        tt = test_proj.tracks[i]

        if bt.body == tt.body:
            continue

        track_num = i + 1
        print(f"\n  Track {track_num}: type 0x{tt.type_byte:02X} (baseline 0x{bt.type_byte:02X})")
        print(f"    Baseline body: {len(bt.body)} bytes")
        print(f"    Test body:     {len(tt.body)} bytes")
        print(f"    Preamble:      {bt.preamble.hex()} -> {tt.preamble.hex()}")
        print(f"    Delta:         +{len(tt.body) - len(bt.body)} bytes")

        # Find where bodies diverge
        min_len = min(len(bt.body), len(tt.body))
        first_diff = None
        for j in range(min_len):
            if bt.body[j] != tt.body[j]:
                first_diff = j
                break

        if first_diff is not None:
            print(f"    First diff at body offset 0x{first_diff:04X}")
            # Show context around first diff
            ctx_start = max(0, first_diff - 4)
            ctx_end = min(min_len, first_diff + 16)
            print(f"    Baseline [{ctx_start:04X}..{ctx_end:04X}]: {bt.body[ctx_start:ctx_end].hex(' ')}")
            print(f"    TestFile [{ctx_start:04X}..{ctx_end:04X}]: {tt.body[ctx_start:ctx_end].hex(' ')}")

        # Check if it's a pure append (baseline body is prefix of test body)
        if tt.body[:len(bt.body)] == bt.body:
            appended = tt.body[len(bt.body):]
            print(f"\n    PURE APPEND: {len(appended)} appended bytes")
            hex_dump(appended, "Appended bytes", offset_base=len(bt.body))
            annotate_event(appended, f"Event annotation (Track {track_num})")
            activated.append((track_num, appended))
        elif tt.type_byte == 0x07 and bt.type_byte == 0x05:
            # Type change 05->07: 2-byte padding removed + event appended
            # The padding bytes (08 00) at body[0x0A:0x0C] are removed
            # So baseline body without padding should be prefix of test body
            bt_no_pad = bt.body[:0x0A] + bt.body[0x0C:]
            if tt.body[:len(bt_no_pad)] == bt_no_pad:
                appended = tt.body[len(bt_no_pad):]
                print(f"\n    TYPE 05->07 TRANSFORM + APPEND: {len(appended)} appended bytes")
                print(f"    (2-byte padding '08 00' removed from body[0x0A:0x0C])")
                hex_dump(appended, "Appended bytes", offset_base=len(bt_no_pad))
                annotate_event(appended, f"Event annotation (Track {track_num})")
                activated.append((track_num, appended))
            else:
                # More complex diff — do byte-level comparison
                print(f"\n    COMPLEX DIFF (not pure append after padding removal)")
                # Show the full test body tail
                if len(tt.body) > len(bt.body):
                    tail_start = len(bt.body) - 20  # Some overlap
                    print(f"\n    Test body tail (from offset 0x{max(0,tail_start):04X}):")
                    hex_dump(tt.body[max(0,tail_start):], offset_base=max(0,tail_start))

                # Try to find event data by looking for known event type bytes
                for et in [0x25, 0x21, 0x1F, 0x20, 0x1E, 0x2D]:
                    for pos in range(len(tt.body)):
                        if tt.body[pos] == et and pos + 1 < len(tt.body):
                            count = tt.body[pos+1]
                            if 1 <= count <= 16:
                                # Plausible event
                                # Find the end of events in the body
                                event_data = tt.body[pos:]
                                print(f"\n    Found potential event at body offset 0x{pos:04X} (type=0x{et:02X}, count={count})")
                                hex_dump(event_data[:80], f"Event data (first 80 bytes)", offset_base=pos)
                                annotate_event(event_data, f"Event annotation attempt (Track {track_num})")
                                break
                    else:
                        continue
                    break

                activated.append((track_num, None))
        else:
            # Some other kind of diff
            print(f"\n    NON-APPEND DIFF")
            # Check preamble-only changes
            if bt.body == tt.body:
                print(f"    Only preamble changed")
            else:
                # Show last N bytes of test body as they likely contain the event
                tail_len = min(60, len(tt.body))
                print(f"\n    Test body last {tail_len} bytes:")
                hex_dump(tt.body[-tail_len:], offset_base=len(tt.body)-tail_len)

                # Diff analysis
                changes = []
                for j in range(min_len):
                    if bt.body[j] != tt.body[j]:
                        changes.append((j, bt.body[j], tt.body[j]))
                if len(tt.body) > len(bt.body):
                    for j in range(min_len, len(tt.body)):
                        changes.append((j, None, tt.body[j]))

                print(f"\n    Total changed/added bytes: {len(changes)}")
                if len(changes) <= 40:
                    for offset, old, new in changes:
                        if old is not None:
                            print(f"      [{offset:04X}] {old:02X} -> {new:02X}")
                        else:
                            print(f"      [{offset:04X}] __ -> {new:02X}")

    return activated


def analyze_unnamed80_detail(baseline_proj, test_proj):
    """Special detailed analysis of unnamed 80 which has single notes + chord."""
    print(f"\n{'='*80}")
    print(f"DETAILED ANALYSIS: unnamed 80 — singles at steps 1/5/9 + chord at step 13")
    print(f"{'='*80}")

    bt = baseline_proj.tracks[0]  # Track 1
    tt = test_proj.tracks[0]      # Track 1

    # Get the event data
    if tt.type_byte == 0x07 and bt.type_byte == 0x05:
        bt_no_pad = bt.body[:0x0A] + bt.body[0x0C:]
        if tt.body[:len(bt_no_pad)] == bt_no_pad:
            event_data = tt.body[len(bt_no_pad):]
        else:
            print("  Could not isolate event data via padding removal")
            return
    elif tt.body[:len(bt.body)] == bt.body:
        event_data = tt.body[len(bt.body):]
    else:
        print("  Could not isolate event data")
        return

    print(f"\n  Full event data: {len(event_data)} bytes")
    hex_dump(event_data, "Complete event blob")

    print(f"\n  Event type: 0x{event_data[0]:02X}")
    print(f"  Note count: {event_data[1]} (decimal)")

    # This file should have notes at steps 1, 5, 9 (single) and step 13 (chord of 3)
    # That's either 6 notes in one event, or multiple events
    # Let's see what the count byte says

    annotate_event(event_data, "Full event with singles + chord")


def analyze_chord_structure():
    """Main analysis comparing chord and single-note events."""

    # Load all files
    projects = {}
    for name, path in FILES.items():
        data = load(path)
        projects[name] = XYProject.from_bytes(data)
        print(f"Loaded {name}: {path} ({len(data)} bytes)")

    baseline = projects["baseline"]

    # 1. Single note references
    print("\n" + "#"*80)
    print("# SINGLE-NOTE REFERENCES")
    print("#"*80)

    compare_tracks(baseline, projects["single_s1"], "unnamed 2 — single note T1 step 1")
    compare_tracks(baseline, projects["single_s9"], "unnamed 81 — single C4 T1 step 9")

    # Show unnamed 93 (8 tracks) for T3 reference
    print("\n" + "#"*80)
    print("# UNNAMED 93 — single C4 on all 8 tracks (T3 reference for chord comparison)")
    print("#"*80)
    compare_tracks(baseline, projects["single_8t"], "unnamed 93 — single C4 all 8 tracks")

    # 2. Chord files
    print("\n" + "#"*80)
    print("# CHORD FILES")
    print("#"*80)

    compare_tracks(baseline, projects["chord_CEG"], "unnamed 3 — C-E-G triad T1 step 1")
    compare_tracks(baseline, projects["chord_mix"], "unnamed 80 — singles + chord T1")
    compare_tracks(baseline, projects["chord_midi"], "unnamed 94 — MIDI chord on T3")

    # 3. Detailed unnamed 80 analysis
    analyze_unnamed80_detail(baseline, projects["chord_mix"])

    # 4. Direct byte comparison: single note vs chord at same step position
    print("\n" + "#"*80)
    print("# DIRECT COMPARISON: 1-note event vs 3-note chord event")
    print("#"*80)

    # Extract T1 event from unnamed 2 (single note step 1)
    bt = baseline.tracks[0]

    # unnamed 2: single note
    t2 = projects["single_s1"].tracks[0]
    if t2.type_byte == 0x07 and bt.type_byte == 0x05:
        bt_no_pad = bt.body[:0x0A] + bt.body[0x0C:]
        single_event = t2.body[len(bt_no_pad):]
    else:
        single_event = None

    # unnamed 3: chord
    t3 = projects["chord_CEG"].tracks[0]
    if t3.type_byte == 0x07 and bt.type_byte == 0x05:
        bt_no_pad = bt.body[:0x0A] + bt.body[0x0C:]
        chord_event = t3.body[len(bt_no_pad):]
    else:
        chord_event = None

    if single_event and chord_event:
        print(f"\n  Single-note event (unnamed 2, T1 step 1): {len(single_event)} bytes")
        print(f"  Chord event (unnamed 3, T1 step 1, C-E-G): {len(chord_event)} bytes")
        print(f"  Size difference: {len(chord_event) - len(single_event)} bytes")

        print(f"\n  Single: {single_event.hex(' ')}")
        print(f"  Chord:  {chord_event.hex(' ')}")

        # Byte-by-byte comparison
        print(f"\n  Byte-by-byte comparison:")
        max_len = max(len(single_event), len(chord_event))
        for i in range(max_len):
            s = f"{single_event[i]:02X}" if i < len(single_event) else "__"
            c = f"{chord_event[i]:02X}" if i < len(chord_event) else "__"
            marker = " *" if s != c else ""
            print(f"    [{i:3d}]  single={s}  chord={c}{marker}")

    # 5. Summary
    print("\n" + "#"*80)
    print("# SUMMARY")
    print("#"*80)

    if single_event and chord_event:
        print(f"\n  Single note event:")
        print(f"    Type byte:     0x{single_event[0]:02X}")
        print(f"    Count byte:    0x{single_event[1]:02X} = {single_event[1]}")
        print(f"    Total size:    {len(single_event)} bytes")

        print(f"\n  Chord event (C-E-G triad):")
        print(f"    Type byte:     0x{chord_event[0]:02X}")
        print(f"    Count byte:    0x{chord_event[1]:02X} = {chord_event[1]}")
        print(f"    Total size:    {len(chord_event)} bytes")

        print(f"\n  Key question answers:")
        if chord_event[0] == single_event[0]:
            print(f"    - Same event type byte (0x{chord_event[0]:02X}) for both")
        else:
            print(f"    - DIFFERENT event type: single=0x{single_event[0]:02X} chord=0x{chord_event[0]:02X}")

        if chord_event[1] == 3 and single_event[1] == 1:
            print(f"    - Count byte changes: 1 for single, 3 for triad")
            print(f"    - Chord = same event type with count=N, then N individual note records")
        elif chord_event[1] == single_event[1]:
            print(f"    - Count byte is SAME ({chord_event[1]}) — chord uses different encoding!")


if __name__ == "__main__":
    analyze_chord_structure()
