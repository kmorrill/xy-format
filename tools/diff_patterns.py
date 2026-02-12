#!/usr/bin/env python3
"""Deep binary comparison of multi-pattern storage in OP-XY .xy files.

Compares:
  - unnamed 1.xy (baseline, 1 pattern)
  - unnamed 6.xy (2 patterns — "created a new blank pattern")
  - unnamed 7.xy (3+ patterns — "added three blank patterns on track one")
"""

import sys
sys.path.insert(0, '/Users/kevinmorrill/Documents/xy-format')

from xy.container import XYProject, TrackBlock
from xy.structs import find_track_handles, pattern_max_slot


def load(name: str) -> tuple:
    path = f'/Users/kevinmorrill/Documents/xy-format/src/one-off-changes-from-default/{name}'
    with open(path, 'rb') as f:
        raw = f.read()
    proj = XYProject.from_bytes(raw)
    return raw, proj


def hexdump(data: bytes, offset: int = 0, width: int = 16) -> str:
    lines = []
    for i in range(0, len(data), width):
        chunk = data[i:i + width]
        hexpart = ' '.join(f'{b:02x}' for b in chunk)
        asciipart = ''.join(chr(b) if 32 <= b < 127 else '.' for b in chunk)
        lines.append(f'  {offset + i:04x}: {hexpart:<{width * 3 - 1}}  {asciipart}')
    return '\n'.join(lines)


def compare_hex_regions(regions: dict, label: str):
    """regions: {name: bytes} — highlight byte-level differences."""
    names = list(regions.keys())
    datas = list(regions.values())
    max_len = max(len(d) for d in datas)

    print(f'\n{"=" * 70}')
    print(f'{label}')
    print(f'{"=" * 70}')
    print(f'Lengths: {", ".join(f"{n}={len(d)}" for n, d in regions.items())}')

    # Show hex side by side in rows of 16
    width = 16
    for row_start in range(0, max_len, width):
        for ni, name in enumerate(names):
            d = datas[ni]
            chunk = d[row_start:row_start + width] if row_start < len(d) else b''
            hexpart = ' '.join(f'{b:02x}' for b in chunk)
            print(f'  {name:12s} {row_start:04x}: {hexpart}')
        # Mark differences
        min_len_row = min(len(d) for d in datas)
        diffs = []
        for j in range(width):
            pos = row_start + j
            if pos >= max_len:
                break
            vals = set()
            for d in datas:
                if pos < len(d):
                    vals.add(d[pos])
                else:
                    vals.add(None)
            if len(vals) > 1:
                diffs.append(j)
        if diffs:
            marker = '  ' + ' ' * 12 + '      '
            for j in range(width):
                if j in diffs:
                    marker += '^^'
                else:
                    marker += '  '
                if j < width - 1:
                    marker += ' '
            print(marker)
        print()


