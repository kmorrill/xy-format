#!/usr/bin/env python3
"""Index/query OP-XY corpus files with SQLite.

Purpose
-------
Give us one place to ask structural questions across many `.xy` files
instead of doing one-off diffs.

Examples
--------
  python tools/corpus_lab.py index
  python tools/corpus_lab.py report clone-pre1
  python tools/corpus_lab.py report topology --where "f.source='oneoff'"
  python tools/corpus_lab.py sql "SELECT name,size,logical_entries FROM files ORDER BY size DESC LIMIT 10"
  python tools/corpus_lab.py record output/k04_song_safefix2_12347.xy pass
  python tools/corpus_lab.py report result-summary
"""

from __future__ import annotations

import argparse
import glob
import hashlib
import sqlite3
import sys
from pathlib import Path
from typing import Iterable, List, Optional, Sequence, Tuple

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import TrackBlock, XYProject

TRACK_SIG_HEAD = b"\x00\x00\x01"
TRACK_SIG_TAIL = b"\xff\x00\xfc\x00"
KNOWN_EVENT_TYPES = {0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x25, 0x2D}
DEFAULT_DB = str(REPO_ROOT / "output" / "corpus_lab.sqlite")


def _sha1(data: bytes) -> str:
    return hashlib.sha1(data).hexdigest()


def _source_for_path(path: Path) -> str:
    s = str(path).replace("\\", "/")
    if "/src/one-off-changes-from-default/" in s:
        return "oneoff"
    if "/output/" in s:
        return "output"
    if "/src/" in s:
        return "src"
    return "other"


def _find_track_sigs(buf: bytes) -> List[int]:
    offsets: List[int] = []
    i = 0
    while i < len(buf) - 8:
        j = buf.find(TRACK_SIG_HEAD, i)
        if j == -1:
            break
        if j + 8 <= len(buf) and buf[j + 4 : j + 8] == TRACK_SIG_TAIL:
            offsets.append(j)
            i = j + 4
        else:
            i = j + 1
    return offsets


def _split_overflow(track16: TrackBlock) -> List[Tuple[bytes, bytes]]:
    body = track16.body
    sigs = _find_track_sigs(body)
    if not sigs:
        return [(track16.preamble, track16.body)]

    entries: List[Tuple[bytes, bytes]] = []
    for idx, sig_off in enumerate(sigs):
        preamble = track16.preamble if idx == 0 else body[sig_off - 4 : sig_off]
        end = sigs[idx + 1] - 4 if idx + 1 < len(sigs) else len(body)
        entries.append((preamble, body[sig_off:end]))
    return entries


def _extract_logical_entries(project: XYProject) -> List[dict]:
    raw: List[Tuple[bytes, bytes]] = [(t.preamble, t.body) for t in project.tracks[:15]]
    raw.extend(_split_overflow(project.tracks[15]))

    entries: List[dict] = []
    i = 0
    for track in range(1, 17):
        if i >= len(raw):
            raise ValueError(f"ran out of raw entries before track {track}")
        pattern_count = raw[i][0][1] or 1
        for pattern in range(1, pattern_count + 1):
            if i >= len(raw):
                raise ValueError(f"ran out of raw entries at track {track} pattern {pattern}")
            preamble, body = raw[i]
            type_byte = body[9] if len(body) > 9 else -1
            engine_id = body[0x0D] if type_byte == 0x05 and len(body) > 0x0D else (
                body[0x0B] if len(body) > 0x0B else -1
            )
            entries.append(
                {
                    "ordinal": i,
                    "track": track,
                    "pattern": pattern,
                    "pattern_count": pattern_count,
                    "is_clone": 1 if pattern > 1 else 0,
                    "is_leader": 1 if pattern == 1 and pattern_count > 1 else 0,
                    "is_last": 1 if pattern == pattern_count else 0,
                    "preamble": preamble,
                    "pre0": preamble[0],
                    "pre1": preamble[1],
                    "pre2": preamble[2],
                    "pre3": preamble[3],
                    "body_len": len(body),
                    "type_byte": type_byte,
                    "engine_id": engine_id,
                    "active": 1 if type_byte == 0x07 else 0,
                    "body": body,
                }
            )
            i += 1

    if i != len(raw):
        raise ValueError(f"logical mapping consumed {i}/{len(raw)} raw entries")

    for idx, e in enumerate(entries):
        prev_active = entries[idx - 1]["active"] if idx > 0 else 0
        e["prev_active"] = prev_active

    return entries


