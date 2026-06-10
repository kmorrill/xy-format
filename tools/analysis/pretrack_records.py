#!/usr/bin/env python3
"""Pre-track variable-record parser (record-boundary reframe follow-up).

Model under test (2026-06-09):

    pre_track := fixed_header  dir_header(2B: v56 v57)  record*  handle_table(36B)  tail(1B)
    record    := payload bytes ... [track_tag 0x16..0x1E] 01 00 00
    separator := 00 (between records, not before the first)
    tail      := 0xD6 - 0x21 * len(records)

The fixed header is anchored by its distinctive last 9 bytes
``cd cc cc 00 0c 00 00 01 40`` (groove/header constants), which tolerates
upstream inserts (MIDI config growth at ~0x23, scene ordinal bytes at 0x0F).
"""
from __future__ import annotations

import glob
import re
import sys
from dataclasses import dataclass

# NOTE: the 4th signature byte is the TRACK SCALE (0x03 = default scale 1,
# 0x05 = scale 2, 0x0E = scale 16, 0x01 = scale 1/2 — unnamed 20/21/22).
SIG_RE = re.compile(rb"\x00\x00\x01[\x00-\x0f]\xff\x00\xfc\x00", re.S)
ANCHOR = bytes.fromhex("cdcccc000c00000140")
TAGS = set(range(0x16, 0x1F))


@dataclass
class PretrackParse:
    path: str
    fixed_end: int          # offset just past the anchor
    dir_header: bytes       # 2 bytes (v56 v57 in old terminology)
    records: list[bytes]    # raw record bytes (payload + tag + 01 00 00)
    leftover: bytes         # bytes that did not parse as records
    handle_table: bytes     # 36 bytes
    tail: int
    tail_pred_records: int  # (0xD6 - tail) / 0x21 if integral else -1


def split_track_array_records(body: bytes) -> tuple[list[bytes], bytes]:
    """Split track-array records: each ends ``[tag 0x16..0x1E][01]``."""
    recs: list[bytes] = []
    i = 0
    while i < len(body):
        k = None
        for m in range(i, len(body) - 1):
            if body[m] in TAGS and body[m + 1] == 0x01:
                k = m
                break
        if k is None:
            break
        recs.append(body[i : k + 2])
        i = k + 2
    return recs, body[i:]


def split_pair_list_records(body: bytes) -> list[bytes]:
    """Song-family records: ``00 00``-separated lists of 2-byte pairs.

    Region shape: ``00 00 (pair pair ... 00 00)*`` where pair = [a][b].
    """
    chunks = [c for c in body.split(b"\x00\x00") if c]
    return chunks


def parse_pretrack(path: str, data: bytes) -> PretrackParse | None:
    m = SIG_RE.search(data)
    if m is None:
        return None
    j = m.start()
    hl = 3 if 1 <= data[j - 3] <= 9 else 2
    tail_pos = j - hl - 1
    pre = data[:tail_pos]
    tail = data[tail_pos]

    a = pre.rfind(ANCHOR)
    if a < 0:
        return None
    fixed_end = a + len(ANCHOR)

    ht = pre[-36:]
    region = pre[fixed_end:-36]
    dir_header, body = region[:2], region[2:]

    records, leftover = split_track_array_records(region)
    if not records and leftover.strip(b"\x00"):
        # song-family pair-list records
        records = split_pair_list_records(leftover)
        leftover = b""

    diff = 0xD6 - tail
    pred = diff // 0x21 if diff % 0x21 == 0 else -1
    return PretrackParse(path, fixed_end, dir_header, records, leftover, ht, tail, pred)


def main(patterns: list[str]) -> int:
    files: list[str] = []
    for pat in patterns:
        files.extend(sorted(glob.glob(pat)))
    ok = bad = skipped = 0
    for f in files:
        data = open(f, "rb").read()
        if data[:4] != bytes.fromhex("ddccbbaa"):
            continue
        p = parse_pretrack(f, data)
        name = f.split("/")[-1]
        if p is None:
            print(f"!! {name}: no anchor / no signature")
            skipped += 1
            continue
        match = len(p.records) == p.tail_pred_records and not p.leftover.strip(b"\x00")
        status = "OK " if match else "BAD"
        if match:
            ok += 1
        else:
            bad += 1
        recs = " | ".join(r.hex(" ") for r in p.records) or "-"
        extra = f" leftover={p.leftover.hex(' ')}" if p.leftover else ""
        ht_used = sum(1 for k in range(0, 36, 3) if p.handle_table[k : k + 3] != b"\xff\x00\x00")
        print(
            f"{status} {name:<42} dir={p.dir_header.hex(' ')} tail=0x{p.tail:02x}"
            f" pred={p.tail_pred_records} recs={len(p.records)} ht_used={ht_used}"
            f"  [{recs}]{extra}"
        )
    print(f"\nok={ok} bad={bad} skipped={skipped}")
    return 0


if __name__ == "__main__":
    args = sys.argv[1:] or [
        "src/one-off-changes-from-default/*.xy",
        "src/bleez*.xy",
        "src/unnamed*.xy",
    ]
    raise SystemExit(main(args))