def main():
    raw1, proj1 = load('unnamed 1.xy')
    raw6, proj6 = load('unnamed 6.xy')
    raw7, proj7 = load('unnamed 7.xy')

    files = {'unnamed1': (raw1, proj1), 'unnamed6': (raw6, proj6), 'unnamed7': (raw7, proj7)}

    # =========================================================================
    # Section 1: File sizes and basic stats
    # =========================================================================
    print('=' * 70)
    print('SECTION 1: FILE SIZES AND BASIC STATS')
    print('=' * 70)
    for name, (raw, proj) in files.items():
        pat_count = int.from_bytes(raw[0x56:0x58], 'little')
        print(f'{name}: {len(raw)} bytes, pattern_max_slot=0x{pat_count:04x} ({pat_count}), '
              f'pre_track={len(proj.pre_track)} bytes')

    # =========================================================================
    # Section 2: Pre-track region comparison
    # =========================================================================
    compare_hex_regions(
        {n: p.pre_track for n, (_, p) in files.items()},
        'SECTION 2: PRE-TRACK REGION (bytes before first track preamble)'
    )

    # =========================================================================
    # Section 3: Slot pointer table at 0x58+
    # =========================================================================
    print('=' * 70)
    print('SECTION 3: SLOT POINTER TABLE (0x58+)')
    print('=' * 70)
    for name, (raw, proj) in files.items():
        print(f'\n  {name}:')
        handles = find_track_handles(raw)
        for h in handles:
            if h.track <= 16:
                print(f'    T{h.track:2d}: slot=0x{h.slot:04x} aux=0x{h.aux:04x} '
                      f'(slot_le=0x{h.slot_le():04x} aux_le=0x{h.aux_le():04x})'
                      f'{" UNUSED" if h.is_unused() else ""}')

        # Also dump raw hex from 0x58 to end of pre_track
        pre = proj.pre_track
        print(f'\n    Raw pre_track from 0x58 to end ({len(pre) - 0x58} bytes):')
        print(hexdump(pre[0x58:], offset=0x58))

    # =========================================================================
    # Section 4: Preamble comparison
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 4: PREAMBLE COMPARISON (4 bytes per track)')
    print('=' * 70)
    print(f'  {"Track":<8}', end='')
    for name in files:
        print(f'{name:>20}', end='')
    print()
    print(f'  {"-----":<8}', end='')
    for _ in files:
        print(f'{"--------------------":>20}', end='')
    print()

    for ti in range(16):
        print(f'  T{ti+1:<6d}', end='')
        preambles = []
        for name, (_, proj) in files.items():
            p = proj.tracks[ti].preamble
            preambles.append(p)
            print(f'{p.hex(" "):>20}', end='')
        # Mark if different
        if len(set(preambles)) > 1:
            print('  <-- DIFFERENT', end='')
        print()

    # =========================================================================
    # Section 5: Track body sizes
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 5: TRACK BODY SIZES')
    print('=' * 70)
    print(f'  {"Track":<8}', end='')
    for name in files:
        print(f'{name:>12}', end='')
    print('  delta6  delta7')
    for ti in range(16):
        print(f'  T{ti+1:<6d}', end='')
        sizes = []
        for name, (_, proj) in files.items():
            s = len(proj.tracks[ti].body)
            sizes.append(s)
            print(f'{s:>12}', end='')
        d6 = sizes[1] - sizes[0]
        d7 = sizes[2] - sizes[0]
        mark = ''
        if d6 != 0 or d7 != 0:
            mark = '  <--'
        print(f'  {d6:+6d}  {d7:+6d}{mark}')

    # =========================================================================
    # Section 6: Body content matching (rotation hypothesis)
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 6: BODY CONTENT MATCHING — ROTATION HYPOTHESIS')
    print('=' * 70)

    # Build body fingerprints for unnamed1
    bodies1 = {ti: proj1.tracks[ti].body for ti in range(16)}

    print('\n  --- unnamed6 track bodies vs unnamed1 ---')
    for ti in range(16):
        body6 = proj6.tracks[ti].body
        matches = [j for j in range(16) if bodies1[j] == body6]
        if matches:
            match_str = ', '.join(f'T{j+1}' for j in matches)
            shift = matches[0] - ti if matches else '?'
            print(f'  unnamed6 T{ti+1:2d} ({len(body6):5d} bytes) == unnamed1 {match_str} (shift={shift})')
        else:
            print(f'  unnamed6 T{ti+1:2d} ({len(body6):5d} bytes) == NO MATCH in unnamed1')

    print('\n  --- unnamed7 track bodies vs unnamed1 ---')
    for ti in range(16):
        body7 = proj7.tracks[ti].body
        matches = [j for j in range(16) if bodies1[j] == body7]
        if matches:
            match_str = ', '.join(f'T{j+1}' for j in matches)
            shift = matches[0] - ti if matches else '?'
            print(f'  unnamed7 T{ti+1:2d} ({len(body7):5d} bytes) == unnamed1 {match_str} (shift={shift})')
        else:
            print(f'  unnamed7 T{ti+1:2d} ({len(body7):5d} bytes) == NO MATCH in unnamed1')

    # Also check unnamed6 vs unnamed7
    print('\n  --- unnamed7 track bodies vs unnamed6 ---')
    bodies6 = {ti: proj6.tracks[ti].body for ti in range(16)}
    for ti in range(16):
        body7 = proj7.tracks[ti].body
        matches = [j for j in range(16) if bodies6[j] == body7]
        if matches:
            match_str = ', '.join(f'T{j+1}' for j in matches)
            print(f'  unnamed7 T{ti+1:2d} == unnamed6 {match_str}')
        else:
            print(f'  unnamed7 T{ti+1:2d} == NO MATCH in unnamed6')

    # =========================================================================
    # Section 7: T1 body differences
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 7: T1 BODY COMPARISON')
    print('=' * 70)

    for name, (_, proj) in files.items():
        t1 = proj.tracks[0]
        print(f'\n  {name} T1: type_byte=0x{t1.type_byte:02x}, body={len(t1.body)} bytes')
        print(f'    First 64 bytes:')
        print(hexdump(t1.body[:64]))

    # Byte-level diff of T1 bodies
    t1_1 = proj1.tracks[0].body
    t1_6 = proj6.tracks[0].body
    t1_7 = proj7.tracks[0].body

    def fmt_byte(b):
        return f'0x{b:02x}' if b is not None else '??'

    print('\n  --- T1 byte differences: unnamed1 vs unnamed6 ---')
    max_len = max(len(t1_1), len(t1_6))
    diff_count = 0
    for i in range(max_len):
        b1 = t1_1[i] if i < len(t1_1) else None
        b6 = t1_6[i] if i < len(t1_6) else None
        if b1 != b6:
            print(f'    offset 0x{i:04x}: unnamed1={fmt_byte(b1)} unnamed6={fmt_byte(b6)}')
            diff_count += 1
            if diff_count > 50:
                print('    ... (truncated, too many diffs)')
                break
    if diff_count == 0:
        print('    IDENTICAL')

    print('\n  --- T1 byte differences: unnamed1 vs unnamed7 ---')
    max_len = max(len(t1_1), len(t1_7))
    diff_count = 0
    for i in range(max_len):
        b1 = t1_1[i] if i < len(t1_1) else None
        b7 = t1_7[i] if i < len(t1_7) else None
        if b1 != b7:
            print(f'    offset 0x{i:04x}: unnamed1={fmt_byte(b1)} unnamed7={fmt_byte(b7)}')
            diff_count += 1
            if diff_count > 50:
                print('    ... (truncated, too many diffs)')
                break
    if diff_count == 0:
        print('    IDENTICAL')

    # =========================================================================
    # Section 8: T16 analysis
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 8: T16 (LAST TRACK) ANALYSIS')
    print('=' * 70)

    for name, (_, proj) in files.items():
        t16 = proj.tracks[15]
        print(f'\n  {name} T16: type_byte=0x{t16.type_byte:02x}, body={len(t16.body)} bytes, preamble={t16.preamble.hex(" ")}')

    # Compare T16 bodies
    t16_1 = proj1.tracks[15].body
    t16_6 = proj6.tracks[15].body
    t16_7 = proj7.tracks[15].body

    print(f'\n  unnamed1 T16 body size: {len(t16_1)}')
    print(f'  unnamed6 T16 body size: {len(t16_6)} (delta={len(t16_6)-len(t16_1):+d})')
    print(f'  unnamed7 T16 body size: {len(t16_7)} (delta={len(t16_7)-len(t16_1):+d})')

    # Check if unnamed1 T16 body is a prefix of unnamed6/7 T16
    if t16_6[:len(t16_1)] == t16_1:
        print(f'\n  unnamed6 T16 starts with identical content as unnamed1 T16!')
        extra = t16_6[len(t16_1):]
        print(f'  Extra {len(extra)} bytes appended:')
        print(hexdump(extra[:256], offset=len(t16_1)))
    else:
        # Find where they diverge
        for i in range(min(len(t16_1), len(t16_6))):
            if t16_1[i] != t16_6[i]:
                print(f'\n  unnamed1 vs unnamed6 T16 first diff at body offset 0x{i:04x}')
                print(f'    unnamed1: {t16_1[max(0,i-8):i+16].hex(" ")}')
                print(f'    unnamed6: {t16_6[max(0,i-8):i+16].hex(" ")}')
                break

    if t16_7[:len(t16_1)] == t16_1:
        print(f'\n  unnamed7 T16 starts with identical content as unnamed1 T16!')
        extra = t16_7[len(t16_1):]
        print(f'  Extra {len(extra)} bytes appended:')
        print(hexdump(extra[:256], offset=len(t16_1)))
    else:
        for i in range(min(len(t16_1), len(t16_7))):
            if t16_1[i] != t16_7[i]:
                print(f'\n  unnamed1 vs unnamed7 T16 first diff at body offset 0x{i:04x}')
                print(f'    unnamed1: {t16_1[max(0,i-8):i+16].hex(" ")}')
                print(f'    unnamed7: {t16_7[max(0,i-8):i+16].hex(" ")}')
                break

    # Show full T16 body for unnamed6 if manageable
    if len(t16_6) < 2000:
        print(f'\n  Full unnamed6 T16 body ({len(t16_6)} bytes):')
        print(hexdump(t16_6))
    else:
        print(f'\n  unnamed6 T16 first 256 bytes:')
        print(hexdump(t16_6[:256]))
        print(f'  unnamed6 T16 last 256 bytes:')
        print(hexdump(t16_6[-256:], offset=len(t16_6) - 256))

    # =========================================================================
    # Section 9: Non-matching tracks — detailed diff
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 9: NON-MATCHING TRACK BODIES — WHAT CHANGED?')
    print('=' * 70)

    # For unnamed6, find tracks that don't match any unnamed1 track
    for ti in range(16):
        body6 = proj6.tracks[ti].body
        if not any(bodies1[j] == body6 for j in range(16)):
            print(f'\n  unnamed6 T{ti+1} ({len(body6)} bytes) has NO MATCH in unnamed1')
            # Find closest match
            best_match = -1
            best_common = 0
            for j in range(16):
                common = 0
                for k in range(min(len(body6), len(bodies1[j]))):
                    if body6[k] == bodies1[j][k]:
                        common += 1
                if common > best_common:
                    best_common = common
                    best_match = j
            if best_match >= 0:
                print(f'    Closest: unnamed1 T{best_match+1} ({len(bodies1[best_match])} bytes), '
                      f'{best_common}/{min(len(body6), len(bodies1[best_match]))} bytes match '
                      f'({100*best_common/min(len(body6), len(bodies1[best_match])):.1f}%)')
                # Show first 10 diffs
                ref = bodies1[best_match]
                dcount = 0
                for k in range(min(len(body6), len(ref))):
                    if body6[k] != ref[k]:
                        print(f'      offset 0x{k:04x}: ref=0x{ref[k]:02x} this=0x{body6[k]:02x}')
                        dcount += 1
                        if dcount >= 20:
                            print('      ... (truncated)')
                            break
                if len(body6) != len(ref):
                    print(f'      Size difference: {len(body6)} vs {len(ref)} ({len(body6)-len(ref):+d})')
            print(f'    First 128 bytes:')
            print(hexdump(body6[:128]))

    for ti in range(16):
        body7 = proj7.tracks[ti].body
        if not any(bodies1[j] == body7 for j in range(16)):
            print(f'\n  unnamed7 T{ti+1} ({len(body7)} bytes) has NO MATCH in unnamed1')
            best_match = -1
            best_common = 0
            for j in range(16):
                common = 0
                for k in range(min(len(body7), len(bodies1[j]))):
                    if body7[k] == bodies1[j][k]:
                        common += 1
                if common > best_common:
                    best_common = common
                    best_match = j
            if best_match >= 0:
                print(f'    Closest: unnamed1 T{best_match+1} ({len(bodies1[best_match])} bytes), '
                      f'{best_common}/{min(len(body7), len(bodies1[best_match]))} bytes match '
                      f'({100*best_common/min(len(body7), len(bodies1[best_match])):.1f}%)')
                ref = bodies1[best_match]
                dcount = 0
                for k in range(min(len(body7), len(ref))):
                    if body7[k] != ref[k]:
                        print(f'      offset 0x{k:04x}: ref=0x{ref[k]:02x} this=0x{body7[k]:02x}')
                        dcount += 1
                        if dcount >= 20:
                            print('      ... (truncated)')
                            break
                if len(body7) != len(ref):
                    print(f'      Size difference: {len(body7)} vs {len(ref)} ({len(body7)-len(ref):+d})')
            print(f'    First 128 bytes:')
            print(hexdump(body7[:128]))

    # =========================================================================
    # Section 10: Global file diff summary
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 10: TOTAL FILE SIZE ACCOUNTING')
    print('=' * 70)
    for name, (raw, proj) in files.items():
        total_body = sum(len(t.body) for t in proj.tracks)
        total_preamble = 16 * 4
        print(f'  {name}: total={len(raw)}, pre_track={len(proj.pre_track)}, '
              f'preamble_total={total_preamble}, body_total={total_body}, '
              f'sum={len(proj.pre_track) + total_preamble + total_body}')

    # =========================================================================
    # Section 11: Pattern-slot analysis at 0x56
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 11: OFFSET 0x56 AND SURROUNDING CONTEXT')
    print('=' * 70)
    for name, (raw, proj) in files.items():
        print(f'\n  {name} bytes 0x50-0x80:')
        end = min(0x80, len(proj.pre_track))
        print(hexdump(raw[0x50:end], offset=0x50))

    # =========================================================================
    # Section 12: Deeper look at new pattern blocks
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 12: NEW TRACK BLOCKS INSERTED (unnamed6 T1, unnamed7 T1-T3)')
    print('=' * 70)

    # unnamed6 T1 is the "new" block (not matching anything in unnamed1)
    t1_6_body = proj6.tracks[0].body
    print(f'\n  unnamed6 T1 body ({len(t1_6_body)} bytes) — first 256 bytes:')
    print(hexdump(t1_6_body[:256]))

    # unnamed7: check which tracks are new
    for ti in range(16):
        body7 = proj7.tracks[ti].body
        if not any(bodies1[j] == body7 for j in range(16)):
            # Also check if it matches unnamed6 T1 (the "pattern block")
            if body7 == t1_6_body:
                print(f'\n  unnamed7 T{ti+1} body == unnamed6 T1 (same new pattern block)')
            else:
                # Check if matches unnamed6 non-matching blocks
                pass

    # Show unnamed7 T1-T4 first 128 bytes each
    for ti in range(4):
        body = proj7.tracks[ti].body
        print(f'\n  unnamed7 T{ti+1} body ({len(body)} bytes) — first 128 bytes:')
        print(hexdump(body[:128]))

    # =========================================================================
    # Section 13: Are new blocks identical to each other?
    # =========================================================================
    print('\n' + '=' * 70)
    print('SECTION 13: ARE NEW PATTERN BLOCKS IDENTICAL TO EACH OTHER?')
    print('=' * 70)

    # Collect non-matching blocks from unnamed7
    new_blocks_7 = []
    for ti in range(16):
        body7 = proj7.tracks[ti].body
        if not any(bodies1[j] == body7 for j in range(16)):
            new_blocks_7.append((ti, body7))

    if len(new_blocks_7) > 1:
        print(f'\n  unnamed7 has {len(new_blocks_7)} non-matching blocks:')
        for ti, body in new_blocks_7:
            print(f'    T{ti+1}: {len(body)} bytes')

        # Cross-compare
        for i in range(len(new_blocks_7)):
            for j in range(i + 1, len(new_blocks_7)):
                ti_i, body_i = new_blocks_7[i]
                ti_j, body_j = new_blocks_7[j]
                if body_i == body_j:
                    print(f'    T{ti_i+1} == T{ti_j+1} (identical)')
                else:
                    common = sum(1 for a, b in zip(body_i, body_j) if a == b)
                    max_l = max(len(body_i), len(body_j))
                    print(f'    T{ti_i+1} vs T{ti_j+1}: {common}/{max_l} bytes common ({100*common/max_l:.1f}%)')

    # Check unnamed6 T1 vs unnamed7 new blocks
    print(f'\n  unnamed6 T1 vs unnamed7 new blocks:')
    for ti, body in new_blocks_7:
        if body == t1_6_body:
            print(f'    unnamed7 T{ti+1} == unnamed6 T1')
        else:
            common = sum(1 for a, b in zip(body, t1_6_body) if a == b)
            max_l = max(len(body), len(t1_6_body))
            print(f'    unnamed7 T{ti+1} vs unnamed6 T1: {common}/{max_l} common ({100*common/max_l:.1f}%)')


if __name__ == '__main__':
    main()
