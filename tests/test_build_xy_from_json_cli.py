"""CLI integration tests for tools/build_xy_from_json.py."""

from __future__ import annotations

import json
import os
from pathlib import Path
import subprocess
import sys
import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
SCRIPT = REPO_ROOT / "tools" / "build_xy_from_json.py"
CORPUS_DIR = REPO_ROOT / "src" / "one-off-changes-from-default"
TEMPLATE = CORPUS_DIR / "unnamed 1.xy"


def _write_spec(path: Path, payload: dict) -> Path:
    path.write_text(json.dumps(payload), encoding="utf-8")
    return path


def _run_cli(spec_path: Path, *extra_args: str) -> subprocess.CompletedProcess[str]:
    env = dict(os.environ)
    env["PYTHONPATH"] = str(REPO_ROOT)
    return subprocess.run(
        [sys.executable, str(SCRIPT), str(spec_path), *extra_args],
        cwd=str(REPO_ROOT),
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )


def _single_track_spec(*, output: str | None = None) -> dict:
    spec = {
        "version": 1,
        "mode": "multi_pattern",
        "template": str(TEMPLATE),
        "tracks": [
            {
                "track": 1,
                "patterns": [[{"step": 1, "note": 60, "velocity": 100}]],
            }
        ],
    }
    if output is not None:
        spec["output"] = output
    return spec


def _nine_patterns(notes_by_pattern: dict[int, list[dict]]) -> list[object]:
    patterns: list[object] = [None] * 9
    for pattern_idx, notes in notes_by_pattern.items():
        patterns[pattern_idx - 1] = notes
    return patterns


GOLDEN_MATRIX: list[tuple[str, dict]] = [
    (
        "unnamed 2.xy",
        _single_track_spec(),
    ),
    (
        "unnamed 81.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "tracks": [
                {
                    "track": 1,
                    "patterns": [[{"step": 9, "note": 60, "velocity": 100}]],
                }
            ],
        },
    ),
    (
        "unnamed 56.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "tracks": [
                {
                    "track": 3,
                    "patterns": [[{"step": 9, "note": 48, "velocity": 100, "gate_ticks": 960}]],
                }
            ],
        },
    ),
    (
        "unnamed 57.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "tracks": [
                {
                    "track": 3,
                    "patterns": [[{"step": 9, "note": 48, "velocity": 100, "gate_ticks": 1920}]],
                }
            ],
        },
    ),
    (
        "unnamed 92.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "tracks": [
                {
                    "track": 3,
                    "patterns": [[
                        {"step": 1, "note": 48, "velocity": 100, "gate_ticks": 960},
                        {"step": 5, "note": 50, "velocity": 100, "gate_ticks": 1920},
                        {"step": 11, "note": 53, "velocity": 100, "gate_ticks": 2880},
                    ]],
                }
            ],
        },
    ),
    (
        "unnamed 102.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [None, [{"step": 9, "note": 60, "velocity": 100}]],
                }
            ],
        },
    ),
    (
        "unnamed 103.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [
                        [{"step": 1, "note": 60, "velocity": 100}],
                        [{"step": 9, "note": 64, "velocity": 100}],
                    ],
                }
            ],
        },
    ),
    (
        "unnamed 104.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [
                        [{"step": 1, "note": 60, "velocity": 100}],
                        None,
                        [{"step": 9, "note": 64, "velocity": 100}],
                    ],
                }
            ],
        },
    ),
    (
        "unnamed 105.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [None, [{"step": 1, "note": 60, "velocity": 100}]],
                },
                {
                    "track": 3,
                    "patterns": [None, [{"step": 2, "note": 52, "velocity": 100}]],
                },
            ],
        },
    ),
    (
        "unnamed 105b.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [None, [{"step": 1, "note": 60, "velocity": 100}]],
                },
                {
                    "track": 3,
                    "patterns": [
                        [{"step": 8, "note": 53, "velocity": 100}],
                        [{"step": 2, "note": 52, "velocity": 100}],
                    ],
                },
            ],
        },
    ),
    (
        "j05_t2_p3_blank.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 2,
                    "patterns": [None, None, None],
                }
            ],
        },
    ),
    (
        "j06_all16_p9_blank.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(CORPUS_DIR / "j06_all16_p9_blank.xy"),
            "descriptor_strategy": "strict",
            "tracks": [{"track": t, "patterns": [None] * 9} for t in range(1, 9)],
        },
    ),
    (
        "j07_all16_p9_sparsemap.xy",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(CORPUS_DIR / "j06_all16_p9_blank.xy"),
            "descriptor_strategy": "strict",
            "tracks": [
                {"track": 1, "patterns": _nine_patterns({
                    1: [{"step": 1, "note": 60, "velocity": 100}],
                    9: [{"step": 9, "note": 60, "velocity": 100}],
                })},
                {"track": 2, "patterns": _nine_patterns({
                    2: [{"step": 2, "note": 60, "velocity": 100}],
                    9: [{"step": 10, "note": 60, "velocity": 100}],
                })},
                {"track": 3, "patterns": _nine_patterns({
                    1: [{"step": 3, "note": 53, "velocity": 100}],
                    9: [{"step": 11, "note": 53, "velocity": 100}],
                })},
                {"track": 4, "patterns": _nine_patterns({
                    2: [{"step": 4, "note": 53, "velocity": 100}],
                    9: [{"step": 12, "note": 53, "velocity": 100}],
                })},
                {"track": 5, "patterns": _nine_patterns({
                    1: [{"step": 5, "note": 53, "velocity": 100}],
                    9: [{"step": 13, "note": 53, "velocity": 100}],
                })},
                {"track": 6, "patterns": _nine_patterns({
                    2: [{"step": 6, "note": 53, "velocity": 100}],
                    9: [{"step": 14, "note": 53, "velocity": 100}],
                })},
                {"track": 7, "patterns": _nine_patterns({
                    1: [{"step": 7, "note": 53, "velocity": 100}],
                    9: [{"step": 15, "note": 53, "velocity": 100}],
                })},
                {"track": 8, "patterns": _nine_patterns({
                    2: [{"step": 8, "note": 53, "velocity": 100}],
                    9: [{"step": 16, "note": 53, "velocity": 100}],
                })},
            ],
        },
    ),
]


