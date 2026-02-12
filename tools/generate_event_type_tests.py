#!/usr/bin/env python3
"""Generate test .xy files to distinguish event type selection hypotheses.

Each test changes ONE variable from a known-working baseline.
Uses xy.note_events and xy.project_builder for correct encoding.

Tests:
  A: 0x25 on Track 3 (Prism) — tests if 0x25 is Track-1-only
  B: 0x21 on Track 1, engine changed to Prism — tests body-structure hypothesis
  C: 0x2D on Track 1 — tests if 0x2D works where 0x21 doesn't
  D: 0x2D on Track 2 — tests if 0x2D works on Track 2
  E: 0x21 on Track 1 (Drum) — negative control (known crash)
  F: 0x21 on Track 3 (Prism) — positive control (known working)
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from xy.container import TrackBlock, XYProject
from xy.note_events import Note, build_event
from xy.project_builder import _activate_body, _update_preamble


SIMPLE_NOTES = [
    Note(step=1, note=60, velocity=100),
    Note(step=5, note=62, velocity=100),
    Note(step=9, note=64, velocity=100),
    Note(step=13, note=65, velocity=100),
]


# --- Test generators ---
# Each returns a new XYProject.

TESTS = {}


def test(tid, name):
    """Decorator to register a test function."""
    def decorator(fn):
        TESTS[tid] = (name, fn)
        return fn
    return decorator


def _append_event(project: XYProject, track_idx_0based: int,
                  event_type: int, notes: list[Note],
                  engine_id: int | None = None) -> XYProject:
    """Activate a track, optionally change engine, append event, fix preamble."""
    tracks = list(project.tracks)
    target = tracks[track_idx_0based]

    # Activate body
    new_body = _activate_body(target.body)

    # Optionally change engine_id (at body[0x0B] for type-07)
    if engine_id is not None:
        old_engine = new_body[0x0B]
        new_body[0x0B] = engine_id & 0xFF
        print(f"  Engine ID: {old_engine:#x} → {engine_id:#x}")

    # Build and append event
    event_blob = build_event(notes, event_type=event_type)
    new_body.extend(event_blob)

    tracks[track_idx_0based] = TrackBlock(
        index=target.index,
        preamble=target.preamble,
        body=bytes(new_body),
    )

    # Update next track's preamble byte 0 to 0x64
    nxt = track_idx_0based + 1
    if nxt < 16:
        t = tracks[nxt]
        tracks[nxt] = TrackBlock(
            index=t.index,
            preamble=_update_preamble(t.preamble, 0x64),
            body=t.body,
        )

    return XYProject(pre_track=project.pre_track, tracks=tracks)


@test("A", "0x25_on_T3_prism")
def generate_test_a(project):
    """Test A: 0x25 on Track 3 (Prism engine 0x12).

    Baseline: 0x21 on T3 works. 0x25 on T1 works.
    Question: Does 0x25 work on a non-T1 track?
    """
    print("Test A: 0x25 on Track 3 (Prism)")
    return _append_event(project, track_idx_0based=2,
                         event_type=0x25, notes=SIMPLE_NOTES)


@test("B", "0x21_on_T1_prism_engine")
def generate_test_b(project):
    """Test B: 0x21 on Track 1, engine changed to Prism (0x12).

    Baseline: 0x21 on T1 crashes (with Drum engine).
    Question: Does changing engine to Prism make 0x21 work on T1?
    """
    print("Test B: 0x21 on Track 1, engine → Prism (0x12)")
    return _append_event(project, track_idx_0based=0,
                         event_type=0x21, notes=SIMPLE_NOTES,
                         engine_id=0x12)


@test("C", "0x2D_on_T1_drum")
def generate_test_c(project):
    """Test C: 0x2D on Track 1.

    Baseline: 0x25 works on T1, 0x21 crashes on T1.
    Question: Does 0x2D work on T1?
    """
    print("Test C: 0x2D on Track 1")
    return _append_event(project, track_idx_0based=0,
                         event_type=0x2d, notes=SIMPLE_NOTES)


@test("D", "0x2D_on_T2_drum")
def generate_test_d(project):
    """Test D: 0x2D on Track 2.

    Baseline: 0x21 works on T2, 0x25 crashes on T2.
    Question: Does 0x2D also work on T2?
    """
    print("Test D: 0x2D on Track 2")
    return _append_event(project, track_idx_0based=1,
                         event_type=0x2d, notes=SIMPLE_NOTES)


@test("E", "0x21_on_T1_drum_NEG_CONTROL")
def generate_test_e(project):
    """Test E (neg control): 0x21 on Track 1, Drum engine.

    KNOWN CRASH. Confirms our baseline is consistent.
    """
    print("Test E (negative control): 0x21 on Track 1, Drum engine")
    return _append_event(project, track_idx_0based=0,
                         event_type=0x21, notes=SIMPLE_NOTES)


@test("F", "0x21_on_T3_prism_POS_CONTROL")
def generate_test_f(project):
    """Test F (pos control): 0x21 on Track 3, Prism engine.

    KNOWN WORKING. Confirms our tooling produces valid files.
    """
    print("Test F (positive control): 0x21 on Track 3, Prism engine")
    return _append_event(project, track_idx_0based=2,
                         event_type=0x21, notes=SIMPLE_NOTES)


def main():
    if len(sys.argv) < 2:
        print("Usage: generate_event_type_tests.py <input.xy> [output_dir] [test_ids]")
        print()
        print("Tests:")
        for tid, (name, fn) in TESTS.items():
            print(f"  {tid}: {name} — {fn.__doc__.strip().splitlines()[0]}")
        print()
        print("Examples:")
        print("  generate_event_type_tests.py 'unnamed 1.xy' output/        # all tests")
        print("  generate_event_type_tests.py 'unnamed 1.xy' output/ A,B,F  # specific tests")
        sys.exit(1)

    input_path = Path(sys.argv[1])
    output_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("output")
    test_ids = sys.argv[3].split(",") if len(sys.argv) > 3 else list(TESTS.keys())

    output_dir.mkdir(parents=True, exist_ok=True)

    data = input_path.read_bytes()
    project = XYProject.from_bytes(data)

    # Verify round-trip integrity
    assert project.to_bytes() == data, "Round-trip check failed on input file!"
    print(f"Input: {input_path} ({len(data)} bytes, round-trip OK)")
    print(f"Tracks: {len(project.tracks)}")
    for i, t in enumerate(project.tracks):
        print(f"  T{i+1}: type={t.type_byte:#x} engine={t.engine_id:#x} "
              f"body={len(t.body)}B preamble={t.preamble.hex()}")
    print()

    for tid in test_ids:
        tid = tid.strip().upper()
        if tid not in TESTS:
            print(f"Unknown test ID: {tid}")
            continue

        name, generator = TESTS[tid]
        out_path = output_dir / f"test_{tid}_{name}.xy"
        print(f"--- Test {tid}: {name} ---")

        try:
            result_project = generator(project)
            result_bytes = result_project.to_bytes()

            # Verify round-trip
            reparse = XYProject.from_bytes(result_bytes)
            assert reparse.to_bytes() == result_bytes, "Round-trip check failed!"
            print(f"  Re-parse OK: {len(reparse.tracks)} tracks")

            # Show modified track info
            for i, t in enumerate(reparse.tracks):
                orig = project.tracks[i]
                if t.body != orig.body or t.preamble != orig.preamble:
                    print(f"  T{i+1}: type={t.type_byte:#x} engine={t.engine_id:#x} "
                          f"body={len(t.body)}B preamble={t.preamble.hex()}")

            out_path.write_bytes(result_bytes)
            print(f"  Output: {out_path} ({len(result_bytes)} bytes)")
        except Exception as e:
            print(f"  ERROR: {e}")
            import traceback
            traceback.print_exc()
        print()

    print("=" * 60)
    print("Done. Copy test files to OP-XY and report which ones work/crash.")
    print()
    print("Expected results:")
    print("  E (neg control): CRASH  (0x21 on T1 Drum — known crash)")
    print("  F (pos control): WORKS  (0x21 on T3 Prism — known working)")
    print("  A: UNKNOWN — does 0x25 work on T3?")
    print("  B: UNKNOWN — does 0x21 work on T1 with Prism engine?")
    print("  C: UNKNOWN — does 0x2D work on T1?")
    print("  D: UNKNOWN — does 0x2D work on T2?")
    print()
    print("Interpretation guide:")
    print("  If B works → body structure/engine matters, not track index")
    print("  If B crashes → track index matters (T1 is special)")
    print("  If A works → 0x25 isn't T1-only")
    print("  If A crashes + B crashes → T1 is hardcoded for 0x25")
    print("  If C works → T1 accepts 0x25 and 0x2D (not just 0x25)")
    print("  If D works → 0x2D is broadly compatible (like 0x21)")


if __name__ == "__main__":
    main()
