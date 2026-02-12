"""Step component encoding for OP-XY track blocks.

Step components modify note playback behavior (hold, multiply, ramp, etc.).
They are stored in a 13-slot table within the track body at body07 offset 0xA2.

Encoding verified on 20 corpus specimens (unnamed 8/9/59-78).
Only step 1 and step 9 slot positions are verified. Other steps unsupported.

Component data format:
  Header (3 bytes): [step_byte] [B1] [B2]
  Param (3 or 5 bytes): standard = 00 TYPE_ID PARAM 00 00
                         pulse   = REPEAT 00 00
"""

from __future__ import annotations

from dataclasses import dataclass
from enum import Enum, auto
from typing import NamedTuple


class ComponentType(Enum):
    """Step component types. 14 total across 2 banks."""
    # Bank 1 (8 components)
    PULSE = auto()
    HOLD = auto()
    MULTIPLY = auto()
    VELOCITY = auto()
    RAMP_UP = auto()
    RAMP_DOWN = auto()
    RANDOM = auto()
    PORTAMENTO = auto()
    # Bank 2 (5 uniquely verified components; bit 0x20 omitted — ambiguous)
    BEND = auto()
    TONALITY = auto()
    JUMP = auto()
    PARAMETER = auto()
    CONDITIONAL = auto()


class _Meta(NamedTuple):
    bank: int       # 1 or 2
    bit: int        # bitmask bit for this component
    type_id: int    # type_id for standard 5-byte param record (-1 for non-standard)
    standard: bool  # True = 5-byte param, False = 3-byte param


_COMPONENT_META: dict[ComponentType, _Meta] = {
    ComponentType.PULSE:       _Meta(bank=1, bit=0x01, type_id=-1,   standard=False),
    ComponentType.HOLD:        _Meta(bank=1, bit=0x02, type_id=0x00, standard=True),
    ComponentType.MULTIPLY:    _Meta(bank=1, bit=0x04, type_id=0x01, standard=True),
    ComponentType.VELOCITY:    _Meta(bank=1, bit=0x08, type_id=-1,   standard=False),
    ComponentType.RAMP_UP:     _Meta(bank=1, bit=0x10, type_id=0x03, standard=True),
    ComponentType.RAMP_DOWN:   _Meta(bank=1, bit=0x20, type_id=0x04, standard=True),
    ComponentType.RANDOM:      _Meta(bank=1, bit=0x40, type_id=0x05, standard=True),
    ComponentType.PORTAMENTO:  _Meta(bank=1, bit=0x80, type_id=0x06, standard=True),
    ComponentType.BEND:        _Meta(bank=2, bit=0x01, type_id=0x06, standard=True),
    ComponentType.TONALITY:    _Meta(bank=2, bit=0x02, type_id=0x07, standard=True),
    ComponentType.JUMP:        _Meta(bank=2, bit=0x04, type_id=0x08, standard=True),
    ComponentType.PARAMETER:   _Meta(bank=2, bit=0x08, type_id=0x09, standard=True),
    ComponentType.CONDITIONAL: _Meta(bank=2, bit=0x10, type_id=0x0A, standard=True),
}

# Verified slot positions — only 2 data points from corpus
_STEP_SLOT: dict[int, int] = {
    1: 5,   # step_0=0 → slot 5 (offset 0xB1), verified: unnamed 8, 9
    9: 6,   # step_0=8 → slot 6 (offset 0xB4), verified: unnamed 59-78
}

SLOT_BASE = 0x00A2  # body07 offset of slot table start

