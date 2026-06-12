from pathlib import Path

import pytest

from xy.rle import decode_project
from xy.sampler_sample_inspection import (
    LOOP_TYPE_INFINITE,
    LOOP_TYPE_OFF,
    LOOP_TYPE_UNTIL_RELEASE,
    SamplerSampleEdit,
    TRACK_LOOP_CROSSFADE_U8,
    TRACK_LOOP_END_U16,
    TRACK_LOOP_START_U16,
    TRACK_SAMPLE_END_U16,
    TRACK_SAMPLE_START_U16,
    VOICE_TABLE_OFFSET,
    SLOT_DIRECTION,
    SLOT_GAIN,
    SLOT_LOOP_TYPE,
    SLOT_TUNE,
    SLOT_TUNE_AUX,
    inspect_sampler_samples_bytes,
    read_sampler_sample_edit,
)
from xy.image_writer import ImageProject

ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "app-sampler-probes" / "2026-06-oneshot"
BASELINE = PROBES / "g0.xy"


def _baseline() -> SamplerSampleEdit:
    return read_sampler_sample_edit(ImageProject.from_file(str(BASELINE)))


def test_baseline_sampler_fields() -> None:
    sample = _baseline()
    assert sample.engine_id == 0x02
    assert "nt-acidic" in sample.path
    assert sample.sample_start == 0
    assert sample.sample_end == 0x7DF4
    assert sample.loop_start == 0x6EC5
    assert sample.loop_end == 0x7DF4
    assert sample.loop_crossfade == 0
    assert sample.tune_byte == 0x3C
    assert sample.tune_aux_byte == 0
    assert sample.loop_type_byte == LOOP_TYPE_INFINITE
    assert sample.gain == 0
    assert sample.direction == 0


@pytest.mark.parametrize(
    "filename,checks",
    [
        ("g1.xy", {"tune_byte": 0xFF}),
        ("g2.xy", {"tune_byte": 0x00, "tune_aux_byte": 0x5A}),
        ("g3.xy", {"sample_start": 0x17C4}),
        ("g4.xy", {"sample_end": 0x76B1, "loop_end": 0x76B1}),
        ("g5.xy", {"loop_start": 0x4D1A}),
        ("g6.xy", {"loop_end": 0x78AC, "sample_end": 0x7DF4}),
        ("g7.xy", {"direction": 1}),
        ("g8.xy", {"gain": 0xE2}),
        ("g9.xy", {"gain": 0x14}),
        ("g11.xy", {"loop_crossfade": 0x60}),
        ("g12.xy", {"loop_type_byte": LOOP_TYPE_OFF}),
        ("g13.xy", {"loop_type_byte": LOOP_TYPE_UNTIL_RELEASE}),
        ("g14.xy", {"loop_type_byte": LOOP_TYPE_INFINITE}),
    ],
)
def test_probe_changes_expected_fields(filename: str, checks: dict) -> None:
    sample = read_sampler_sample_edit(ImageProject.from_file(str(PROBES / filename)))
    for key, value in checks.items():
        assert getattr(sample, key) == value, f"{filename} {key}"


def test_g10_matches_baseline_sampler_region() -> None:
  base = _baseline()
  g10 = read_sampler_sample_edit(ImageProject.from_file(str(PROBES / "g10.xy")))
  for field in (
      "sample_start",
      "sample_end",
      "loop_start",
      "loop_end",
      "loop_crossfade",
      "tune_byte",
      "tune_aux_byte",
      "loop_type_byte",
      "gain",
      "direction",
  ):
      assert getattr(base, field) == getattr(g10, field)


def _track_region_diffs(base: bytes, var: bytes, track_base: int) -> list[int]:
    end = track_base + 0x3A00
    limit = min(len(base), len(var), end)
    return [i for i in range(track_base, limit) if base[i] != var[i]]


@pytest.mark.parametrize(
    "filename,allowed_rel",
    [
        ("g1.xy", {VOICE_TABLE_OFFSET + SLOT_TUNE}),
        ("g2.xy", {VOICE_TABLE_OFFSET + SLOT_TUNE, VOICE_TABLE_OFFSET + SLOT_TUNE_AUX}),
        ("g3.xy", {TRACK_SAMPLE_START_U16, TRACK_SAMPLE_START_U16 + 1}),
        (
            "g4.xy",
            {
                TRACK_SAMPLE_END_U16,
                TRACK_SAMPLE_END_U16 + 1,
                TRACK_LOOP_END_U16,
                TRACK_LOOP_END_U16 + 1,
            },
        ),
        ("g5.xy", {TRACK_LOOP_START_U16, TRACK_LOOP_START_U16 + 1}),
        ("g6.xy", {TRACK_LOOP_END_U16, TRACK_LOOP_END_U16 + 1}),
        ("g7.xy", {VOICE_TABLE_OFFSET + SLOT_DIRECTION}),
        ("g8.xy", {VOICE_TABLE_OFFSET + SLOT_GAIN}),
        ("g9.xy", {VOICE_TABLE_OFFSET + SLOT_GAIN}),
        ("g11.xy", {TRACK_LOOP_CROSSFADE_U8}),
        ("g12.xy", {VOICE_TABLE_OFFSET + SLOT_LOOP_TYPE}),
        ("g13.xy", {VOICE_TABLE_OFFSET + SLOT_LOOP_TYPE}),
    ],
)
def test_probe_diffs_are_isolated_to_expected_offsets(
    filename: str, allowed_rel: set[int]
) -> None:
    project = ImageProject.from_file(str(BASELINE))
    track_base = project.track_start(1)
    _, base = decode_project(BASELINE.read_bytes())
    _, var = decode_project((PROBES / filename).read_bytes())
    rel = {i - track_base for i in _track_region_diffs(base, var, track_base)}
    assert rel == allowed_rel, rel


def test_inspect_sampler_samples_bytes_finds_track() -> None:
    inspection = inspect_sampler_samples_bytes(BASELINE.read_bytes())
    assert len(inspection.tracks) == 1
    assert inspection.tracks[0].path.endswith(".wav") or "wav" in inspection.tracks[0].path
