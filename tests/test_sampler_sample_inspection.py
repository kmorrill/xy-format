from pathlib import Path

import pytest

from xy.rle import decode_project
from xy.sampler_sample_inspection import (
    LOOP_TYPE_INFINITE,
    LOOP_TYPE_OFF,
    LOOP_TYPE_UNTIL_RELEASE,
    SAMPLER_TUNE_CENTER_BYTE,
    SAMPLER_TUNE_NEGATIVE_BYTE,
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
    decode_sampler_tune_tenths,
    encode_sampler_tune_tenths,
    inspect_sampler_samples_bytes,
    read_sampler_sample_edit,
)
from xy.image_writer import ImageProject

ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "sampler-probes" / "2026-06-oneshot"
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


@pytest.mark.parametrize(
    "filename,tenths,tune_byte,tune_aux",
    [
        ("g-tune-0.xy", 0, SAMPLER_TUNE_CENTER_BYTE, 0),
        ("g-tune-1.xy", 1, SAMPLER_TUNE_CENTER_BYTE, 10),
        ("g-tune-2.xy", 2, SAMPLER_TUNE_CENTER_BYTE, 20),
        ("g-tune-3.xy", 3, SAMPLER_TUNE_CENTER_BYTE, 30),
        ("g-tune-4.xy", 4, SAMPLER_TUNE_CENTER_BYTE, 40),
        ("g-tune-neg1.xy", -1, SAMPLER_TUNE_NEGATIVE_BYTE, 90),
        ("g-tune-neg2.xy", -2, SAMPLER_TUNE_NEGATIVE_BYTE, 80),
        ("g-tune-neg3.xy", -3, SAMPLER_TUNE_NEGATIVE_BYTE, 70),
        ("g-tune-neg4.xy", -4, SAMPLER_TUNE_NEGATIVE_BYTE, 60),
        ("g-tune-neg5.xy", -5, SAMPLER_TUNE_NEGATIVE_BYTE, 50),
    ],
)
def test_tune_sweep_probes(
    filename: str, tenths: int, tune_byte: int, tune_aux: int
) -> None:
    sample = read_sampler_sample_edit(ImageProject.from_file(str(PROBES / filename)))
    assert sample.tune_byte == tune_byte
    assert sample.tune_aux_byte == tune_aux
    assert sample.tune_tenths == tenths
    assert sample.tune_ui == pytest.approx(tenths / 10.0)


@pytest.mark.parametrize("tenths", [0, 1, 4, -1, -5])
def test_tune_encode_decode_roundtrip(tenths: int) -> None:
    encoded = encode_sampler_tune_tenths(tenths)
    assert decode_sampler_tune_tenths(*encoded) == tenths


@pytest.mark.parametrize(
    "filename,allowed_rel",
    [
        ("g-tune-1.xy", {VOICE_TABLE_OFFSET + SLOT_TUNE_AUX}),
        (
            "g-tune-neg1.xy",
            {VOICE_TABLE_OFFSET + SLOT_TUNE, VOICE_TABLE_OFFSET + SLOT_TUNE_AUX},
        ),
    ],
)
def test_tune_probe_diffs_are_isolated(filename: str, allowed_rel: set[int]) -> None:
    tune_base = PROBES / "g-tune-0.xy"
    project = ImageProject.from_file(str(tune_base))
    track_base = project.track_start(1)
    _, base = decode_project(tune_base.read_bytes())
    _, var = decode_project((PROBES / filename).read_bytes())
    rel = {i - track_base for i in _track_region_diffs(base, var, track_base)}
    assert rel == allowed_rel, rel