def _parse_event_ending_at_tail(body: bytes) -> Optional[Tuple[int, int, int]]:
    """Return (start, event_type, count) for an event that ends exactly at body EOF."""

    n = len(body)
    if n < 12:
        return None

    # Search only near tail; events can still be long so keep window generous.
    start_min = max(0, n - 5000)

    for start in range(start_min, n - 2):
        etype = body[start]
        count = body[start + 1]
        if etype not in KNOWN_EVENT_TYPES or not (1 <= count <= 120):
            continue

        pos = start + 2
        ok = True
        for note_i in range(count):
            if pos >= n:
                ok = False
                break

            matched_tick = False
            for tick_len in (2, 4):
                p = pos
                if p + tick_len >= n:
                    continue
                flag = body[p + tick_len]
                if flag not in (0x00, 0x02):
                    continue

                p += tick_len + 1
                if flag == 0x00:
                    if p + 2 > n:
                        continue
                    p += 2

                if p >= n:
                    continue
                if body[p] == 0xF0:
                    if p + 4 > n:
                        continue
                    p += 4
                else:
                    if p + 5 > n:
                        continue
                    p += 5

                if p + 2 > n:
                    continue
                p += 2

                trail = 2 if note_i == count - 1 else 3
                if p + trail > n:
                    continue
                p += trail

                pos = p
                matched_tick = True
                break

            if not matched_tick:
                ok = False
                break

        if ok and pos == n:
            return (start, etype, count)

    return None


def _find_ff_table_start(pre_track: bytes) -> Optional[int]:
    """First offset where eight consecutive `ff 00 00` entries appear."""
    for i in range(0x56, len(pre_track) - 24):
        if all(pre_track[i + k * 3 : i + k * 3 + 3] == b"\xff\x00\x00" for k in range(8)):
            return i
    return None


def _collect_paths(patterns: Sequence[str]) -> List[Path]:
    paths: List[Path] = []
    for pattern in patterns:
        matches = sorted(Path(p) for p in glob.glob(pattern, recursive=True))
        if matches:
            paths.extend(matches)
        else:
            p = Path(pattern)
            if p.exists():
                paths.append(p)
    unique: List[Path] = []
    seen: set[Path] = set()
    for p in paths:
        rp = p.resolve()
        if rp not in seen:
            seen.add(rp)
            unique.append(rp)
    return unique


def _create_schema(conn: sqlite3.Connection) -> None:
    conn.executescript(
        """
        CREATE TABLE IF NOT EXISTS files (
          id INTEGER PRIMARY KEY,
          path TEXT UNIQUE NOT NULL,
          name TEXT NOT NULL,
          source TEXT NOT NULL,
          size INTEGER NOT NULL,
          sha1 TEXT NOT NULL,
          parse_ok INTEGER NOT NULL,
          parse_error TEXT,
          pre_track_len INTEGER,
          pre56_hex TEXT,
          ff_table_start INTEGER,
          descriptor_var_hex TEXT,
          logical_entries INTEGER,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        );

        CREATE TABLE IF NOT EXISTS entries (
          id INTEGER PRIMARY KEY,
          file_id INTEGER NOT NULL REFERENCES files(id) ON DELETE CASCADE,
          ordinal INTEGER NOT NULL,
          track INTEGER NOT NULL,
          pattern INTEGER NOT NULL,
          pattern_count INTEGER NOT NULL,
          is_clone INTEGER NOT NULL,
          is_leader INTEGER NOT NULL,
          is_last INTEGER NOT NULL,
          preamble_hex TEXT NOT NULL,
          pre0 INTEGER NOT NULL,
          pre1 INTEGER NOT NULL,
          pre2 INTEGER NOT NULL,
          pre3 INTEGER NOT NULL,
          body_len INTEGER NOT NULL,
          type_byte INTEGER NOT NULL,
          engine_id INTEGER NOT NULL,
          active INTEGER NOT NULL,
          prev_active INTEGER NOT NULL,
          event_tail INTEGER NOT NULL,
          event_start INTEGER,
          event_type INTEGER,
          event_count INTEGER
        );

        CREATE INDEX IF NOT EXISTS idx_entries_file ON entries(file_id);
        CREATE INDEX IF NOT EXISTS idx_entries_track_pattern ON entries(track, pattern);
        CREATE INDEX IF NOT EXISTS idx_entries_clone_active ON entries(is_clone, prev_active, pre1);
        CREATE INDEX IF NOT EXISTS idx_entries_event ON entries(event_tail, event_type, event_count);

        CREATE TABLE IF NOT EXISTS test_results (
          id INTEGER PRIMARY KEY,
          file_id INTEGER NOT NULL REFERENCES files(id) ON DELETE CASCADE,
          status TEXT NOT NULL,
          error_class TEXT,
          note TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        );
        CREATE INDEX IF NOT EXISTS idx_test_results_file_id ON test_results(file_id, id DESC);
        """
    )


