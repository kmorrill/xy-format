"""Round-trip and extraction tests for xy/project_to_json.py."""

from __future__ import annotations

import json
from pathlib import Path
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.json_build_spec import build_xy_bytes, parse_build_spec
from xy.project_to_json import project_to_json
from xy.rle import decode_project


CORPUS = REPO_ROOT / "src" / "one-off-changes-from-default"


# ── Extraction ──────────────────────────────────────────────────────


def test_extracts_header_from_baseline() -> None:
    path = CORPUS / "unnamed 1.xy"
    payload = project_to_json(path.read_bytes(), template_path=path)
    assert payload["version"] == 1
    assert payload["template"] == str(path)
    assert "header" in payload
    hdr = payload["header"]
    # Baseline file exists; exact values will be locked by subsequent
    # tests. Sanity-check they're in plausible ranges.
    assert 0 <= hdr["tempo_tenths"] <= 0xFFFF
    assert 0 <= hdr["groove_type"] <= 0xFF
    assert 0 <= hdr["groove_amount"] <= 0xFF
    assert 0 <= hdr["metronome_level"] <= 0xFF


def test_extracts_notes_for_single_pattern_file() -> None:
    # unnamed 80 has a single-pattern T1 event with 6 notes.
    path = CORPUS / "unnamed 80.xy"
    payload = project_to_json(path.read_bytes(), template_path=path)
    assert payload["profile"] == "single_pattern_notes"
    tracks = {t["track"]: t for t in payload["tracks"]}
    assert 1 in tracks
    notes = tracks[1]["patterns"][0]
    # Ground truth (change log): C4@1, D4@5, E4@9, F4+G4+A4 chord@13.
    note_pitches = sorted(n["note"] for n in notes)
    assert note_pitches == [0x3C, 0x3E, 0x40, 0x41, 0x43, 0x45]


def test_multi_pattern_file_extracts_sound_state_but_not_clone_notes() -> None:
    # Any scaffold-style multi-pattern file should produce a
    # sound_state profile because project_to_json now emits editable sound
    # fields, but still doesn't walk clone note bodies.
    path = CORPUS / "j06_all16_p9_blank.xy"
    payload = project_to_json(path.read_bytes(), template_path=path)
    assert payload["profile"] == "sound_state"
    # ``tracks`` is emitted as an empty list so parse_build_spec
    # doesn't trip on a missing field; the profile validator
    # enforces the "no tracks" constraint.
    assert payload["tracks"] == []
    assert payload["sound_state"]["tracks"][0]["track"] == 1
    assert payload["sound_state"]["tracks"][0]["engine_params"]["param1"] >= 0
    assert "_notes" in payload
    assert any("multi-pattern" in note.lower() for note in payload["_notes"])


def test_extraction_output_parses_as_valid_buildspec() -> None:
    path = CORPUS / "unnamed 80.xy"
    payload = project_to_json(path.read_bytes(), template_path=path)
    # parse_build_spec should accept the payload without errors.
    spec = parse_build_spec(payload, base_dir=REPO_ROOT)
    assert spec.profile == "single_pattern_notes"
    assert spec.template == path
    assert spec.multi_tracks  # tracks were extracted


def test_extracts_decoded_current_value_diagnostics() -> None:
    path = CORPUS / "unnamed 124.xy"
    payload = project_to_json(path.read_bytes(), template_path=path)

    assert "_decoded_global_state" in payload
    assert payload["_decoded_global_state"]["master_eq"]["low"]["offset"] == "0x00068"

    tracks = {entry["track"]: entry for entry in payload["_decoded_track_state"]}
    assert len(tracks) == 16
    assert tracks[1]["current_values"]["lfo_current"]["cc40"]["u32"] == 0x7FFFFFFF
    assert tracks[2]["current_values"]["lfo_current"]["cc41"]["u32"] == 0x7FFFFFFF
    assert tracks[3]["current_values"]["mix"]["volume"]["u32"] == 0x7FFFFFFF
    assert tracks[5]["current_values"]["mix"]["pan"]["u32"] == 0x7FFFFFFF
    sound_tracks = {entry["track"]: entry for entry in payload["sound_state"]["tracks"]}
    assert sound_tracks[1]["lfo_current"]["cc40"] == 0x7FFFFFFF
    assert sound_tracks[2]["lfo_current"]["cc41"] == 0x7FFFFFFF
    assert sound_tracks[3]["mix"]["volume"] == 0x7FFFFFFF
    assert sound_tracks[5]["mix"]["pan"] == 0x7FFFFFFF

    # Diagnostics are underscore-prefixed and must not break BuildSpec parsing.
    spec = parse_build_spec(payload, base_dir=REPO_ROOT)
    assert spec.profile == payload["profile"]


