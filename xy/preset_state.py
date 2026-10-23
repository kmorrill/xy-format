"""Read the complete stored preset state in each format 9.19 pattern.

This is a raw-state inspector, not a patch.json exporter or firmware emulator.
It preserves bytes omitted by JSON, including low parameter bits and opaque
configuration. It does not resolve sample paths or perform load normalization.
See docs/format/preset_json.md for the firmware field crosswalk.
"""
from __future__ import annotations

import struct

from xy.rle import decode_project
from xy.serialization import LayoutError, parse_image


def _text(raw: bytes) -> str:
    # The adjacent raw hex retains invalid UTF-8 and bytes following NUL.
    return raw.split(b"\0", 1)[0].decode("utf-8", errors="replace")


def _sample(raw: bytes, slot: int) -> dict:
    words = struct.unpack_from("<6I", raw)
    tune, gain, pan = struct.unpack_from("<3b", raw, 0x1C)
    return {
        "slot": slot,  # zero-based stored order; not hikey - 53
        "raw_hex": raw.hex(),
        "frame_count": words[0],
        "sample_start": words[1],
        "sample_end": words[2],
        "loop_start": words[3],
        "loop_end": words[4],
        "fade_or_crossfade_raw": words[5],
        "root_key": raw[0x18],
        "unknown_19": raw[0x19],
        "high_key": raw[0x1A],
        "mode_flags_raw": raw[0x1B],
        "mode": raw[0x1B] & 0x3F,
        "tune_raw_signed": tune,
        "gain_raw_signed": gain,
        "pan_raw_signed": pan,
        "reverse_raw": raw[0x1F],
        "path": _text(raw[0x20:]),
        "path_raw_hex": raw[0x20:].hex(),
    }


def inspect_preset_state(data: bytes) -> dict:
    """Inspect a complete .xy file without changing or normalizing its state.

    Only format 9.19 is supported. Header version is checked before interpreting
    offsets; legacy images require their own readers and migration chain.
    Patterns/tracks in the result are one-based; sample slots are zero-based.
    Every sample slot is returned, including empty and non-sampler records.
    """
    header, image = decode_project(data)
    if header[4:6] != bytes([9, 19]):
        raise LayoutError(
            f"preset-state inspection requires format 9.19; "
            f"got {header[4]}.{header[5]}"
        )
    layout = parse_image(image)
    patterns = []
    for pattern in layout.patterns:
        origin = pattern.origin
        words = struct.unpack_from("<58I", image, origin + 0x3857)
        samples = [
            _sample(image[origin + 0x393F + i * 128:origin + 0x393F + (i + 1) * 128], i)
            for i in range(24)
        ]
        identity = image[origin + 0x453F:origin + 0x456F]
        tuning = image[pattern.end - 96:pattern.end - 48]
        tail = image[pattern.end - 48:pattern.end]
        patterns.append({
            "track": pattern.track,
            "pattern": pattern.number,
            "body_start": pattern.start,
            "body_end": pattern.end,
            "virtual_origin": origin,
            "note_count": pattern.note_count,
            "controller_counts": dict(zip(
                ("pitchbend", "modwheel", "aftertouch", "sustain"), pattern.lane_counts
            )),
            "octave": struct.unpack_from("<b", image, 0x3D + pattern.track - 1)[0],
            "timing_and_edit_raw_hex": image[origin + 1:origin + 0x13].hex(),
            "engine_and_pages_raw_hex": image[origin + 0x13:origin + 0x26].hex(),
            "engine_id": struct.unpack_from("<I", image, origin + 0x14)[0],
            "unknown_13": image[origin + 0x13],
            "unknown_18_u32": struct.unpack_from("<I", image, origin + 0x18)[0],
            "lfo_type": struct.unpack_from("<I", image, origin + 0x1C)[0],
            "lfo_active_raw": image[origin + 0x20],
            "fx_type": struct.unpack_from("<I", image, origin + 0x21)[0],
            "fx_active_raw": image[origin + 0x25],
            "opaque_config_raw_hex": image[origin + 0x26:origin + 0x24E].hex(),
            "parameter_words": [
                {"id": i, "raw_u32": word, "high16": word >> 16}
                for i, word in enumerate(words)
            ],
            "samples": samples,
            "preset_identity": _text(identity),
            "preset_identity_raw_hex": identity.hex(),
            "tuning_words_raw_u32": list(struct.unpack("<12I", tuning)),
            "tuning_raw_hex": tuning.hex(),
            "unresolved_tail_text": _text(tail),
            "unresolved_tail_raw_hex": tail.hex(),
        })
    return {
        "format": "9.19",
        "header_raw_hex": header.hex(),
        "decoded_payload_bytes": len(image),
        "pattern_counts": list(layout.pattern_counts),
        "patterns": patterns,
    }
