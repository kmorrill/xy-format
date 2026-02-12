#!/usr/bin/env python3
"""Deeper analysis: new pattern blocks, T16 overflow, preamble byte decoding."""

import sys
sys.path.insert(0, '/Users/kevinmorrill/Documents/xy-format')

from xy.container import XYProject


def load(name):
    path = f'/Users/kevinmorrill/Documents/xy-format/src/one-off-changes-from-default/{name}'
    with open(path, 'rb') as f:
        raw = f.read()
    return raw, XYProject.from_bytes(raw)


def hexdump(data, offset=0, width=16):
    lines = []
    for i in range(0, len(data), width):
        chunk = data[i:i + width]
        hexpart = ' '.join(f'{b:02x}' for b in chunk)
        asciipart = ''.join(chr(b) if 32 <= b < 127 else '.' for b in chunk)
        lines.append(f'  {offset + i:04x}: {hexpart:<{width * 3 - 1}}  {asciipart}')
    return '\n'.join(lines)


def main():
    raw1, proj1 = load('unnamed 1.xy')
    raw6, proj6 = load('unnamed 6.xy')
    raw7, proj7 = load('unnamed 7.xy')

    # =========================================================================
    # A: The 1-byte difference between unnamed1-T1 (1832) and new pattern block (1831)
    # =========================================================================
    print('=' * 70)
    print('A: UNNAMED1 T1 (1832b) vs NEW PATTERN BLOCK IN UNNAMED6 T1 (1831b)')
    print('=' * 70)

    orig = proj1.tracks[0].body  # 1832 bytes
    new_blk = proj6.tracks[0].body  # 1831 bytes

    # Find where they diverge
    min_len = min(len(orig), len(new_blk))
    first_diff = None
    for i in range(min_len):
        if orig[i] != new_blk[i]:
            first_diff = i
            break

    if first_diff is None and len(orig) != len(new_blk):
        first_diff = min_len
        print(f'  Bodies are identical for first {min_len} bytes, then orig has 1 extra byte')
        print(f'  Extra byte at offset 0x{min_len:04x} in orig: 0x{orig[min_len]:02x}')
        print(f'\n  Context around end (orig last 32 bytes):')
        print(hexdump(orig[-32:], offset=len(orig) - 32))
        print(f'\n  Context around end (new last 32 bytes):')
        print(hexdump(new_blk[-32:], offset=len(new_blk) - 32))
    elif first_diff is not None:
        print(f'  First difference at body offset 0x{first_diff:04x}')
        ctx_start = max(0, first_diff - 16)
        print(f'  orig  [{ctx_start:04x}]: {orig[ctx_start:first_diff+16].hex(" ")}')
        print(f'  new   [{ctx_start:04x}]: {new_blk[ctx_start:first_diff+16].hex(" ")}')
    else:
        print('  IDENTICAL (should not happen since sizes differ)')

    # =========================================================================
    # B: T16 structure decomposition
    # =========================================================================
    print('\n' + '=' * 70)
    print('B: T16 INTERNAL STRUCTURE')
    print('=' * 70)

    t16_1 = proj1.tracks[15].body
    t16_6 = proj6.tracks[15].body
    t16_7 = proj7.tracks[15].body

    print(f'\n  unnamed1 T16 ({len(t16_1)} bytes):')
    print(hexdump(t16_1))

    # Look for track signatures inside T16 bodies (which would indicate embedded blocks)
    SIG = b'\x00\x00\x01\x03\xff\x00\xfc\x00'

    for name, body in [('unnamed1', t16_1), ('unnamed6', t16_6), ('unnamed7', t16_7)]:
        sigs = []
        start = 0
        while True:
            pos = body.find(SIG, start)
            if pos == -1:
                break
            sigs.append(pos)
            start = pos + 1
        print(f'\n  {name} T16: track signatures found at body offsets: {[f"0x{s:04x}" for s in sigs]}')
        if len(sigs) > 1:
            # There are embedded preamble+block boundaries
            for si, sig_off in enumerate(sigs):
                # Check 4 bytes before each sig for preamble
                if sig_off >= 4:
                    preamble = body[sig_off-4:sig_off]
                    print(f'    sig[{si}] at 0x{sig_off:04x}, preceding 4 bytes (preamble?): {preamble.hex(" ")}')
                else:
                    print(f'    sig[{si}] at 0x{sig_off:04x} (at body start, no preamble)')

                # Next boundary
                if si + 1 < len(sigs):
                    next_off = sigs[si + 1]
                    # Preamble of next would be 4 bytes before it
                    block_end = next_off - 4 if next_off >= 4 else next_off
                    block_len = block_end - sig_off
                    print(f'      block body: {block_len} bytes')
                else:
                    block_len = len(body) - sig_off
                    print(f'      block body: {block_len} bytes (to end)')

    # =========================================================================
    # C: T16 tail — what's after the last embedded signature?
    # =========================================================================
    print('\n' + '=' * 70)
    print('C: T16 TAIL CONTENT (after last track signature block)')
    print('=' * 70)

    for name, body in [('unnamed6', t16_6), ('unnamed7', t16_7)]:
        sigs = []
        start = 0
        while True:
            pos = body.find(SIG, start)
            if pos == -1:
                break
            sigs.append(pos)
            start = pos + 1

        if len(sigs) >= 2:
            # The last "block" — from last sig to end
            last_sig = sigs[-1]
            tail = body[last_sig:]
            print(f'\n  {name} T16 last block (from 0x{last_sig:04x}, {len(tail)} bytes):')
            print(hexdump(tail, offset=last_sig))

            # Also dump everything after the second-to-last signature block
            for si in range(len(sigs)):
                start_off = sigs[si]
                end_off = sigs[si+1] - 4 if si + 1 < len(sigs) else len(body)
                block = body[start_off:end_off]
                print(f'\n    Block {si} (sig at 0x{start_off:04x}): {len(block)} bytes, type_byte=0x{block[9]:02x} if len > 9')

    # =========================================================================
    # D: Preamble byte 1 analysis
    # =========================================================================
    print('\n' + '=' * 70)
    print('D: PREAMBLE BYTE-BY-BYTE ANALYSIS')
    print('=' * 70)

    files = {'unnamed1': proj1, 'unnamed6': proj6, 'unnamed7': proj7}

    print('\n  Preamble layout: [byte0] [byte1] [byte2] [byte3]')
    print('  Previously known: byte2 high nibble = bar_count, byte2-3 = F0 10 constant?\n')

    for ti in range(16):
        print(f'  T{ti+1:2d}:', end='')
        for name, proj in files.items():
            p = proj.tracks[ti].preamble
            print(f'  {name}: {p[0]:02x} {p[1]:02x} {p[2]:02x} {p[3]:02x}', end='')
        print()

    # Focus on byte0 and byte1 patterns
    print('\n  --- Preamble byte 0 values ---')
    for ti in range(16):
        vals = []
        for name, proj in files.items():
            vals.append(proj.tracks[ti].preamble[0])
        if len(set(vals)) > 1:
            print(f'  T{ti+1:2d}: ' + ', '.join(f'{name}=0x{v:02x}' for name, v in zip(files.keys(), vals)))

    print('\n  --- Preamble byte 1 values ---')
    for ti in range(16):
        vals = []
        for name, proj in files.items():
            vals.append(proj.tracks[ti].preamble[1])
        if len(set(vals)) > 1:
            print(f'  T{ti+1:2d}: ' + ', '.join(f'{name}=0x{v:02x}' for name, v in zip(files.keys(), vals)))

    # =========================================================================
    # E: Check if preambles rotate with bodies
    # =========================================================================
    print('\n' + '=' * 70)
    print('E: DO PREAMBLES ROTATE WITH BODIES?')
    print('=' * 70)

    # unnamed6: bodies shifted by +1 from T2 onwards. Do preambles also shift?
    print('\n  unnamed1 preambles vs unnamed6 preambles (shifted):')
    print(f'  {"Track":>8} {"unnamed1":>14} {"unnamed6(same body track)":>30} {"actual unnamed6":>18}')

    for ti in range(16):
        p1 = proj1.tracks[ti].preamble
        p6 = proj6.tracks[ti].preamble
        # Which unnamed1 track has the same body?
        body6 = proj6.tracks[ti].body
        match_idx = None
        for j in range(16):
            if proj1.tracks[j].body == body6:
                match_idx = j
                break
        match_p = proj1.tracks[match_idx].preamble if match_idx is not None else b'????'
        match_str = f'T{match_idx+1}:{match_p.hex(" ")}' if match_idx is not None else 'NEW'
        print(f'  T{ti+1:2d}       {p1.hex(" ")}    {match_str:>26}    {p6.hex(" ")}')

    # =========================================================================
    # F: Handle table reinterpretation
    # =========================================================================
    print('\n' + '=' * 70)
    print('F: HANDLE TABLE REINTERPRETATION (3-byte entries?)')
    print('=' * 70)

    # The handle table at 0x58 was parsed as 4-byte entries for 16 tracks.
    # But unnamed1 has repeating `ff 00 00` pattern — maybe it's 3-byte entries?

    for name, (raw, proj) in [('unnamed1', (raw1, proj1)), ('unnamed6', (raw6, proj6)), ('unnamed7', (raw7, proj7))]:
        pre = proj.pre_track
        table_start = 0x58
        table_data = pre[table_start:]
        print(f'\n  {name} handle table ({len(table_data)} bytes from 0x{table_start:02x}):')

        # Try 3-byte entries
        print('    As 3-byte entries:')
        for i in range(0, len(table_data), 3):
            if i + 3 <= len(table_data):
                entry = table_data[i:i+3]
                idx = i // 3
                val_le = int.from_bytes(entry, 'little')
                print(f'      [{idx:2d}] 0x{table_start+i:02x}: {entry.hex(" ")} (u24_le=0x{val_le:06x}={val_le})')

        # Also try as pattern-count-dependent structure
        pat_count = int.from_bytes(raw[0x56:0x58], 'little')
        print(f'    pattern_max_slot={pat_count}')

    # =========================================================================
    # G: The 5 bytes at 0x56-0x5A across files
    # =========================================================================
    print('\n' + '=' * 70)
    print('G: BYTES 0x56-0x60 DECODED')
    print('=' * 70)

    for name, raw in [('unnamed1', raw1), ('unnamed6', raw6), ('unnamed7', raw7)]:
        region = raw[0x56:0x62]
        print(f'\n  {name}: {region.hex(" ")}')
        pat_max = int.from_bytes(raw[0x56:0x58], 'little')
        print(f'    0x56-57: pattern_max_slot = {pat_max}')
        # Next bytes
        if pat_max > 0:
            # There's a new structure between 0x58 and the handle table
            for i in range(0x58, 0x58 + pat_max * 5 + 10):
                if i < len(raw):
                    pass
            # Dump 0x56 to 0x62
            print(f'    0x58-5C: {raw[0x58:0x5d].hex(" ")}')
            # Interpret as: [u8 slot_id?] [u16_le pointer?] [u16_le something?]
            # For unnamed6: 00 1d 01 00 00
            # For unnamed7: 00 1d 01 00 00
            ptr1 = int.from_bytes(raw[0x58:0x5a], 'little')
            ptr2 = int.from_bytes(raw[0x5a:0x5c], 'little')
            ptr3_byte = raw[0x5c] if 0x5c < len(raw) else None
            print(f'    0x58-59 as u16_le = 0x{ptr1:04x} ({ptr1})')
            print(f'    0x5a-5b as u16_le = 0x{ptr2:04x} ({ptr2})')
            # Also try as u8 + u16_le + u16_le
            print(f'    As [u8, u16, u16]: [{raw[0x58]:02x}] [{int.from_bytes(raw[0x59:0x5b], "little"):04x}] [{int.from_bytes(raw[0x5b:0x5d], "little"):04x}]')

    # =========================================================================
    # H: Trace exact composition of unnamed6 T16 body
    # =========================================================================
    print('\n' + '=' * 70)
    print('H: UNNAMED6 T16 BODY COMPOSITION')
    print('=' * 70)

    t16_6 = proj6.tracks[15].body

    # Find all track signatures in T16
    SIG = b'\x00\x00\x01\x03\xff\x00\xfc\x00'
    sigs = []
    start = 0
    while True:
        pos = t16_6.find(SIG, start)
        if pos == -1:
            break
        sigs.append(pos)
        start = pos + 1

    print(f'  T16 has {len(sigs)} track signatures at offsets: {[hex(s) for s in sigs]}')

    # Check if preamble bytes appear before second sig
    if len(sigs) >= 2:
        boundary = sigs[1]
        # 4 bytes before = preamble
        preamble = t16_6[boundary-4:boundary]
        print(f'  Preamble before second sig: {preamble.hex(" ")}')

        # Compare blocks:
        block1 = t16_6[:boundary-4]  # first block body (up to preamble of second)
        block2 = t16_6[boundary:]    # second block body

        # But wait - how is the boundary defined? Let's look at it differently.
        # The first sig starts the first embedded "track". Where does it end?

        # Check: is first block = unnamed1 T15 body?
        t15_1 = proj1.tracks[14].body
        print(f'\n  Block 0 (0x0000 to 0x{boundary-4:04x}): {boundary-4} bytes')
        print(f'    unnamed1 T15 body: {len(t15_1)} bytes')
        if block1 == t15_1:
            print('    MATCH: unnamed6 T16 block0 == unnamed1 T15')
        else:
            # Maybe the whole block1 is unnamed1 T16?
            t16_1_body = proj1.tracks[15].body
            print(f'    unnamed1 T16 body: {len(t16_1_body)} bytes')
            if block1 == t16_1_body:
                print('    MATCH: unnamed6 T16 block0 == unnamed1 T16')
            elif block1[:len(t16_1_body)] == t16_1_body:
                print(f'    PARTIAL: unnamed6 T16 block0 starts with unnamed1 T16, then {boundary-4-len(t16_1_body)} extra bytes')

    # Check: does unnamed6 T16 contain unnamed1 T15 body + unnamed1 T16 body?
    for search_name, search_body in [('T15', proj1.tracks[14].body), ('T16', proj1.tracks[15].body)]:
        pos = t16_6.find(search_body)
        if pos >= 0:
            print(f'  unnamed1 {search_name} body found in unnamed6 T16 at offset 0x{pos:04x}')

    # What about the tail after the last sig in T16?
    if sigs:
        last = sigs[-1]
        tail_start = last  # from sig to end
        last_block = t16_6[last:]
        # Compare to unnamed1 T16
        t16_1_body = proj1.tracks[15].body
        if last_block == t16_1_body:
            print(f'  Last block (from 0x{last:04x}) == unnamed1 T16 body!')
        else:
            # Check similarity
            common = sum(1 for a, b in zip(last_block, t16_1_body) if a == b)
            print(f'  Last block vs unnamed1 T16: {common}/{min(len(last_block), len(t16_1_body))} common')

    # Manual: unnamed6 T16 = shifted T15 body + preamble + shifted T16 body + overflow?
    # Let's check: unnamed6 T16 first block = unnamed1 T15?
    # The first block starts at 0x0000 (the first sig in the body)
    # unnamed1 T15 has body = 346 bytes.
    # unnamed1 T16 has body = 403 bytes.

    # Actually the body already starts with the signature. So:
    # unnamed6 T16 = [block_A body][preamble_B][block_B body][tail?]
    # block_A ends where preamble_B starts (4 bytes before second sig)

    if len(sigs) >= 2:
        block_A = t16_6[:sigs[1]-4]  # from start to just before preamble of block B
        preamble_B = t16_6[sigs[1]-4:sigs[1]]
        block_B = t16_6[sigs[1]:]

        print(f'\n  Decomposition:')
        print(f'    Block A: {len(block_A)} bytes (0x0000 to 0x{sigs[1]-5:04x})')
        print(f'    Preamble B: {preamble_B.hex(" ")}')
        print(f'    Block B: {len(block_B)} bytes (0x{sigs[1]:04x} to end)')

        # Compare block_A to unnamed1 T15
        t15_1 = proj1.tracks[14].body
        if block_A == t15_1:
            print(f'    Block A == unnamed1 T15 body (346 bytes)')
        else:
            print(f'    Block A size={len(block_A)} vs unnamed1 T15={len(t15_1)}')

        # Compare block_B to unnamed1 T16
        t16_1_body = proj1.tracks[15].body
        if block_B == t16_1_body:
            print(f'    Block B == unnamed1 T16 body ({len(t16_1_body)} bytes)')
        else:
            print(f'    Block B size={len(block_B)} vs unnamed1 T16={len(t16_1_body)}')
            # Check byte by byte
            for i in range(min(len(block_B), len(t16_1_body))):
                if block_B[i] != t16_1_body[i]:
                    print(f'    First diff at offset 0x{i:04x}')
                    break

    # =========================================================================
    # I: Same analysis for unnamed7 T16
    # =========================================================================
    print('\n' + '=' * 70)
    print('I: UNNAMED7 T16 BODY COMPOSITION')
    print('=' * 70)

    t16_7 = proj7.tracks[15].body
    sigs7 = []
    start = 0
    while True:
        pos = t16_7.find(SIG, start)
        if pos == -1:
            break
        sigs7.append(pos)
        start = pos + 1

    print(f'  T16 has {len(sigs7)} track signatures at offsets: {[hex(s) for s in sigs7]}')

    # Decompose into blocks
    blocks = []
    for si in range(len(sigs7)):
        sig_off = sigs7[si]
        if si + 1 < len(sigs7):
            # Block ends 4 bytes before next sig (preamble)
            end_off = sigs7[si+1] - 4
            preamble_next = t16_7[sigs7[si+1]-4:sigs7[si+1]]
        else:
            end_off = len(t16_7)
            preamble_next = None

        block_body = t16_7[sig_off:end_off]
        blocks.append(block_body)

        print(f'\n  Block {si}: {len(block_body)} bytes (0x{sig_off:04x} to 0x{end_off-1:04x})')
        if preamble_next:
            print(f'    Followed by preamble: {preamble_next.hex(" ")}')

        # Try to match against unnamed1 tracks
        for j in range(16):
            if block_body == proj1.tracks[j].body:
                print(f'    == unnamed1 T{j+1} body')
                break
        else:
            # Try partial match
            best = -1
            best_n = 0
            for j in range(16):
                ref = proj1.tracks[j].body
                n = sum(1 for a, b in zip(block_body, ref) if a == b)
                if n > best_n:
                    best_n = n
                    best = j
            if best >= 0 and best_n > 10:
                print(f'    Closest: unnamed1 T{best+1} ({best_n}/{min(len(block_body), len(proj1.tracks[best].body))} matching)')

    # =========================================================================
    # J: Check the tail bytes at the very end of T16 in unnamed6/7
    # =========================================================================
    print('\n' + '=' * 70)
    print('J: T16 TAIL BYTES (AFTER LAST BLOCK)')
    print('=' * 70)

    for name, body in [('unnamed6', t16_6), ('unnamed7', t16_7)]:
        print(f'\n  {name} T16 last 64 bytes:')
        print(hexdump(body[-64:], offset=len(body) - 64))


if __name__ == '__main__':
    main()
