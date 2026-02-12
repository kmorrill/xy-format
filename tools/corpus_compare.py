#!/usr/bin/env python3
"""Compare two indexed `.xy` files at logical-entry granularity.

Requires an existing corpus_lab index DB.

Examples
--------
  python tools/corpus_compare.py j07_all16_p9_sparsemap.xy k04_song_safefix2_12347.xy
  python tools/corpus_compare.py k03_song_safefix_12347.xy k04_song_safefix2_12347.xy
"""

from __future__ import annotations

import argparse
import sqlite3
from pathlib import Path
from typing import Dict, Tuple


def _resolve_file(conn: sqlite3.Connection, ref: str) -> sqlite3.Row:
    p = Path(ref)
    if p.exists():
        row = conn.execute(
            "SELECT * FROM files WHERE path=?", (str(p.resolve()),)
        ).fetchone()
        if row:
            return row

    row = conn.execute("SELECT * FROM files WHERE path=?", (ref,)).fetchone()
    if row:
        return row

    rows = conn.execute("SELECT * FROM files WHERE name=?", (Path(ref).name,)).fetchall()
    if len(rows) == 1:
        return rows[0]
    if len(rows) > 1:
        sample = ", ".join(r["path"] for r in rows[:5])
        raise SystemExit(f"ambiguous file name {ref!r}; matches: {sample}")
    raise SystemExit(f"file not found in index: {ref!r}")


def _entries_by_key(conn: sqlite3.Connection, file_id: int) -> Dict[Tuple[int, int], sqlite3.Row]:
    rows = conn.execute(
        """
        SELECT track, pattern, pattern_count, ordinal,
               pre0, pre1, pre2, pre3,
               body_len, type_byte, engine_id, active,
               prev_active, event_tail, event_type, event_count
        FROM entries
        WHERE file_id=?
        ORDER BY track, pattern
        """,
        (file_id,),
    ).fetchall()
    return {(r["track"], r["pattern"]): r for r in rows}


def _fmt_hex(byte_val: int | None) -> str:
    if byte_val is None:
        return "-"
    return f"0x{byte_val:02X}"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file_a", help="first file (path or basename in DB)")
    parser.add_argument("file_b", help="second file (path or basename in DB)")
    parser.add_argument("--db", default="output/corpus_lab.sqlite", help="SQLite path")
    args = parser.parse_args()

    conn = sqlite3.connect(args.db)
    conn.row_factory = sqlite3.Row

    a = _resolve_file(conn, args.file_a)
    b = _resolve_file(conn, args.file_b)

    print(f"A: {a['name']}  source={a['source']} size={a['size']} sha1={a['sha1']}")
    print(f"B: {b['name']}  source={b['source']} size={b['size']} sha1={b['sha1']}")
    print(
        "File-level deltas: "
        f"size={int(b['size'])-int(a['size'])} "
        f"pre_track_len={int((b['pre_track_len'] or 0)) - int((a['pre_track_len'] or 0))} "
        f"logical_entries={int((b['logical_entries'] or 0)) - int((a['logical_entries'] or 0))}"
    )

    ea = _entries_by_key(conn, int(a["id"]))
    eb = _entries_by_key(conn, int(b["id"]))
    keys = sorted(set(ea) | set(eb))

    fields = [
        "pattern_count",
        "ordinal",
        "pre0",
        "pre1",
        "pre2",
        "body_len",
        "type_byte",
        "engine_id",
        "active",
        "prev_active",
        "event_tail",
        "event_type",
        "event_count",
    ]

    diffs = 0
    for key in keys:
        ra = ea.get(key)
        rb = eb.get(key)
        if ra is None or rb is None:
            diffs += 1
            print(f"T{key[0]:02d} P{key[1]}: present only in {'A' if rb is None else 'B'}")
            continue

        row_diff = []
        for f in fields:
            va = ra[f]
            vb = rb[f]
            if va != vb:
                if f in ("pre0", "pre1", "pre2", "type_byte", "engine_id", "event_type"):
                    row_diff.append(f"{f} {_fmt_hex(va)}->{_fmt_hex(vb)}")
                else:
                    row_diff.append(f"{f} {va}->{vb}")

        if row_diff:
            diffs += 1
            print(f"T{key[0]:02d} P{key[1]}: " + "; ".join(row_diff))

    if diffs == 0:
        print("No logical-entry differences")
    else:
        print(f"Total differing logical entries: {diffs}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