def _clear(conn: sqlite3.Connection) -> None:
    conn.execute("DELETE FROM test_results")
    conn.execute("DELETE FROM entries")
    conn.execute("DELETE FROM files")


def _insert_file(conn: sqlite3.Connection, row: dict) -> int:
    cur = conn.execute(
        """
        INSERT INTO files(
          path,name,source,size,sha1,parse_ok,parse_error,
          pre_track_len,pre56_hex,ff_table_start,descriptor_var_hex,logical_entries
        ) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)
        ON CONFLICT(path) DO UPDATE SET
          name=excluded.name,
          source=excluded.source,
          size=excluded.size,
          sha1=excluded.sha1,
          parse_ok=excluded.parse_ok,
          parse_error=excluded.parse_error,
          pre_track_len=excluded.pre_track_len,
          pre56_hex=excluded.pre56_hex,
          ff_table_start=excluded.ff_table_start,
          descriptor_var_hex=excluded.descriptor_var_hex,
          logical_entries=excluded.logical_entries,
          created_at=CURRENT_TIMESTAMP
        """,
        (
            row["path"],
            row["name"],
            row["source"],
            row["size"],
            row["sha1"],
            row["parse_ok"],
            row["parse_error"],
            row["pre_track_len"],
            row["pre56_hex"],
            row["ff_table_start"],
            row["descriptor_var_hex"],
            row["logical_entries"],
        ),
    )
    if cur.lastrowid:
        return int(cur.lastrowid)

    file_id = conn.execute("SELECT id FROM files WHERE path=?", (row["path"],)).fetchone()
    if not file_id:
        raise RuntimeError("failed to fetch file id after upsert")
    return int(file_id[0])


def _replace_entries(conn: sqlite3.Connection, file_id: int, entries: List[dict]) -> None:
    conn.execute("DELETE FROM entries WHERE file_id=?", (file_id,))
    payload = []
    for e in entries:
        tail = _parse_event_ending_at_tail(e["body"])
        payload.append(
            (
                file_id,
                e["ordinal"],
                e["track"],
                e["pattern"],
                e["pattern_count"],
                e["is_clone"],
                e["is_leader"],
                e["is_last"],
                e["preamble"].hex(" "),
                e["pre0"],
                e["pre1"],
                e["pre2"],
                e["pre3"],
                e["body_len"],
                e["type_byte"],
                e["engine_id"],
                e["active"],
                e["prev_active"],
                1 if tail else 0,
                tail[0] if tail else None,
                tail[1] if tail else None,
                tail[2] if tail else None,
            )
        )

    conn.executemany(
        """
        INSERT INTO entries(
          file_id,ordinal,track,pattern,pattern_count,is_clone,is_leader,is_last,
          preamble_hex,pre0,pre1,pre2,pre3,body_len,type_byte,engine_id,
          active,prev_active,event_tail,event_start,event_type,event_count
        ) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
        """,
        payload,
    )