# Allocation marker: [XX] 40 00 00 pattern at body07 0xC9 (baseline).
# After component insertion, shifts right by the insertion size.
# Formula for the allocation byte value (verified 16/19 corpus specimens):
#   alloc = 0xF7 - step_0 * 0x10 - component_global_index
#
# Global indices follow the bitmask order across both banks:
#   Pulse=0  Hold=1  Multiply=2  Velocity=3  RampUp=4  RampDown=5
#   Random=6  Portamento=7  Bend=8  Tonality=9  Jump=10  Parameter=11
#   Conditional=12  (bit 0x20)=13
#
# Known exceptions: Pulse/Velocity random-mode specimens have +2/+5 delta.
_ALLOC_BASELINE_OFFSET = 0x00C9  # body07 offset of alloc marker in baseline
_ALLOC_BASE = 0xF7  # formula base constant

_COMPONENT_GLOBAL_INDEX: dict[ComponentType, int] = {
    ComponentType.PULSE: 0,
    ComponentType.HOLD: 1,
    ComponentType.MULTIPLY: 2,
    ComponentType.VELOCITY: 3,
    ComponentType.RAMP_UP: 4,
    ComponentType.RAMP_DOWN: 5,
    ComponentType.RANDOM: 6,
    ComponentType.PORTAMENTO: 7,
    ComponentType.BEND: 8,
    ComponentType.TONALITY: 9,
    ComponentType.JUMP: 10,
    ComponentType.PARAMETER: 11,
    ComponentType.CONDITIONAL: 12,
}


@dataclass
class StepComponent:
    """A step component to attach to a specific step."""
    step: int               # 1-based step index (1-16)
    component: ComponentType
    param: int = 0          # param byte value (interpretation depends on component)


def build_component_data(comp: StepComponent) -> bytes:
    """Build the raw bytes to insert at the slot position.

    Returns header (3 bytes) + param record (3 or 5 bytes).
    Total: 6 bytes (non-standard) or 8 bytes (standard).
    """
    meta = _COMPONENT_META[comp.component]
    step_0 = comp.step - 1

    # Nibble encoding (corpus-verified for step_0=0 and step_0=8 only)
    if step_0 == 0:
        nibble = 4  # step 1: all components use nibble=4
    elif step_0 == 8:
        nibble = 3 if meta.bank == 1 else 4  # step 9: bank-dependent
    else:
        raise ValueError(
            f"step {comp.step} not yet supported (only steps 1 and 9 verified)"
        )

    header_byte = ((0xE - step_0) << 4) | nibble

    # Bitmask bytes depend on nibble
    if nibble == 3:
        b1 = meta.bit if meta.bank == 1 else 0x00
        b2 = meta.bit if meta.bank == 2 else 0x00
    else:  # nibble == 4
        b1 = meta.bit
        b2 = 0x00

    header = bytes([header_byte, b1, b2])

    # Param record
    if meta.standard:
        param_record = bytes([0x00, meta.type_id, comp.param & 0xFF, 0x00, 0x00])
    else:
        # Pulse/Velocity: [param] 00 00
        param_record = bytes([comp.param & 0xFF, 0x00, 0x00])

    return header + param_record


def slot_body07_offset(step: int) -> int:
    """Return the body07 byte offset for the given step's slot."""
    if step not in _STEP_SLOT:
        supported = ", ".join(str(s) for s in sorted(_STEP_SLOT))
        raise ValueError(
            f"step {step} not supported; verified slot positions: step {supported}"
        )
    return SLOT_BASE + _STEP_SLOT[step] * 3


def compute_alloc_byte(comp: StepComponent) -> int:
    """Compute the allocation marker byte for a single component.

    Formula: alloc = 0xF7 - step_0 * 0x10 - component_global_index
    Verified on 16/19 corpus specimens (exceptions: random-mode variants).
    """
    step_0 = comp.step - 1
    idx = _COMPONENT_GLOBAL_INDEX[comp.component]
    return (_ALLOC_BASE - step_0 * 0x10 - idx) & 0xFF


def alloc_marker_body07_offset(step: int, insert_size: int) -> int:
    """Return the body07 offset of the allocation marker after insertion.

    The marker starts at 0xC9 in baseline and shifts right by insert_size.
    """
    return _ALLOC_BASELINE_OFFSET + insert_size
