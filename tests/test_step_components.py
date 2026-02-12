"""Tests for step component encoding and insertion."""
import pytest
from pathlib import Path

from xy.container import XYProject
from xy.step_components import (
    ComponentType, StepComponent,
    build_component_data, slot_body07_offset,
    compute_alloc_byte, alloc_marker_body07_offset,
)
from xy.project_builder import add_step_components


CORPUS = Path("src/one-off-changes-from-default")


@pytest.fixture
def baseline():
    return XYProject.from_bytes((CORPUS / "unnamed 1.xy").read_bytes())


# ── build_component_data ──────────────────────────────────────────────


class TestBuildComponentData:
    """Test the raw byte encoding for each component type."""

    def test_hold_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.HOLD, 0x01))
        # Header: 0x63 (step_0=8, nibble=3), bank1=0x02, bank2=0x00
        # Param: 00 00 01 00 00 (type_id=0x00, param=0x01)
        assert data == bytes([0x63, 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00])

    def test_multiply_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.MULTIPLY, 0x04))
        assert data == bytes([0x63, 0x04, 0x00, 0x00, 0x01, 0x04, 0x00, 0x00])

    def test_bend_step9_bank2(self):
        data = build_component_data(StepComponent(9, ComponentType.BEND, 0x01))
        # nibble=4 for bank-2 at step 9, B1=0x01 (Bend bit), B2=0x00
        assert data == bytes([0x64, 0x01, 0x00, 0x00, 0x06, 0x01, 0x00, 0x00])

    def test_pulse_step9_nonstandard(self):
        data = build_component_data(StepComponent(9, ComponentType.PULSE, 0x01))
        # 3-byte non-standard param: 01 00 00
        assert data == bytes([0x63, 0x01, 0x00, 0x01, 0x00, 0x00])
        assert len(data) == 6  # header(3) + param(3)

    def test_hold_step1_nibble4(self):
        data = build_component_data(StepComponent(1, ComponentType.HOLD, 0x01))
        # step_0=0 → header_byte = (0xE << 4) | 4 = 0xE4, nibble=4 → B1=bit, B2=0
        assert data[0] == 0xE4
        assert data[1] == 0x02  # Hold bit
        assert data[2] == 0x00

    def test_conditional_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.CONDITIONAL, 0x02))
        assert data == bytes([0x64, 0x10, 0x00, 0x00, 0x0A, 0x02, 0x00, 0x00])

    def test_standard_param_size(self):
        """Standard components produce 8 bytes (3 header + 5 param)."""
        for ct in [ComponentType.HOLD, ComponentType.MULTIPLY, ComponentType.RAMP_UP,
                   ComponentType.RAMP_DOWN, ComponentType.RANDOM, ComponentType.PORTAMENTO,
                   ComponentType.BEND, ComponentType.TONALITY, ComponentType.JUMP,
                   ComponentType.PARAMETER, ComponentType.CONDITIONAL]:
            data = build_component_data(StepComponent(9, ct, 0x00))
            assert len(data) == 8, f"{ct.name} should be 8 bytes, got {len(data)}"

    def test_nonstandard_param_size(self):
        """Pulse and Velocity produce 6 bytes (3 header + 3 param)."""
        for ct in [ComponentType.PULSE, ComponentType.VELOCITY]:
            data = build_component_data(StepComponent(9, ct, 0x00))
            assert len(data) == 6, f"{ct.name} should be 6 bytes, got {len(data)}"

    def test_unsupported_step_raises(self):
        with pytest.raises(ValueError, match="not yet supported"):
            build_component_data(StepComponent(5, ComponentType.HOLD, 0x01))


# ── slot_body07_offset ────────────────────────────────────────────────


class TestSlotOffset:

    def test_step1_slot5(self):
        assert slot_body07_offset(1) == 0xA2 + 5 * 3  # 0xB1

    def test_step9_slot6(self):
        assert slot_body07_offset(9) == 0xA2 + 6 * 3  # 0xB4

    def test_unsupported_step_raises(self):
        with pytest.raises(ValueError):
            slot_body07_offset(5)


# ── compute_alloc_byte ────────────────────────────────────────────────