@pytest.mark.parametrize(
    ("fixture_name", "payload"),
    GOLDEN_MATRIX,
    ids=[
        "note_t1_s1",
        "note_t1_s9",
        "note_t3_gate960",
        "note_t3_gate1920",
        "note_t3_three_gated",
        "mp_t1_p2",
        "mp_t1_p1p2",
        "mp_t1_p1_blank_p2",
        "mp_t1_t3",
        "mp_t1_t3_105b",
        "mp_t2_p3_blank_j05",
        "mp_j06_blank_scaffold",
        "mp_j06_to_j07_sparsemap",
    ],
)
def test_cli_golden_repro_matrix_dry_run_expect(
    tmp_path: Path,
    fixture_name: str,
    payload: dict,
) -> None:
    spec_path = _write_spec(tmp_path / f"spec_{fixture_name.replace(' ', '_')}.json", payload)
    proc = _run_cli(
        spec_path,
        "--dry-run",
        "--expect",
        str(CORPUS_DIR / fixture_name),
    )

    assert proc.returncode == 0
    assert "expect match: yes" in proc.stdout
    assert "dry-run OK" in proc.stdout


def test_cli_dry_run_expect_match_returns_zero(tmp_path: Path) -> None:
    spec_path = _write_spec(tmp_path / "spec_match.json", _single_track_spec())
    proc = _run_cli(
        spec_path,
        "--dry-run",
        "--expect",
        str(CORPUS_DIR / "unnamed 2.xy"),
    )

    assert proc.returncode == 0
    assert "expect match: yes" in proc.stdout
    assert "dry-run OK" in proc.stdout


def test_cli_dry_run_expect_mismatch_returns_two(tmp_path: Path) -> None:
    spec_path = _write_spec(tmp_path / "spec_mismatch.json", _single_track_spec())
    proc = _run_cli(
        spec_path,
        "--dry-run",
        "--expect",
        str(CORPUS_DIR / "unnamed 81.xy"),
    )

    assert proc.returncode == 2
    assert "expect match: no" in proc.stdout
    assert "first diff @" in proc.stdout


