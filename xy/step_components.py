"""Step component encoding for OP-XY track blocks.

Step components modify note playback behavior on individual steps.
They are stored in a 13-slot table within the track body, using two
dedicated slot positions — one per half of the bar.

Slot model (device-verified: steps 1 and 9 work; steps 5 and 13 crash):
  Single-step mode only supports step 1 and step 9:
    Slot 5 → step 1   (0 trailing sentinels)
    Slot 6 → step 9   (1 trailing sentinel)
  For other steps, the multi-step encoding (unnamed 118/119) is required
  but not yet implemented.  The step_byte formula is the same across both
  modes, but single-step mode uses slot replacement while multi-step
  replaces the entire sentinel table with a contiguous block stream.

Encoding overview (byte-perfect on 16 corpus specimens: unnamed 8/9/59-61/67-77):

  The 3-byte slot entry (ff 00 00 at baseline) is REPLACED by the
  component's header bytes.  Any additional payload bytes (and trailing
  sentinels) are INSERTED after the slot position.  Net body growth =
  total_data_size - 3.

  Component data layout:
    Header (3 bytes):  [step_byte] [bitmask] [0x00]
    Payload (variable):
      1-byte:  [param]                        -- PulseMax, Velocity
      3-byte:  [repeat] [0x00] [0x00]         -- Pulse
      5-byte:  [0x00] [type_id] [param] [0x00] [0x00]
                                               -- all other types
    Trailing sentinels:  half x ff 00 00
      Steps 1-8  (half=0): 0 sentinels.
      Steps 9-16 (half=1): 1 sentinel (3 bytes).

  step_byte = ((0xE - step_0) << 4) | nibble
    nibble = 4 - half + bank
      half = step_0 // 8  (0 for steps 1-8, 1 for steps 9-16)
      bank = bitpos // 8  (0 for bank 1 bits 0-7, 1 for bank 2 bits 8-13)
    Verified:  step 1 bank 0 → 0xE4, step 9 bank 0 → 0x63, step 9 bank 1 → 0x64
    Predicted: step 5 bank 0 → 0xA4, step 13 bank 1 → 0x24, etc.

  14-bit bitmask across two banks:
    Bank 1 (bits 0-7):
      0x01 = Pulse / PulseMax  (unnamed 8, 9, 59, 60)
      0x02 = Hold              (unnamed 61)
      0x04 = Multiply          (unnamed 66)
      0x08 = Velocity          (unnamed 67)
      0x10 = Ramp Up           (unnamed 68)
      0x20 = Ramp Down         (unnamed 69)
      0x40 = Random            (unnamed 70)
      0x80 = Portamento        (unnamed 71)
    Bank 2 (bits 8-13):
      0x01 = Bend              (unnamed 72)
      0x02 = Tonality          (unnamed 73)
      0x04 = Jump              (unnamed 74)
      0x08 = Parameter         (unnamed 75)
      0x10 = Conditional       (unnamed 76)
      0x20 = Trigger           (unnamed 77)

  Alloc marker: XX 40 00 00 at body07 offset 0xC9 (baseline Drum).
    After insertion, shifts right by net_growth bytes.
    XX = ((0xF - step_0) << 4) + low_nibble  (arithmetic, NOT bitwise OR)
      low_nibble = 7 - global_bitpos  (for 3B and 5B payload; can be negative)
      low_nibble = 9                  (for 1B payload: PulseMax, Velocity)

Corpus-verified steps: 1 (Pulse, PulseMax) and 9 (all 14 types).
Device-tested: steps 5 and 13 crash (num_patterns > 0) — single-step
slot replacement is limited to steps 1 and 9.  Multi-step encoding
(unnamed 118/119) is needed for arbitrary steps.
"""

from __future__ import annotations

from dataclasses import dataclass
from enum import Enum, auto
from typing import NamedTuple


class ComponentType(Enum):
    """Step component types.

    All 14 types are serialization-supported.  They span a 14-bit bitmask
    across two banks (bank 1 = bits 0-7, bank 2 = bits 8-13).
    """
    # Bank 1 (global bits 0-7):
    PULSE = auto()       # bit 0, 3B — retrig (corpus: unnamed 8, 59)
    PULSE_MAX = auto()   # bit 0, 1B — pulse at max/random (corpus: unnamed 9, 60)
    HOLD = auto()        # bit 1, 5B, type=0x00 (corpus: unnamed 61)
    MULTIPLY = auto()    # bit 2, 5B, type=0x01 (corpus: unnamed 66)
    VELOCITY = auto()    # bit 3, 1B (corpus: unnamed 67)
    RAMP_UP = auto()     # bit 4, 5B, type=0x03 (corpus: unnamed 68)
    RAMP_DOWN = auto()   # bit 5, 5B, type=0x04 (corpus: unnamed 69)
    RANDOM = auto()      # bit 6, 5B, type=0x05 (corpus: unnamed 70)
    PORTAMENTO = auto()  # bit 7, 5B, type=0x06 (corpus: unnamed 71)
    # Bank 2 (global bits 8-13):
    BEND = auto()        # bit 8, 5B, type=0x06 (corpus: unnamed 72)
    TONALITY = auto()    # bit 9, 5B, type=0x07 (corpus: unnamed 73)
    JUMP = auto()        # bit 10, 5B, type=0x08 (corpus: unnamed 74)
    PARAMETER = auto()   # bit 11, 5B, type=0x09 (corpus: unnamed 75)
    CONDITIONAL = auto() # bit 12, 5B, type=0x0A (corpus: unnamed 76)
    TRIGGER = auto()     # bit 13, 5B, type=0x0B (corpus: unnamed 77)


