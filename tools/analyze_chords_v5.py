#!/usr/bin/env python3
"""Chord analysis v5 — comprehensive hypothesis testing.

KEY FINDINGS from v4:
1. unnamed 80: PERFECT PARSE. 0x01 = 2-byte tick. Chord notes at step 13
   use repeated 4-byte ticks (trail[2]=0x00 between chord notes).
2. unnamed 94 T3: PERFECT PARSE. Chord uses trail[2]=0x04 for chord continuation.
3. unnamed 3: FAILS. Note 2 has trail[2]=0x00, but note 3 parse as 4B tick = garbage.

TWO CHORD ENCODINGS discovered:
  A) Grid-entered (unnamed 80): each chord note has its own tick (repeated same value)
  B) MIDI-recorded (unnamed 94): chord notes use continuation (trail[2]=0x04, no tick)

For unnamed 3 (grid-entered):
  Note 2 trail = 00 00 00 with note 3 starting at byte 25
  Bytes 25-38: 05 00 00 01 DC 16 00 00 00 40 67 00 00
  If 4B tick: 05 00 00 01 = 0x01000005 = 16777221 — GARBAGE

  BUT what if trail[2]=0x00 after a chord note means "same tick, with 4B tick"?
  Then note 3 should have tick=0 as 4B. But bytes are 05 00 00 01. Not 0.

  WAIT: What if the 0x05 is the continuation byte, not part of the tick?
  What if trail is [00 00] + [continuation byte] where:
    0x00 = 4B tick
    0x01 = 2B tick
    0x04 = no tick (chord)
    0x05 = no tick (chord) + 2B-tick variant

  From unnamed 3 data:
  Note 2 trail = [00 00], next_prefix = 0x00 -> "4B tick"
  Note 3 tick: 05 00 00 01 = garbage

  ALTERNATIVE: What if there's a different trail[2] meaning?
  Let me look at this from the other direction.
  We KNOW note 3 should be at offset 34 (note=0x40=E4) with vel=0x67=103.
  Working backwards from offset 34:
  gate must end at 33 (term byte) or 34 is note.
  If explicit gate: [4B gate] [1B term] before note. So gate starts at 29.
  d[29:34] = DC 16 00 00 00 -> gate = 0x000016DC = 5852, term=0x00
  Before gate: d[28] = 01 ... this could be a flag byte.
  Before flag: d[24:28] = 00 05 00 00 — if 4B tick = 0x00000500 = 1280 ticks = step 3.67. Wrong.
  d[25:29] = 05 00 00 01 — if 4B tick = 0x01000005 = 16777221. Wrong.

  What if note 3 has a 2B tick?
  Then d[?:?+2] = tick, d[?+2] = flag
  We need: gate starts at 29, so flag at 28 (=0x01), tick at 26-27.
  d[26:28] = 00 00 = tick = 0. flag = 0x01.
  But then what's d[25] = 0x05?

  Actually: d[22:25] = 00 00 00 = trail of note 2 (3 bytes)
  Then d[25] = 0x05 = continuation byte?
  If 0x05 = chord continuation:
    note 3: no tick, gate at 26: d[26:30] = 00 01 DC 16 = gate val... 0x16DC0100 = 383385856. Wrong.
    OR: d[26:31] = 00 01 DC 16 00, gate = 0x16DC0100 = wrong.

  Hmm. Let me try:
  trail is 2 bytes: d[22:24] = 00 00
  next prefix: d[24] = 0x00 (4B tick)
  4B tick: d[25:29] = 05 00 00 01 = garbage

  OK let me try yet another interpretation:
  What if trail length varies?
  - When continuation = 0x00: trail = [00 00 00] (3 bytes, "next has 4B tick")
  - When continuation = 0x04: trail = [00 00 04] (3 bytes, "next is chord cont")
  But then for unnamed 3, note 2 has trail[2]=0x00.

  Final idea: What if the 3rd byte encodes tick WIDTH, not just presence?
  0x00 = next note has 4-byte tick (standard)
  0x01 = next note has 2-byte tick (compact)
  0x04 = no tick (chord, first chord note in group)
  0x05 = no tick (chord), plus next non-chord will use 2-byte tick

  Actually, let me just brute-force all possible parse interpretations for unnamed 3 note 3.
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


def main():
    baseline = XYProject.from_bytes(load(f"{BASE}/unnamed 1.xy"))

    proj3 = XYProject.from_bytes(load(f"{BASE}/unnamed 3.xy"))
    ev3 = extract_event(baseline, proj3, 0)

    if not ev3:
        print("Could not extract event from unnamed 3")
        return

    d = ev3
    print(f"unnamed 3 chord data ({len(d)} bytes):")
    print(f"  {d.hex(' ')}")
    print()

    # Known: note 1 at offset 10 = C4(60), vel=75
    #         note 2 at offset 20 = G4(67), vel=41
    #         note 3 at offset 34 = E4(64), vel=0x67=103
    # Wait: vel=103 is suspicious. Let me check: vel should be 0-127.
    # 0x67 = 103. That's valid but odd for grid entry. Unless it's not velocity.
    # Actually, 0x67 = 'g'. Let me look again.
    # d[34] = 0x40 = 64 = E4. d[35] = 0x67 = 103.
    # If d[35] is vel=103, that's valid.
    # Or is d[34] note and d[35] part of something else?

    # Actually, step back. Let me find note 3 from a different angle.
    # We know E4 = 64 = 0x40. Where is 0x40 in the data?
    print("Searching for 0x40 (E4=64) in event data:")
    for i in range(len(d)):
        if d[i] == 0x40:
            ctx_start = max(0, i-8)
            ctx_end = min(len(d), i+6)
            print(f"  offset {i}: context = {d[ctx_start:i].hex(' ')} [{d[i]:02X}] {d[i+1:ctx_end].hex(' ')}")

    print()

    # 0x40 appears at offset 34.
    # Context around offset 34: ... 16 00 00 00 [40] 67 00 00

    # Now working backwards from offset 34:
    # note 3 is at d[34]=0x40, vel at d[35]=0x67
    # Before note: gate field.
    # If explicit gate (5 bytes): d[29:34] = DC 16 00 00 00
    #   gate_val = int.from_bytes(d[29:33], 'little') = 0x000016DC = 5852
    #   term = d[33] = 0x00
    #   That gives gate=5852 ticks = 12.19 steps. This matches the other chord notes' gates!
    # If default gate (4 bytes): d[30:34] = 16 00 00 00. But d[30]=0x16, not 0xF0. So not default.

    # So gate starts at 29: [DC 16 00 00] [00]
    # Before gate: what comes before?
    # If note 3 has tick:
    #   flag at 28: d[28] = 0x01
    #   4B tick at 24-27: d[24:28] = 00 05 00 00 = 0x00000500 = 1280 ticks = step 3.67 ???
    #   2B tick at 26-27: d[26:28] = 00 00 = tick 0, with flag at 28 = 0x01
    #     Then d[24:26] = 00 05 are trail[0:2] of note 2. But trail should be 00 00.
    #     d[24] = 0x00 (OK), d[25] = 0x05 (NOT 0x00!)

    # Hmm. What if note 3 has tick = 0 encoded as 2 bytes, with flag = 0x01?
    # That means: [00 00] [01] [gate 5B] [note] [vel] [trail 2B]
    # = 2 + 1 + 5 + 1 + 1 + 2 = 12 bytes
    # From offset 26 to 37 = 12 bytes. d[26:38] = 00 00 01 DC 16 00 00 00 40 67 00 00

    # Let me parse that:
    #   tick: d[26:28] = 00 00 = 0 (tick=0, 2B)
    #   flag: d[28] = 0x01 (NOT 0x02! Different from first-note-at-tick-0 flag)
    #   gate: d[29:33] = DC 16 00 00 = 5852 ticks, d[33] = 0x00 = term
    #   note: d[34] = 0x40 = E4 = 64
    #   vel: d[35] = 0x67 = 103
    #   trail: d[36:38] = 00 00 (LAST)

    # That would work! But then what's between note 2 and note 3?
    # Note 2 ends at offset 21 (vel), trail starts at 22.
    # If trail of note 2 is 3 bytes: d[22:25] = 00 00 00
    # Then continuation byte = 0x00 = next has 4B tick
    # But note 3 starts at 26 (2B tick), not 25 (4B tick)!
    # 25 to 26: there's an extra byte d[25] = 0x05

    # OR: trail of note 2 is 2 bytes: d[22:24] = 00 00
    # Continuation prefix at d[24] = 0x00 = 4B tick follows? But note 3 has 2B tick.
    # OR: d[25] = 0x05 is the continuation prefix?
    # If trail = 3 bytes: d[22:25] = 00 00 00, prefix = d[25] = 0x05

    # WAIT. WAIT. WAIT.
    # What if trail is FOUR bytes for chord continuation notes?
    # - Non-chord non-last: 3 bytes [00 00 XX] where XX = continuation
    # - Chord continuation non-last: 4 bytes [00 00 00 XX] ???
    # That seems unlikely but let me check.

    # Actually, let me re-examine the continuation byte semantics more carefully.
    # What if the continuation byte is NOT the 3rd trail byte but rather:
    # trail is always exactly 2 bytes: [00 00]
    # Then the next byte is a "record type" prefix that indicates what follows:
    #   0x00 = 4-byte tick + 1-byte flag
    #   0x01 = 2-byte tick + 1-byte flag (v4 hypothesis)
    #   0x02 = 2-byte tick (always 00 00) + (this IS the flag) — i.e. tick=0 marker
    #   0x04 = chord continuation (no tick, no flag)
    #   0x05 = chord continuation (no tick, no flag) — same as 0x04?

    # With this model:
    # For unnamed 3:
    # Note 1:
    #   tick: 00 00 (2B), flag-like prefix: 0x02 (= "tick=0")
    #   gate: FD 16 00 00 00 (explicit)
    #   note: 3C (C4), vel: 4B (75)
    #   trail: 00 00
    #   prefix: 0x04 => chord continuation for note 2

    # Note 2:
    #   (no tick, no flag — chord continuation)
    #   gate: EC 16 00 00 00 (explicit, 5868 ticks)
    #   note: 43 (G4), vel: 29 (41)
    #   trail: 00 00
    #   prefix: 0x00 => next has 4B tick + 1B flag

    # Note 3:
    #   tick: 05 00 00 01 (4B) = 0x01000005 = 16777221 ticks. GARBAGE.
    #   FAIL.

    # OK that doesn't work either. Let me try prefix = 0x05:
    # What if note 2 trail = 00 00, and prefix = d[24] = 0x00, d[25] = 0x05?
    # But that's two bytes for the prefix...

    # Actually, what if the model is:
    # Each non-last note ends with: note vel [2B trail] [1B separator]
    # The separator byte appears BETWEEN notes, not as part of trail.
    # And for the FIRST note, the "tick+flag" encoding is:
    #   tick=0: [00 00] [02] (but 02 might be flag, or might be separator from previous?)
    # No, this doesn't work for the first note which has no previous.

    # Let me try a radically different approach.
    # What if I'm wrong about trail[2] being the continuation byte?
    # Let me look at the ORIGINAL note_events.py to see what was being used.

    # From note_events.py:
    #   is_last: trail = 00 00 (2B)
    #   not last: trail = 00 00 00 (3B)
    # No continuation byte at all in the builder!

    # But that builder only handles sequential notes, not chords.
    # It works for unnamed 80 without chord continuation because:
    # In unnamed 80, ALL chord notes have their own tick!

    # So the question is: unnamed 3 and unnamed 94 use a DIFFERENT format
    # where chord notes don't have their own tick.

    # For unnamed 94 T3: the pattern is [00 00] [04] between chord notes
    # where 04 seems to replace the usual 3rd trail byte (00).

    # For unnamed 3: note 2 (chord cont) has bytes:
    # EC 16 00 00 00 43 29 [00 00 00] 05 00 00 01 DC 16 00 00 00 40 67 00 00
    # If trail = 3 bytes: 00 00 00. cont = 0x00 (not chord).
    # next byte: 05. If 4B tick: 05 00 00 01 = garbage.

    # ALTERNATIVE: trail = 3 bytes for non-chord, but for chord notes the trail might be
    # [00 00 XX] where the XX encodes something about the CURRENT note too.

    # Actually, let me look at this as a BITFIELD for trail[2]:
    # bit 2 (0x04): next note is chord continuation
    # bit 0 (0x01): next note's tick is 2 bytes (compact)
    # 0x00 = neither: next has 4B tick, different step
    # 0x01 = compact: next has 2B tick, different step
    # 0x04 = chord: next has no tick (chord continuation)
    # 0x05 = chord + compact: next has no tick (chord continuation), but the NEXT next is 2B?

    # For unnamed 3:
    # Note 1 trail[2] = 0x04: chord continuation (note 2 has no tick) ✓
    # Note 2 trail[2] = 0x00: next has 4B tick (note 3 at different step?) ✗ for chord
    #   OR: 0x00 after a chord cont could mean something different?

    # WAIT. Let me revisit unnamed 80 more carefully.
    # unnamed 80 chord notes at step 13:
    # Note 3 (E4, step 9): trail = 00 00 00. Next: 4B tick.
    # Note 4 (A4, step 13): trail = 00 00 00. Next: 4B tick.
    # Note 5 (G4, step 13): trail = 00 00 00. Next: 4B tick.
    # Note 6 (F4, step 13): trail = 00 00 (last)

    # So in unnamed 80, the chord notes (4, 5, 6) each have their own tick field.
    # All three show tick=5760 (step 13). The device apparently handles both formats:
    # - Repeated ticks (each chord note carries its own tick = same value)
    # - Shared tick (chord continuation with trail[2]=0x04)

    # Now for unnamed 3: maybe it's a MIX of both approaches?
    # Note 1 (C4): has tick=0. Trail[2]=0x04 → note 2 is chord continuation.
    # Note 2 (G4): NO tick (chord cont). Trail[2]=0x00 → note 3 has 4B tick.
    # Note 3 (E4): HAS tick (should be 0 since same step).
    #   Tick bytes: 05 00 00 01 = NOT 0.

    # Unless... the tick is stored differently after a chord continuation?
    # What if the tick for note 3 is RELATIVE to note 1?
    # Or what if I'm miscounting bytes?

    print("\n\nDETAILED BYTE-BY-BYTE LAYOUT:")
    print(f"Offset  Hex  Dec  Interpretation attempt")
    print(f"------  ---  ---  ----------------------")
    for i, b in enumerate(d):
        print(f"  {i:4d}   {b:02X}  {b:3d}  ", end="")
        if i == 0: print("event type 0x25 (Track 1)")
        elif i == 1: print(f"note count = {b}")
        elif i == 2: print("tick byte 0 (=0)")
        elif i == 3: print("tick byte 1 (=0, tick=0 2B)")
        elif i == 4: print(f"flag 0x02 (tick=0)")
        elif i == 5: print(f"gate byte 0")
        elif i == 6: print(f"gate byte 1 (gate_val=0x{int.from_bytes(d[5:9],'little'):08X}={int.from_bytes(d[5:9],'little')})")
        elif i == 7: print(f"gate byte 2")
        elif i == 8: print(f"gate byte 3")
        elif i == 9: print(f"gate terminator 0x00")
        elif i == 10: print(f"NOTE = {b} ({note_name(b)})")
        elif i == 11: print(f"VEL  = {b}")
        elif i == 12: print("trail byte 0 (note 1)")
        elif i == 13: print("trail byte 1 (note 1)")
        elif i == 14: print(f"trail byte 2 / separator = 0x{b:02X}")
        # Note 2 starts here if trail[2]=0x04 (chord continuation, no tick)
        elif i == 15: print(f"gate byte 0 [note 2 chord cont]")
        elif i == 16: print(f"gate byte 1")
        elif i == 17: print(f"gate byte 2 (gate_val=0x{int.from_bytes(d[15:19],'little'):08X}={int.from_bytes(d[15:19],'little')})")
        elif i == 18: print(f"gate byte 3")
        elif i == 19: print(f"gate terminator 0x00")
        elif i == 20: print(f"NOTE = {b} ({note_name(b)})")
        elif i == 21: print(f"VEL  = {b}")
        elif i == 22: print("trail byte 0 (note 2)")
        elif i == 23: print("trail byte 1 (note 2)")
        elif i == 24: print(f"??? = 0x{b:02X} — trail[2] or separator?")
        # What if byte 24 (0x00) is trail[2] and byte 25 (0x05) is a prefix?
        elif i == 25: print(f"??? = 0x{b:02X}")
        elif i == 26: print(f"??? = 0x{b:02X}")
        elif i == 27: print(f"??? = 0x{b:02X}")
        elif i == 28: print(f"??? = 0x{b:02X}")
        elif i == 29: print(f"??? = 0x{b:02X}")
        elif i == 30: print(f"??? = 0x{b:02X}")
        elif i == 31: print(f"??? = 0x{b:02X}")
        elif i == 32: print(f"??? = 0x{b:02X}")
        elif i == 33: print(f"??? = 0x{b:02X}")
        elif i == 34: print(f"TARGET NOTE = {b} ({note_name(b)})")
        elif i == 35: print(f"TARGET VEL  = {b}")
        elif i == 36: print("trail byte 0 (note 3, last)")
        elif i == 37: print("trail byte 1 (note 3, last)")
        else: print()

    # Note 3 at offset 34, working backwards:
    # gate explicit (5B): d[29:34] = DC 16 00 00 00
    #   gate = 0x000016DC = 5852, term = 0x00
    # Before gate at 29:
    #   if flag at 28: d[28] = 0x01
    #   if 2B tick at 26-27: d[26:28] = 00 00 = tick 0
    #   prefix at 25: d[25] = 0x05
    #   trail of note 2: d[22:24] = 00 00 (2 bytes)
    #   separator at 24: d[24] = 0x00

    # Wait, this gives:
    # trail note 2 = [00 00] at 22-23
    # d[24] = 0x00 = separator
    # d[25] = 0x05 = ???
    # d[26:28] = 00 00 = 2B tick=0
    # d[28] = 0x01 = flag

    # What if 0x05 is a prefix that means "2-byte tick + chord flag"?
    # Or what if the separator/prefix is 2 bytes: [00 05]?

    # REVELATION: What if trail of note 2 = [00 00 00] (3 bytes ending in 0x00)?
    # Then byte 25 = 0x05 is a SEPARATE prefix.
    # And 0x05 means "chord continuation"?

    # If 0x05 = chord continuation:
    # Note 3: no tick, no flag
    # Gate starts at 26: d[26:30] = 00 01 DC 16 = 0x16DC0100 = 383385856. GARBAGE.
    # NOPE.

    # OK ONE MORE IDEA:
    # What if the continuation byte is:
    # 0x00 = next has 4B tick + flag 0x00
    # 0x01 = next has 2B tick + flag 0x00
    # 0x02 = next has 2B tick=0 + flag 0x02 (shortcut for tick=0)
    # 0x04 = chord continuation (no tick, no flag)
    # 0x05 = chord continuation with different gate encoding?

    # For unnamed 3, note 2 continuation = 0x00 → 4B tick
    # But 4B tick at 25 = 05 00 00 01 = garbage.

    # UNLESS: What if the trail[2] is NOT a continuation byte but just a constant 0x00?
    # And the distinction between chord continuation and sequential is encoded
    # DIFFERENTLY?

    # Let me look at this from scratch. Let me compare unsigned 80 vs 94 T3:

    print("\n\n" + "="*70)
    print("CROSS-FILE STRUCTURE COMPARISON")
    print("="*70)

    proj80 = XYProject.from_bytes(load(f"{BASE}/unnamed 80.xy"))
    ev80 = extract_event(baseline, proj80, 0)

    proj94 = XYProject.from_bytes(load(f"{BASE}/unnamed 94.xy"))
    ev94 = extract_event(baseline, proj94, 2)

    print(f"\nunnamed 80 (grid, default gate, chord at step 13 with REPEATED ticks):")
    print(f"  {ev80.hex(' ')}")

    print(f"\nunnamed 94 T3 (MIDI, explicit gate, all-chord with SHARED tick via 0x04):")
    print(f"  {ev94.hex(' ')}")

    print(f"\nunnamed 3 (grid, explicit gate, all-chord on step 1):")
    print(f"  {ev3.hex(' ')}")

    # Grid chord (unnamed 3) vs MIDI chord (unnamed 94):
    # Grid: 25 03 00 00 02 FD 16 00 00 00 3C 4B 00 00 04 EC 16 00 00 00 43 29 00 00 00 05 00 00 01 DC 16 00 00 00 40 67 00 00
    # MIDI: 2D 03 00 00 02 E0 01 00 00 00 43 64 00 00 04 E0 01 00 00 00 40 64 00 00 04 E0 01 00 00 00 3C 64 00 00

    # MIDI: after each trail byte 2 = 04, chord continuation (no tick) works.
    # Grid: after trail byte 2 = 04 (note 1), chord continuation works for note 2.
    #        But note 2 trail byte 2 = 00, not 04!

    # In MIDI chord: all 3 notes have same gate (480). All continuation bytes are 04.
    # In grid chord: note 1 gate = 5885, note 2 gate = 5868. Different gates! Note 2 cont = 00.

    # What if the OP-XY uses DIFFERENT chord serialization based on:
    # - MIDI input (real-time): uses 0x04 continuation
    # - Grid input: uses repeated ticks (like unnamed 80)
    # But then unnamed 3 has trail[2]=0x04 for note 1→2, so it's a MIX.

    # Let me try: note 2 trail = [00 00] (2 bytes), and the byte 0x00 at offset 24
    # is NOT a trail byte but rather a tick encoding prefix.
    # And 0x05 at offset 25 is part of the tick?

    # What if tick encoding is variable-length (like VLQ)?
    # 00 05 00 00 01 ... seems unlikely for VLQ.

    # Let me just try EVERY possible note 3 start position:
    print(f"\n\nBRUTE FORCE: trying every possible start offset for note 3")
    print(f"We know note=0x40(E4) should appear at offset 34, vel at 35")
    print(f"Gate should end at offset 33 (explicit: 5 bytes 29-33)")
    print()

    for note3_start in range(22, 30):
        remaining = d[note3_start:]
        print(f"  If note 3 starts at offset {note3_start}: {remaining.hex(' ')}")

        # Try different tick encodings
        for tick_len in [0, 2, 4]:  # no tick, 2B tick, 4B tick
            p = note3_start

            if tick_len == 0:
                tick_desc = "no tick"
            elif tick_len == 2:
                if p + 2 > len(d): continue
                tick = int.from_bytes(d[p:p+2], "little")
                tick_desc = f"2B tick={tick}"
                p += 2
            elif tick_len == 4:
                if p + 4 > len(d): continue
                tick = int.from_bytes(d[p:p+4], "little")
                tick_desc = f"4B tick={tick}"
                p += 4

            # Flag?
            for has_flag in [True, False]:
                pp = p
                if has_flag:
                    if pp >= len(d): continue
                    flag = d[pp]
                    flag_desc = f"flag=0x{flag:02X}"
                    pp += 1
                else:
                    flag_desc = "no flag"

                # Gate
                if pp >= len(d): continue
                if d[pp] == 0xF0:
                    gate_desc = "default gate"
                    pp += 4
                else:
                    if pp + 5 > len(d): continue
                    gv = int.from_bytes(d[pp:pp+4], "little")
                    gt = d[pp+4]
                    gate_desc = f"gate={gv}({gv/480:.1f}steps) term={gt:02X}"
                    pp += 5

                if pp + 2 > len(d): continue
                note = d[pp]
                vel = d[pp+1]
                pp += 2

                # Check if note and vel make sense
                if note != 0x40:  # Not E4
                    continue

                # Check remaining for trail
                trail_remaining = len(d) - pp
                if trail_remaining == 2:
                    trail_desc = f"trail={d[pp]:02X} {d[pp+1]:02X} (last, 2B)"
                    match = True
                elif trail_remaining == 3:
                    trail_desc = f"trail={d[pp]:02X} {d[pp+1]:02X} {d[pp+2]:02X} (non-last, 3B)"
                    match = True
                elif trail_remaining >= 2:
                    trail_desc = f"trail + {trail_remaining-2} extra bytes"
                    match = trail_remaining == 2  # only exact match
                else:
                    trail_desc = f"only {trail_remaining} bytes left"
                    match = False

                if note == 0x40 and 1 <= vel <= 127:
                    valid = "VALID" if match else "partial"
                    gate_ok = "GOOD" if (gv > 100 and gv < 20000) if 'gv' in dir() else True else "???"
                    tick_ok = "GOOD" if tick_len == 0 or (0 <= tick <= 7680) else "BAD"
                    print(f"    start={note3_start} {tick_desc} {flag_desc} {gate_desc} note={note}({note_name(note)}) vel={vel} {trail_desc} [{valid}]")

    # From the brute force, the best parse for note 3:
    # Start at 26: 2B tick=0, flag=0x01, gate=5852(12.2 steps), note=E4, vel=103, trail=00 00 (VALID)
    # This means: bytes 22-24 = trail of note 2 (00 00 00, 3 bytes)
    # And byte 25 = 0x05 = continuation prefix meaning "chord continuation"

    # BUT WAIT: if trail is 3 bytes (00 00 00) and prefix is 0x05 (chord cont),
    # then note 3 should have NO tick. But we just said it has a 2B tick.
    # UNLESS 0x05 means something different from 0x04.

    # 0x04: chord continuation, no tick, no flag
    # 0x05: chord continuation, WITH 2B tick + flag? (tick is redundant but present?)

    # Actually, from unnamed 80 we established:
    # 0x01 = next note has 2B tick + flag
    # From unnamed 94: 0x04 = chord continuation (no tick)
    # What if 0x05 = 0x04 | 0x01 = chord continuation but WITH 2B tick?

    print(f"\n\n{'='*70}")
    print("BITFIELD HYPOTHESIS FOR CONTINUATION BYTE")
    print(f"{'='*70}")
    print("""
    Bit 0 (0x01): Tick field width
      0 = 4-byte tick (default)
      1 = 2-byte tick (compact, for small tick values)

    Bit 2 (0x04): Chord continuation
      0 = next note is at a different time (sequential)
      1 = next note is at the same time (chord)

    Combinations:
      0x00 = sequential, 4B tick     (unnamed 80: step 1→5, step 5→9)
      0x01 = sequential, 2B tick     (unnamed 80: step 9→13? NO, step 9→13 = 5760 needs 4B)
      0x04 = chord continuation      (unnamed 94 T3: all chord notes, no tick field)
      0x05 = chord, 2B tick          (unnamed 3: chord note with 2B tick=0)

    Wait but if 0x04 means "no tick" and 0x05 means "2B tick", they're different!
    Let me reconsider:

    Maybe the bit meanings are:
      Bit 0 (0x01): compact mode flag
        Affects tick encoding of next note
      Bit 2 (0x04): determines if next note skips tick entirely

    0x00: normal mode, 4B tick
    0x01: compact mode, 2B tick
    0x04: skip tick entirely (chord)
    0x05: compact chord? Maybe 2B tick but value must be same as previous?