def test_cli_dry_run_expect_mismatch_for_unnamed3_compact_live_chord(tmp_path: Path) -> None:
    spec_path = _write_spec(
        tmp_path / "spec_unnamed3_gap.json",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "tracks": [
                {
                    "track": 1,
                    "patterns": [[
                        {"step": 1, "note": 60, "velocity": 75, "gate_ticks": 5885},
                        {"step": 1, "note": 67, "velocity": 74, "gate_ticks": 5868},
                        {"step": 1, "note": 64, "velocity": 103, "gate_ticks": 5852},
                    ]],
                }
            ],
        },
    )
    proc = _run_cli(
        spec_path,
        "--dry-run",
        "--expect",
        str(CORPUS_DIR / "unnamed 3.xy"),
    )

    assert proc.returncode == 2
    assert "expect match: no" in proc.stdout
    assert "first diff @ 0x0007B4" in proc.stdout


def test_cli_requires_output_when_not_dry_run(tmp_path: Path) -> None:
    spec_path = _write_spec(tmp_path / "spec_no_output.json", _single_track_spec(output=None))
    proc = _run_cli(spec_path)

    assert proc.returncode == 2
    assert "output path required" in proc.stderr


def test_cli_writes_output_from_spec_field(tmp_path: Path) -> None:
    spec_path = _write_spec(
        tmp_path / "spec_with_output.json",
        _single_track_spec(output="built/from_spec.xy"),
    )
    out_path = tmp_path / "built" / "from_spec.xy"
    proc = _run_cli(spec_path)

    assert proc.returncode == 0
    assert out_path.exists()
    assert out_path.read_bytes() == (CORPUS_DIR / "unnamed 2.xy").read_bytes()


def test_cli_output_flag_overrides_spec_output(tmp_path: Path) -> None:
    spec_path = _write_spec(
        tmp_path / "spec_override.json",
        _single_track_spec(output="built/from_spec.xy"),
    )
    spec_output = tmp_path / "built" / "from_spec.xy"
    override_output = tmp_path / "built" / "from_cli.xy"
    proc = _run_cli(spec_path, "--output", str(override_output))

    assert proc.returncode == 0
    assert override_output.exists()
    assert not spec_output.exists()
    assert override_output.read_bytes() == (CORPUS_DIR / "unnamed 2.xy").read_bytes()


def test_cli_resolves_relative_template_against_spec_dir(tmp_path: Path) -> None:
    template_rel = os.path.relpath(TEMPLATE, tmp_path)
    spec_path = _write_spec(
        tmp_path / "spec_relative_template.json",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": template_rel,
            "tracks": [
                {
                    "track": 1,
                    "patterns": [[{"step": 1, "note": 60, "velocity": 100}]],
                }
            ],
        },
    )
    proc = _run_cli(
        spec_path,
        "--dry-run",
        "--expect",
        str(CORPUS_DIR / "unnamed 2.xy"),
    )

    assert proc.returncode == 0
    assert "expect match: yes" in proc.stdout


def test_cli_dry_run_expect_match_for_multi_pattern_unnamed104(tmp_path: Path) -> None:
    spec_path = _write_spec(
        tmp_path / "spec_mp_104.json",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(TEMPLATE),
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [
                        [{"step": 1, "note": 60, "velocity": 100}],
                        None,
                        [{"step": 9, "note": 64, "velocity": 100}],
                    ],
                }
            ],
        },
    )
    proc = _run_cli(
        spec_path,
        "--dry-run",
        "--expect",
        str(CORPUS_DIR / "unnamed 104.xy"),
    )

    assert proc.returncode == 0
    assert "expect match: yes" in proc.stdout


def test_cli_accepts_large_scaffold_topology(tmp_path: Path) -> None:
    spec_path = _write_spec(
        tmp_path / "spec_j06_like.json",
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(CORPUS_DIR / "unnamed 94.xy"),
            "descriptor_strategy": "strict",
            "tracks": [{"track": t, "patterns": [None] * 9} for t in range(1, 9)],
        },
    )
    proc = _run_cli(spec_path, "--dry-run")

    assert proc.returncode == 0
