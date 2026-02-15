#!/usr/bin/env python3
"""Extract p-lock param_ids from CC mapping experiment corpus files.

Scans track bodies for the config-tail signature, then reads the p-lock
entry table that follows. Outputs a comprehensive CC → param_id mapping.
"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from xy.container import XYProject
from xy.plocks import (
    CONFIG_TAIL_SIG,
    extract_drum_plock_entries,
    extract_synth_plock_entries,
    find_plock_start,
)
from collections import defaultdict

# Engine names
ENGINE_NAMES = {
    0x03: "Drum", 0x07: "EPiano", 0x12: "Prism", 0x13: "Hardsync",
    0x14: "Dissolve", 0x16: "Axis", 0x1E: "Multi", 0x1F: "Wavetable",
    0x00: "aux-0x00", 0x02: "aux-0x02", 0x05: "aux-0x05", 0x06: "aux-0x06",
}

def find_config_tail(body: bytes) -> int:
    """Find offset of config tail signature in track body. Returns -1 if not found."""
    start = find_plock_start(body)
    if start is None:
        return -1
    return start - len(CONFIG_TAIL_SIG)


def analyze_file(filepath: str, track_ccs: dict, label: str, verbose=False):
    """Analyze a single corpus file."""
    with open(filepath, 'rb') as f:
        data = f.read()

    proj = XYProject.from_bytes(data)
    print(f"\n{'='*70}")
    print(f"  {label}: {os.path.basename(filepath)}")
    print(f"{'='*70}")

    results = {}

    for track_idx in range(16):
        track = proj.tracks[track_idx]
        track_num = track_idx + 1

        if track_num not in track_ccs:
            continue

        cc = track_ccs[track_num]
        engine = track.engine_id
        engine_name = ENGINE_NAMES.get(engine, f"unk-0x{engine:02X}")
        type_byte = track.type_byte

        sig_off = find_config_tail(track.body)

        print(f"\n  T{track_num} ({engine_name}, type=0x{type_byte:02X}, eng=0x{engine:02X}, CC{cc}):")

        if sig_off < 0:
            print(f"    Config tail signature not found!")
            continue

        start = sig_off + len(CONFIG_TAIL_SIG)
        print(f"    Config tail at body+0x{sig_off:04X}, entries start at body+0x{start:04X}")

        # Decide extraction strategy
        is_drum_t1 = (engine == 0x03 and track_num in (1, 2))

        if is_drum_t1:
            entries, count = extract_drum_plock_entries(track.body, start, verbose=verbose)
            fmt = "DRUM-18B"
        else:
            entries, count = extract_synth_plock_entries(track.body, start, verbose=verbose)
            fmt = "SYNTH-5B"

        if entries:
            for param_id, values in entries:
                n = len(values)
                val_preview = ', '.join(str(v) for v in values[:6])
                if n > 6:
                    val_preview += '...'
                print(f"    [{fmt}] param_id=0x{param_id:02X}  ({n} vals): {val_preview}")
                if isinstance(cc, int):
                    results[track_num] = (cc, param_id, engine_name, n)
        else:
            print(f"    No entries found ({count} total slots scanned)")
            # Dump raw bytes for debugging
            region = track.body[start:start+40]
            print(f"    Raw: {region.hex(' ')}")

    return results


def main():
    corpus = "src/one-off-changes-from-default"

    experiments = {
        "unnamed 120.xy": {
            "label": "CC32 on T3 only (original discovery)",
            "tracks": {3: 32},
        },
        "unnamed 121.xy": {
            "label": "cc_map_1a: CC12-15 + CC20-23",
            "tracks": {1: 12, 2: 13, 3: 14, 4: 15, 5: 20, 6: 21, 7: 22, 8: 23},
        },
        "unnamed 122.xy": {
            "label": "cc_map_1b: CC24-31 (T1/T2 synth-swapped)",
            "tracks": {1: 24, 2: 25, 3: 26, 4: 27, 5: 28, 6: 29, 7: 30, 8: 31},
        },
        "unnamed 123.xy": {
            "label": "cc_map_1c: CC32-39",
            "tracks": {1: 32, 2: 33, 3: 34, 4: 35, 5: 36, 6: 37, 7: 38, 8: 39},
        },
        "unnamed 124.xy": {
            "label": "cc_map_1d: CC40/41/CC7/CC9/CC10",
            "tracks": {1: 40, 2: 41, 3: 7, 4: 9, 5: 10},
        },
        "unnamed 125.xy": {
            "label": "cc_map_multi: 3 CCs on T3",
            "tracks": {3: "32+12+14"},
        },
        "unnamed 126.xy": {
            "label": "cc_map_2a: aux T9-T16",
            "tracks": {9: 7, 10: 10, 11: 12, 12: 40, 13: 12, 14: 12, 15: 12, 16: 12},
        },
    }

    all_results = {}
    verbose = "--verbose" in sys.argv or "-v" in sys.argv

    for filename in sorted(experiments.keys()):
        info = experiments[filename]
        filepath = os.path.join(corpus, filename)
        if not os.path.exists(filepath):
            print(f"\n  SKIP: {filename} not found")
            continue
        results = analyze_file(filepath, info["tracks"], info["label"], verbose=verbose)
        all_results[filename] = results

    # Collect clean results
    rows = []
    for filename, results in all_results.items():
        for track_num, (cc, param_id, engine, count) in results.items():
            rows.append((cc, param_id, engine, track_num, filename, count))

    rows.sort(key=lambda r: (r[0], r[1]))

    print(f"\n{'='*70}")
    print(f"  CLEAN CC → param_id MAPPING TABLE")
    print(f"{'='*70}")
    print(f"  {'CC':>4}  {'param_id':>10}  {'Engine':>12}  {'Track':>6}  {'Vals':>5}  Source")
    print(f"  {'─'*4}  {'─'*10}  {'─'*12}  {'─'*6}  {'─'*5}  {'─'*20}")

    for cc, param_id, engine, track, source, count in rows:
        print(f"  CC{cc:>3}  0x{param_id:02X}        {engine:>12}  T{track:<5}  {count:>5}  {source}")

    # Cross-engine verification
    print(f"\n{'='*70}")
    print(f"  CROSS-ENGINE VERIFICATION")
    print(f"{'='*70}")

    by_cc = defaultdict(list)
    for cc, param_id, engine, track, source, count in rows:
        by_cc[cc].append((param_id, engine, track, source))

    for cc in sorted(by_cc.keys()):
        entries = by_cc[cc]
        param_ids = set(e[0] for e in entries)
        engines = set(e[1] for e in entries)

        if len(param_ids) == 1 and len(engines) > 1:
            tag = " ** UNIVERSAL **"
        elif len(param_ids) > 1:
            tag = " [VARIES by engine]"
        else:
            tag = ""

        pids = ', '.join(f'0x{p:02X}' for p in sorted(param_ids))
        print(f"\n  CC{cc:>3} → param_id={pids}{tag}")
        for pid, eng, trk, src in entries:
            print(f"    T{trk:>2} {eng:>12}: 0x{pid:02X}  ({src})")

    # Summary: sorted by param_id to show sequential pattern
    print(f"\n{'='*70}")
    print(f"  SORTED BY param_id (sequential pattern analysis)")
    print(f"{'='*70}")

    # Filter to non-drum synth tracks only for clean pattern analysis
    synth_rows = [(cc, pid, eng, trk, src, cnt) for cc, pid, eng, trk, src, cnt in rows
                  if eng != "Drum" and not eng.startswith("aux")]
    synth_rows.sort(key=lambda r: r[1])  # sort by param_id

    print(f"\n  Synth tracks only (non-drum, non-aux):")
    print(f"  {'param_id':>10}  {'CC':>4}  {'Parameter':>20}  {'Engine(s)'}")
    print(f"  {'─'*10}  {'─'*4}  {'─'*20}  {'─'*20}")

    # CC name lookup
    CC_NAMES = {
        7: "Volume", 9: "Mute", 10: "Pan",
        12: "Param 1", 13: "Param 2", 14: "Param 3", 15: "Param 4",
        20: "Amp Attack", 21: "Amp Decay", 22: "Amp Sustain", 23: "Amp Release",
        24: "Flt Attack", 25: "Flt Decay", 26: "Flt Sustain", 27: "Flt Release",
        28: "Flt Env Amt", 29: "Flt Resonance", 30: "Flt Key Track", 31: "Flt Velocity",
        32: "Flt Cutoff", 33: "Flt Type", 34: "LFO Rate", 35: "LFO Depth",
        36: "LFO Dest", 37: "LFO Wave", 38: "LFO Sync", 39: "LFO Phase",
        40: "LFO Param", 41: "LFO Key Sync",
    }

    for pid, cc, eng, trk, src, cnt in synth_rows:
        name = CC_NAMES.get(cc, f"CC{cc}")
        # Collect all engines seen for this CC
        all_eng = set(e[1] for e in by_cc[cc])
        eng_str = ', '.join(sorted(all_eng))
        print(f"  0x{pid:02X}        CC{cc:>3}  {name:>20}  {eng_str}")


if __name__ == "__main__":
    main()
