#!/usr/bin/env python3
"""Deep analysis of chord vs single-note event serialization — v2.

Focus: understand raw byte layout of chord events by careful manual parsing.
Key insight from v1: the chord in unnamed 3 has 3 notes ALL at tick=0 (same step),
and the parser broke because it doesn't handle simultaneous notes correctly.
"""

import sys
import os
import struct

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from xy.container import XYProject

BASE = "src/one-off-changes-from-default"


def load(path):
    with open(path, "rb") as f:
        return f.read()


def hex_dump(data, label="", offset_base=0, width=16):
    if label:
        print(f"\n  --- {label} ({len(data)} bytes) ---")
    for i in range(0, len(data), width):
        chunk = data[i:i+width]
        hex_part = " ".join(f"{b:02X}" for b in chunk)
        ascii_part = "".join(chr(b) if 32 <= b < 127 else "." for b in chunk)
        print(f"  {offset_base+i:04X}: {hex_part:<{width*3}}  |{ascii_part}|")


def note_name(midi):
    names = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    return f"{names[midi % 12]}{(midi // 12) - 2}"


def extract_event_from_track(baseline_proj, test_proj, track_idx):
    """Extract event bytes from an activated track by comparing against baseline."""
    bt = baseline_proj.tracks[track_idx]
    tt = test_proj.tracks[track_idx]

    if bt.body == tt.body:
        return None

    # Look for the event at the end of the body
    # Find known event type bytes near the end
    for search_start in range(max(0, len(tt.body) - 200), len(tt.body)):
        if tt.body[search_start] in (0x25, 0x21, 0x1F, 0x20, 0x1E, 0x2D):
            count = tt.body[search_start + 1] if search_start + 1 < len(tt.body) else 0
            if 1 <= count <= 32:
                # Check that the byte before is 0x00 (separator) or this is at a known boundary
                if search_start == 0 or tt.body[search_start - 1] == 0x00:
                    return tt.body[search_start:]
    return None