class TestAllocByte:

    @pytest.mark.parametrize("comp_type,expected", [
        (ComponentType.PULSE,      0x77),
        (ComponentType.HOLD,       0x76),
        (ComponentType.MULTIPLY,   0x75),
        (ComponentType.RAMP_UP,    0x73),
        (ComponentType.RAMP_DOWN,  0x72),
        (ComponentType.RANDOM,     0x71),
        (ComponentType.PORTAMENTO, 0x70),
        (ComponentType.BEND,       0x6F),
        (ComponentType.TONALITY,   0x6E),
        (ComponentType.JUMP,       0x6D),
        (ComponentType.PARAMETER,  0x6C),
        (ComponentType.CONDITIONAL,0x6B),
    ])
    def test_step9_alloc(self, comp_type, expected):
        comp = StepComponent(9, comp_type, 0x00)
        assert compute_alloc_byte(comp) == expected

    def test_step1_pulse(self):
        comp = StepComponent(1, ComponentType.PULSE, 0x01)
        assert compute_alloc_byte(comp) == 0xF7

    def test_alloc_marker_offset_standard(self):
        # Standard 8-byte insertion shifts marker from 0xC9 to 0xD1
        assert alloc_marker_body07_offset(9, 8) == 0xC9 + 8

    def test_alloc_marker_offset_pulse(self):
        # Pulse 6-byte insertion shifts marker from 0xC9 to 0xCF
        assert alloc_marker_body07_offset(9, 6) == 0xC9 + 6


# ── Full round-trip against corpus specimens ──────────────────────────


class TestCorpusMatch:

    def test_hold_s9_byte_perfect(self, baseline):
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.HOLD, 0x01),
        ])
        specimen = (CORPUS / "unnamed 61.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_bend_s9_byte_perfect(self, baseline):
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.BEND, 0x01),
        ])
        specimen = (CORPUS / "unnamed 72.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_pulse_s9_byte_perfect(self, baseline):
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.PULSE, 0x01),
        ])
        specimen = (CORPUS / "unnamed 59.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_no_preamble_change_on_t2(self, baseline):
        """Component-only activation must NOT set 0x64 on next track."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.HOLD, 0x01),
        ])
        # Track 2 preamble should keep its original value
        assert proj.tracks[1].preamble == baseline.tracks[1].preamble

    def test_body_size_standard(self, baseline):
        """Standard component adds 8 bytes to body."""
        base_body_size = len(baseline.tracks[0].body) - 2  # minus padding
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.HOLD, 0x01),
        ])
        assert len(proj.tracks[0].body) == base_body_size + 8

    def test_body_size_pulse(self, baseline):
        """Pulse component adds 6 bytes to body."""
        base_body_size = len(baseline.tracks[0].body) - 2
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.PULSE, 0x01),
        ])
        assert len(proj.tracks[0].body) == base_body_size + 6


# ── Additional verification against corpus alloc bytes ────────────────


class TestCorpusAllocBytes:
    """Verify alloc byte formula against every standard corpus specimen."""

    @pytest.mark.parametrize("filename,comp_type,expected_alloc", [
        ("unnamed 59.xy", ComponentType.PULSE,      0x77),
        ("unnamed 61.xy", ComponentType.HOLD,       0x76),
        ("unnamed 66.xy", ComponentType.MULTIPLY,   0x75),
        ("unnamed 68.xy", ComponentType.RAMP_UP,    0x73),
        ("unnamed 69.xy", ComponentType.RAMP_DOWN,  0x72),
        ("unnamed 70.xy", ComponentType.RANDOM,     0x71),
        ("unnamed 71.xy", ComponentType.PORTAMENTO, 0x70),
        ("unnamed 72.xy", ComponentType.BEND,       0x6F),
        ("unnamed 73.xy", ComponentType.TONALITY,   0x6E),
        ("unnamed 74.xy", ComponentType.JUMP,       0x6D),
        ("unnamed 75.xy", ComponentType.PARAMETER,  0x6C),
        ("unnamed 76.xy", ComponentType.CONDITIONAL,0x6B),
    ])
    def test_alloc_matches_formula(self, filename, comp_type, expected_alloc):
        comp = StepComponent(9, comp_type, 0x00)
        assert compute_alloc_byte(comp) == expected_alloc
