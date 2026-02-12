#!/usr/bin/env python3
"""Chord analysis v3 — test and verify the trailing-byte hypothesis.

KEY DISCOVERY from v2:
  The 3rd byte of the trailing separator (trail[2]) encodes the tick format
  of the NEXT note:
    - 0x00: next note has a 4-byte absolute tick (different step)
    - 0x04: next note is at the SAME tick (chord continuation, NO tick field)
    - 0x01: ???  (seen in unnamed 80, note 2 -> note 3)
    - 0x05: ???  (seen in unnamed 3, note 2 -> note 3)

  The LAST note always has a 2-byte trail (00 00) with no continuation byte.

Let's validate this across all files.
"""

import sys
import os
import struct

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from xy.container import XYProject

BASE = "src/one-off-changes-from-default"
STEP_TICKS = 480


def load(path):
    with open(path, "rb") as f:
        return f.read()


def note_name(midi):
    names = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    return f"{names[midi % 12]}{(midi // 12) - 2}"


def extract_event(baseline_proj, test_proj, track_idx):
    """Extract event bytes by finding the event type byte near the end of body."""
    bt = baseline_proj.tracks[track_idx]
    tt = test_proj.tracks[track_idx]
    if bt.body == tt.body:
        return None
    for s in range(max(0, len(tt.body) - 200), len(tt.body)):
        if tt.body[s] in (0x25, 0x21, 0x1F, 0x20, 0x1E, 0x2D):
            if s + 1 < len(tt.body):
                count = tt.body[s + 1]
                if 1 <= count <= 32:
                    if s == 0 or tt.body[s - 1] == 0x00:
                        return tt.body[s:]
    return None


def parse_event(data, label=""):
    """Parse an event using the new trailing-byte hypothesis.

    Trail encoding for non-last notes: [00 00 XX]
    where XX encodes the tick format of the NEXT note:
      0x00 = next note has 4-byte tick (00 00 00 = all zero trail = 4B tick follows)
      0x01 = next note has 4-byte tick (different from 0x00 how?)
      0x04 = next note has NO tick (chord continuation, same tick as this note)
      0x05 = next note has NO tick (chord continuation, same tick as this note, variant?)
    """
    if label:
        print(f"\n{'='*70}")
        print(f"  {label}")
        print(f"{'='*70}")
        print(f"  Raw ({len(data)} bytes): {data.hex(' ')}")

    if len(data) < 2:
        print("  [too short]")
        return []

    etype = data[0]
    count = data[1]
    print(f"  Event type: 0x{etype:02X}")
    print(f"  Note count: {count}")

    p = 2
    notes_parsed = []
    prev_tick = 0
    current_tick = None  # for chord continuation
    has_tick = True  # first note always has tick

    for n in range(count):
        is_last = (n == count - 1)
        note_info = {}

        if has_tick:
            # Check for tick=0 (2-byte encoding: 00 00 followed by flag 0x02)
            if p + 3 <= len(data) and data[p] == 0 and data[p+1] == 0 and data[p+2] == 0x02:
                tick = 0
                flag = 0x02
                print(f"\n  Note {n+1}/{count}: tick=0 (2B), flag=0x02")
                p += 3
            elif p + 5 <= len(data):
                tick = int.from_bytes(data[p:p+4], "little")
                flag = data[p+4]
                step = tick / STEP_TICKS + 1
                print(f"\n  Note {n+1}/{count}: tick={tick} (4B, step {step:.1f}), flag=0x{flag:02X}")
                p += 5
            else:
                print(f"\n  Note {n+1}/{count}: [insufficient bytes at pos {p}]")
                break
            current_tick = tick
        else:
            tick = current_tick
            step = tick / STEP_TICKS + 1 if tick is not None else "?"
            print(f"\n  Note {n+1}/{count}: CHORD CONTINUATION (same tick={tick}, step {step})")

        # Gate
        if p >= len(data):
            print(f"  [EOF at gate position]")
            break

        if data[p] == 0xF0:
            if p + 4 <= len(data):
                print(f"    Gate: DEFAULT (F0 00 00 01)")
                p += 4
                note_info['gate'] = 'default'
            else:
                print(f"    [insufficient bytes for default gate]")
                break
        else:
            if p + 5 <= len(data):
                gate_val = int.from_bytes(data[p:p+4], "little")
                gate_term = data[p+4]
                print(f"    Gate: EXPLICIT {gate_val} ticks ({gate_val/STEP_TICKS:.2f} steps), term=0x{gate_term:02X}")
                p += 5
                note_info['gate'] = gate_val
            else:
                print(f"    [insufficient bytes for explicit gate at pos {p}]")
                break

        # Note + velocity
        if p + 2 > len(data):
            print(f"    [insufficient bytes for note/vel]")
            break
        midi = data[p]
        vel = data[p+1]
        print(f"    Note: {midi} ({note_name(midi)}), Velocity: {vel}")
        p += 2

        note_info.update({'tick': tick, 'note': midi, 'vel': vel})
        notes_parsed.append(note_info)

        # Trailing bytes
        if is_last:
            if p + 2 <= len(data):
                trail = data[p:p+2]
                print(f"    Trail: {trail.hex(' ')} (LAST note, 2 bytes)")
                p += 2
            else:
                remaining = data[p:]
                print(f"    Trail: {remaining.hex(' ')} (last note, {len(remaining)} bytes)")
                p += len(remaining)
            has_tick = True  # doesn't matter, no next note
        else:
            if p + 3 <= len(data):
                trail = data[p:p+3]
                continuation = trail[2]
                if continuation == 0x00:
                    desc = "NEXT has 4-byte tick (different step)"
                elif continuation == 0x01:
                    desc = "NEXT has 4-byte tick (variant 0x01 — TBD)"
                elif continuation == 0x04:
                    desc = "CHORD CONTINUATION (next note same tick, NO tick field)"
                elif continuation == 0x05:
                    desc = "CHORD CONTINUATION (variant 0x05 — TBD)"
                else:
                    desc = f"UNKNOWN continuation 0x{continuation:02X}"

                print(f"    Trail: {trail.hex(' ')} (non-last) => {desc}")
                p += 3

                # Set has_tick for next iteration
                if continuation in (0x04, 0x05):
                    has_tick = False
                else:
                    has_tick = True
            else:
                remaining = data[p:]
                print(f"    Trail: {remaining.hex(' ')} (non-last, {len(remaining)} bytes)")
                p += len(remaining)
                has_tick = True

    if p == len(data):
        print(f"\n  >>> ALL {len(data)} BYTES PARSED SUCCESSFULLY <<<")
    elif p < len(data):
        print(f"\n  *** UNPARSED {len(data)-p} bytes at pos {p}: {data[p:].hex(' ')} ***")
    else:
        print(f"\n  *** OVERRUN: parsed {p} bytes but data is only {len(data)} ***")

    return notes_parsed


