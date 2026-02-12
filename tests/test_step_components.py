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
    """Test raw byte encoding for each verified component type."""

    def test_pulse_step1(self):
        data = build_component_data(StepComponent(1, ComponentType.PULSE, 0x01))
        # Header: E4 (step_byte), 01 (bitmask), 00; Payload: 01 00 00; No sentinel
        assert data == bytes([0xE4, 0x01, 0x00, 0x01, 0x00, 0x00])
        assert len(data) == 6

    def test_multiply_step1(self):
        data = build_component_data(StepComponent(1, ComponentType.MULTIPLY, 0x00))
        # Header: E4, 01 (shared bit with Pulse), 00; Payload: 00; No sentinel
        assert data == bytes([0xE4, 0x01, 0x00, 0x00])
        assert len(data) == 4

    def test_pulse_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.PULSE, 0x01))
        # Header: 63, 01, 00; Payload: 01 00 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x01, 0x00, 0x01, 0x00, 0x00, 0xFF, 0x00, 0x00])
        assert len(data) == 9

    def test_multiply_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.MULTIPLY, 0x00))
        # Header: 63, 01, 00; Payload: 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x01, 0x00, 0x00, 0xFF, 0x00, 0x00])
        assert len(data) == 7

    def test_velocity_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.VELOCITY, 0x01))
        # Header: 63, 02, 00; Payload: 00 00 01 00 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
                              0xFF, 0x00, 0x00])
        assert len(data) == 11

    def test_bend_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.BEND, 0x00))
        # Header: 63, 08, 00; Payload: 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x08, 0x00, 0x00, 0xFF, 0x00, 0x00])
        assert len(data) == 7

    def test_tonality_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.TONALITY, 0x08))
        # Header: 63, 10, 00; Payload: 00 03 08 00 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x10, 0x00, 0x00, 0x03, 0x08, 0x00, 0x00,
                              0xFF, 0x00, 0x00])
        assert len(data) == 11

    def test_jump_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.JUMP, 0x02))
        assert data == bytes([0x63, 0x20, 0x00, 0x00, 0x04, 0x02, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_parameter_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.PARAMETER, 0x03))
        assert data == bytes([0x63, 0x40, 0x00, 0x00, 0x05, 0x03, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_conditional_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.CONDITIONAL, 0x07))
        assert data == bytes([0x63, 0x80, 0x00, 0x00, 0x06, 0x07, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_unsupported_hold_raises(self):
        with pytest.raises(ValueError, match="not supported for serialization"):
            build_component_data(StepComponent(9, ComponentType.HOLD, 0x01))

    def test_unsupported_ramp_up_raises(self):
        with pytest.raises(ValueError, match="not supported for serialization"):
            build_component_data(StepComponent(9, ComponentType.RAMP_UP, 0x01))

    def test_velocity_step1_raises(self):
        """Velocity on step 1 is not supported (no body change in corpus)."""
        with pytest.raises(ValueError, match="not supported on step 1"):
            build_component_data(StepComponent(1, ComponentType.VELOCITY, 0x01))

    def test_unsupported_step_raises(self):
        with pytest.raises(ValueError, match="not supported"):
            build_component_data(StepComponent(5, ComponentType.PULSE, 0x01))

    def test_net_growth_step1(self):
        """Step 1: net body growth = data_size - 3."""
        pulse = build_component_data(StepComponent(1, ComponentType.PULSE, 0x01))
        assert len(pulse) - 3 == 3  # net +3

        mult = build_component_data(StepComponent(1, ComponentType.MULTIPLY, 0x00))
        assert len(mult) - 3 == 1   # net +1

    def test_net_growth_step9(self):
        """Step 9: net body growth = data_size - 3 (includes sentinel)."""
        pulse = build_component_data(StepComponent(9, ComponentType.PULSE, 0x01))
        assert len(pulse) - 3 == 6  # net +6

        mult = build_component_data(StepComponent(9, ComponentType.MULTIPLY, 0x00))
        assert len(mult) - 3 == 4   # net +4

        vel = build_component_data(StepComponent(9, ComponentType.VELOCITY, 0x01))
        assert len(vel) - 3 == 8    # net +8


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

    @pytest.mark.parametrize("comp_type,param,expected", [
        (ComponentType.PULSE,       0x01, 0x77),  # (7<<4)|(7-0) = 0x77
        (ComponentType.MULTIPLY,    0x00, 0x79),  # (7<<4)|9     = 0x79
        (ComponentType.VELOCITY,    0x01, 0x76),  # (7<<4)|(7-1) = 0x76
        (ComponentType.BEND,        0x00, 0x79),  # (7<<4)|9     = 0x79
        (ComponentType.TONALITY,    0x08, 0x73),  # (7<<4)|(7-4) = 0x73
        (ComponentType.JUMP,        0x02, 0x72),  # (7<<4)|(7-5) = 0x72
        (ComponentType.PARAMETER,   0x03, 0x71),  # (7<<4)|(7-6) = 0x71
        (ComponentType.CONDITIONAL, 0x07, 0x70),  # (7<<4)|(7-7) = 0x70
    ])
    def test_step9_alloc(self, comp_type, param, expected):
        comp = StepComponent(9, comp_type, param)
        assert compute_alloc_byte(comp) == expected

    def test_step1_pulse_alloc(self):
        comp = StepComponent(1, ComponentType.PULSE, 0x01)
        assert compute_alloc_byte(comp) == 0xF7  # (0xF<<4)|(7-0)

    def test_step1_multiply_alloc(self):
        comp = StepComponent(1, ComponentType.MULTIPLY, 0x00)
        assert compute_alloc_byte(comp) == 0xF9  # (0xF<<4)|9

    def test_alloc_marker_offset(self):
        # Net growth shifts marker from baseline 0xC9
        assert alloc_marker_body07_offset(3) == 0xC9 + 3   # step 1 Pulse
        assert alloc_marker_body07_offset(6) == 0xC9 + 6   # step 9 Pulse
        assert alloc_marker_body07_offset(8) == 0xC9 + 8   # step 9 Velocity


# ── Full round-trip against corpus specimens ──────────────────────────


class TestCorpusMatch:

    def test_pulse_s1_byte_perfect(self, baseline):
        """Pulse step 1 should match corpus unnamed 8."""
        proj = add_step_components(baseline, 1, [
            StepComponent(1, ComponentType.PULSE, 0x01),
        ])
        specimen = (CORPUS / "unnamed 8.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_multiply_s1_byte_perfect(self, baseline):
        """Multiply step 1 should match corpus unnamed 9."""
        proj = add_step_components(baseline, 1, [
            StepComponent(1, ComponentType.MULTIPLY, 0x00),
        ])
        specimen = (CORPUS / "unnamed 9.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_pulse_s9_byte_perfect(self, baseline):
        """Pulse step 9 should match corpus unnamed 59."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.PULSE, 0x01),
        ])
        specimen = (CORPUS / "unnamed 59.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_multiply_s9_byte_perfect(self, baseline):
        """Multiply step 9 should match corpus unnamed 60."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.MULTIPLY, 0x00),
        ])
        specimen = (CORPUS / "unnamed 60.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_velocity_s9_byte_perfect(self, baseline):
        """Velocity step 9 should match corpus unnamed 61."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.VELOCITY, 0x01),
        ])
        specimen = (CORPUS / "unnamed 61.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_body_growth_step1_pulse(self, baseline):
        """Step 1 Pulse: net +3 bytes."""
        base_size = len(baseline.tracks[0].body) - 2  # minus type-05 padding
        proj = add_step_components(baseline, 1, [
            StepComponent(1, ComponentType.PULSE, 0x01),
        ])
        assert len(proj.tracks[0].body) == base_size + 3

    def test_body_growth_step1_multiply(self, baseline):
        """Step 1 Multiply: net +1 byte."""
        base_size = len(baseline.tracks[0].body) - 2
        proj = add_step_components(baseline, 1, [
            StepComponent(1, ComponentType.MULTIPLY, 0x00),
        ])
        assert len(proj.tracks[0].body) == base_size + 1

    def test_body_growth_step9_pulse(self, baseline):
        """Step 9 Pulse: net +6 bytes."""
        base_size = len(baseline.tracks[0].body) - 2
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.PULSE, 0x01),
        ])
        assert len(proj.tracks[0].body) == base_size + 6

    def test_no_preamble_change_on_t2(self, baseline):
        """Component-only activation must NOT set 0x64 on next track."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.PULSE, 0x01),
        ])
        assert proj.tracks[1].preamble == baseline.tracks[1].preamble