def raw_annotate(data, label=""):
    """Annotate event bytes without assumptions about note encoding structure.

    Known structure:
    - Byte 0: event type (0x25, 0x21, etc.)
    - Byte 1: note count

    Then for each note (hypothesis to test):
    - Tick encoding: 2 bytes if tick==0 (00 00), 4 bytes if tick>0
    - Flag byte: 0x02 if first note at tick=0, 0x00 otherwise
    - Gate: F0 00 00 01 (default, 4 bytes) or [u32_le] 00 (explicit, 5 bytes)
    - Note: 1 byte MIDI
    - Velocity: 1 byte
    - Trailing: varies
    """
    if label:
        print(f"\n{'='*70}")
        print(f"  {label}")
        print(f"{'='*70}")

    hex_dump(data, "Raw hex dump")

    if len(data) < 2:
        return

    etype = data[0]
    count = data[1]
    print(f"\n  Event type: 0x{etype:02X}")
    print(f"  Note count: {count}")

    # Now let's try to parse each note
    # But first, let's look for a DIFFERENT structure for chords:
    # Perhaps all notes at the same tick are grouped differently

    pos = 2
    for n in range(count):
        print(f"\n  --- Note {n+1}/{count} (starting at byte {pos}) ---")
        if pos >= len(data):
            print(f"  [EOF]")
            break

        remaining = data[pos:]
        print(f"  Remaining bytes: {remaining.hex(' ')}")

        # Parse tick
        is_first = (n == 0)

        # Tick=0 check: first 2 bytes are 00 00 and next byte is 02
        if pos + 2 <= len(data) and data[pos] == 0 and data[pos+1] == 0:
            # Could be tick=0 (2-byte)
            # Check if byte at pos+2 is 0x02 (flag for tick=0)
            if pos + 3 <= len(data) and data[pos+2] == 0x02:
                tick = 0
                tick_bytes = 2
                flag = 0x02
                print(f"  Tick: {data[pos]:02X} {data[pos+1]:02X} => tick=0 (2 bytes)")
                print(f"  Flag: {data[pos+2]:02X} => 0x02 (tick==0 flag)")
                pos += 3
            elif pos + 5 <= len(data):
                # Could be tick=0 as 4 bytes (00 00 00 00) with flag 0x00
                tick_4 = int.from_bytes(data[pos:pos+4], "little")
                flag_4 = data[pos+4]
                if tick_4 == 0 and flag_4 in (0x00, 0x02, 0x04):
                    tick = 0
                    tick_bytes = 4
                    flag = flag_4
                    print(f"  Tick: {data[pos]:02X} {data[pos+1]:02X} {data[pos+2]:02X} {data[pos+3]:02X} => tick=0 (4 bytes)")
                    print(f"  Flag: {data[pos+4]:02X} => 0x{flag:02X}")
                    pos += 5
                else:
                    # Ambiguous - treat as 2-byte tick=0
                    tick = 0
                    tick_bytes = 2
                    flag = data[pos+2]
                    print(f"  Tick: {data[pos]:02X} {data[pos+1]:02X} => tick=0 (2 bytes)")
                    print(f"  Flag: {data[pos+2]:02X} => 0x{flag:02X}")
                    pos += 3
            else:
                tick = 0
                tick_bytes = 2
                flag = data[pos+2] if pos+3 <= len(data) else 0xFF
                print(f"  Tick: {data[pos]:02X} {data[pos+1]:02X} => tick=0 (2 bytes)")
                if pos+3 <= len(data):
                    print(f"  Flag: {data[pos+2]:02X} => 0x{flag:02X}")
                    pos += 3
                else:
                    pos += 2
        elif pos + 4 <= len(data):
            tick = int.from_bytes(data[pos:pos+4], "little")
            step = tick / 480
            print(f"  Tick: {data[pos]:02X} {data[pos+1]:02X} {data[pos+2]:02X} {data[pos+3]:02X} => tick={tick} (step {step:.1f})")
            pos += 4
            if pos < len(data):
                flag = data[pos]
                print(f"  Flag: {data[pos]:02X} => 0x{flag:02X}")
                pos += 1
            else:
                print(f"  [no flag byte]")
                continue
        else:
            print(f"  [insufficient bytes for tick]")
            break

        # Gate
        if pos < len(data) and data[pos] == 0xF0:
            # Default gate
            if pos + 4 <= len(data):
                gate_bytes = data[pos:pos+4]
                print(f"  Gate: {gate_bytes.hex(' ')} => DEFAULT gate")
                pos += 4
            else:
                print(f"  [insufficient bytes for default gate]")
                break
        elif pos + 4 <= len(data):
            # Explicit gate
            gate_val = int.from_bytes(data[pos:pos+4], "little")
            gate_term = data[pos+4] if pos+5 <= len(data) else None
            gate_steps = gate_val / 480
            if pos + 5 <= len(data):
                print(f"  Gate: {data[pos]:02X} {data[pos+1]:02X} {data[pos+2]:02X} {data[pos+3]:02X} {data[pos+4]:02X} => {gate_val} ticks ({gate_steps:.2f} steps), terminator=0x{gate_term:02X}")
                pos += 5
            else:
                print(f"  Gate: {data[pos]:02X} {data[pos+1]:02X} {data[pos+2]:02X} {data[pos+3]:02X} => {gate_val} ticks ({gate_steps:.2f} steps) [no terminator byte]")
                pos += 4
        else:
            print(f"  [insufficient bytes for gate]")
            break

        # Note + velocity
        if pos + 2 <= len(data):
            midi = data[pos]
            vel = data[pos+1]
            print(f"  Note: {data[pos]:02X} => MIDI {midi} ({note_name(midi)})")
            print(f"  Vel:  {data[pos+1]:02X} => {vel}")
            pos += 2
        else:
            print(f"  [insufficient bytes for note/vel]")
            break

        # Trailing bytes
        is_last = (n == count - 1)
        if is_last:
            if pos + 2 <= len(data):
                trail = data[pos:pos+2]
                print(f"  Trail: {trail.hex(' ')} (last note, 2 bytes)")
                pos += 2
            elif pos < len(data):
                trail = data[pos:]
                print(f"  Trail: {trail.hex(' ')} (last note, {len(trail)} bytes)")
                pos += len(trail)
        else:
            # Non-last: 3 bytes for different-tick notes
            # But what about same-tick (chord) notes?
            if pos + 3 <= len(data):
                trail = data[pos:pos+3]
                print(f"  Trail: {trail.hex(' ')} (non-last, 3 bytes)")
                pos += 3
            elif pos + 2 <= len(data):
                trail = data[pos:pos+2]
                print(f"  Trail: {trail.hex(' ')} (non-last, only 2 bytes)")
                pos += 2
            elif pos < len(data):
                trail = data[pos:]
                print(f"  Trail: {trail.hex(' ')} (non-last, only {len(trail)} bytes)")
                pos += len(trail)

    if pos < len(data):
        print(f"\n  *** UNPARSED {len(data)-pos} bytes at position {pos}: {data[pos:].hex(' ')}")
    elif pos == len(data):
        print(f"\n  >>> PARSE COMPLETE: all {len(data)} bytes accounted for <<<")


def try_chord_hypothesis(data, label=""):
    """Try hypothesis: chord notes (same tick) use a DIFFERENT separator.

    Hypothesis: The trailing bytes might encode whether the NEXT note is at
    the same tick (chord) vs a different tick (sequential).

    Let's look at what the trailing bytes actually are in the chord case.
    """
    if label:
        print(f"\n{'='*70}")
        print(f"  HYPOTHESIS TEST: {label}")
        print(f"{'='*70}")

    if len(data) < 2:
        return

    etype = data[0]
    count = data[1]
    print(f"  Event type: 0x{etype:02X}, count: {count}")

    # Let's try a completely different approach:
    # What if the "trailing" byte after note/vel encodes the tick format of the NEXT note?
    # 00 00 00 = next note has 4-byte tick
    # 00 00 04 = next note has ???
    # 00 00 = last note (no next)

    # Let me scan for note byte values (valid MIDI: 0-127) preceded by gate patterns
    # and followed by velocity values (0-127)

    # Actually, let's try yet another approach. Let me look for all plausible
    # (note, velocity) pairs by scanning for bytes in MIDI range
    print(f"\n  Scanning for plausible (note, velocity) pairs:")
    for i in range(2, len(data) - 1):
        midi_note = data[i]
        vel = data[i+1]
        if 24 <= midi_note <= 96 and 1 <= vel <= 127:
            name = note_name(midi_note)
            print(f"    [{i:3d}] note={midi_note:3d} ({name:>4s})  vel={vel:3d}  | context: ...{data[max(0,i-4):i].hex(' ')} [{data[i]:02X} {data[i+1]:02X}] {data[i+2:min(len(data),i+5)].hex(' ')}...")