def main():
    baseline = XYProject.from_bytes(load(f"{BASE}/unnamed 1.xy"))

    # ========== SINGLE-NOTE REFERENCES ==========
    print("\n" + "#"*70)
    print("# SINGLE-NOTE REFERENCES")
    print("#"*70)

    # unnamed 2: single T1 step 1
    proj2 = XYProject.from_bytes(load(f"{BASE}/unnamed 2.xy"))
    ev2 = extract_event(baseline, proj2, 0)
    if ev2:
        parse_event(ev2, "unnamed 2: Single C4, T1, step 1, default gate")

    # unnamed 81: single T1 step 9
    proj81 = XYProject.from_bytes(load(f"{BASE}/unnamed 81.xy"))
    ev81 = extract_event(baseline, proj81, 0)
    if ev81:
        parse_event(ev81, "unnamed 81: Single C4, T1, step 9, default gate")

    # unnamed 93: single T3 step 1 (MIDI recorded)
    proj93 = XYProject.from_bytes(load(f"{BASE}/unnamed 93.xy"))
    ev93_t3 = extract_event(baseline, proj93, 2)
    if ev93_t3:
        parse_event(ev93_t3, "unnamed 93 T3: Single C4, step 1, explicit gate 480")

    # ========== CHORD FILES ==========
    print("\n\n" + "#"*70)
    print("# CHORD FILES")
    print("#"*70)

    # unnamed 3: C-E-G triad, T1, step 1
    proj3 = XYProject.from_bytes(load(f"{BASE}/unnamed 3.xy"))
    ev3 = extract_event(baseline, proj3, 0)
    if ev3:
        parse_event(ev3, "unnamed 3: C-E-G chord, T1, step 1 (grid-entered)")

    # unnamed 94 T3: MIDI chord C4+E4+G4
    proj94 = XYProject.from_bytes(load(f"{BASE}/unnamed 94.xy"))
    ev94_t3 = extract_event(baseline, proj94, 2)
    if ev94_t3:
        parse_event(ev94_t3, "unnamed 94 T3: C4+E4+G4 chord (MIDI-recorded)")

    # unnamed 94 T1: 2 single notes
    ev94_t1 = extract_event(baseline, proj94, 0)
    if ev94_t1:
        parse_event(ev94_t1, "unnamed 94 T1: 2 notes at different steps")

    # unnamed 94 T5: single note
    ev94_t5 = extract_event(baseline, proj94, 4)
    if ev94_t5:
        parse_event(ev94_t5, "unnamed 94 T5: Single note")

    # unnamed 94 T7: single note
    ev94_t7 = extract_event(baseline, proj94, 6)
    if ev94_t7:
        parse_event(ev94_t7, "unnamed 94 T7: Single note at step 9")

    # unnamed 80: 3 singles + 3-note chord
    proj80 = XYProject.from_bytes(load(f"{BASE}/unnamed 80.xy"))
    ev80 = extract_event(baseline, proj80, 0)
    if ev80:
        parse_event(ev80, "unnamed 80: 3 singles (steps 1/5/9) + chord at step 13, T1")

    # ========== COMPARISON TABLE ==========
    print("\n\n" + "#"*70)
    print("# TRAILING BYTE ANALYSIS")
    print("#"*70)

    # Examine all trailing byte values across all events
    print(f"\n  Collecting all trail[2] (continuation byte) values:\n")
    all_events = [
        ("unnamed 2 T1", ev2),
        ("unnamed 81 T1", ev81),
        ("unnamed 93 T3", ev93_t3),
        ("unnamed 3 T1", ev3),
        ("unnamed 94 T3", ev94_t3),
        ("unnamed 94 T1", ev94_t1),
        ("unnamed 80 T1", ev80),
    ]

    for name, ev in all_events:
        if not ev or len(ev) < 2:
            continue
        count = ev[1]
        if count == 1:
            print(f"  {name:20s}: count={count}, no continuation bytes (single note)")
            continue

        # Quick scan of continuation bytes
        conts = []
        p = 2
        for n in range(count):
            is_last = (n == count - 1)
            has_tick_field = (n == 0) or (len(conts) > 0 and conts[-1] not in (0x04, 0x05))

            # Skip tick
            if has_tick_field:
                if p + 3 <= len(ev) and ev[p] == 0 and ev[p+1] == 0 and ev[p+2] == 0x02:
                    p += 3
                elif p + 5 <= len(ev):
                    p += 5
                else:
                    break

            # Skip gate
            if p < len(ev) and ev[p] == 0xF0:
                p += 4
            else:
                p += 5

            # Skip note + vel
            p += 2

            # Trail
            if is_last:
                p += 2
            else:
                if p + 3 <= len(ev):
                    cont_byte = ev[p + 2]
                    conts.append(cont_byte)
                    p += 3
                else:
                    break

        cont_strs = [f"0x{c:02X}" for c in conts]
        print(f"  {name:20s}: count={count}, continuation bytes: [{', '.join(cont_strs)}]")

    # ========== NOW VERIFY: unnamed 3 ==========
    print("\n\n" + "#"*70)
    print("# DETAILED: unnamed 3 chord with continuation byte hypothesis")
    print("#"*70)

    if ev3:
        d = ev3
        print(f"\n  Raw: {d.hex(' ')}")
        print(f"  Type: 0x{d[0]:02X}, Count: {d[1]}")

        # Note 1: tick=0 (2B), flag=02, gate=explicit, note, vel, trail with cont=0x04
        print(f"\n  Note 1:")
        print(f"    [2-3]   00 00     tick=0 (2B)")
        print(f"    [4]     02        flag=0x02")
        print(f"    [5-9]   {d[5]:02X} {d[6]:02X} {d[7]:02X} {d[8]:02X} {d[9]:02X}  gate={int.from_bytes(d[5:9], 'little')} ticks ({int.from_bytes(d[5:9], 'little')/480:.2f} steps), term={d[9]:02X}")
        print(f"    [10]    {d[10]:02X}        note={d[10]} ({note_name(d[10])})")
        print(f"    [11]    {d[11]:02X}        vel={d[11]}")
        print(f"    [12-14] {d[12]:02X} {d[13]:02X} {d[14]:02X}  trail, continuation=0x{d[14]:02X}")

        if d[14] == 0x04:
            print(f"    => 0x04 = CHORD CONTINUATION, next note has NO tick field")
        elif d[14] == 0x05:
            print(f"    => 0x05 = CHORD CONTINUATION (variant), next note has NO tick field")

        # Note 2: NO tick field (chord continuation)
        print(f"\n  Note 2 (chord continuation, no tick):")
        p2 = 15
        gate2 = int.from_bytes(d[p2:p2+4], "little")
        print(f"    [{p2}-{p2+4}]  {d[p2]:02X} {d[p2+1]:02X} {d[p2+2]:02X} {d[p2+3]:02X} {d[p2+4]:02X}  gate={gate2} ticks ({gate2/480:.2f} steps), term={d[p2+4]:02X}")
        p2 += 5
        print(f"    [{p2}]    {d[p2]:02X}        note={d[p2]} ({note_name(d[p2])})")
        print(f"    [{p2+1}]    {d[p2+1]:02X}        vel={d[p2+1]}")
        p2 += 2
        print(f"    [{p2}-{p2+2}] {d[p2]:02X} {d[p2+1]:02X} {d[p2+2]:02X}  trail, continuation=0x{d[p2+2]:02X}")

        cont2 = d[p2+2]
        if cont2 == 0x04:
            print(f"    => 0x04 = CHORD CONTINUATION")
        elif cont2 == 0x05:
            print(f"    => 0x05 = CHORD CONTINUATION (variant)")
        elif cont2 == 0x00:
            print(f"    => 0x00 = NEXT note has 4-byte tick")
        p2 += 3

        # Note 3: depends on continuation byte
        is_chord_cont = cont2 in (0x04, 0x05)
        print(f"\n  Note 3 ({'chord continuation' if is_chord_cont else '4-byte tick'}):")

        if not is_chord_cont:
            tick3 = int.from_bytes(d[p2:p2+4], "little")
            flag3 = d[p2+4]
            print(f"    [{p2}-{p2+3}] {d[p2]:02X} {d[p2+1]:02X} {d[p2+2]:02X} {d[p2+3]:02X}  tick={tick3}")
            print(f"    [{p2+4}]    {d[p2+4]:02X}        flag=0x{flag3:02X}")
            p2 += 5
        else:
            print(f"    (no tick field)")

        # Gate
        gate3 = int.from_bytes(d[p2:p2+4], "little")
        print(f"    [{p2}-{p2+4}] {d[p2]:02X} {d[p2+1]:02X} {d[p2+2]:02X} {d[p2+3]:02X} {d[p2+4]:02X}  gate={gate3} ticks ({gate3/480:.2f} steps), term={d[p2+4]:02X}")
        p2 += 5
        print(f"    [{p2}]    {d[p2]:02X}        note={d[p2]} ({note_name(d[p2])})")
        print(f"    [{p2+1}]    {d[p2+1]:02X}        vel={d[p2+1]}")
        p2 += 2
        print(f"    [{p2}-{p2+1}] {d[p2]:02X} {d[p2+1]:02X}     trail (LAST note)")
        p2 += 2

        print(f"\n  Parsed {p2}/{len(d)} bytes")
        if p2 == len(d):
            print(f"  >>> ALL BYTES ACCOUNTED FOR <<<")

    # ========== DETAILED: unnamed 80 ==========
    print("\n\n" + "#"*70)
    print("# DETAILED: unnamed 80 with continuation byte hypothesis")
    print("#"*70)

    if ev80:
        d = ev80
        print(f"\n  Raw ({len(d)} bytes): {d.hex(' ')}")
        print(f"  Type: 0x{d[0]:02X}, Count: {d[1]}")

        # Parse using the hypothesis
        p = 2
        has_tick = True

        for n in range(d[1]):
            is_last = (n == d[1] - 1)

            if has_tick:
                if d[p] == 0 and d[p+1] == 0 and p+2 < len(d) and d[p+2] == 0x02:
                    tick = 0
                    print(f"\n  Note {n+1}/{d[1]}: tick=0 (2B), flag=0x02")
                    p += 3
                else:
                    tick = int.from_bytes(d[p:p+4], "little")
                    flag = d[p+4]
                    print(f"\n  Note {n+1}/{d[1]}: tick={tick} (step {tick/480+1:.0f}), flag=0x{flag:02X}")
                    p += 5
            else:
                print(f"\n  Note {n+1}/{d[1]}: CHORD CONT (same tick)")

            # Gate
            if d[p] == 0xF0:
                print(f"    Gate: DEFAULT")
                p += 4
            else:
                gv = int.from_bytes(d[p:p+4], "little")
                print(f"    Gate: {gv} ticks ({gv/480:.2f} steps), term=0x{d[p+4]:02X}")
                p += 5

            # Note + vel
            print(f"    Note: {d[p]} ({note_name(d[p])}), Vel: {d[p+1]}")
            p += 2

            # Trail
            if is_last:
                print(f"    Trail: {d[p]:02X} {d[p+1]:02X} (LAST)")
                p += 2
            else:
                cont = d[p+2]
                print(f"    Trail: {d[p]:02X} {d[p+1]:02X} {d[p+2]:02X} (continuation=0x{cont:02X})")
                p += 3
                has_tick = cont not in (0x04, 0x05)

        print(f"\n  Parsed {p}/{len(d)} bytes")
        if p == len(d):
            print(f"  >>> ALL BYTES ACCOUNTED FOR <<<")
        else:
            print(f"  *** MISMATCH: {len(d)-p} bytes remaining ***")

    # ========== LOOK AT TRAIL BYTE MEANING MORE CAREFULLY ==========
    print("\n\n" + "#"*70)
    print("# CONTINUATION BYTE MEANING ANALYSIS")
    print("#"*70)

    if ev80:
        # unnamed 80 has singles at step 1, 5, 9 and chord at 13
        # So:
        # Note 1 (step 1) -> Note 2 (step 5): different step, trail[2] = ?
        # Note 2 (step 5) -> Note 3 (step 9): different step, trail[2] = ?
        # Note 3 (step 9) -> Note 4 (step 13, chord note 1): different step, trail[2] = ?
        # Note 4 (step 13) -> Note 5 (step 13, chord note 2): SAME step, trail[2] = ?
        # Note 5 (step 13) -> Note 6 (step 13, chord note 3): SAME step, trail[2] = ?
        # Note 6 (step 13): LAST, 2-byte trail

        # From the raw parse above, let's extract continuation bytes
        # We need to re-parse just to get the continuation bytes
        d = ev80
        p = 2
        has_tick = True
        for n in range(d[1]):
            is_last = (n == d[1] - 1)
            if has_tick:
                if d[p] == 0 and d[p+1] == 0 and p+2 < len(d) and d[p+2] == 0x02:
                    tick = 0
                    p += 3
                else:
                    tick = int.from_bytes(d[p:p+4], "little")
                    p += 5
            if d[p] == 0xF0:
                p += 4
            else:
                p += 5
            p += 2  # note+vel
            if is_last:
                p += 2
            else:
                cont = d[p+2]
                p += 3
                has_tick = cont not in (0x04, 0x05)

    # ========== SUMMARY ==========
    print("\n\n" + "#"*70)
    print("# FINAL SUMMARY")
    print("#"*70)

    print("""
  CHORD ENCODING IN OP-XY .xy FORMAT:

  1. HEADER: Same as single-note events
     - Byte 0: event type (0x25 for T1, 0x21 for T2+, etc.)
     - Byte 1: TOTAL note count (includes all chord notes individually)

  2. NOTE ENCODING: Each note has the standard fields:
     - Tick:     2 bytes if tick=0 (00 00); 4 bytes otherwise (u32 LE)
     - Flag:     1 byte (0x02 for tick=0, 0x00 otherwise)
     - Gate:     4 bytes default (F0 00 00 01) or 5 bytes explicit (u32_LE + 00)
     - Note:     1 byte MIDI
     - Velocity: 1 byte

  3. TRAILING BYTES (the key to chord encoding):
     - LAST note:     2 bytes: 00 00
     - NON-LAST note: 3 bytes: 00 00 XX
       where XX is a CONTINUATION BYTE:
         0x00 = next note has a TICK FIELD (different timestep)
         0x01 = next note has a TICK FIELD (variant — meaning TBD)
         0x04 = CHORD: next note at SAME tick, NO tick field
         0x05 = CHORD: next note at SAME tick, NO tick field (variant — meaning TBD)

  4. CHORD NOTE LAYOUT (no tick field):
     When continuation byte is 0x04/0x05, the next note omits both
     the tick field AND the flag byte. It starts directly with the gate.

  5. NOTE ORDER:
     - Sequential notes: ascending by tick position
     - Chord notes (same tick): appears to be descending by pitch
       (unnamed 94 T3: G4, E4, C4; unnamed 3: C4, G4, E4)
       Actually, order may vary.

  6. SIZES:
     - Single note at tick=0 with default gate:    13 bytes total
     - Single note at tick>0 with default gate:     15 bytes total
     - Single note at tick=0 with explicit gate:    14 bytes total
     - Chord note (continuation) with default gate: 9 bytes (last) / 10 bytes (non-last)
     - Chord note (continuation) with explicit gate: 10 bytes (last) / 11 bytes (non-last)
""")


if __name__ == "__main__":
    main()