def cmd_index(args: argparse.Namespace) -> int:
    paths = _collect_paths(args.glob)
    if not paths:
        print("No files matched")
        return 1

    db_path = Path(args.db)
    db_path.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(str(db_path))
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys=ON")

    _create_schema(conn)
    if not args.append:
        _clear(conn)

    parsed_ok = 0
    parsed_err = 0

    for path in paths:
        raw = path.read_bytes()
        record = {
            "path": str(path),
            "name": path.name,
            "source": _source_for_path(path),
            "size": len(raw),
            "sha1": _sha1(raw),
            "parse_ok": 0,
            "parse_error": None,
            "pre_track_len": None,
            "pre56_hex": None,
            "ff_table_start": None,
            "descriptor_var_hex": None,
            "logical_entries": None,
        }

        entries: List[dict] = []
        try:
            project = XYProject.from_bytes(raw)
            pre = project.pre_track
            ff_start = _find_ff_table_start(pre)
            record["parse_ok"] = 1
            record["pre_track_len"] = len(pre)
            record["pre56_hex"] = pre[0x56:0x58].hex(" ") if len(pre) >= 0x58 else None
            record["ff_table_start"] = ff_start
            if ff_start is not None and len(pre) >= 0x56:
                record["descriptor_var_hex"] = pre[0x56:ff_start].hex(" ")
            entries = _extract_logical_entries(project)
            record["logical_entries"] = len(entries)
            parsed_ok += 1
        except Exception as exc:
            record["parse_error"] = str(exc)
            parsed_err += 1

        file_id = _insert_file(conn, record)
        if record["parse_ok"]:
            _replace_entries(conn, file_id, entries)

    conn.commit()

    files_n = conn.execute("SELECT COUNT(*) AS n FROM files").fetchone()["n"]
    entries_n = conn.execute("SELECT COUNT(*) AS n FROM entries").fetchone()["n"]

    print(f"Indexed db: {db_path}")
    print(f"  files:   {files_n}")
    print(f"  entries: {entries_n}")
    print(f"  parse ok: {parsed_ok}  parse errors: {parsed_err}")
    return 0


def _print_rows(rows: Iterable[sqlite3.Row]) -> None:
    rows = list(rows)
    if not rows:
        print("(no rows)")
        return

    cols = rows[0].keys()
    print("\t".join(cols))
    for r in rows:
        print("\t".join("" if r[c] is None else str(r[c]) for c in cols))


def cmd_sql(args: argparse.Namespace) -> int:
    conn = sqlite3.connect(args.db)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys=ON")
    _create_schema(conn)
    try:
        rows = conn.execute(args.query)
    except sqlite3.Error as exc:
        print(f"SQL error: {exc}")
        return 1
    _print_rows(rows)
    return 0


def _resolve_file_id(conn: sqlite3.Connection, file_ref: str) -> Tuple[int, str]:
    p = Path(file_ref)

    # 1) Exact absolute path match if the file exists.
    if p.exists():
        resolved = str(p.resolve())
        row = conn.execute("SELECT id, name FROM files WHERE path=?", (resolved,)).fetchone()
        if row:
            return int(row["id"]), str(row["name"])

    # 2) Exact literal path match (for already-absolute refs not present locally).
    row = conn.execute("SELECT id, name FROM files WHERE path=?", (file_ref,)).fetchone()
    if row:
        return int(row["id"]), str(row["name"])

    # 3) Basename match.
    rows = conn.execute("SELECT id, name, path FROM files WHERE name=?", (Path(file_ref).name,)).fetchall()
    if len(rows) == 1:
        return int(rows[0]["id"]), str(rows[0]["name"])
    if len(rows) > 1:
        paths = ", ".join(str(r["path"]) for r in rows[:5])
        raise ValueError(f"ambiguous file name {file_ref!r}; matches: {paths}")

    raise ValueError(f"file not found in index: {file_ref!r}")