class _Meta(NamedTuple):
    bitpos: int         # GLOBAL bit position (0-13); bank = bitpos // 8
    payload_size: int   # 1, 3, or 5 bytes
    type_id: int        # firmware type_id for 5-byte payload (-1 for others)
    default_param: int  # default param value observed in corpus


_COMPONENT_META: dict[ComponentType, _Meta] = {
    # Bank 1 (bits 0-7)
    ComponentType.PULSE:       _Meta(bitpos=0,  payload_size=3, type_id=-1,   default_param=0x01),
    ComponentType.PULSE_MAX:   _Meta(bitpos=0,  payload_size=1, type_id=-1,   default_param=0x00),
    ComponentType.HOLD:        _Meta(bitpos=1,  payload_size=5, type_id=0x00, default_param=0x01),
    ComponentType.MULTIPLY:    _Meta(bitpos=2,  payload_size=5, type_id=0x01, default_param=0x04),
    ComponentType.VELOCITY:    _Meta(bitpos=3,  payload_size=1, type_id=-1,   default_param=0x00),
    ComponentType.RAMP_UP:     _Meta(bitpos=4,  payload_size=5, type_id=0x03, default_param=0x08),
    ComponentType.RAMP_DOWN:   _Meta(bitpos=5,  payload_size=5, type_id=0x04, default_param=0x02),
    ComponentType.RANDOM:      _Meta(bitpos=6,  payload_size=5, type_id=0x05, default_param=0x03),
    ComponentType.PORTAMENTO:  _Meta(bitpos=7,  payload_size=5, type_id=0x06, default_param=0x07),
    # Bank 2 (bits 8-13)
    ComponentType.BEND:        _Meta(bitpos=8,  payload_size=5, type_id=0x06, default_param=0x01),
    ComponentType.TONALITY:    _Meta(bitpos=9,  payload_size=5, type_id=0x07, default_param=0x04),
    ComponentType.JUMP:        _Meta(bitpos=10, payload_size=5, type_id=0x08, default_param=0x04),
    ComponentType.PARAMETER:   _Meta(bitpos=11, payload_size=5, type_id=0x09, default_param=0x04),
    ComponentType.CONDITIONAL: _Meta(bitpos=12, payload_size=5, type_id=0x0A, default_param=0x02),
    ComponentType.TRIGGER:     _Meta(bitpos=13, payload_size=5, type_id=0x0B, default_param=0x09),
}

# The 55-slot ff 00 00 table starts at different body07 offsets per engine.
# Step component slots are at table positions 47 (steps 1-8) and 48 (steps 9-16).
# Table start offset is engine-dependent:
_TABLE_START: dict[int, int] = {
    0x03: 0x0024,  # Drum (T1, T2 default)
    0x12: 0x0024,  # Prism (T3 default)
    0x07: 0x0021,  # EPiano (T4 default)
    0x14: 0x0025,  # Dissolve (T5 default)
    0x13: 0x0025,  # Hardsync (T6 default)
    0x16: 0x0025,  # Axis (T7 default)
    0x1E: 0x0025,  # Multisampler (T8 default)
}
_DRUM_TABLE_START = 0x0024  # reference engine (all formulas derived from this)
_STEP_COMP_SLOT_OFFSET = 42  # step comp slots start at table_start + 42*3


_VALID_STEPS = {1, 9}  # only steps 1 and 9 work in single-step slot replacement mode


def _slot_for_step(step: int) -> int:
    """Return the slot index (5 or 6) for the given 1-based step.

    Only steps 1 and 9 are supported in single-step mode.  Steps 2-8
    and 10-16 require the multi-step encoding (not yet implemented).
    """
    if step not in _VALID_STEPS:
        raise ValueError(
            f"only steps {sorted(_VALID_STEPS)} are supported in single-step "
            f"mode; got step {step}"
        )
    return 5 + (step - 1) // 8


@dataclass
class StepComponent:
    """A step component to attach to a specific step."""
    step: int               # 1-based step index (1-16)
    component: ComponentType
    param: int = 0          # param value (Pulse: repeat count, others: component param)