def test_decoded_track_diagnostics_skip_multi_pattern_clones() -> None:
    path = CORPUS / "j06_all16_p9_blank.xy"
    payload = project_to_json(path.read_bytes(), template_path=path)
    decoded = payload["_decoded_track_state"]

    assert [entry["track"] for entry in decoded] == list(range(1, 17))
    assert decoded[0]["u8"]["pattern_count"] == 9
    assert decoded[7]["u8"]["pattern_count"] == 9
    assert decoded[8]["u8"]["pattern_count"] == 1


# ── Round-trip ──────────────────────────────────────────────────────


def test_roundtrip_parses_and_builds_single_pattern_file() -> None:
    # Read file -> JSON -> BuildSpec -> rebuild bytes.
    # Assert: rebuilt bytes also parse and carry equivalent intent
    # (tempo matches, note count matches). Byte-exact equality is
    # NOT the goal; intent round-trip is.
    path = CORPUS / "unnamed 80.xy"
    payload = project_to_json(path.read_bytes(), template_path=path)
    spec = parse_build_spec(payload, base_dir=REPO_ROOT)
    rebuilt = build_xy_bytes(spec)
    # Re-extract from rebuilt bytes and compare intent.
    rebuilt_payload = project_to_json(rebuilt, template_path=path)
    assert rebuilt_payload["header"] == payload["header"]
    assert rebuilt_payload["profile"] == payload["profile"]
    assert rebuilt_payload.get("tracks", []) == payload.get("tracks", [])


def test_roundtrip_preserves_tempo_edit() -> None:
    # The editing workflow: read -> modify tempo -> rebuild.
    path = CORPUS / "unnamed 80.xy"
    payload = project_to_json(path.read_bytes(), template_path=path)
    payload["header"]["tempo_tenths"] = 1450  # change to 145.0 BPM
    spec = parse_build_spec(payload, base_dir=REPO_ROOT)
    rebuilt = build_xy_bytes(spec)
    # Rebuilt bytes should reflect the new tempo when read back.
    reread = project_to_json(rebuilt, template_path=path)
    assert reread["header"]["tempo_tenths"] == 1450


def test_multi_pattern_sound_state_roundtrip_preserves_template_state() -> None:
    # For a multi-pattern file, sound/header state round-trips. Topology
    # still comes from the template and should survive the round-trip.
    path = CORPUS / "j06_all16_p9_blank.xy"
    original = path.read_bytes()
    payload = project_to_json(original, template_path=path)
    # Edit header only.
    payload["header"]["tempo_tenths"] = 1000  # 100.0 BPM
    spec = parse_build_spec(payload, base_dir=REPO_ROOT)
    rebuilt = build_xy_bytes(spec)
    # Tempo should have changed; decoded image size/structure should not.
    assert len(decode_project(rebuilt)[1]) == len(decode_project(original)[1])
    # Re-extract and confirm header edit applied.
    reread = project_to_json(rebuilt, template_path=path)
    assert reread["header"]["tempo_tenths"] == 1000
    # The extracted editable sound state should still be detected.
    assert reread["profile"] == "sound_state"


# ── CLI ─────────────────────────────────────────────────────────────


def test_cli_writes_json_to_output(tmp_path: Path) -> None:
    """The CLI entry point should produce the same payload as the API."""
    import subprocess
    import os

    script = REPO_ROOT / "tools" / "project_to_json.py"
    input_path = CORPUS / "unnamed 80.xy"
    output_path = tmp_path / "out.json"

    env = dict(os.environ)
    env["PYTHONPATH"] = str(REPO_ROOT)
    proc = subprocess.run(
        [
            sys.executable,
            str(script),
            str(input_path),
            "-o",
            str(output_path),
        ],
        env=env,
        capture_output=True,
        text=True,
        check=False,
    )
    assert proc.returncode == 0, proc.stderr

    payload = json.loads(output_path.read_text(encoding="utf-8"))
    assert payload["profile"] == "single_pattern_notes"
    assert payload["template"] == str(input_path)