def main():
    baseline_data = load(f"{BASE}/unnamed 1.xy")
    baseline = XYProject.from_bytes(baseline_data)

    # ===== UNNAMED 2: Single note, T1, step 1 (REFERENCE) =====
    data2 = load(f"{BASE}/unnamed 2.xy")
    proj2 = XYProject.from_bytes(data2)
    ev2 = extract_event_from_track(baseline, proj2, 0)
    if ev2:
        raw_annotate(ev2, "UNNAMED 2: Single note C4, T1, step 1 (default gate)")

    # ===== UNNAMED 81: Single C4, T1, step 9 (REFERENCE) =====
    data81 = load(f"{BASE}/unnamed 81.xy")
    proj81 = XYProject.from_bytes(data81)
    ev81 = extract_event_from_track(baseline, proj81, 0)
    if ev81:
        raw_annotate(ev81, "UNNAMED 81: Single C4, T1, step 9 (default gate)")

    # ===== UNNAMED 93: Single C4 on T3 (REFERENCE for chord comparison) =====
    data93 = load(f"{BASE}/unnamed 93.xy")
    proj93 = XYProject.from_bytes(data93)
    ev93_t3 = extract_event_from_track(baseline, proj93, 2)  # Track 3
    if ev93_t3:
        raw_annotate(ev93_t3, "UNNAMED 93: Single C4, T3, step 1 (explicit gate 480)")

    print("\n\n" + "#"*70)
    print("# CHORD FILES")
    print("#"*70)

    # ===== UNNAMED 3: C-E-G triad, T1, step 1 =====
    data3 = load(f"{BASE}/unnamed 3.xy")
    proj3 = XYProject.from_bytes(data3)
    ev3 = extract_event_from_track(baseline, proj3, 0)
    if ev3:
        raw_annotate(ev3, "UNNAMED 3: C-E-G chord, T1, step 1 (grid-entered)")
        try_chord_hypothesis(ev3, "UNNAMED 3: C-E-G chord")

    # ===== UNNAMED 80: Singles at 1/5/9 + chord at 13, T1 =====
    data80 = load(f"{BASE}/unnamed 80.xy")
    proj80 = XYProject.from_bytes(data80)
    ev80 = extract_event_from_track(baseline, proj80, 0)
    if ev80:
        raw_annotate(ev80, "UNNAMED 80: Singles at 1/5/9 + F4/G4/A4 chord at step 13, T1")
        try_chord_hypothesis(ev80, "UNNAMED 80: singles + chord")

    # ===== UNNAMED 94: MIDI chord on T3 =====
    data94 = load(f"{BASE}/unnamed 94.xy")
    proj94 = XYProject.from_bytes(data94)

    # T1
    ev94_t1 = extract_event_from_track(baseline, proj94, 0)
    if ev94_t1:
        raw_annotate(ev94_t1, "UNNAMED 94: T1 events (2 single notes)")

    # T3
    ev94_t3 = extract_event_from_track(baseline, proj94, 2)
    if ev94_t3:
        raw_annotate(ev94_t3, "UNNAMED 94: T3 chord C4+E4+G4 (MIDI-recorded)")
        try_chord_hypothesis(ev94_t3, "UNNAMED 94 T3: MIDI chord C4+E4+G4")

    # T5
    ev94_t5 = extract_event_from_track(baseline, proj94, 4)
    if ev94_t5:
        raw_annotate(ev94_t5, "UNNAMED 94: T5 single note")

    # T7
    ev94_t7 = extract_event_from_track(baseline, proj94, 6)
    if ev94_t7:
        raw_annotate(ev94_t7, "UNNAMED 94: T7 single note")

    # ===== CROSS-FILE SIZE COMPARISON =====
    print("\n\n" + "#"*70)
    print("# SIZE COMPARISON TABLE")
    print("#"*70)
    print(f"\n  {'File':<30} {'Track':>5} {'Type':>6} {'Count':>5} {'Size':>5}  Notes")
    print(f"  {'-'*30} {'-'*5} {'-'*6} {'-'*5} {'-'*5}  {'-'*30}")

    entries = [
        ("unnamed 2 (single s1)", ev2, "T1"),
        ("unnamed 81 (single s9)", ev81, "T1"),
        ("unnamed 93 T3 (single)", ev93_t3, "T3"),
        ("unnamed 3 (chord CEG)", ev3, "T1"),
        ("unnamed 80 (mix)", ev80, "T1"),
        ("unnamed 94 T1", ev94_t1, "T1"),
        ("unnamed 94 T3 (chord)", ev94_t3, "T3"),
        ("unnamed 94 T5", ev94_t5, "T5"),
        ("unnamed 94 T7", ev94_t7, "T7"),
    ]

    for name, ev, track in entries:
        if ev and len(ev) >= 2:
            etype = f"0x{ev[0]:02X}"
            count = ev[1]
            size = len(ev)
            # Identify note content
            desc = ""
            if count == 1:
                desc = "single note"
            elif count == 3:
                desc = "triad/chord"
            elif count == 6:
                desc = "3 singles + 3-note chord"
            elif count == 2:
                desc = "2 notes"
            print(f"  {name:<30} {track:>5} {etype:>6} {count:>5} {size:>5}  {desc}")

    # ===== KEY QUESTION: What's byte pattern for chord notes at same tick? =====
    print("\n\n" + "#"*70)
    print("# KEY ANALYSIS: Same-tick notes in chords")
    print("#"*70)

    if ev3:
        print(f"\n  UNNAMED 3 chord (C-E-G at step 1, grid-entered):")
        print(f"  Raw: {ev3.hex(' ')}")
        print(f"  Length: {len(ev3)}")
        print(f"  Count byte (offset 1): {ev3[1]} notes")

        # All 3 notes are at tick=0 (step 1)
        # Single note at tick=0: 00 00 02 [gate 4-5B] [note] [vel] [trail 2B] = 12-13 bytes
        # Expected: 13 bytes for single with default gate
        # For 3 notes at tick=0:
        # If each uses 00 00 for tick (2B): 3 * (2+1+4+1+1+3) = 3*12 = 36, minus 1 for last trail = 35
        # But we got 38 bytes total minus 2 header = 36 bytes for 3 notes
        # Hmm, 36/3 = 12 per note

        # Let me check: what if chord notes at same tick don't repeat the tick?
        # Header: 25 03 (2 bytes)
        # Note 1: 00 00 02 [gate] [note] [vel] [trail]
        # Note 2: [???] [gate] [note] [vel] [trail]
        # Note 3: [???] [gate] [note] [vel] [trail]

        # Actually the gate here is explicit (not F0 default), so 5 bytes
        # Note 1 at tick=0: 00 00 02 [5B gate] [note] [vel] [3B trail] = 12 bytes for non-last
        #                                                    [2B trail] = 11 for last
        # If all 3 at tick=0 with explicit gate:
        # N1: 2+1+5+1+1+3 = 13 (non-last)
        # N2: ?+?+5+1+1+3 = ?  (non-last)
        # N3: ?+?+5+1+1+2 = ?  (last)
        # Total data = 38 - 2 header = 36
        # If N2 and N3 also use 2-byte tick: 13+13+12 = 38 - hmm that's 38 note bytes + 2 header = 40
        # That's 40, not 38. So N2/N3 might be shorter.

        # Let's calculate: 36 bytes for 3 notes
        # N1: 00 00 02 [5B gate] note vel [3B trail] = 2+1+5+1+1+3 = 13
        # That leaves 36-13 = 23 for N2 + N3
        # If N2 has NO tick field (simultaneous): [5B gate] note vel [3B trail] = 5+1+1+3 = 10
        # N3 with NO tick: [5B gate] note vel [2B trail] = 5+1+1+2 = 9
        # Total: 13+10+9 = 32. Not 36.

        # If N2 has 4-byte tick: 4+1+5+1+1+3 = 15
        # N3 has 4-byte tick: 4+1+5+1+1+2 = 14
        # Total: 13+15+14 = 42. Not 36.

        # If N2 has 2-byte tick: 2+1+5+1+1+3 = 13
        # N3 has 2-byte tick: 2+1+5+1+1+2 = 12
        # Total: 13+13+12 = 38. THAT'S 36+2=38! MATCH!

        # Wait, 36 is note data, but total is 38 including header.
        # 13+13+12 = 38 for note data. Plus 2 for header = 40. That's 40, not 38.

        # Hmm. Let me just manually parse byte by byte.
        print(f"\n  Manual byte-by-byte parse:")
        print(f"  [0-1] {ev3[0]:02X} {ev3[1]:02X}  = header: type=0x25, count=3")

        # After header (pos=2), remaining = 36 bytes
        # ev3[2:] = 00 00 02 FD 16 00 00 00 3C 4B 00 00 04 EC 16 00 00 00 43 29 00 00 00 05 00 00 01 DC 16 00 00 00 40 67 00 00
        rest = ev3[2:]
        print(f"  Note data ({len(rest)} bytes): {rest.hex(' ')}")

        # Note 1: starts with 00 00 02 = tick=0, flag=0x02
        # Then gate: is next byte FD? Not 0xF0, so explicit gate
        # FD 16 00 00 = gate_val = 0x000016FD = 5885 ticks
        # 00 = gate terminator
        # 3C = note 60 (C4)
        # 4B = vel 75
        # Then: 00 00 04
        print(f"\n  Note 1 parse:")
        print(f"    [2-3]   {ev3[2]:02X} {ev3[3]:02X}     = tick=0 (2 bytes)")
        print(f"    [4]     {ev3[4]:02X}        = flag 0x02")
        print(f"    [5-8]   {ev3[5]:02X} {ev3[6]:02X} {ev3[7]:02X} {ev3[8]:02X} = gate LE = {int.from_bytes(ev3[5:9], 'little')} ticks ({int.from_bytes(ev3[5:9], 'little')/480:.2f} steps)")
        print(f"    [9]     {ev3[9]:02X}        = gate terminator 0x00")
        print(f"    [10]    {ev3[10]:02X}        = note {ev3[10]} ({note_name(ev3[10])})")
        print(f"    [11]    {ev3[11]:02X}        = velocity {ev3[11]}")
        print(f"    [12-14] {ev3[12]:02X} {ev3[13]:02X} {ev3[14]:02X}  = trailing (non-last, 3 bytes)")

        # Note 2 starts at offset 15
        # ev3[15:] = EC 16 00 00 00 43 29 00 00 00 05 00 00 01 DC 16 00 00 00 40 67 00 00
        # If this is a 4-byte tick: EC 16 00 00 = 0x000016EC = 5868
        # But wait, all notes should be at the same tick (step 1 = tick 0) for a chord!
        # 5868 is NOT 0. So either:
        # (a) The chord notes aren't all at tick 0, or
        # (b) The tick encoding is different for chord notes

        # Let's check: maybe the trailing byte 04 is significant
        # What if trailing 3rd byte is a flag: 00=next note has 4B tick, 04=???

        # Actually wait. Let me reconsider. What if the gate value for a grid-entered
        # chord is something weird? Let me check gate=5885:
        # 5885 / 480 = 12.26 steps. That seems wrong for a grid chord.
        # But the grid default is F0 00 00 01 (1 step).
        # So maybe this ISN'T the gate? Maybe the encoding is different?

        # Let me try: what if grid-entered chords use DEFAULT gate (F0)?
        # Reparse with assumption: byte 5 = FD is NOT F0, so it's explicit...
        # But FD is close to F0. Hmm.

        # Actually, wait. Let me look at this differently.
        # unnamed 2 (single, default gate): 25 01 00 00 02 F0 00 00 01 3C 64 00 00
        # unnamed 3 (chord, ???):           25 03 00 00 02 FD 16 00 00 00 3C 4B 00 00 04 ...

        # Comparing the first note:
        # Single: 00 00 02 F0 00 00 01 3C 64 00 00
        # Chord:  00 00 02 FD 16 00 00 00 3C 4B 00 00 04 ...

        # In single: after flag 02, gate = F0 00 00 01 (default), note=3C, vel=64
        # In chord:  after flag 02, next byte = FD (not F0, so explicit gate)
        #   gate = FD 16 00 00 = 5885, term = 00, note = 3C, vel = 4B
        # That gives vel=75 which is plausible for grid entry (not max 100/127)

        # So note 1 of chord: C4, vel=75, gate=5885 ticks (12.26 steps)
        # Gate of 12.26 steps = sustained, which makes sense for a held chord

        print(f"\n  Note 2 parse (starting at offset 15):")
        # ev3[15:] = EC 16 00 00 00 43 29 00 00 00 05 00 00 01 DC 16 00 00 00 40 67 00 00

        # Two hypotheses for note 2:
        # (A) 4-byte tick: EC 16 00 00 = 5868. Then flag = 00.
        #     Gate explicit: 43 29 00 00 = 10563. Term = 00. Note = 05 (way too low!), vel = 00
        #     This gives note=5 which is F#-2. WRONG.

        # (B) What about... NO tick field for simultaneous notes?
        #     But then what are these bytes?

        # (C) What if the trailing byte 04 means something different?
        #     What if the 3-byte trail is actually 2 bytes + 1 byte that belongs to next note?

        # Let me try: Note 1 trail = 00 00 (2 bytes), then byte 04 is part of note 2
        # Note 2 starting at offset 14:
        # 04 EC 16 00 00 00 43 29 00 00 00 05 00 00 01 DC 16 00 00 00 40 67 00 00
        # If 04 is some kind of "chord continuation" marker...
        # Then tick could be: EC 16 00 00 = 5868 ... still not 0

        # OR: What if 04 means "next note is N steps later" where 04 encodes something?

        # Let me try with trail = 00 00 (just 2 bytes, like last note):
        print(f"\n  ALTERNATIVE HYPOTHESIS: All non-last notes have 2-byte trail (not 3)")
        print(f"  Then note 2 starts at offset 14:")
        off = 14
        print(f"    [{off}]     {ev3[off]:02X}        = ??? prefix/flag byte")

        # Actually, let me try the SIMPLEST hypothesis:
        # What if the separator between notes is just 00 00 for non-chord
        # and 00 00 04 for chord continuation (next note at same tick)?

        # Let me try yet another approach: just look at where the known notes should be
        # Expected notes in unnamed 3 chord: C4 (60), E4 (64), G4 (67) - all at step 1

        print(f"\n  SEARCHING for expected note bytes in chord data:")
        print(f"  Expected: C4=0x3C(60), E4=0x40(64), G4=0x43(67)")
        for i, b in enumerate(ev3):
            if b in (0x3C, 0x40, 0x43):
                context_start = max(0, i-6)
                context_end = min(len(ev3), i+4)
                context = ev3[context_start:context_end]
                marker_pos = i - context_start
                print(f"    Offset {i:2d}: 0x{b:02X} ({note_name(b)})  context: {context.hex(' ')}  (note at position {marker_pos} in context)")

        # From the search:
        # 0x3C at offset 10 - this is note 1 (C4)
        # 0x43 at offset 20 - this should be G4 (67)
        # 0x40 at offset 34 - this should be E4 (64)

        # Wait, those are out of order! C4, G4, E4? That's unusual.
        # But in a grid editor, the order might be arbitrary or sorted by something else.

        # Let me verify with velocity:
        print(f"\n  Note locations and velocities:")
        note_offsets = [(10, 0x3C), (20, 0x43), (34, 0x40)]
        for off, expected_note in note_offsets:
            if off + 1 < len(ev3):
                actual_note = ev3[off]
                vel = ev3[off + 1]
                print(f"    Offset {off}: note={actual_note} ({note_name(actual_note)}) vel={vel}")

        # OK so: note at 10, note at 20, note at 34
        # Between notes: 10 bytes between note 1 and note 2, 14 bytes between note 2 and note 3
        # That's different! So there's something different between them.

        # Let me lay out the regions:
        print(f"\n  Region analysis:")
        print(f"    Header:         ev3[0:2]   = {ev3[0:2].hex(' ')}")
        print(f"    Pre-note1:      ev3[2:10]  = {ev3[2:10].hex(' ')} ({len(ev3[2:10])} bytes)")
        print(f"    Note1+vel:      ev3[10:12] = {ev3[10:12].hex(' ')} = {note_name(ev3[10])} vel={ev3[11]}")
        print(f"    Between 1&2:    ev3[12:20] = {ev3[12:20].hex(' ')} ({len(ev3[12:20])} bytes)")
        print(f"    Note2+vel:      ev3[20:22] = {ev3[20:22].hex(' ')} = {note_name(ev3[20])} vel={ev3[21]}")
        print(f"    Between 2&3:    ev3[22:34] = {ev3[22:34].hex(' ')} ({len(ev3[22:34])} bytes)")
        print(f"    Note3+vel:      ev3[34:36] = {ev3[34:36].hex(' ')} = {note_name(ev3[34])} vel={ev3[35]}")
        print(f"    After note3:    ev3[36:38] = {ev3[36:38].hex(' ')} ({len(ev3[36:38])} bytes)")

    if ev80:
        print(f"\n\n  UNNAMED 80 (singles + chord):")
        print(f"  Raw: {ev80.hex(' ')}")
        print(f"  Length: {len(ev80)}")
        print(f"  Count byte: {ev80[1]} notes")

        # Expected: notes at steps 1, 5, 9 (single C4, D4, E4?) and step 13 chord (F4, G4, A4)
        # Count=6 means all 6 notes in one event

        print(f"\n  SEARCHING for note bytes:")
        for i, b in enumerate(ev80):
            if 48 <= b <= 80:  # Wide range for drum/synth notes
                if i + 1 < len(ev80):
                    vel = ev80[i + 1]
                    if 1 <= vel <= 127:
                        context_start = max(0, i-6)
                        context_end = min(len(ev80), i+4)
                        context = ev80[context_start:context_end]
                        print(f"    Offset {i:2d}: 0x{b:02X} ({note_name(b):>4s}) vel={vel:3d}  context: {context.hex(' ')}")

        # Parse the single notes first (steps 1, 5, 9) then the chord (step 13)
        print(f"\n  Known: 3 single notes + 3-note chord = 6 total")
        print(f"  Step 1  = tick 0")
        print(f"  Step 5  = tick 1920 = 0x0780")
        print(f"  Step 9  = tick 3840 = 0x0F00")
        print(f"  Step 13 = tick 5760 = 0x1680")

        print(f"\n  Region analysis:")
        print(f"    Header: {ev80[0:2].hex(' ')}")

        # Note 1 at step 1 (tick=0):
        # 00 00 02 F0 00 00 01 3C 64 00 00 00
        # = tick=0(2B), flag=02, gate=F0(default 4B), note=3C(C4), vel=64(100), trail=00 00 00(3B)
        print(f"    Note 1 (step 1): {ev80[2:14].hex(' ')}")
        print(f"      tick=0, flag=02, gate=default, note=60(C4), vel=100, trail=00 00 00")

        # Note 2 at step 5 (tick=1920=0x0780):
        # 80 07 00 00 00 F0 00 00 01 3E 64 00 00 01
        # Wait, this should be: tick=80 07 00 00(4B), flag=00, gate=F0 00 00 01(default),
        # note=3E(D4=62), vel=64(100), trail=00 00 01
        # But trail byte 3 = 01? That's unusual, previously we saw 00.
        print(f"    Note 2 (step 5): {ev80[14:28].hex(' ')}")

        # Let me parse it:
        p = 14
        tick_2 = int.from_bytes(ev80[p:p+4], "little")
        print(f"      tick={tick_2} ({tick_2/480:.0f} steps), flag={ev80[p+4]:02X}")
        p += 5
        if ev80[p] == 0xF0:
            print(f"      gate=default (F0 00 00 01)")
            p += 4
        print(f"      note={ev80[p]} ({note_name(ev80[p])}), vel={ev80[p+1]}")
        p += 2
        print(f"      trail: {ev80[p:p+3].hex(' ')}")
        p += 3

        print(f"    Note 3 (step 9): starting at offset {p}")
        tick_3 = int.from_bytes(ev80[p:p+4], "little")
        print(f"      tick={tick_3} ({tick_3/480:.0f} steps), flag={ev80[p+4]:02X}")
        p += 5
        if ev80[p] == 0xF0:
            print(f"      gate=default (F0 00 00 01)")
            p += 4
        print(f"      note={ev80[p]} ({note_name(ev80[p])}), vel={ev80[p+1]}")
        p += 2
        print(f"      trail: {ev80[p:p+3].hex(' ')}")
        p += 3

        print(f"\n    Now at offset {p}, remaining: {ev80[p:].hex(' ')}")
        print(f"    This should be the CHORD at step 13 (tick=5760=0x1680)")

        # Note 4 (first of chord, step 13):
        tick_4 = int.from_bytes(ev80[p:p+4], "little")
        print(f"\n    Note 4 (chord note 1, step 13):")
        print(f"      tick={tick_4} ({tick_4/480:.1f} steps), flag={ev80[p+4]:02X}")
        p += 5
        if ev80[p] == 0xF0:
            print(f"      gate=default (F0 00 00 01)")
            p += 4
        else:
            gate = int.from_bytes(ev80[p:p+4], "little")
            print(f"      gate=explicit {gate} ticks, term={ev80[p+4]:02X}")
            p += 5
        print(f"      note={ev80[p]} ({note_name(ev80[p])}), vel={ev80[p+1]}")
        p += 2

        # Now: what does the trail look like before the next chord note?
        print(f"      bytes after note/vel: {ev80[p:p+5].hex(' ')}")

        # Is the next chord note at the same tick? If so, how is it encoded?
        # The key question!

        # Let me just show all remaining bytes with possible interpretations
        print(f"\n    All remaining from offset {p}: {ev80[p:].hex(' ')} ({len(ev80)-p} bytes)")
        print(f"    We expect 2 more notes (chord notes 2 and 3)")

        # Let me search for the expected note values
        print(f"\n    Searching for remaining chord notes in tail bytes:")
        tail = ev80[p:]
        for i, b in enumerate(tail):
            if b in range(48, 80) and i+1 < len(tail) and 1 <= tail[i+1] <= 127:
                print(f"      tail[{i}] (abs {p+i}): note={b} ({note_name(b)}) vel={tail[i+1]}")

    if ev94_t3:
        print(f"\n\n  UNNAMED 94 T3 chord (C4+E4+G4, MIDI-recorded):")
        print(f"  Raw: {ev94_t3.hex(' ')}")
        print(f"  Length: {len(ev94_t3)}")
        print(f"  Count: {ev94_t3[1]}")

        print(f"\n  SEARCHING for note bytes:")
        for i, b in enumerate(ev94_t3):
            if b in (0x3C, 0x40, 0x43):
                if i + 1 < len(ev94_t3):
                    vel = ev94_t3[i+1]
                    print(f"    Offset {i:2d}: 0x{b:02X} ({note_name(b)}) vel={vel}")

        print(f"\n  Region analysis:")
        # Expected: type=0x2D, count=3, all at tick=0
        # 2D 03 00 00 02 E0 01 00 00 00 43 64 00 00 04 E0 01 00 00 00 40 64 00 00 04 E0 01 00 00 00 3C 64 00 00
        # Note locations: 43(G4) at offset 10, 40(E4) at offset 20, 3C(C4) at offset 30

        # Pattern: header(2) + [tick+flag(3) + gate(5) + note(1) + vel(1) + trail] x 3
        # First note: 00 00 02 E0 01 00 00 00 43 64 [00 00 04] = 13 bytes (tick=0, explicit gate 480)
        # Second:     E0 01 00 00 00 40 64 [00 00 04] = 10 bytes
        # Third:      E0 01 00 00 00 3C 64 [00 00] = 9 bytes

        # Wait! Second note starts at offset 15 with E0 01 00 00
        # If this is a tick: 0x000001E0 = 480 ticks = step 2. But this should be simultaneous!
        # Unless... this ISN'T a tick. What if the trailing 04 means "next note has NO tick"?
        # Then bytes E0 01 00 00 00 would be: gate = E0 01 00 00 = 480 ticks, term = 00
        # That gives: gate(5) + note(1) + vel(1) + trail(2 or 3) = 9 or 10 bytes per note

        # Let me check this hypothesis:
        print(f"\n  HYPOTHESIS: 0x04 in trail = 'chord continuation' (next note at same tick, no tick field)")
        print(f"  Note 1:")
        print(f"    [{2:2d}-{3:2d}] tick = 00 00 = 0 (2 bytes)")
        print(f"    [{4:2d}]    flag = 02")
        print(f"    [{5:2d}-{9:2d}] gate = E0 01 00 00 00 = 480 ticks (explicit)")
        print(f"    [{10:2d}]    note = 43 = G4 (67)")
        print(f"    [{11:2d}]    vel  = 64 = 100")
        print(f"    [{12:2d}-{14:2d}] trail = 00 00 04  *** 04 = chord continuation? ***")

        print(f"  Note 2 (NO tick field due to 04 flag):")
        print(f"    [{15:2d}-{19:2d}] gate = E0 01 00 00 00 = 480 ticks (explicit)")
        print(f"    [{20:2d}]    note = 40 = E4 (64)")
        print(f"    [{21:2d}]    vel  = 64 = 100")
        print(f"    [{22:2d}-{24:2d}] trail = 00 00 04  *** 04 = chord continuation? ***")

        print(f"  Note 3 (NO tick field due to 04 flag):")
        print(f"    [{25:2d}-{29:2d}] gate = E0 01 00 00 00 = 480 ticks (explicit)")
        print(f"    [{30:2d}]    note = 3C = C4 (60)")
        print(f"    [{31:2d}]    vel  = 64 = 100")
        print(f"    [{32:2d}-{33:2d}] trail = 00 00     (last note, 2 bytes)")

        # Verify: 2 + (3+5+2+3) + (5+2+3) + (5+2+2) = 2 + 13 + 10 + 9 = 34
        # ev94_t3 length should be 34
        print(f"\n  Predicted length: 2 + 13 + 10 + 9 = 34 bytes")
        print(f"  Actual length: {len(ev94_t3)} bytes")
        if len(ev94_t3) == 34:
            print(f"  >>> MATCH! Hypothesis confirmed for unnamed 94 T3! <<<")

    # Now verify against unnamed 3 chord
    if ev3:
        print(f"\n\n  VERIFY HYPOTHESIS on UNNAMED 3 (grid-entered chord, explicit gate):")
        print(f"  Raw: {ev3.hex(' ')}")
        print(f"  Length: {len(ev3)}")

        # If 04 trail means "chord continuation, no tick for next note":
        # Note 1: tick(2)+flag(1)+gate(5)+note(1)+vel(1)+trail(3) = 13
        #   00 00 02 FD 16 00 00 00 3C 4B 00 00 04
        # Note 2: gate(5)+note(1)+vel(1)+trail(3) = 10
        #   EC 16 00 00 00 43 29 00 00 00
        # Wait, but 00 00 00 is trail[0:3], and the 3rd byte is 00, not 04.
        # That means note 3 is NOT a chord continuation?

        # Hmm. Let me look more carefully.
        # ev3 = 25 03 00 00 02 FD 16 00 00 00 3C 4B 00 00 04 EC 16 00 00 00 43 29 00 00 00 05 00 00 01 DC 16 00 00 00 40 67 00 00

        # What if trail for note 1 = 00 00 04?
        #   04 means: next note has no tick (chord continuation)
        # Note 2 (no tick): gate = EC 16 00 00 = 5868. term = 00.
        #   note = 43 = G4. vel = 29 = 41. trail = 00 00 00
        # 00 as last trail byte: NOT 04, so note 3 DOES have a tick?
        # But all 3 notes should be at tick 0!

        # Note 3 (HAS tick): 05 00 00 01 = tick = 0x01000005 = 16777221???
        # That's clearly wrong.

        # Maybe the trail interpretation is wrong for note 2.
        # What if trail is only 2 bytes: 00 00?
        # Then byte 00 at offset 24 is start of note 3.
        # But note 3 starts with 00, which could be tick=0 (2-byte): 00 05
        # tick = 0x0500 = 1280? That's not step 1 either.

        # Let me try yet another approach. What if the trailing separator has
        # variable length depending on the 3rd byte?
        # Trail = 00 00 [continuation_byte]
        # If continuation_byte = 04: next note is chord (no tick), 3 trail bytes total
        # If continuation_byte = 00: next note has 4-byte tick, 3 trail bytes total
        # If continuation_byte = 05: ???

        # Actually, from unnamed 80, the single notes had trailing:
        # Note 1: 00 00 00 (step 1 -> step 5, 4-byte tick)
        # Note 2: 00 00 01 (step 5 -> step 9, 4-byte tick)
        # Hmm wait, let me re-check that.

        print(f"\n  Re-examining unnamed 80 trailing bytes:")
        # ev80: 25 06 00 00 02 F0 00 00 01 3C 64 00 00 00 80 07 ...
        # Note 1: tick=00 00, flag=02, gate=F0 00 00 01, note=3C, vel=64
        # Trail: 00 00 00
        # Note 2: 80 07 00 00 (tick=1920), 00 (flag), F0 00 00 01 (gate), 3E (D4), 64 (100)
        # Trail: 00 00 01
        if ev80:
            # Note 2 trail
            p = 25  # after note2 vel
            print(f"    Note 2 trail: {ev80[p]:02X} {ev80[p+1]:02X} {ev80[p+2]:02X}")
            # Note 3 starts at p+3 = 28
            tick_3 = int.from_bytes(ev80[p+3:p+7], "little")
            print(f"    Note 3 tick: {ev80[p+3]:02X} {ev80[p+4]:02X} {ev80[p+5]:02X} {ev80[p+6]:02X} = {tick_3}")

    # ===== Let's dump unnamed 80 with complete manual parse =====
    if ev80:
        print(f"\n\n  COMPLETE MANUAL PARSE OF UNNAMED 80:")
        print(f"  Raw ({len(ev80)} bytes): {ev80.hex(' ')}")
        d = ev80
        p = 0
        print(f"  [{p}] {d[p]:02X}     = event type 0x25")
        p += 1
        print(f"  [{p}] {d[p]:02X}     = note count {d[p]}")
        p += 1

        note_count = d[1]
        for n in range(note_count):
            print(f"\n  Note {n+1}/{note_count}:")

            # Determine if we have tick or not
            # For the first note, tick field is always present
            # For subsequent notes: check the previous trailing byte

            has_tick = True  # assume for now

            if has_tick:
                # Tick=0 check
                if d[p] == 0 and d[p+1] == 0 and d[p+2] == 0x02:
                    tick = 0
                    flag = 0x02
                    print(f"  [{p}] {d[p]:02X} {d[p+1]:02X}  = tick=0 (2 bytes)")
                    print(f"  [{p+2}] {d[p+2]:02X}     = flag 0x{flag:02X}")
                    p += 3
                else:
                    tick = int.from_bytes(d[p:p+4], "little")
                    flag = d[p+4]
                    print(f"  [{p}] {d[p]:02X} {d[p+1]:02X} {d[p+2]:02X} {d[p+3]:02X} = tick={tick} (step {tick/480+1:.0f})")
                    print(f"  [{p+4}] {d[p+4]:02X}     = flag 0x{flag:02X}")
                    p += 5

            # Gate
            if d[p] == 0xF0:
                print(f"  [{p}] {d[p]:02X} {d[p+1]:02X} {d[p+2]:02X} {d[p+3]:02X} = DEFAULT gate")
                p += 4
            else:
                gate = int.from_bytes(d[p:p+4], "little")
                print(f"  [{p}] {d[p]:02X} {d[p+1]:02X} {d[p+2]:02X} {d[p+3]:02X} {d[p+4]:02X} = explicit gate {gate} ticks ({gate/480:.2f} steps)")
                p += 5

            # Note + velocity
            print(f"  [{p}] {d[p]:02X}     = note {d[p]} ({note_name(d[p])})")
            print(f"  [{p+1}] {d[p+1]:02X}     = velocity {d[p+1]}")
            p += 2

            # Trail
            is_last = (n == note_count - 1)
            if is_last:
                trail = d[p:p+2]
                print(f"  [{p}] {trail.hex(' ')}  = trail (LAST note, 2 bytes)")
                p += 2
            else:
                trail = d[p:p+3]
                print(f"  [{p}] {trail.hex(' ')} = trail (non-last, 3 bytes) [3rd byte = 0x{trail[2]:02X}]")
                p += 3

        print(f"\n  Parsed {p}/{len(d)} bytes")
        if p < len(d):
            print(f"  Remaining: {d[p:].hex(' ')}")


if __name__ == "__main__":
    main()