def cmd_record(args: argparse.Namespace) -> int:
    conn = sqlite3.connect(args.db)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys=ON")
    _create_schema(conn)
    try:
        file_id, file_name = _resolve_file_id(conn, args.file)
    except ValueError as exc:
        print(str(exc))
        return 1

    conn.execute(
        """
        INSERT INTO test_results(file_id, status, error_class, note)
        VALUES (?, ?, ?, ?)
        """,
        (file_id, args.status, args.error_class, args.note),
    )
    conn.commit()
    print(f"Recorded: {file_name} status={args.status} error_class={args.error_class or '-'}")
    return 0


def cmd_results(args: argparse.Namespace) -> int:
    conn = sqlite3.connect(args.db)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys=ON")
    _create_schema(conn)

    where = ""
    if args.where:
        where = f" AND ({args.where})"

    query = f"""
        WITH latest AS (
          SELECT tr.*
          FROM test_results tr
          JOIN (
            SELECT file_id, MAX(id) AS max_id
            FROM test_results
            GROUP BY file_id
          ) x ON x.max_id = tr.id
        )
        SELECT
          f.name,
          f.source,
          l.status,
          COALESCE(l.error_class, '') AS error_class,
          COALESCE(l.note, '') AS note,
          l.created_at
        FROM latest l
        JOIN files f ON f.id = l.file_id
        WHERE 1=1 {where}
        ORDER BY l.id DESC
        LIMIT ?
    """
    rows = conn.execute(query, (args.limit,)).fetchall()
    _print_rows(rows)
    return 0


REPORTS = {
    "clone-pre1": """
        SELECT
          printf('0x%02X', e.pre1) AS clone_pre1,
          e.prev_active,
          COUNT(*) AS n
        FROM entries e
        JOIN files f ON f.id = e.file_id
        WHERE e.is_clone = 1 {extra_where}
        GROUP BY e.pre1, e.prev_active
        ORDER BY e.prev_active DESC, n DESC, e.pre1
    """,
    "topology": """
        SELECT
          f.name,
          f.source,
          e.track,
          MAX(e.pattern_count) AS patterns
        FROM entries e
        JOIN files f ON f.id = e.file_id
        WHERE 1=1 {extra_where}
        GROUP BY f.id, e.track
        ORDER BY f.name, e.track
    """,
    "event-tail": """
        SELECT
          f.source,
          printf('0x%02X', e.event_type) AS event_type,
          e.event_count,
          COUNT(*) AS n
        FROM entries e
        JOIN files f ON f.id = e.file_id
        WHERE e.event_tail = 1 {extra_where}
        GROUP BY f.source, e.event_type, e.event_count
        ORDER BY n DESC, f.source, e.event_type
    """,
    "crash-risk-clones": """
        SELECT
          f.name,
          e.track,
          e.pattern,
          printf('0x%02X', e.pre1) AS pre1,
          e.prev_active
        FROM entries e
        JOIN files f ON f.id = e.file_id
        WHERE e.is_clone = 1
          AND e.prev_active = 1
          AND (e.pre1 < 128 AND e.pre1 NOT IN (0x2E, 0x64))
          {extra_where}
        ORDER BY f.name, e.track, e.pattern
    """,
    "clone-low-active": """
        SELECT
          f.name,
          e.track,
          e.pattern,
          printf('0x%02X', e.pre1) AS pre1
        FROM entries e
        JOIN files f ON f.id = e.file_id
        WHERE e.is_clone = 1
          AND e.prev_active = 1
          AND e.pre1 < 128
          {extra_where}
        ORDER BY f.name, e.track, e.pattern
    """,
    "result-summary": """
        WITH latest AS (
          SELECT tr.*
          FROM test_results tr
          JOIN (
            SELECT file_id, MAX(id) AS max_id
            FROM test_results
            GROUP BY file_id
          ) x ON x.max_id = tr.id
        )
        SELECT
          l.status,
          COALESCE(l.error_class, '') AS error_class,
          COUNT(*) AS n
        FROM latest l
        JOIN files f ON f.id = l.file_id
        WHERE 1=1 {extra_where}
        GROUP BY l.status, l.error_class
        ORDER BY n DESC, l.status
    """,
    "signal-clone-pre1": """
        WITH latest AS (
          SELECT tr.*
          FROM test_results tr
          JOIN (
            SELECT file_id, MAX(id) AS max_id
            FROM test_results
            GROUP BY file_id
          ) x ON x.max_id = tr.id
        )
        SELECT
          l.status,
          printf('0x%02X', e.pre1) AS pre1,
          e.prev_active,
          COUNT(*) AS n
        FROM entries e
        JOIN latest l ON l.file_id = e.file_id
        JOIN files f ON f.id = e.file_id
        WHERE e.is_clone = 1
          AND e.prev_active = 1
          {extra_where}
        GROUP BY l.status, e.pre1, e.prev_active
        ORDER BY l.status, n DESC, e.pre1
    """,
    "signal-event-tail": """
        WITH latest AS (
          SELECT tr.*
          FROM test_results tr
          JOIN (
            SELECT file_id, MAX(id) AS max_id
            FROM test_results
            GROUP BY file_id
          ) x ON x.max_id = tr.id
        )
        SELECT
          l.status,
          printf('0x%02X', e.event_type) AS event_type,
          e.event_count,
          COUNT(*) AS n
        FROM entries e
        JOIN latest l ON l.file_id = e.file_id
        JOIN files f ON f.id = e.file_id
        WHERE e.event_tail = 1
          {extra_where}
        GROUP BY l.status, e.event_type, e.event_count
        ORDER BY l.status, n DESC, e.event_type, e.event_count
    """,
}


