#!/usr/bin/env python3
"""Chord analysis v4 — figure out the exact trailing byte semantics.

From v3 we know:
  - unnamed 94 T3 (MIDI chord): trail[2]=0x04 means chord continuation. PERFECT PARSE.
  - unnamed 3 (grid chord): trail[2]=0x04 on note 1 works, but note 2 has trail=00 00 00
    which we interpreted as "next note has 4B tick" — but note 3 parse failed.
  - unnamed 80: trail[2]=0x01 after note 2 breaks the parse entirely.

KEY QUESTION: What if the trail[2] value encodes something more nuanced?
Let's look at the raw bits more carefully.

New hypothesis: trail byte encodes a BIT FIELD:
  bit 2 (0x04): chord continuation (no tick field on next note)
  bit 0 (0x01): ???
  bit 4 (0x10): ???
  0x05 = 0x04 | 0x01: chord continuation + something

OR: What if the 3-byte trail is not [00 00 XX] but rather
  [XX 00 00] where XX is always 00 for non-last notes,
  and the separation between notes is different?

Let me try yet another approach: What if the third trail byte encodes
how the NEXT note's tick is stored?
  0x00: 4-byte tick follows  (next note at different step)
  0x01: 2-byte tick follows? (next note has 2-byte tick?)
  0x04: no tick follows      (chord continuation)
  0x05: ???

Wait — unnamed 80 note 2 has trail 00 00 01, and note 3 should be
at step 9 = tick 3840 = 0x0F00. If trail[2]=0x01 means "2-byte tick",
then: 0F 00 = 3840. That would work! Let me test this.
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


def parse_event_v4(data, label=""):
    """Parse event with new hypothesis about trail byte encoding next tick format.

    Trail byte encoding (non-last notes: 3 bytes total):
      00 00 00: next note has 4-byte tick
      00 00 01: next note has 2-byte tick (u16 LE)
      00 00 04: next note has no tick (chord continuation)
      00 00 05: next note has no tick, 2-byte-tick-compatible (chord cont + 0x01?)

    For notes with a tick field:
      - 2-byte tick (when preceded by trail[2]=0x01): u16 LE, flag byte follows
      - 4-byte tick (when preceded by trail[2]=0x00): u32 LE, flag byte follows
      - Special case: first note with tick=0 uses 2-byte (00 00) + flag 0x02

    For chord continuation notes (preceded by trail[2]=0x04 or 0x05):
      - No tick field, no flag byte
      - Starts directly with gate
    """
    if label:
        print(f"\n{'='*70}")
        print(f"  {label}")
        print(f"{'='*70}")
        print(f"  Raw ({len(data)} bytes): {data.hex(' ')}")

    if len(data) < 2:
        print("  [too short]")
        return

    etype = data[0]
    count = data[1]
    print(f"  Event type: 0x{etype:02X}")
    print(f"  Note count: {count}")

    p = 2
    # First note always starts with tick
    # tick_mode: 'first' for the first note, '4B' for 4-byte, '2B' for 2-byte,
    #            'chord' for no tick, 'chord2' for chord+2B variant
    tick_mode = 'first'

    for n in range(count):
        is_last = (n == count - 1)

        if tick_mode == 'chord' or tick_mode == 'chord2':
            print(f"\n  Note {n+1}/{count}: CHORD CONTINUATION (no tick field)")
        elif tick_mode == 'first':
            # First note: check for tick=0 (2B)
            if p + 3 <= len(data) and data[p] == 0 and data[p+1] == 0 and data[p+2] == 0x02:
                tick = 0
                flag = 0x02
                print(f"\n  Note {n+1}/{count}: tick=0 (2B: 00 00), flag=0x02")
                p += 3
            elif p + 5 <= len(data):
                tick = int.from_bytes(data[p:p+4], "little")
                flag = data[p+4]
                print(f"\n  Note {n+1}/{count}: tick={tick} (4B), step={tick/480+1:.1f}, flag=0x{flag:02X}")
                p += 5
            else:
                print(f"\n  Note {n+1}/{count}: [insufficient bytes at {p}]")
                break
        elif tick_mode == '2B':
            if p + 3 <= len(data):
                tick = int.from_bytes(data[p:p+2], "little")
                flag = data[p+2]
                print(f"\n  Note {n+1}/{count}: tick={tick} (2B: {data[p]:02X} {data[p+1]:02X}), step={tick/480+1:.1f}, flag=0x{flag:02X}")
                p += 3
            else:
                print(f"\n  Note {n+1}/{count}: [insufficient bytes for 2B tick at {p}]")
                break
        elif tick_mode == '4B':
            if p + 5 <= len(data):
                tick = int.from_bytes(data[p:p+4], "little")
                flag = data[p+4]
                print(f"\n  Note {n+1}/{count}: tick={tick} (4B), step={tick/480+1:.1f}, flag=0x{flag:02X}")
                p += 5
            else:
                print(f"\n  Note {n+1}/{count}: [insufficient bytes for 4B tick at {p}]")
                break

        # Gate
        if p >= len(data):
            print(f"    [EOF at gate]")
            break

        if data[p] == 0xF0:
            if p + 4 <= len(data):
                print(f"    Gate: DEFAULT (F0 00 00 01)")
                p += 4
            else:
                print(f"    [EOF in default gate]")
                break
        else:
            if p + 5 <= len(data):
                gv = int.from_bytes(data[p:p+4], "little")
                gt = data[p+4]
                print(f"    Gate: {gv} ticks ({gv/480:.2f} steps), term=0x{gt:02X}")
                p += 5
            else:
                print(f"    [insufficient bytes for explicit gate at {p}]")
                break

        # Note + velocity
        if p + 2 > len(data):
            print(f"    [EOF at note/vel]")
            break
        midi = data[p]
        vel = data[p+1]
        print(f"    Note: {midi} ({note_name(midi)}), Vel: {vel}")
        p += 2

        # Trail
        if is_last:
            if p + 2 <= len(data):
                print(f"    Trail: {data[p]:02X} {data[p+1]:02X} (LAST)")
                p += 2
            elif p < len(data):
                print(f"    Trail: {data[p:].hex(' ')} (LAST, {len(data)-p} bytes)")
                p = len(data)
        else:
            if p + 3 <= len(data):
                t0, t1, t2 = data[p], data[p+1], data[p+2]
                if t2 == 0x00:
                    desc = "next: 4-byte tick"
                    tick_mode = '4B'
                elif t2 == 0x01:
                    desc = "next: 2-byte tick (HYPOTHESIS)"
                    tick_mode = '2B'
                elif t2 == 0x04:
                    desc = "CHORD CONT (no tick)"
                    tick_mode = 'chord'
                elif t2 == 0x05:
                    desc = "CHORD CONT variant (no tick)"
                    tick_mode = 'chord2'
                else:
                    desc = f"UNKNOWN 0x{t2:02X}"
                    tick_mode = '4B'  # default fallback
                print(f"    Trail: {t0:02X} {t1:02X} {t2:02X} => {desc}")
                p += 3
            else:
                print(f"    Trail: {data[p:].hex(' ')} (non-last, {len(data)-p} bytes)")
                p = len(data)

    if p == len(data):
        print(f"\n  >>> ALL {len(data)} BYTES PARSED SUCCESSFULLY <<<")
    elif p < len(data):
        print(f"\n  *** UNPARSED {len(data)-p} bytes at pos {p}: {data[p:].hex(' ')} ***")
    else:
        print(f"\n  *** OVERRUN ***")


def main():
    baseline = XYProject.from_bytes(load(f"{BASE}/unnamed 1.xy"))

    # ===== REFERENCE: Single notes =====
    print("#"*70)
    print("# SINGLE-NOTE REFERENCES")
    print("#"*70)

    for name, path, tidx in [
        ("unnamed 2 T1", f"{BASE}/unnamed 2.xy", 0),
        ("unnamed 81 T1 (step 9)", f"{BASE}/unnamed 81.xy", 0),
        ("unnamed 93 T3", f"{BASE}/unnamed 93.xy", 2),
    ]:
        proj = XYProject.from_bytes(load(path))
        ev = extract_event(baseline, proj, tidx)
        if ev:
            parse_event_v4(ev, name)

    # ===== REFERENCE: Multi-note sequential =====
    print("\n\n" + "#"*70)
    print("# MULTI-NOTE SEQUENTIAL (no chords)")
    print("#"*70)

    proj94 = XYProject.from_bytes(load(f"{BASE}/unnamed 94.xy"))
    ev94_t1 = extract_event(baseline, proj94, 0)
    if ev94_t1:
        parse_event_v4(ev94_t1, "unnamed 94 T1: 2 sequential notes (MIDI)")

    # ===== CHORD: MIDI-recorded =====
    print("\n\n" + "#"*70)
    print("# MIDI-RECORDED CHORD")
    print("#"*70)

    ev94_t3 = extract_event(baseline, proj94, 2)
    if ev94_t3:
        parse_event_v4(ev94_t3, "unnamed 94 T3: C4+E4+G4 chord (MIDI)")

    # ===== CHORD: Grid-entered =====
    print("\n\n" + "#"*70)
    print("# GRID-ENTERED CHORD")
    print("#"*70)

    proj3 = XYProject.from_bytes(load(f"{BASE}/unnamed 3.xy"))
    ev3 = extract_event(baseline, proj3, 0)
    if ev3:
        parse_event_v4(ev3, "unnamed 3 T1: C-E-G chord (grid)")

    # ===== MIXED: Singles + Chord =====
    print("\n\n" + "#"*70)
    print("# MIXED: SINGLES + CHORD")
    print("#"*70)

    proj80 = XYProject.from_bytes(load(f"{BASE}/unnamed 80.xy"))
    ev80 = extract_event(baseline, proj80, 0)
    if ev80:
        parse_event_v4(ev80, "unnamed 80 T1: 3 singles (1/5/9) + chord at 13")

    # ===== ADDITIONAL: Check unnamed 3 note 2's trail interpretation =====
    print("\n\n" + "#"*70)
    print("# UNNAMED 3 DEEP DIVE")
    print("#"*70)

    if ev3:
        d = ev3
        print(f"\n  Full raw: {d.hex(' ')}")
        print(f"\n  The problem: note 2 trail = 00 00 00")
        print(f"  With '00' meaning '4B tick', note 3 starts at offset 25")
        print(f"  Bytes 25-28: {d[25]:02X} {d[26]:02X} {d[27]:02X} {d[28]:02X} = tick {int.from_bytes(d[25:29], 'little')}")
        print(f"  That tick is clearly wrong for a C-E-G chord where all notes are at step 1.\n")

        print(f"  ALTERNATIVE: What if note 2's trail is [00 00] (2 bytes, like last note)?")
        print(f"  Then note 2 is the last chord continuation note, and the remaining bytes")
        print(f"  starting at offset 24 belong to note 3 which starts a NEW step:")
        print(f"  Bytes from 24: {d[24:].hex(' ')}")
        print(f"  But that leaves: 00 05 00 00 01 DC 16 00 00 00 40 67 00 00")
        print(f"  If this is tick: 00 05 00 00 = tick 1280 (step 3.7) — wrong for step 1 chord\n")

        print(f"  ALTERNATIVE 2: What if continuation=0x04 only applies to ONE chord note?")
        print(f"  And the third byte of trail encodes something else?")
        print(f"  Note 1 trail: 00 00 04 — 04 means chord cont for note 2")
        print(f"  Note 2 trail: 00 00 00 — 00 means different step for note 3")
        print(f"  BUT note 3 is at the same step (all in a chord)!\n")

        print(f"  ALTERNATIVE 3: What if the continuation byte is a BITFIELD?")
        print(f"  0x04 = bit 2 = chord continuation (no tick)")
        print(f"  0x00 = no bits = has tick")
        print(f"  0x01 = bit 0 = ???")
        print(f"  0x05 = bit 2 + bit 0 = chord continuation + ???")
        print(f"\n  In unnamed 3, note 2 cont = 0x00 means note 3 HAS a tick field.")
        print(f"  But note 3 should be at same tick! Unless it's a 2-note chord + 1 separate...\n")

        print(f"  WAIT — Let me re-read the file description:")
        print(f"  unnamed 3.xy = 'C-E-G triad on step 1, Track 1 (grid-entered)'")
        print(f"  So all 3 notes SHOULD be at step 1.\n")

        print(f"  Let me check: what if note 2 trail = 00 00, and byte at 24 starts note 3?")
        print(f"  Note 1 trail = 00 00 04 (3 bytes, cont=04)")
        print(f"  Note 2 (chord, no tick): gate=EC 16 00 00, term=00")
        print(f"    gate_val = {int.from_bytes(d[15:19], 'little')} ticks = {int.from_bytes(d[15:19], 'little')/480:.2f} steps")
        print(f"    note = {d[20]} ({note_name(d[20])})")
        print(f"    vel = {d[21]}")
        print(f"    trail = 00 00 00 (3 bytes, 3rd = 0x00)")
        print(f"\n  So note 2 continuation byte = 0x00 = note 3 has 4-byte tick")
        print(f"  Note 3 tick bytes: {d[25]:02X} {d[26]:02X} {d[27]:02X} {d[28]:02X} = {int.from_bytes(d[25:29], 'little')}")
        print(f"  This is NOT 0. So either this isn't right, or the chord is actually")
        print(f"  only 2 notes at same tick and note 3 is at a different time.\n")

        # BUT WAIT: The file is described as C-E-G triad. Let me check if the notes
        # actually parse to C, E, G:
        print(f"  Checking note values from my parse:")
        print(f"  Note 1: offset 10 = 0x{d[10]:02X} = {d[10]} = {note_name(d[10])}, vel={d[11]}")
        print(f"  Note 2: offset 20 = 0x{d[20]:02X} = {d[20]} = {note_name(d[20])}, vel={d[21]}")

        # What if note 3 is at offset 34? Let me check
        # If parsing breaks but we know notes should be C(60), E(64), G(67):
        # We found: note1=60(C4), note2=67(G4), note3=?
        # note3 should be E(64)=0x40
        # Is 0x40 at offset 34? d[34] = 0x40! Yes!
        print(f"  Expected note 3 at offset 34: 0x{d[34]:02X} = {d[34]} = {note_name(d[34])}, vel={d[35]}")
        print(f"  So all three notes ARE C4, G4, E4 (order: C, G, E)")

        # So notes are at offsets 10, 20, 34
        # Between note 1 (off 10) and note 2 (off 20): 10 bytes gap
        # Between note 2 (off 20) and note 3 (off 34): 14 bytes gap
        # After note 3 (off 34): 34+2=36, trail=36-37 = 2 bytes

        # For note 2 (chord cont, no tick):
        # gate(5) + note(1) + vel(1) = 7 bytes
        # trail: 3 bytes
        # Total: 10. Gap = 20-10-2 = 8? No, gap 20-10 = 10, but we have note(1)+vel(1) at 10-11.
        # Let me recalculate:
        # note1 at 10, vel1 at 11, trail starts at 12: 12, 13, 14 (3 bytes)
        # note2 block starts at 15: gate 15-19 (5 bytes), note at 20, vel at 21
        # trail starts at 22: 22, 23, 24 (3 bytes)
        # note3 block starts at 25
        # If note3 has 4B tick: tick at 25-28, flag at 29
        # gate at 30-34, but d[30] could be start of 5-byte gate or 4-byte gate
        # note at 34 = 0x40 = 64 = E4, vel at 35 = 0x67 = 103
        # Hmm, vel=103 is plausible.

        # Wait, if gate starts at 30:
        # d[30:35] = DC 16 00 00 00 — that's gate = 0x000016DC = 5852 ticks, term=0x00
        # Then note at 35 = 0x40 = E4, vel at 36 = 0x67 = 103
        # trail at 37-38 = 00 00 (last note)
        # Total = 2 + (3+5+2+3) + (5+2+3) + (5+5+2+2) = 2+13+10+14 = 39. But data is 38!

        # Hmm. Off by 1. Let me try:
        # note3 has 4B tick: d[25:29] = 05 00 00 01 — tick = 0x01000005 = 16777221. WRONG.
        # OK this clearly doesn't work.

        # Let me try: what if note 2's trail is just 2 bytes (00 00),
        # NOT 3 bytes, because it's a CHORD LAST note?
        # Then byte at 24 = 00 starts note 3.
        # But what kind of encoding starts with 00?
        # If it's a 2-byte tick: 00 05 = 1280. Not right.
        # If it's a 4-byte tick: 00 05 00 00 = 1280. Not right.

        # ANOTHER IDEA: What if the trail[2] byte IS part of the next note's encoding?
        # So trail is always 2 bytes (00 00), and the "continuation byte" is actually
        # the first byte of the next note record?
        #
        # Layout would be:
        #   [note_data] [00 00] [next_note_prefix] [next_note_data] [00 00] ...
        #
        # The prefix byte would encode tick format:
        #   0x00 = 4-byte tick follows
        #   0x01 = 2-byte tick follows
        #   0x04 = no tick (chord continuation)
        #   0x05 = no tick (chord variant)

        print(f"\n  *** NEW HYPOTHESIS: Trail is ALWAYS 2 bytes (00 00) ***")
        print(f"  *** The 3rd byte is a PREFIX of the NEXT note, not part of the trail ***")
        print(f"  *** This prefix byte encodes the tick format of the next note ***")
        print(f"\n  Re-parsing unnamed 3 with this hypothesis:")

        p = 2
        for n in range(3):
            is_last = (n == 2)
            print(f"\n  Note {n+1}/3 at offset {p}:")

            if n == 0:
                # First note: starts with tick
                print(f"    tick: {d[p]:02X} {d[p+1]:02X} = 0 (2B)")
                print(f"    flag: {d[p+2]:02X} = 0x02")
                p += 3
            elif hasattr(main, f'_prefix_{n}'):
                pass  # placeholder

            # Gate
            if d[p] == 0xF0:
                print(f"    gate: DEFAULT")
                p += 4
            else:
                gv = int.from_bytes(d[p:p+4], "little")
                print(f"    gate: {gv} ticks ({gv/480:.2f} steps), term=0x{d[p+4]:02X}")
                p += 5

            # Note + vel
            print(f"    note: {d[p]} ({note_name(d[p])}), vel: {d[p+1]}")
            p += 2

            # Trail (always 2 bytes)
            print(f"    trail: {d[p]:02X} {d[p+1]:02X}")
            p += 2

            if not is_last:
                # Prefix byte for next note
                prefix = d[p]
                print(f"    next_prefix: 0x{prefix:02X}")
                p += 1

                if prefix == 0x04:
                    print(f"    => chord continuation (no tick for note {n+2})")
                elif prefix == 0x00:
                    print(f"    => 4-byte tick for note {n+2}")
                    # Read tick
                    tick = int.from_bytes(d[p:p+4], "little")
                    flag = d[p+4]
                    print(f"    tick: {tick}, flag: 0x{flag:02X}")
                    p += 5
                elif prefix == 0x01:
                    print(f"    => 2-byte tick for note {n+2}")
                    tick = int.from_bytes(d[p:p+2], "little")
                    flag = d[p+2]
                    print(f"    tick: {tick}, flag: 0x{flag:02X}")
                    p += 3
                elif prefix == 0x05:
                    print(f"    => chord continuation variant (no tick for note {n+2})")

        print(f"\n  Parsed {p}/{len(d)} bytes")
        if p == len(d):
            print(f"  >>> PERFECT PARSE <<<")

    # ===== TEST HYPOTHESIS ON UNNAMED 80 =====
    if ev80:
        d = ev80
        print(f"\n\n  Re-parsing UNNAMED 80 with new hypothesis:")
        print(f"  Raw: {d.hex(' ')}")

        p = 2
        count = d[1]
        for n in range(count):
            is_last = (n == count - 1)
            print(f"\n  Note {n+1}/{count} at offset {p}:")

            if n == 0:
                # First note
                if d[p] == 0 and d[p+1] == 0 and d[p+2] == 0x02:
                    print(f"    tick: 0 (2B), flag: 0x02")
                    p += 3
                else:
                    tick = int.from_bytes(d[p:p+4], "little")
                    print(f"    tick: {tick} (4B), flag: 0x{d[p+4]:02X}")
                    p += 5

            # Gate
            if p < len(d) and d[p] == 0xF0:
                print(f"    gate: DEFAULT")
                p += 4
            elif p + 5 <= len(d):
                gv = int.from_bytes(d[p:p+4], "little")
                print(f"    gate: {gv} ticks ({gv/480:.2f} steps), term=0x{d[p+4]:02X}")
                p += 5
            else:
                print(f"    [gate parse error at {p}]")
                break

            # Note + vel
            if p + 2 <= len(d):
                print(f"    note: {d[p]} ({note_name(d[p])}), vel: {d[p+1]}")
                p += 2
            else:
                print(f"    [note/vel parse error at {p}]")
                break

            # Trail (always 2 bytes)
            if p + 2 <= len(d):
                print(f"    trail: {d[p]:02X} {d[p+1]:02X}")
                p += 2
            else:
                print(f"    [trail parse error at {p}]")
                break

            if not is_last:
                # Prefix byte
                if p >= len(d):
                    print(f"    [EOF before prefix]")
                    break
                prefix = d[p]
                print(f"    next_prefix: 0x{prefix:02X}")
                p += 1

                if prefix == 0x00:
                    print(f"    => 4-byte tick")
                    if p + 5 <= len(d):
                        tick = int.from_bytes(d[p:p+4], "little")
                        flag = d[p+4]
                        print(f"    tick: {tick} (step {tick/480+1:.0f}), flag: 0x{flag:02X}")
                        p += 5
                    else:
                        print(f"    [insufficient bytes for 4B tick at {p}]")
                        break
                elif prefix == 0x01:
                    print(f"    => 2-byte tick")
                    if p + 3 <= len(d):
                        tick = int.from_bytes(d[p:p+2], "little")
                        flag = d[p+2]
                        print(f"    tick: {tick} (step {tick/480+1:.0f}), flag: 0x{flag:02X}")
                        p += 3
                    else:
                        print(f"    [insufficient bytes for 2B tick at {p}]")
                        break
                elif prefix == 0x04:
                    print(f"    => chord continuation (no tick)")
                elif prefix == 0x05:
                    print(f"    => chord continuation variant (no tick)")
                else:
                    print(f"    => UNKNOWN prefix 0x{prefix:02X}, trying as 4B tick")
                    if p + 5 <= len(d):
                        tick = int.from_bytes(d[p:p+4], "little")
                        flag = d[p+4]
                        print(f"    tick: {tick}, flag: 0x{flag:02X}")
                        p += 5

        print(f"\n  Parsed {p}/{len(d)} bytes")
        if p == len(d):
            print(f"  >>> PERFECT PARSE <<<")
        else:
            print(f"  *** {len(d)-p} bytes remaining ***")

    # ===== TEST ON unnamed 94 T3 (known good) =====
    if ev94_t3:
        d = ev94_t3
        print(f"\n\n  Re-parsing UNNAMED 94 T3 with new hypothesis:")
        print(f"  Raw: {d.hex(' ')}")

        p = 2
        count = d[1]
        for n in range(count):
            is_last = (n == count - 1)
            print(f"\n  Note {n+1}/{count} at offset {p}:")

            if n == 0:
                if d[p] == 0 and d[p+1] == 0 and d[p+2] == 0x02:
                    print(f"    tick: 0 (2B), flag: 0x02")
                    p += 3
                else:
                    tick = int.from_bytes(d[p:p+4], "little")
                    print(f"    tick: {tick} (4B), flag: 0x{d[p+4]:02X}")
                    p += 5

            # Gate
            if d[p] == 0xF0:
                print(f"    gate: DEFAULT")
                p += 4
            else:
                gv = int.from_bytes(d[p:p+4], "little")
                print(f"    gate: {gv} ticks ({gv/480:.2f} steps), term=0x{d[p+4]:02X}")
                p += 5

            print(f"    note: {d[p]} ({note_name(d[p])}), vel: {d[p+1]}")
            p += 2

            print(f"    trail: {d[p]:02X} {d[p+1]:02X}")
            p += 2

            if not is_last:
                prefix = d[p]
                print(f"    next_prefix: 0x{prefix:02X}")
                p += 1
                if prefix == 0x04:
                    print(f"    => chord continuation")
                elif prefix == 0x00:
                    tick = int.from_bytes(d[p:p+4], "little")
                    flag = d[p+4]
                    print(f"    => 4B tick: {tick}, flag: 0x{flag:02X}")
                    p += 5

        print(f"\n  Parsed {p}/{len(d)} bytes")
        if p == len(d):
            print(f"  >>> PERFECT PARSE <<<")

    # ===== TEST ON unnamed 94 T1 (2 sequential notes) =====
    if ev94_t1:
        d = ev94_t1
        print(f"\n\n  Re-parsing UNNAMED 94 T1 with new hypothesis:")
        print(f"  Raw: {d.hex(' ')}")

        p = 2
        count = d[1]
        for n in range(count):
            is_last = (n == count - 1)
            print(f"\n  Note {n+1}/{count} at offset {p}:")

            if n == 0:
                if d[p] == 0 and d[p+1] == 0 and d[p+2] == 0x02:
                    print(f"    tick: 0 (2B), flag: 0x02")
                    p += 3
                else:
                    tick = int.from_bytes(d[p:p+4], "little")
                    print(f"    tick: {tick} (4B), flag: 0x{d[p+4]:02X}")
                    p += 5

            # Gate
            if d[p] == 0xF0:
                print(f"    gate: DEFAULT")
                p += 4
            else:
                gv = int.from_bytes(d[p:p+4], "little")
                print(f"    gate: {gv} ticks ({gv/480:.2f} steps), term=0x{d[p+4]:02X}")
                p += 5

            print(f"    note: {d[p]} ({note_name(d[p])}), vel: {d[p+1]}")
            p += 2

            print(f"    trail: {d[p]:02X} {d[p+1]:02X}")
            p += 2

            if not is_last:
                prefix = d[p]
                print(f"    next_prefix: 0x{prefix:02X}")
                p += 1
                if prefix == 0x04:
                    print(f"    => chord continuation")
                elif prefix == 0x00:
                    tick = int.from_bytes(d[p:p+4], "little")
                    flag = d[p+4]
                    print(f"    => 4B tick: {tick} (step {tick/480+1:.0f}), flag: 0x{flag:02X}")
                    p += 5
                elif prefix == 0x01:
                    tick = int.from_bytes(d[p:p+2], "little")
                    flag = d[p+2]
                    print(f"    => 2B tick: {tick} (step {tick/480+1:.0f}), flag: 0x{flag:02X}")
                    p += 3

        print(f"\n  Parsed {p}/{len(d)} bytes")
        if p == len(d):
            print(f"  >>> PERFECT PARSE <<<")


if __name__ == "__main__":
    main()
