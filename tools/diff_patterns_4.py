#!/usr/bin/env python3
"""Final clarifications: handle table as 3-byte entries, preamble mechanism."""

import sys
sys.path.insert(0, '/Users/kevinmorrill/Documents/xy-format')

from xy.container import XYProject


def load(name):
    path = f'/Users/kevinmorrill/Documents/xy-format/src/one-off-changes-from-default/{name}'
    with open(path, 'rb') as f:
        raw = f.read()
    return raw, XYProject.from_bytes(raw)


def main():
    raw1, proj1 = load('unnamed 1.xy')
    raw6, proj6 = load('unnamed 6.xy')
    raw7, proj7 = load('unnamed 7.xy')

    # =========================================================================
    # 1: Handle table: re-examine as having variable layout
    # =========================================================================
    print('=' * 70)
    print('1: PRE-TRACK TABLE STRUCTURE HYPOTHESIS')
    print('=' * 70)

    # unnamed1: 0x56-0x57 = 00 00 (pat_max_slot=0)
    # Then 0x58 to 0x7B = all `ff 00 00` repeated (12 entries x 3 bytes = 36)
    # Total pre_track = 0x7C = 124

    # unnamed6: 0x56-0x57 = 01 00 (pat_max_slot=1)
    # Then 0x58 to 0x80 = 41 bytes
    # Structure: 5-byte pattern descriptor + 12 `xx 00 00` entries?

    # Let's look at what's REALLY at 0x58+ for unnamed6
    print('\n  unnamed6 raw 0x56 to 0x80 (hex with offset):')
    r = raw6
    for i in range(0x56, 0x81):
        if i % 16 == 0x56 % 16 or i == 0x56:
            print(f'  {i:04x}:', end='')
        print(f' {r[i]:02x}', end='')
        if (i - 0x56 + 1) % 16 == 0:
            print()
    print()

    # unnamed6 0x56-0x80:
    # 0056: 01 00  (pat_max_slot=1)
    # 0058: 00 1d  01  00 00  (5 bytes: one pattern entry)
    # 005d: ff 00 00  (entry 1)
    # 0060: ff 00 00  (entry 2)
    # 0063: ff 00 00  (entry 3)
    # 0066: ff 00 00  (entry 4)
    # 0069: ff 00 00  (entry 5)
    # 006c: ff 00 00  (entry 6)
    # 006f: ff 00 00  (entry 7)
    # 0072: ff 00 00  (entry 8)
    # 0075: ff 00 00  (entry 9)
    # 0078: ff 00 00  (entry 10)
    # 007b: ff 00 00  (entry 11)
    # 007e: ff 00 00  (entry 12)

    # Check: 5 + 12*3 = 5 + 36 = 41. 0x58 + 41 = 0x81. Matches pre_track size!

    # But unnamed7 also has pre_track 0x81. Let's check:
    print('\n  unnamed7 raw 0x56 to 0x80:')
    r = raw7
    for i in range(0x56, 0x81):
        if i % 16 == 0x56 % 16 or i == 0x56:
            print(f'  {i:04x}:', end='')
        print(f' {r[i]:02x}', end='')
        if (i - 0x56 + 1) % 16 == 0:
            print()
    print()

    # unnamed7 0x56-0x80:
    # Same pattern? pat_max_slot=2 but same pre_track size...
    # 0056: 02 00
    # 0058: 00 1d 01 00 00  (same 5-byte entry)
    # Then 12 entries of ff 00 00

    # So the 5-byte entry doesn't multiply with pat_max_slot!
    # It's a fixed 5-byte structure, not per-pattern.

    # =========================================================================
    # 2: What's the 5-byte entry? [00 1d 01 00 00]
    # =========================================================================
    print('\n' + '=' * 70)
    print('2: THE 5-BYTE PATTERN DESCRIPTOR AT 0x58')
    print('=' * 70)

    for name, raw in [('unnamed1', raw1), ('unnamed6', raw6), ('unnamed7', raw7)]:
        pat = int.from_bytes(raw[0x56:0x58], 'little')
        print(f'\n  {name}: pat_max_slot={pat}')
        if pat > 0:
            entry = raw[0x58:0x5d]
            print(f'    5-byte entry: {entry.hex(" ")}')
            # Various decodings:
            print(f'    As [u8 u16_LE u16_LE]: [{entry[0]:02x}] [{int.from_bytes(entry[1:3], "little"):04x}] [{int.from_bytes(entry[3:5], "little"):04x}]')
            print(f'    As [u16_LE u8 u16_LE]: [{int.from_bytes(entry[0:2], "little"):04x}] [{entry[2]:02x}] [{int.from_bytes(entry[3:5], "little"):04x}]')
            print(f'    As [u8 u8 u8 u16_LE]: [{entry[0]:02x}] [{entry[1]:02x}] [{entry[2]:02x}] [{int.from_bytes(entry[3:5], "little"):04x}]')

    # =========================================================================
    # 3: Preamble rotation summary — the T2 anomaly
    # =========================================================================
    print('\n' + '=' * 70)
    print('3: PREAMBLE MECHANISM SUMMARY')
    print('=' * 70)

    # Bodies rotate perfectly: unnamed6 T(N+1).body == unnamed1 T(N).body for N>=1
    # Preambles rotate from T3 onwards: unnamed6 T(N+1).preamble == unnamed1 T(N).preamble for N>=2
    # T2 is special: unnamed6 T2 gets 00 8a 10 f0 instead of unnamed1 T1's d6 01 10 f0
    # T1 gets a new preamble: b5 02 10 f0

    # The 0x00 byte in T2 preamble byte 0 — this is the 0x64 sentinel we already know about!
    # Wait, 0x00 != 0x64. Let me check...
    # Actually from MEMORY.md: "0x64 preamble byte 0" — but here we see 0x00.
    # Could unnamed6 use 0x00 instead of 0x64 for a different kind of marker?

    print('\n  T2 preamble in pattern files:')
    print(f'    unnamed6 T2: {proj6.tracks[1].preamble.hex(" ")}  (0x00 marker, byte1=0x8a)')
    print(f'    unnamed7 T2: {proj7.tracks[1].preamble.hex(" ")}  (0x00 marker, byte1=0x8a)')
    print(f'    unnamed7 T3: {proj7.tracks[2].preamble.hex(" ")}  (0x00 marker, byte1=0x8a)')

    # In all three cases byte1 = 0x8a. And unnamed1 T2 preamble byte0 is also 0x8a.
    # So the pattern block that was inserted gets a preamble of [0x00, orig_next_track_byte0, 0x10, 0xf0]

    # What about T1?
    print(f'\n    unnamed1 T1: {proj1.tracks[0].preamble.hex(" ")}  (byte0=0xd6, byte1=0x01)')
    print(f'    unnamed6 T1: {proj6.tracks[0].preamble.hex(" ")}  (byte0=0xb5, byte1=0x02)')
    print(f'    unnamed7 T1: {proj7.tracks[0].preamble.hex(" ")}  (byte0=0xb5, byte1=0x03)')

    # T1 byte0 changes from 0xd6 to 0xb5 when patterns are added.
    # T1 byte1 = number of patterns (1, 2, 3).

    # =========================================================================
    # 4: Verify the T16 overflow is exactly the evicted blocks
    # =========================================================================
    print('\n' + '=' * 70)
    print('4: T16 OVERFLOW = EVICTED BLOCKS VERIFICATION')
    print('=' * 70)

    # unnamed6: 1 pattern added. T16 grows by unnamed1 T15 body + unnamed1 T15 preamble.
    # Let's verify: unnamed6 T16 = [unnamed1 T15 body][unnamed1 T15 preamble_data?][unnamed1 T16 body]
    # Wait, from Section H we found:
    #   unnamed6 T16 block A (346 bytes) == unnamed1 T15 body
    #   preamble between blocks: 9b 01 10 f0
    #   unnamed6 T16 block B (403 bytes) == unnamed1 T16 body
    # And unnamed1 T15 preamble is 9b 01 10 f0 (confirmed), but that's T16's own preamble.
    # Actually, T16 in unnamed1 has preamble 9b 01 10 f0.

    # The preamble between the two embedded blocks is 9b 01 10 f0.
    # unnamed1 T16 preamble: 9b 01 10 f0
    # unnamed1 T15 preamble: 9b 01 10 f0
    # They're the same! So the embedded preamble is just the original T16 preamble.

    # unnamed6 T16 = [unnamed1_T15.body] [unnamed1_T16.preamble] [unnamed1_T16.body]
    t16_6 = proj6.tracks[15].body
    t15_1 = proj1.tracks[14]
    t16_1 = proj1.tracks[15]

    expected_6 = t15_1.body + t16_1.preamble + t16_1.body
    if t16_6 == expected_6:
        print('  unnamed6 T16 == unnamed1_T15.body + unnamed1_T16.preamble + unnamed1_T16.body  CONFIRMED!')
    else:
        print('  unnamed6 T16 != expected. Checking...')
        print(f'    Expected: {len(expected_6)} bytes')
        print(f'    Actual:   {len(t16_6)} bytes')
        for i in range(min(len(expected_6), len(t16_6))):
            if expected_6[i] != t16_6[i]:
                print(f'    First diff at 0x{i:04x}')
                break

    # unnamed7: 2 patterns added. T16 should have 2 evicted blocks.
    # unnamed7 T16 = [unnamed1_T14.body] [unnamed1_T15.preamble] [unnamed1_T15.body] [unnamed1_T16.preamble] [unnamed1_T16.body]
    t16_7 = proj7.tracks[15].body
    t14_1 = proj1.tracks[13]

    expected_7 = t14_1.body + t15_1.preamble + t15_1.body + t16_1.preamble + t16_1.body
    if t16_7 == expected_7:
        print('  unnamed7 T16 == unnamed1_T14.body + unnamed1_T15.preamble + unnamed1_T15.body + unnamed1_T16.preamble + unnamed1_T16.body  CONFIRMED!')
    else:
        print('  unnamed7 T16 != expected (T14+T15+T16). Checking...')
        print(f'    Expected: {len(expected_7)} bytes')
        print(f'    Actual:   {len(t16_7)} bytes')
        for i in range(min(len(expected_7), len(t16_7))):
            if expected_7[i] != t16_7[i]:
                print(f'    First diff at 0x{i:04x}')
                break

    # =========================================================================
    # 5: Summary of findings
    # =========================================================================
    print('\n' + '=' * 70)
    print('5: COMPLETE MULTI-PATTERN STORAGE MODEL')
    print('=' * 70)

    print("""
  When the user creates a new blank pattern on Track 1:

  1. PRE-TRACK REGION:
     - Offset 0x56-0x57: pattern_max_slot increments (0 -> 1 -> 2)
     - If going from 0 to 1+: 5 bytes [00 1d 01 00 00] inserted at 0x58
       (pre_track grows from 0x7C to 0x81 = +5 bytes)
     - Going from 1 to 2: pre_track stays at 0x81 (no additional bytes)

  2. TRACK BLOCK ROTATION:
     - A NEW pattern block is inserted at the T1 position
     - All existing blocks shift down by 1 position (T1->T2, T2->T3, ..., T14->T15)
     - T15's body (now evicted) is pushed into T16's body as a prefix

  3. NEW PATTERN BLOCK:
     - Identical to original T1 body MINUS 1 trailing 0x00 byte
     - Size: 1831 vs original 1832
     - Same type byte (0x05), same engine (0x03)

  4. T16 OVERFLOW MECHANISM:
     - T16 body = [evicted_block(s)] + [original_T16_preamble + body]
     - Each evicted block carries its preamble before the next one
     - With N extra patterns, T16 contains N evicted blocks + original T16

  5. PREAMBLE BEHAVIOR:
     a. T1 gets new preamble:
        - byte0 changes from 0xd6 to 0xb5 (meaning unclear)
        - byte1 = total pattern count (1, 2, 3)
        - bytes 2-3 stay as 10 f0
     b. T2 (the displaced original T1) gets MODIFIED preamble:
        - byte0 = 0x00 (marker for "this was the original T1 of a pattern chain")
        - byte1 = unnamed1 T2's byte0 (0x8a)
        - bytes 2-3 stay as 10 f0
     c. T3-T15: preambles shift down with their bodies (no modification)
     d. T16: preamble unchanged (9b 01 10 f0)

  6. The pattern ONLY affects Track 1's slot. Patterns are per-track, not global.
     The 16-block structure is reused: each "pattern" for T1 gets its own block,
     and blocks that fall off the end of the 16-slot array overflow into T16.
""")


if __name__ == '__main__':
    main()