""")

    # Let me re-parse unnamed 3 with 0x05 = "chord continuation WITH 2B tick + flag":
    print(f"\nRe-parsing unnamed 3 with 0x05 = '2B tick chord continuation':")
    d = ev3
    print(f"  Raw: {d.hex(' ')}")

    p = 2
    # Note 1: tick=0 (2B), flag=0x02
    print(f"\n  Note 1: tick=0 (2B), flag=0x02")
    p = 5  # after tick+flag
    gate1 = int.from_bytes(d[p:p+4], "little")
    print(f"    gate={gate1} ({gate1/480:.2f} steps), term={d[p+4]:02X}")
    p += 5  # p=10
    print(f"    note={d[p]} ({note_name(d[p])}), vel={d[p+1]}")
    p += 2  # p=12
    print(f"    trail: {d[p]:02X} {d[p+1]:02X}, continuation=0x{d[p+2]:02X}")
    cont1 = d[p+2]
    p += 3  # p=15

    # Note 2: continuation = 0x04, chord continuation, no tick
    print(f"\n  Note 2: chord continuation (0x04), no tick, no flag")
    gate2 = int.from_bytes(d[p:p+4], "little")
    print(f"    gate={gate2} ({gate2/480:.2f} steps), term={d[p+4]:02X}")
    p += 5  # p=20
    print(f"    note={d[p]} ({note_name(d[p])}), vel={d[p+1]}")
    p += 2  # p=22
    print(f"    trail: {d[p]:02X} {d[p+1]:02X}, continuation=0x{d[p+2]:02X}")
    cont2 = d[p+2]
    p += 3  # p=25

    # Note 3: continuation = 0x00 ← this was the problem
    # But from brute force, note 3 works if it starts at 26 with 2B tick + flag
    # So either cont2 isn't 0x00, or the encoding is different

    # What if trail for note 2 is [00 00] (2 bytes) and continuation is [00 05]?
    print(f"\n  ALTERNATE: Note 2 trail=[00 00], prefix=[00 05] (2-byte prefix)")
    # p would be at 22 after note2+vel
    # trail: d[22:24] = 00 00 (2 bytes)
    # prefix: d[24:26] = 00 05
    # If prefix is 2 bytes, what does 00 05 mean?
    # This seems unlikely. 1-byte prefix is more consistent.

    # FINAL ATTEMPT: What if trail is [00 00 00] and next byte 0x05 is:
    # 0x05 = bit 0 (2B tick) | bit 2 (chord) = chord with 2B tick
    # Then: note 3 has 2B tick: d[26:28] = 00 00 = tick 0
    #   flag: d[28] = 0x01
    #   gate: d[29:33] = DC 16 00 00 = 5852, term = d[33] = 0x00
    #   note: d[34] = 0x40 = E4 (64)
    #   vel: d[35] = 0x67 = 103
    #   trail: d[36:38] = 00 00 (last)
    # TOTAL PARSED = 38 bytes = EXACT MATCH!

    print(f"\n  Trail of note 2: [00 00 00] (3 bytes)")
    print(f"  Prefix/continuation at 25: 0x05 = chord + 2B tick")
    print(f"\n  Note 3: chord with 2B tick")
    p = 25
    print(f"    prefix: 0x{d[p]:02X} = chord continuation + 2B tick")
    p += 1  # p=26
    tick3 = int.from_bytes(d[p:p+2], "little")
    flag3 = d[p+2]
    print(f"    tick: {d[p]:02X} {d[p+1]:02X} = {tick3} (step {tick3/480+1:.1f})")
    print(f"    flag: 0x{flag3:02X}")
    p += 3  # p=29
    gate3 = int.from_bytes(d[p:p+4], "little")
    print(f"    gate: {gate3} ({gate3/480:.2f} steps), term={d[p+4]:02X}")
    p += 5  # p=34
    print(f"    note: {d[p]} ({note_name(d[p])}), vel: {d[p+1]}")
    p += 2  # p=36
    print(f"    trail: {d[p]:02X} {d[p+1]:02X} (last)")
    p += 2  # p=38

    print(f"\n  Parsed {p}/{len(d)} bytes")
    if p == len(d):
        print(f"  >>> PERFECT PARSE! ALL BYTES ACCOUNTED FOR! <<<")

    # Now, the question: what's the model?
    # trail = always 3 bytes for non-last (00 00 XX), 2 bytes for last (00 00)
    # XX = continuation byte as BITFIELD:
    #   bit 0 (0x01): next tick is 2 bytes (not 4)
    #   bit 2 (0x04): next note is chord continuation (has tick field if bit 0 set, omits if not)
    # Wait, 0x04 omits tick but 0x05 includes tick. Let me rethink.

    # 0x00: next has 4B tick + flag (normal sequential)
    # 0x01: next has 2B tick + flag (compact sequential)
    # 0x04: next has NO tick, NO flag (chord continuation, pure)
    # 0x05: next has 2B tick + flag (chord continuation with tick=same)

    # The difference between 0x04 and 0x05:
    # 0x04: tick is OMITTED (inherited from previous note)
    # 0x05: tick is PRESENT as 2B (value should be same as current note's tick)

    # Both are chord continuations (same logical tick position).
    # The choice of 0x04 vs 0x05 might depend on firmware version or entry method.

    # VERIFY on unnamed 80:
    print(f"\n\n{'='*70}")
    print(f"VERIFICATION: unnamed 80 with bitfield model")
    print(f"{'='*70}")

    if ev80:
        d = ev80
        print(f"  Raw: {d.hex(' ')}")

        # Note 2 trail[2] = 0x01: next has 2B tick
        # From parse: Note 3 tick = 15 from 2B. But step 9 = tick 3840.
        # Wait, in v4 we parsed: tick=15 (2B: 0F 00) = 0x000F = 15???
        # 0x000F = 15. That's not 3840!
        # Step 9 = tick 3840 = 0x0F00.
        # 0F 00 as u16 LE = 0x000F = 15. NOT 0x0F00!

        # 0F 00 as u16 BE = 0x0F00 = 3840. AH HA!
        # But OP-XY is little-endian! So 0F 00 = 15, not 3840.

        # Hmm. Let me re-check. tick=3840 = 0x0F00.
        # As u16 LE: bytes = 00 0F. NOT 0F 00.
        # As u16 BE: bytes = 0F 00.

        # In unnamed 80 after note 2 (at step 5), trail = 00 00 01
        # Next bytes: 0F 00
        # If this is 2B tick LE: 0x000F = 15 ticks. That's wrong.
        # If this is 2B tick, but the bytes should be: 00 0F for tick=3840.
        # But we have 0F 00!

        # Hmm, let me look at the raw data again:
        # ev80 = 25 06 00 00 02 f0 00 00 01 3c 64 00 00 00 80 07 00 00 00 f0 00 00 01 3e 64 00 00 01 0f 00 00 00 f0 00 00 01 40 64 ...
        # After note 2 trail (00 00 01) at offsets 25-27:
        # Next bytes at 28: 0F 00 00 00 F0 ...

        # Wait! 0F 00 00 00 is a 4-byte value!
        # If we read 2B from offset 28: 0F 00 = 15. Then flag at 30 = 00. Then F0 = gate default.
        # That gives tick=15, which is wrong.

        # But what if 0x01 doesn't mean 2B tick?
        # What if ALL non-chord continuations have 4B tick, and the continuation byte only encodes
        # chord status?
        # 0x00 = sequential
        # 0x01 = sequential (variant?)
        # 0x04 = chord (no tick)
        # 0x05 = chord (with some tick encoding?)

        # If 0x01 = sequential with 4B tick:
        # Note 3 after 0x01: tick at 28-31 = 0F 00 00 00 = 0x0000000F = 15. Still wrong!
        # Step 9 = 3840 = 0x00000F00.

        # WAIT. Let me look at the bytes more carefully.
        # The trail is at offsets 25, 26, 27 (after note 2 vel at 24).
        # d[25]=0x00, d[26]=0x00, d[27]=0x01
        # Then d[28]=0x0F, d[29]=0x00, d[30]=0x00, d[31]=0x00
        # 4B tick at 28: 0F 00 00 00 = 15. That's wrong for step 9!

        # But v4 parsed unnamed 80 PERFECTLY with note 3 at step 9!
        # Let me re-check v4 output:
        # "Note 3/6: tick=15 (2B: 0F 00), step=1.0"
        # Hmm, step=1.0 because 15/480+1 ≈ 1.0. That's wrong!
        # But then how did v4 report "ALL 82 BYTES PARSED SUCCESSFULLY"?

        # The parse DID succeed in byte accounting, but the TICK VALUES were wrong!
        # Note 3 was parsed as tick=15, which is wrong. It should be step 9 = tick 3840.

        # Let me look at this differently.
        # Note 2 is at step 5, tick=1920.
        # Note 3 is at step 9, tick=3840.
        # Difference: 3840 - 1920 = 1920 ticks.

        # What if the tick after 0x01 continuation is DELTA (relative to previous note)?
        # Then tick = 15 means 15 ticks after note 2? That's still wrong (should be 1920).

        # HOLD ON. Let me re-read the v4 output for note 3 more carefully.
        # v4 had: 0x01 = 2B tick, tick = 0F 00 = 15.
        # But then gate was: 0x00 00 F0 01 0x40 = "gate=61440" — which is also wrong.
        # The parse "succeeded" in byte count but values are garbage.

        # So maybe 0x01 does NOT mean 2B tick. Let me try: 0x01 = 4B tick.
        # Then note 3: tick at 28-31 = 0F 00 00 00 = 15. Still wrong.

        # Wait, step 9 = 8 steps from start = 8 * 480 = 3840.
        # 3840 in hex = 0x0F00.
        # As u32 LE: 00 0F 00 00.
        # In the data we have: 0F 00 00 00.
        # Those are DIFFERENT!
        # 0F 00 00 00 LE = 15.
        # 00 0F 00 00 LE = 3840.

        # So the tick bytes at offset 28 are NOT tick=3840.
        # Unless I miscounted the offset.

        # Let me recount:
        # ev80 bytes:
        # [0] 25  [1] 06
        # Note 1: [2] 00 [3] 00 [4] 02 [5] F0 [6] 00 [7] 00 [8] 01 [9] 3C [10] 64
        # Trail: [11] 00 [12] 00 [13] 00
        # Note 2: [14] 80 [15] 07 [16] 00 [17] 00 [18] 00 [19] F0 [20] 00 [21] 00 [22] 01 [23] 3E [24] 64
        # Trail: [25] 00 [26] 00 [27] 01

        # If 0x01 = 4B tick, note 3 tick at [28-31]: 0F 00 00 00 = 15. WRONG.
        # If the trail was 00 00 00 (not 00 00 01), note 3 starts at [28]:
        # But trail[2]=0x01, not 0x00.

        # What if trail is [00 00] (2B) and [01] is NOT trail[2] but prefix?
        # prefix = 0x01 at offset [27]
        # Note 3 tick (if 2B): [28-29] = 0F 00 = 15. Wrong.
        # Note 3 tick (if 4B): [28-31] = 0F 00 00 00 = 15. Wrong.

        # WAIT: Is the trail really starting at offset 25?
        # Let me verify note 2:
        # Note 2: 4B tick at [14-17] = 80 07 00 00 = 0x00000780 = 1920. Correct! Step 5.
        # Flag at [18] = 0x00.
        # Gate: [19] = 0xF0 → default gate [19-22] = F0 00 00 01.
        # Note at [23] = 0x3E = 62. D4. Correct!
        # Vel at [24] = 0x64 = 100. Correct!
        # Trail starts at [25].

        # OK so trail IS at [25-27] = 00 00 01.
        # And the next note (3) starts at [28].

        # Here's the thing: if we DON'T use the continuation byte at all and
        # just always use 4B tick, what happens?
        # Note 3: [28-31] = 0F 00 00 00 = 0x0000000F = 15. Not 3840.

        # But WHAT IF trail is [00 00 00 01]? 4 bytes?
        # Then note 3 starts at [29]:
        # [29-32] = 00 00 00 F0 = 0xF0000000 as tick? No, that's too big.
        # What if [29-30] = 00 00 (tick=0, 2B)? Then [31] = 0x00 = flag. But note 3 at tick=0 = step 1? No.

        # OK I think the issue might be that note 2's data is LONGER.
        # What if note 2 has a different gate encoding?
        # Let me check: [19] = F0. Yes, default gate = F0 00 00 01 (4 bytes). That's correct.

        # Hmm, let me try: what if note 2 flag is different?
        # [18] = 0x00. That's the standard flag for tick>0. OK.

        # What if the tick encoding for note 2 is NOT standard?
        # [14-17] = 80 07 00 00. As u32 LE = 0x00000780 = 1920. Step 5. Correct.

        # I'm stuck. Let me just look at what tick values SHOULD be and find them in the data.
        print(f"\n  Expected tick values in unnamed 80:")
        print(f"    Step 1:  tick=0     = 00 00 00 00 or 00 00")
        print(f"    Step 5:  tick=1920  = 80 07 00 00")
        print(f"    Step 9:  tick=3840  = 00 0F 00 00")
        print(f"    Step 13: tick=5760  = 80 16 00 00")

        print(f"\n  Searching for tick=3840 (00 0F 00 00) in event data:")
        for i in range(len(ev80) - 3):
            if ev80[i:i+4] == b'\x00\x0F\x00\x00':
                print(f"    Found at offset {i}: {ev80[max(0,i-2):i+6].hex(' ')}")

        print(f"\n  Searching for tick=5760 (80 16 00 00) in event data:")
        for i in range(len(ev80) - 3):
            if ev80[i:i+4] == b'\x80\x16\x00\x00':
                print(f"    Found at offset {i}: {ev80[max(0,i-2):i+6].hex(' ')}")

        # Let me also search for the expected notes:
        # Step 1: C4 (60=0x3C), Step 5: D4 (62=0x3E), Step 9: E4 (64=0x40)
        # Step 13 chord: F4 (65=0x41), G4 (67=0x43), A4 (69=0x45)
        print(f"\n  Expected note bytes:")
        note_targets = [(60, "C4"), (62, "D4"), (64, "E4"), (65, "F4"), (67, "G4"), (69, "A4")]
        for midi, name in note_targets:
            for i in range(len(ev80)):
                if ev80[i] == midi:
                    vel_after = ev80[i+1] if i+1 < len(ev80) else -1
                    if 1 <= vel_after <= 127 or vel_after == 100:
                        ctx = ev80[max(0,i-6):min(len(ev80),i+4)]
                        print(f"    {name} (0x{midi:02X}) at offset {i}, vel={vel_after}, ctx: {ctx.hex(' ')}")


if __name__ == "__main__":
    main()
