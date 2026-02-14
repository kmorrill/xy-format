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

    def test_pulse_max_step1(self):
        data = build_component_data(StepComponent(1, ComponentType.PULSE_MAX, 0x00))
        # Header: E4, 01 (shared bit with Pulse), 00; Payload: 00; No sentinel
        assert data == bytes([0xE4, 0x01, 0x00, 0x00])
        assert len(data) == 4

    def test_pulse_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.PULSE, 0x01))
        # Header: 63, 01, 00; Payload: 01 00 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x01, 0x00, 0x01, 0x00, 0x00, 0xFF, 0x00, 0x00])
        assert len(data) == 9

    def test_pulse_max_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.PULSE_MAX, 0x00))
        # Header: 63, 01, 00; Payload: 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x01, 0x00, 0x00, 0xFF, 0x00, 0x00])
        assert len(data) == 7

    def test_hold_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.HOLD, 0x01))
        # Header: 63, 02, 00; Payload: 00 00 01 00 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
                              0xFF, 0x00, 0x00])
        assert len(data) == 11

    def test_multiply_step9(self):
        """Multiply at bitpos=2, 5B payload, type_id=0x01."""
        data = build_component_data(StepComponent(9, ComponentType.MULTIPLY, 0x04))
        assert data == bytes([0x63, 0x04, 0x00, 0x00, 0x01, 0x04, 0x00, 0x00,
                              0xFF, 0x00, 0x00])
        assert len(data) == 11

    def test_velocity_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.VELOCITY, 0x00))
        # Header: 63, 08, 00; Payload: 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x08, 0x00, 0x00, 0xFF, 0x00, 0x00])
        assert len(data) == 7

    def test_ramp_up_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.RAMP_UP, 0x08))
        # Header: 63, 10, 00; Payload: 00 03 08 00 00; Sentinel: FF 00 00
        assert data == bytes([0x63, 0x10, 0x00, 0x00, 0x03, 0x08, 0x00, 0x00,
                              0xFF, 0x00, 0x00])
        assert len(data) == 11

    def test_ramp_down_step9(self):
        """Ramp Down at bitpos=5 (was incorrectly labeled Jump)."""
        data = build_component_data(StepComponent(9, ComponentType.RAMP_DOWN, 0x02))
        assert data == bytes([0x63, 0x20, 0x00, 0x00, 0x04, 0x02, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_random_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.RANDOM, 0x03))
        assert data == bytes([0x63, 0x40, 0x00, 0x00, 0x05, 0x03, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_portamento_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.PORTAMENTO, 0x07))
        assert data == bytes([0x63, 0x80, 0x00, 0x00, 0x06, 0x07, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    # ── Bank 2 components ──

    def test_bend_step9(self):
        """Bank 2 bit 0 (global 8): step_byte=0x64, bitmask=0x01."""
        data = build_component_data(StepComponent(9, ComponentType.BEND, 0x01))
        assert data == bytes([0x64, 0x01, 0x00, 0x00, 0x06, 0x01, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_tonality_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.TONALITY, 0x04))
        assert data == bytes([0x64, 0x02, 0x00, 0x00, 0x07, 0x04, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_jump_step9(self):
        """Real Jump: bank 2 bit 2 (global 10), type_id=0x08."""
        data = build_component_data(StepComponent(9, ComponentType.JUMP, 0x04))
        assert data == bytes([0x64, 0x04, 0x00, 0x00, 0x08, 0x04, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_parameter_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.PARAMETER, 0x04))
        assert data == bytes([0x64, 0x08, 0x00, 0x00, 0x09, 0x04, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_component_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.CONDITIONAL, 0x02))
        assert data == bytes([0x64, 0x10, 0x00, 0x00, 0x0A, 0x02, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    def test_trigger_step9(self):
        data = build_component_data(StepComponent(9, ComponentType.TRIGGER, 0x09))
        assert data == bytes([0x64, 0x20, 0x00, 0x00, 0x0B, 0x09, 0x00, 0x00,
                              0xFF, 0x00, 0x00])

    # ── Error cases ──

    def test_hold_step1(self):
        """Hold on step 1 uses slot 5, bank 1 nibble=4."""
        data = build_component_data(StepComponent(1, ComponentType.HOLD, 0x01))
        assert data[:3] == bytes([0xE4, 0x02, 0x00])  # step_byte, bitmask, 00
        assert len(data) == 8  # 3 header + 5 payload + 0 sentinels

    def test_unsupported_step_raises(self):
        """Steps other than 1 and 9 raise in single-step mode."""
        with pytest.raises(ValueError, match="only steps"):
            build_component_data(StepComponent(5, ComponentType.PULSE, 0x01))
        with pytest.raises(ValueError, match="only steps"):
            build_component_data(StepComponent(13, ComponentType.RANDOM, 0x01))

    def test_bank2_step1(self):
        """Bank 2 on step 1 uses nibble=5 (predicted, not corpus-verified)."""
        data = build_component_data(StepComponent(1, ComponentType.BEND, 0x01))
        # nibble = 4 - 0 + 1 = 5, step_byte = 0xE5
        assert data[0] == 0xE5
        assert data[1] == 0x01  # bitmask for Bend (bit 0 of bank 2)

    def test_step_out_of_range_raises(self):
        with pytest.raises(ValueError, match="only steps"):
            build_component_data(StepComponent(0, ComponentType.PULSE, 0x01))
        with pytest.raises(ValueError, match="only steps"):
            build_component_data(StepComponent(17, ComponentType.PULSE, 0x01))

    # ── Net growth checks ──

    def test_net_growth_step1(self):
        """Step 1: net body growth = data_size - 3."""
        pulse = build_component_data(StepComponent(1, ComponentType.PULSE, 0x01))
        assert len(pulse) - 3 == 3  # net +3

        mult = build_component_data(StepComponent(1, ComponentType.PULSE_MAX, 0x00))
        assert len(mult) - 3 == 1   # net +1

    def test_net_growth_step9(self):
        """Step 9: net body growth = data_size - 3 (includes sentinel)."""
        pulse = build_component_data(StepComponent(9, ComponentType.PULSE, 0x01))
        assert len(pulse) - 3 == 6  # net +6

        pmax = build_component_data(StepComponent(9, ComponentType.PULSE_MAX, 0x00))
        assert len(pmax) - 3 == 4   # net +4

        hold = build_component_data(StepComponent(9, ComponentType.HOLD, 0x01))
        assert len(hold) - 3 == 8    # net +8

    def test_net_growth_bank2(self):
        """Bank 2 5B components: same net growth as bank 1 5B."""
        for comp_type in [ComponentType.BEND, ComponentType.TONALITY,
                          ComponentType.JUMP, ComponentType.PARAMETER,
                          ComponentType.CONDITIONAL, ComponentType.TRIGGER]:
            data = build_component_data(StepComponent(9, comp_type, 0x01))
            assert len(data) - 3 == 8, f"{comp_type.name} net growth wrong"


# ── slot_body07_offset ────────────────────────────────────────────────


class TestSlotOffset:

    def test_step1_slot5(self):
        assert slot_body07_offset(1) == 0xA2 + 5 * 3  # 0xB1

    def test_step9_slot6(self):
        assert slot_body07_offset(9) == 0xA2 + 6 * 3  # 0xB4

    def test_unsupported_step_raises(self):
        """Steps other than 1 and 9 raise."""
        with pytest.raises(ValueError, match="only steps"):
            slot_body07_offset(5)
        with pytest.raises(ValueError, match="only steps"):
            slot_body07_offset(13)
        with pytest.raises(ValueError, match="only steps"):
            slot_body07_offset(0)
        with pytest.raises(ValueError, match="only steps"):
            slot_body07_offset(17)


# ── compute_alloc_byte ────────────────────────────────────────────────


class TestAllocByte:

    @pytest.mark.parametrize("comp_type,param,expected", [
        # Bank 1
        (ComponentType.PULSE,       0x01, 0x77),  # (7<<4)+(7-0) = 0x77
        (ComponentType.PULSE_MAX,   0x00, 0x79),  # (7<<4)+9     = 0x79
        (ComponentType.HOLD,        0x01, 0x76),  # (7<<4)+(7-1) = 0x76
        (ComponentType.MULTIPLY,    0x04, 0x75),  # (7<<4)+(7-2) = 0x75
        (ComponentType.VELOCITY,    0x00, 0x79),  # (7<<4)+9     = 0x79
        (ComponentType.RAMP_UP,     0x08, 0x73),  # (7<<4)+(7-4) = 0x73
        (ComponentType.RAMP_DOWN,   0x02, 0x72),  # (7<<4)+(7-5) = 0x72
        (ComponentType.RANDOM,      0x03, 0x71),  # (7<<4)+(7-6) = 0x71
        (ComponentType.PORTAMENTO,  0x07, 0x70),  # (7<<4)+(7-7) = 0x70
        # Bank 2 (arithmetic wraps across nibble boundary)
        (ComponentType.BEND,        0x01, 0x6F),  # (7<<4)+(7-8)  = 0x6F
        (ComponentType.TONALITY,    0x04, 0x6E),  # (7<<4)+(7-9)  = 0x6E
        (ComponentType.JUMP,        0x04, 0x6D),  # (7<<4)+(7-10) = 0x6D
        (ComponentType.PARAMETER,   0x04, 0x6C),  # (7<<4)+(7-11) = 0x6C
        (ComponentType.CONDITIONAL,   0x02, 0x6B),  # (7<<4)+(7-12) = 0x6B
        (ComponentType.TRIGGER,     0x09, 0x6A),  # (7<<4)+(7-13) = 0x6A
    ])
    def test_step9_alloc(self, comp_type, param, expected):
        comp = StepComponent(9, comp_type, param)
        assert compute_alloc_byte(comp) == expected

    def test_step1_pulse_alloc(self):
        comp = StepComponent(1, ComponentType.PULSE, 0x01)
        assert compute_alloc_byte(comp) == 0xF7  # (0xF<<4)+(7-0)

    def test_step1_pulse_max_alloc(self):
        comp = StepComponent(1, ComponentType.PULSE_MAX, 0x00)
        assert compute_alloc_byte(comp) == 0xF9  # (0xF<<4)+9

    def test_alloc_marker_offset(self):
        # Net growth shifts marker from baseline 0xC9
        assert alloc_marker_body07_offset(3) == 0xC9 + 3   # step 1 Pulse
        assert alloc_marker_body07_offset(6) == 0xC9 + 6   # step 9 Pulse
        assert alloc_marker_body07_offset(8) == 0xC9 + 8   # step 9 Hold


# ── Full round-trip against corpus specimens ──────────────────────────


class TestCorpusMatch:

    # Bank 1 step 1 specimens
    def test_pulse_s1_byte_perfect(self, baseline):
        """Pulse step 1 should match corpus unnamed 8."""
        proj = add_step_components(baseline, 1, [
            StepComponent(1, ComponentType.PULSE, 0x01),
        ])
        specimen = (CORPUS / "unnamed 8.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_pulse_max_s1_byte_perfect(self, baseline):
        """PulseMax step 1 should match corpus unnamed 9."""
        proj = add_step_components(baseline, 1, [
            StepComponent(1, ComponentType.PULSE_MAX, 0x00),
        ])
        specimen = (CORPUS / "unnamed 9.xy").read_bytes()
        assert proj.to_bytes() == specimen

    # Bank 1 step 9 specimens
    def test_pulse_s9_byte_perfect(self, baseline):
        """Pulse step 9 should match corpus unnamed 59."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.PULSE, 0x01),
        ])
        specimen = (CORPUS / "unnamed 59.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_pulse_max_s9_byte_perfect(self, baseline):
        """PulseMax step 9 should match corpus unnamed 60."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.PULSE_MAX, 0x00),
        ])
        specimen = (CORPUS / "unnamed 60.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_hold_s9_byte_perfect(self, baseline):
        """Hold step 9 should match corpus unnamed 61."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.HOLD, 0x01),
        ])
        specimen = (CORPUS / "unnamed 61.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_velocity_s9_byte_perfect(self, baseline):
        """Velocity step 9 should match corpus unnamed 67."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.VELOCITY, 0x00),
        ])
        specimen = (CORPUS / "unnamed 67.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_ramp_up_s9_byte_perfect(self, baseline):
        """Ramp Up step 9 should match corpus unnamed 68."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.RAMP_UP, 0x08),
        ])
        specimen = (CORPUS / "unnamed 68.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_ramp_down_s9_byte_perfect(self, baseline):
        """Ramp Down step 9 should match corpus unnamed 69."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.RAMP_DOWN, 0x02),
        ])
        specimen = (CORPUS / "unnamed 69.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_random_s9_byte_perfect(self, baseline):
        """Random step 9 should match corpus unnamed 70."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.RANDOM, 0x03),
        ])
        specimen = (CORPUS / "unnamed 70.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_portamento_s9_byte_perfect(self, baseline):
        """Portamento step 9 should match corpus unnamed 71."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.PORTAMENTO, 0x07),
        ])
        specimen = (CORPUS / "unnamed 71.xy").read_bytes()
        assert proj.to_bytes() == specimen

    # Bank 2 step 9 specimens
    def test_bend_s9_byte_perfect(self, baseline):
        """Bend step 9 should match corpus unnamed 72."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.BEND, 0x01),
        ])
        specimen = (CORPUS / "unnamed 72.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_tonality_s9_byte_perfect(self, baseline):
        """Tonality step 9 should match corpus unnamed 73."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.TONALITY, 0x04),
        ])
        specimen = (CORPUS / "unnamed 73.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_jump_s9_byte_perfect(self, baseline):
        """Jump step 9 should match corpus unnamed 74."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.JUMP, 0x04),
        ])
        specimen = (CORPUS / "unnamed 74.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_parameter_s9_byte_perfect(self, baseline):
        """Parameter step 9 should match corpus unnamed 75."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.PARAMETER, 0x04),
        ])
        specimen = (CORPUS / "unnamed 75.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_component_s9_byte_perfect(self, baseline):
        """Component step 9 should match corpus unnamed 76."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.CONDITIONAL, 0x02),
        ])
        specimen = (CORPUS / "unnamed 76.xy").read_bytes()
        assert proj.to_bytes() == specimen

    def test_trigger_s9_byte_perfect(self, baseline):
        """Trigger step 9 should match corpus unnamed 77."""
        proj = add_step_components(baseline, 1, [
            StepComponent(9, ComponentType.TRIGGER, 0x09),
        ])
        specimen = (CORPUS / "unnamed 77.xy").read_bytes()
        assert proj.to_bytes() == specimen

    # Body growth checks
    def test_body_growth_step1_pulse(self, baseline):
        """Step 1 Pulse: net +3 bytes."""
        base_size = len(baseline.tracks[0].body) - 2  # minus type-05 padding
        proj = add_step_components(baseline, 1, [
            StepComponent(1, ComponentType.PULSE, 0x01),
        ])
        assert len(proj.tracks[0].body) == base_size + 3

    def test_body_growth_step1_pulse_max(self, baseline):
        """Step 1 PulseMax: net +1 byte."""
        base_size = len(baseline.tracks[0].body) - 2
        proj = add_step_components(baseline, 1, [
            StepComponent(1, ComponentType.PULSE_MAX, 0x00),
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