def build_component_data(comp: StepComponent) -> bytes:
    """Build raw bytes that REPLACE the 3-byte slot entry.

    Returns header (3B) + payload (1/3/5B) + trailing sentinels (0 or 3B).
    The first 3 bytes overwrite the slot's ``ff 00 00`` entry; any
    additional bytes are inserted after the slot position.

    Net body growth = ``len(result) - 3``.
    """
    meta = _COMPONENT_META[comp.component]
    step_0 = comp.step - 1
    bank = meta.bitpos // 8  # 0 = bank 1, 1 = bank 2

    if comp.step not in _VALID_STEPS:
        raise ValueError(
            f"only steps {sorted(_VALID_STEPS)} are supported in single-step "
            f"mode; got step {comp.step}"
        )

    # Header: [step_byte] [bitmask] [0x00]
    half = step_0 // 8  # 0 for steps 1-8, 1 for steps 9-16
    nibble = 4 - half + bank
    step_byte = (((0xE - step_0) << 4) | nibble) & 0xFF
    local_bit = meta.bitpos % 8
    bitmask = 1 << local_bit
    header = bytes([step_byte, bitmask, 0x00])

    # Payload
    if meta.payload_size == 1:
        payload = bytes([comp.param & 0xFF])
    elif meta.payload_size == 3:
        payload = bytes([comp.param & 0xFF, 0x00, 0x00])
    elif meta.payload_size == 5:
        payload = bytes([0x00, meta.type_id, comp.param & 0xFF, 0x00, 0x00])
    else:
        raise ValueError(f"unexpected payload_size {meta.payload_size}")

    # Trailing sentinels: half x ff 00 00
    # Steps 1-8 (half=0): 0 sentinels.  Steps 9-16 (half=1): 1 sentinel.
    sentinels = b'\xff\x00\x00' * half

    return header + payload + sentinels


def slot_body07_offset(step: int, engine_id: int | None = None) -> int:
    """Return the body07 byte offset for the given step's slot.

    Parameters
    ----------
    step : int
        1-based step number (1-16).
    engine_id : int or None
        Engine ID byte.  ``None`` defaults to Drum (0x03).
    """
    if step not in _VALID_STEPS:
        raise ValueError(
            f"only steps {sorted(_VALID_STEPS)} are supported in single-step "
            f"mode; got step {step}"
        )
    table_start = _table_start_for_engine(engine_id)
    slot_abs = _STEP_COMP_SLOT_OFFSET + _slot_for_step(step)
    return table_start + slot_abs * 3


def compute_alloc_byte(comp: StepComponent, engine_id: int | None = None) -> int:
    """Compute the allocation marker byte value.

    Formula (Drum/reference):
      ``((0xF - step_0) << 4) + low_nibble``  (arithmetic addition)

    Uses arithmetic addition (not bitwise OR) so bank 2 values wrap
    correctly across the nibble boundary (e.g., 0x70 + (-1) = 0x6F).

    Parameters
    ----------
    comp : StepComponent
        The component being inserted.
    engine_id : int or None
        Engine ID byte.  ``None`` defaults to Drum (0x03).
    """
    meta = _COMPONENT_META[comp.component]
    step_0 = comp.step - 1
    if meta.payload_size == 1:
        low_nibble = 9
    else:
        low_nibble = 7 - meta.bitpos  # can be negative for bank 2
    base = (((0xF - step_0) << 4) + low_nibble) & 0xFF
    # Adjust for engine: offset = 0xDF - engine_baseline_alloc
    offset = _alloc_offset_for_engine(engine_id)
    return (base - offset) & 0xFF


def alloc_marker_body07_offset(net_growth: int, engine_id: int | None = None) -> int:
    """Return the body07 offset of the alloc marker after insertion.

    The marker is at table_start + 55*3 in baseline, shifting right by net_growth.
    """
    table_start = _table_start_for_engine(engine_id)
    baseline_offset = table_start + 55 * 3
    return baseline_offset + net_growth


# ── Engine-specific alloc offsets ────────────────────────────────────

# Baseline alloc byte at table_start + 55*3 for each engine type.
# Corpus verified: Drum=0xDF (unnamed 1 T1), Prism=0xDE (unnamed 1 T3),
# EPiano=0xE6 (unnamed 1 T4), etc.
_ENGINE_BASELINE_ALLOC: dict[int, int] = {
    0x03: 0xDF,  # Drum
    0x12: 0xDE,  # Prism
    0x07: 0xE6,  # EPiano
    0x14: 0xE2,  # Dissolve
    0x13: 0xDE,  # Hardsync
    0x16: 0xDF,  # Axis
    0x1E: 0xDF,  # Multisampler
}


def _table_start_for_engine(engine_id: int | None) -> int:
    """Return the 55-slot table start offset for the given engine."""
    if engine_id is None:
        return _DRUM_TABLE_START
    return _TABLE_START.get(engine_id, _DRUM_TABLE_START)


def _alloc_offset_for_engine(engine_id: int | None) -> int:
    """Return alloc byte adjustment: 0xDF - engine_baseline_alloc."""
    if engine_id is None:
        return 0
    baseline = _ENGINE_BASELINE_ALLOC.get(engine_id, 0xDF)
    return 0xDF - baseline
