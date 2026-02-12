#!/usr/bin/env python3
"""Final targeted analysis: pre-track pointer, preamble rotation vs insertion."""

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
    # 1: Verify preamble rotation hypothesis
    # =========================================================================
    print('=' * 70)
    print('1: PREAMBLE ROTATION VERIFICATION')
    print('=' * 70)
    print()
    print('Hypothesis: preambles rotate with bodies (inserted at T1 position)')
    print('  unnamed6: new T1 preamble, then unnamed1 T1->T14 preambles shift to T2->T15')
    print('  T16 preamble stays (T16 absorbs overflow)')
    print()

    # unnamed6: T2 body == unnamed1 T1 body. Does T2 preamble == unnamed1 T1 preamble?
    print('unnamed6 preamble check (bodies shifted by 1):')
    for ti in range(1, 15):  # T2-T15 in unnamed6 should have unnamed1 T1-T14 preambles
        p6 = proj6.tracks[ti].preamble
        p1_expected = proj1.tracks[ti - 1].preamble
        match = 'YES' if p6 == p1_expected else 'NO'
        if p6 != p1_expected:
            # Check if byte 0 matches (the variable part)
            b0_match = 'b0 match' if p6[0] == p1_expected[0] else f'b0 diff: {p6[0]:02x} vs {p1_expected[0]:02x}'
            b1_match = 'b1 match' if p6[1] == p1_expected[1] else f'b1 diff: {p6[1]:02x} vs {p1_expected[1]:02x}'
            print(f'  T{ti+1}: unnamed6={p6.hex(" ")} expected(unnamed1 T{ti})={p1_expected.hex(" ")} => {match} ({b0_match}, {b1_match})')
        else:
            print(f'  T{ti+1}: unnamed6={p6.hex(" ")} expected(unnamed1 T{ti})={p1_expected.hex(" ")} => {match}')

    # T2 in unnamed6 is special — it has the original T1 body but preamble is 00 8a 10 f0
    # unnamed1 T1 preamble is d6 01 10 f0
    # Is there a systematic transformation?
    print()
    print('Key preamble differences:')
    print(f'  unnamed1 T1 preamble: {proj1.tracks[0].preamble.hex(" ")}')
    print(f'  unnamed6 T2 preamble: {proj6.tracks[1].preamble.hex(" ")}  (carries unnamed1 T1 body)')
    print(f'  unnamed1 T2 preamble: {proj1.tracks[1].preamble.hex(" ")}')
    print(f'  unnamed6 T3 preamble: {proj6.tracks[2].preamble.hex(" ")}  (carries unnamed1 T2 body)')

    # =========================================================================
    # 2: Focus on preamble byte 0 specifically
    # =========================================================================
    print('\n' + '=' * 70)
    print('2: PREAMBLE BYTE 0 — DOES IT ROTATE?')
    print('=' * 70)

    print('\n  unnamed1 byte0 chain: ', [f'0x{proj1.tracks[i].preamble[0]:02x}' for i in range(16)])
    print('  unnamed6 byte0 chain: ', [f'0x{proj6.tracks[i].preamble[0]:02x}' for i in range(16)])
    print('  unnamed7 byte0 chain: ', [f'0x{proj7.tracks[i].preamble[0]:02x}' for i in range(16)])

    # If byte0 rotates:
    # unnamed6 T2-T15 byte0 should == unnamed1 T1-T14 byte0
    print('\n  unnamed6 byte0 shift check (T2-T15 vs unnamed1 T1-T14):')
    for ti in range(1, 15):
        b6 = proj6.tracks[ti].preamble[0]
        b1 = proj1.tracks[ti-1].preamble[0]
        match = 'OK' if b6 == b1 else f'DIFF (got 0x{b6:02x}, expected 0x{b1:02x})'
        print(f'    T{ti+1}: unnamed6=0x{b6:02x}, unnamed1 T{ti}=0x{b1:02x} => {match}')

    # =========================================================================
    # 3: Preamble byte 1 — count field?
    # =========================================================================
    print('\n' + '=' * 70)
    print('3: PREAMBLE BYTE 1 — PATTERN COUNT HYPOTHESIS')
    print('=' * 70)

    print('\n  Only T1 byte 1 changes across files:')
    for name, proj in [('unnamed1', proj1), ('unnamed6', proj6), ('unnamed7', proj7)]:
        b1 = proj.tracks[0].preamble[1]
        print(f'    {name} T1 preamble byte 1 = 0x{b1:02x} ({b1})')

    # Named pattern counts: unnamed1=1 pattern, unnamed6=2 patterns, unnamed7=3+ patterns
    # But byte1 goes: 0x01, 0x02, 0x03
    # Coincidence? Or pattern count stored in T1 preamble byte 1?

    # What about other tracks?
    print('\n  All preamble byte 1 values:')
    for ti in range(16):
        vals = []
        for name, proj in [('unnamed1', proj1), ('unnamed6', proj6), ('unnamed7', proj7)]:
            vals.append(f'{proj.tracks[ti].preamble[1]:02x}')
        print(f'    T{ti+1:2d}: unnamed1={vals[0]} unnamed6={vals[1]} unnamed7={vals[2]}')

    # =========================================================================
    # 4: Decode the special preamble at T2 in unnamed6 (0x00 0x8a 0x10 0xf0)
    # =========================================================================
    print('\n' + '=' * 70)
    print('4: SPECIAL PREAMBLE BYTES AT ROTATED POSITIONS')
    print('=' * 70)

    # T2 unnamed6: 00 8a 10 f0  — byte0=0x00 means something special
    # T3 unnamed7: 00 8a 10 f0  — same pattern
    # T2 unnamed7: 00 8a 10 f0  — same pattern
    # In all cases, the track that NOW holds unnamed1's T1 body gets byte0=0x00
    # and byte1=0x8a (which was unnamed1 T2's byte0!)

    # Let's check: does byte1 at the rotated T2 position equal the original T2 byte0?
    print('\n  unnamed6 T2: preamble = 00 8a 10 f0')
    print(f'    byte0 = 0x00 (special?)')
    print(f'    byte1 = 0x8a == unnamed1 T2 preamble byte0 = 0x{proj1.tracks[1].preamble[0]:02x}')

    print('\n  unnamed7 T2: preamble = 00 8a 10 f0')
    print(f'    byte1 = 0x8a == unnamed1 T2 preamble byte0 = 0x{proj1.tracks[1].preamble[0]:02x}')

    print('\n  unnamed7 T3: preamble = 00 8a 10 f0')
    print(f'    byte1 = 0x8a == unnamed1 T2 preamble byte0 = 0x{proj1.tracks[1].preamble[0]:02x}')

    # Wait — both unnamed7 T2 and T3 have 0x8a in byte1. T2 holds unnamed6 T1 body (the new block)
    # and T3 holds unnamed1 T1 body. So this 0x8a might not be from rotation...

    # Actually let's look at the preamble word as a u32LE
    print('\n  Preamble as u32_LE:')
    for ti in range(6):
        vals = []
        for name, proj in [('unnamed1', proj1), ('unnamed6', proj6), ('unnamed7', proj7)]:
            w = int.from_bytes(proj.tracks[ti].preamble, 'little')
            vals.append(f'0x{w:08x}')
        print(f'    T{ti+1}: {vals[0]}  {vals[1]}  {vals[2]}')

    # =========================================================================
    # 5: Pre-track pointer at 0x58 — what is 0x1d?
    # =========================================================================
    print('\n' + '=' * 70)
    print('5: POINTER TABLE ENTRY DECODE')
    print('=' * 70)

    # unnamed6 at 0x58-0x5c: 00 1d 01 00 00
    # unnamed7 at 0x58-0x5c: 00 1d 01 00 00 (same)
    # 0x1d = 29 decimal. Could be a slot number: 29 * 0x10 = 0x1D0 = 464
    # unnamed1 first track preamble at offset 0x7C, unnamed6 at 0x81

    # What's the actual byte offset of T1 preamble in each file?
    for name, (raw, proj) in [('unnamed1', (raw1, proj1)), ('unnamed6', (raw6, proj6)), ('unnamed7', (raw7, proj7))]:
        pre_len = len(proj.pre_track)
        print(f'  {name}: pre_track ends at 0x{pre_len:04x}, T1 preamble at 0x{pre_len:04x}')

    # Now check: in unnamed6, does the pointer 0x1d relate to anything?
    # 0x1d as u8 = 29. As a 16-bit: 0x001d from bytes [00 1d] = 0x1d00 LE = 7424? No...
    # As [u8=0x00, u16_LE=0x011d, u16_LE=0x0000]? 0x011d = 285.
    # Hmm. Let's try: the 5 bytes are [00] [1d 01] [00 00]
    # u16_LE(1d 01) = 0x011d = 285. Not obvious.

    # Let's try: the first entry is 5 bytes? Or variable length?
    # With pat_max_slot=1, there's 1 entry consuming 5 bytes at 0x58-0x5c,
    # then the normal 3-byte ff 00 00 handles resume at 0x5d?

    # In unnamed6 pre_track (129 bytes), 0x58 to 0x80:
    print('\n  unnamed6 pre_track 0x56-0x80:')
    pre6 = proj6.pre_track
    for i in range(0x56, len(pre6), 1):
        pass
    # Let me try another interpretation: the entry is [u16_LE track_index?, u8 something?]
    # bytes at 0x58: 00 1d -> u16_LE = 0x1d00 = no
    # Or maybe it's 0x58: [00] and then 0x59: [1d 01 00 00] as some u32?
    # 0x011d0000 doesn't help.

    # Try yet another: right after pat_max_slot (0x56-0x57), there's pat_max_slot * N bytes,
    # then 12 entries of `ff 00 00`.
    # unnamed1: 0 entries, then 12 `ff 00 00` entries = 36 bytes. 0x58 + 36 = 0x7C = pre_track end.
    # unnamed6: 1 entry + 12 `ff 00 00` entries. pre_track = 129 = 0x81. 0x81 - 0x58 = 41 bytes.
    # If 12 `ff 00 00` = 36, then 1 entry = 5 bytes. 36 + 5 = 41. Check.
    # unnamed7: 2 entries + 12 entries? pre_track = 129 = 0x81. 0x81 - 0x58 = 41 again.
    # Wait that's the same! So unnamed7 also has 41 bytes and only 1 5-byte entry?

    # Actually let me re-examine:
    print(f'\n  unnamed1 pre_track size: {len(proj1.pre_track)} (0x{len(proj1.pre_track):x})')
    print(f'  unnamed6 pre_track size: {len(proj6.pre_track)} (0x{len(proj6.pre_track):x})')
    print(f'  unnamed7 pre_track size: {len(proj7.pre_track)} (0x{len(proj7.pre_track):x})')

    # unnamed1: 124 = 0x7C. unnamed6: 129 = 0x81. unnamed7: 129 = 0x81.
    # Diff: 5 bytes for unnamed6 vs unnamed1, 0 for unnamed7 vs unnamed6.
    # So going from 0 to 1 pattern slot adds 5 bytes, going from 1 to 2 adds 0?
    # That doesn't match a simple per-slot 5-byte structure...

    # Unless it's: one 5-byte entry added when pat_max_slot goes from 0 to 1+ (a header entry?)
    # and then pat_max_slot can increase without adding more bytes to the pre_track.

    # OR: the 5-byte block at 0x58 is always the same structure: [00 1d 01 00 00]
    # encoding something about the patterns, and the `ff 00 00` entries are a fixed table.

    # Let's count `ff 00 00` entries in each file:
    for name, proj in [('unnamed1', proj1), ('unnamed6', proj6), ('unnamed7', proj7)]:
        pre = proj.pre_track
        count = 0
        i = 0x58
        # Count from end backwards
        table = pre[0x58:]
        # Count occurrences of ff 00 00
        n_ff = 0
        for j in range(0, len(table) - 2, 3):
            if table[j:j+3] == b'\xff\x00\x00':
                n_ff += 1
        print(f'  {name}: {n_ff} instances of "ff 00 00" in pre_track[0x58:]')

    # =========================================================================
    # 6: Summarize the entire multi-pattern mechanism
    # =========================================================================
    print('\n' + '=' * 70)
    print('6: NEW BLOCK vs ORIGINAL T1 — THE 1-BYTE DIFFERENCE')
    print('=' * 70)

    # The new block is 1831 bytes, original T1 is 1832. Identical for first 1831 bytes.
    # The original has one extra trailing 0x00 byte.
    orig_t1 = proj1.tracks[0].body
    new_blk = proj6.tracks[0].body

    print(f'  Original T1: {len(orig_t1)} bytes, ends with: {orig_t1[-8:].hex(" ")}')
    print(f'  New block:   {len(new_blk)} bytes, ends with: {new_blk[-8:].hex(" ")}')
    print(f'  Last byte of original: 0x{orig_t1[-1]:02x}')
    print(f'  Last byte of new:      0x{new_blk[-1]:02x}')

    # Check if this is the same kind of trimming we see with type 05->07 (2B padding removal)
    # No — both are type 0x05. But the difference is 1 byte, not 2.
    # Let's see what that last byte is in context:
    print(f'\n  Original T1 tail context (last 48 bytes):')
    for i in range(len(orig_t1) - 48, len(orig_t1)):
        print(f'    0x{i:04x}: 0x{orig_t1[i]:02x}', end='')
        if 32 <= orig_t1[i] < 127:
            print(f'  "{chr(orig_t1[i])}"', end='')
        print()

    # =========================================================================
    # 7: Check type bytes of all blocks in all files
    # =========================================================================
    print('\n' + '=' * 70)
    print('7: TYPE BYTES AND ENGINE IDs FOR ALL TRACKS')
    print('=' * 70)

    for name, proj in [('unnamed1', proj1), ('unnamed6', proj6), ('unnamed7', proj7)]:
        print(f'\n  {name}:')
        for ti in range(16):
            t = proj.tracks[ti]
            eid = t.engine_id
            print(f'    T{ti+1:2d}: type=0x{t.type_byte:02x}, engine=0x{eid:02x}, body={len(t.body):5d}')


if __name__ == '__main__':
    main()