def cmd_report(args: argparse.Namespace) -> int:
    tmpl = REPORTS.get(args.name)
    if tmpl is None:
        print(f"Unknown report: {args.name}")
        print("Available:", ", ".join(sorted(REPORTS)))
        return 1

    conn = sqlite3.connect(args.db)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys=ON")
    _create_schema(conn)

    extra_where = ""
    if args.where:
        extra_where = f" AND ({args.where})"

    query = tmpl.format(extra_where=extra_where)
    rows = conn.execute(query)
    _print_rows(rows)
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_index = sub.add_parser("index", help="Index files into sqlite")
    p_index.add_argument("--db", default=DEFAULT_DB, help="SQLite path")
    p_index.add_argument(
        "--glob",
        action="append",
        default=[
            "src/one-off-changes-from-default/*.xy",
            "output/*.xy",
        ],
        help="Input glob (repeatable)",
    )
    p_index.add_argument("--append", action="store_true", help="Append/update instead of clearing first")
    p_index.set_defaults(func=cmd_index)

    p_sql = sub.add_parser("sql", help="Run raw SQL")
    p_sql.add_argument("query", help="SQL query")
    p_sql.add_argument("--db", default=DEFAULT_DB, help="SQLite path")
    p_sql.set_defaults(func=cmd_sql)

    p_record = sub.add_parser("record", help="Record a device test outcome for one indexed file")
    p_record.add_argument("file", help="File path or basename already present in the index")
    p_record.add_argument("status", choices=("pass", "crash", "untested"), help="Outcome status")
    p_record.add_argument("--error-class", help="Optional crash class (e.g. num_patterns, fixed_vector)")
    p_record.add_argument("--note", help="Optional free-text note")
    p_record.add_argument("--db", default=DEFAULT_DB, help="SQLite path")
    p_record.set_defaults(func=cmd_record)

    p_results = sub.add_parser("results", help="Show latest recorded outcomes")
    p_results.add_argument("--where", help="Extra SQL filter applied as AND (...) on files alias f")
    p_results.add_argument("--limit", type=int, default=200, help="Max rows to print")
    p_results.add_argument("--db", default=DEFAULT_DB, help="SQLite path")
    p_results.set_defaults(func=cmd_results)

    p_report = sub.add_parser("report", help="Run predefined report")
    p_report.add_argument("name", choices=sorted(REPORTS), help="Report name")
    p_report.add_argument("--where", help="Extra SQL filter applied as AND (...) on files alias f")
    p_report.add_argument("--db", default=DEFAULT_DB, help="SQLite path")
    p_report.set_defaults(func=cmd_report)

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    return int(args.func(args))


if __name__ == "__main__":
    raise SystemExit(main())
