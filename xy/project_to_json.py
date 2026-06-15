"""Extract decoded intent from an .xy file as a ``BuildSpec`` JSON dict.

This is the inverse of ``xy/json_build_spec.py``: it reads a binary
``.xy`` project and produces a dict that, when passed back through
``build_xy_bytes`` with the same template, produces functionally
equivalent output.

Round-trip strength: **intent round-trip, not byte-exact.** Fields the
encoder understands are extracted and re-applied; everything else
comes from the scaffold template unchanged. Two files with different
undecoded state can therefore produce the same JSON but different
bytes — that's expected, and is why this emits a ``template`` field.

What's decoded today (matching the current profile catalog):
- Header transport: tempo, groove type/amount, metronome level
- Per-track notes on pattern 1 (the top-level track block) for every
  single-pattern track, via ``xy/note_reader.read_event``
- Diagnostic decoded-image state under ``_decoded_global_state`` and
  ``_decoded_track_state``: master EQ, engine parameters, envelopes,
  filter knobs, sends, pinned LFO current lanes, and mixer pan/volume
- Editable ``sound_state`` with the same decoded sound values, suitable for
  feeding back through ``xy/json_build_spec.py``

What's **not** decoded (stays opaque in the scaffold):
- Multi-pattern clone bodies (patterns 2..N live in the overflow
  region; reading them needs the block-rotation walker which is not
  yet wired to this path)
- Scene and song state
- Preset references as editable BuildSpec fields
- Step components, parameter locks as editable BuildSpec fields
- Full LFO/sampler/mix-master enum semantics

For the fields it doesn't decode, the round-trip story is: edit the
JSON's decoded fields, keep ``template`` pointing at the original
file, and ``build_xy_bytes`` will re-apply your intent on top of the
template's undecoded bytes.
"""

from __future__ import annotations

import re
from pathlib import Path
from typing import Dict, List

from .container import XYContainer, XYProject
from .note_reader import read_track_notes
from .profiles import PROFILES, infer_profile
from .rle import decode_project


SUPPORTED_SPEC_VERSION = 1
BASELINE_PRE_TRACK_LEN = 0x7C  # 124: the baseline single-pattern length
DESCRIPTOR_V56_OFFSET = 0x56
DESCRIPTOR_V57_OFFSET = 0x57
SIG_RE = re.compile(rb"\x00\x00\x00[\x00-\x0f]\xff\x00\xfc\x00", re.S)

GLOBAL_EQ = {
    "low": 0x68,
    "mid": 0x6C,
    "high": 0x70,
}
GLOBAL_EQ_BLEND_CANDIDATE = 0x74
GLOBAL_MASTER_MIX_CLUSTER_CANDIDATE = (0x75, 0x95)

TRACK_U8_FIELDS = {
    "pattern_count": 0x00,
    "pattern_steps": 0x01,
    "scale_byte": 0x06,
    "engine_id": 0x14,
    "m4_page": 0x20,
    "filter_type": 0x21,
    "filter_enabled": 0x25,
}

TRACK_U32_GROUPS = {
    "engine_params": {
        "param1": 0x3857,
        "param2": 0x385B,
        "param3": 0x385F,
        "param4": 0x3863,
    },
    "amp_envelope": {
        "attack": 0x3877,
        "decay": 0x387B,
        "sustain": 0x387F,
        "release": 0x3883,
    },
    "m2_shift": {
        "play_mode": 0x3887,
        "portamento": 0x388B,
        "pitch_bend_range": 0x388F,
        "engine_volume": 0x3893,
    },
    "filter": {
        "cutoff": 0x3897,
        "resonance": 0x389B,
        "env_amount": 0x389F,
        "key_tracking": 0x38A3,
    },
    "sends": {
        "ext": 0x38A7,
        "tape": 0x38AB,
        "fx1": 0x38AF,
        "fx2": 0x38B3,
    },
    "lfo_current": {
        "cc40": 0x38B7,
        "cc41": 0x38BB,
    },
    "filter_envelope": {
        "attack": 0x38D7,
        "decay": 0x38DB,
        "sustain": 0x38DF,
        "release": 0x38E3,
    },
    "mix": {
        "pan": 0x38F7,
        "volume": 0x38FB,
    },
}


def _looks_multi_pattern(project: XYProject) -> bool:
    """Detect whether the project uses multi-pattern topology.

    A single-pattern project has ``v56 == 0 and v57 == 0`` AND a
    baseline-length pre-track (``0x7C`` bytes). Multi-pattern files
    set v56/v57 for T1/T2 multi-pattern, or insert a longer pre-track
    to accommodate the Scheme A descriptor body at ``0x58``.

    A handful of corpus files have shorter pre-tracks (119-123 bytes)
    from older firmware versions; those are conservatively treated as
    single-pattern because their v56/v57 bytes are zero and they
    never carry a multi-pattern descriptor.

    See docs/format/descriptor_encoding.md for the authoritative
    layout.
    """
    pre_track = project.pre_track
    if len(pre_track) < 0x58:
        return False
    v56 = pre_track[DESCRIPTOR_V56_OFFSET]
    v57 = pre_track[DESCRIPTOR_V57_OFFSET]
    if v56 != 0 or v57 != 0:
        return True
    # v56==0 and v57==0: T1 and T2 are single-pattern. A longer
    # pre-track still indicates a Scheme A descriptor for T3+ tracks
    # was inserted.
    return len(pre_track) > BASELINE_PRE_TRACK_LEN


def _note_to_dict(note) -> Dict:
    """Serialise a ``Note`` into the JSON shape ``BuildSpec`` expects."""
    out: Dict = {
        "step": note.step,
        "note": note.note,
        "velocity": note.velocity,
    }
    if note.tick_offset:
        out["tick_offset"] = note.tick_offset
    if note.gate_ticks:
        out["gate_ticks"] = note.gate_ticks
    return out


def _u32(image: bytes, offset: int) -> int:
    return int.from_bytes(image[offset : offset + 4], "little")


def _hex_offset(offset: int) -> str:
    return f"0x{offset:05X}"


def _track_struct_starts(image: bytes) -> List[int]:
    """Return the 16 leader track starts in decoded-image space.

    Multi-pattern projects insert clone structs between leaders. The first
    byte of each leader stores pattern count, so we can skip clone structs
    and still report the current state for tracks 1..16.
    """
    starts = [m.start() - 3 for m in SIG_RE.finditer(image)]
    leaders: List[int] = []
    idx = 0
    while idx < len(starts) and len(leaders) < 16:
        start = starts[idx]
        leaders.append(start)
        pattern_count = image[start] if start < len(image) else 1
        if not 1 <= pattern_count <= 9:
            pattern_count = 1
        idx += pattern_count

    # Fall back to raw detected order for unusual/older corpus files whose
    # leader count byte does not let us walk all tracks.
    if len(leaders) < 16 and len(starts) >= 16:
        leaders = starts[:16]
    return leaders


def _decoded_global_state(image: bytes) -> Dict:
    start, end = GLOBAL_MASTER_MIX_CLUSTER_CANDIDATE
    return {
        "master_eq": {
            name: {
                "offset": _hex_offset(offset),
                "u32": _u32(image, offset),
            }
            for name, offset in GLOBAL_EQ.items()
        },
        "eq_blend_candidate": {
            "offset": _hex_offset(GLOBAL_EQ_BLEND_CANDIDATE),
            "u8": image[GLOBAL_EQ_BLEND_CANDIDATE],
        },
        "master_mix_cluster_candidate": {
            "range": f"{_hex_offset(start)}..{_hex_offset(end - 1)}",
            "hex": image[start:end].hex(),
        },
    }


def _decoded_track_state(image: bytes) -> List[Dict]:
    starts = _track_struct_starts(image)
    decoded: List[Dict] = []
    for track, start in enumerate(starts[:16], start=1):
        entry: Dict = {
            "track": track,
            "offset": _hex_offset(start),
            "u8": {
                name: image[start + rel]
                for name, rel in TRACK_U8_FIELDS.items()
                if start + rel < len(image)
            },
            "current_values": {},
        }
        current_values = entry["current_values"]
        for group, fields in TRACK_U32_GROUPS.items():
            current_values[group] = {
                name: {
                    "offset": _hex_offset(start + rel),
                    "track_relative_offset": _hex_offset(rel),
                    "u32": _u32(image, start + rel),
                }
                for name, rel in fields.items()
                if start + rel + 4 <= len(image)
            }
        decoded.append(entry)
    return decoded


def _sound_state_from_image(image: bytes) -> Dict:
    starts = _track_struct_starts(image)
    tracks: List[Dict] = []
    for track, start in enumerate(starts[:16], start=1):
        values = {
            group: {
                name: _u32(image, start + rel)
                for name, rel in fields.items()
                if start + rel + 4 <= len(image)
            }
            for group, fields in TRACK_U32_GROUPS.items()
        }
        filter_values = dict(values["filter"])
        if start + TRACK_U8_FIELDS["filter_type"] < len(image):
            filter_values["type"] = image[start + TRACK_U8_FIELDS["filter_type"]]
        if start + TRACK_U8_FIELDS["filter_enabled"] < len(image):
            filter_values["enabled"] = bool(image[start + TRACK_U8_FIELDS["filter_enabled"]])

        track_entry: Dict = {
            "track": track,
            "engine_id": image[start + TRACK_U8_FIELDS["engine_id"]],
            "engine_params": values["engine_params"],
            "amp_envelope": values["amp_envelope"],
            "m2_shift": values["m2_shift"],
            "filter": filter_values,
            "sends": values["sends"],
            "lfo_current": values["lfo_current"],
            "filter_envelope": values["filter_envelope"],
            "mix": values["mix"],
        }
        tracks.append(track_entry)

    return {
        "master_eq": {
            name: _u32(image, offset)
            for name, offset in GLOBAL_EQ.items()
        },
        "tracks": tracks,
    }


def _extract_track_patterns(
    project: XYProject,
) -> List[Dict]:
    """Return the JSON ``tracks`` array, one entry per track with notes.

    Only pattern 1 (the top-level track block body) is emitted. Tracks
    with no decodable notes are omitted from the list — they'd add
    noise and the template carries their state regardless.
    """
    tracks: List[Dict] = []
    for idx, track in enumerate(project.tracks):
        if track.type_byte == 0x05:
            # Inactive track (padding still present). No note payload.
            continue
        notes = read_track_notes(track, idx + 1)
        if not notes:
            continue
        tracks.append({
            "track": idx + 1,
            "patterns": [[_note_to_dict(n) for n in notes]],
        })
    return tracks


def project_to_json(
    xy_bytes: bytes,
    *,
    template_path: Path,
) -> Dict:
    """Extract decoded project intent from an .xy file.

    Parameters
    ----------
    xy_bytes : bytes
        The full ``.xy`` file contents.
    template_path : Path
        Path to the file that will be used as the scaffold template
        on re-build. Typically this is the same file being read —
        round-tripping applies the extracted intent on top of the
        original bytes. The path is embedded in the returned dict.

    Returns
    -------
    dict
        A ``BuildSpec`` payload with a declared profile that matches
        what was decoded. Can be fed back into
        ``xy.json_build_spec.parse_build_spec`` and
        ``build_xy_bytes`` for a round-trip.

    Notes
    -----
    The returned ``profile`` is inferred from decoded content. If the
    file has multi-pattern topology that wasn't captured in ``tracks``,
    the profile will be ``header_only`` (safe — only tempo/groove/
    metronome round-trip). Extending decode coverage (e.g. multi-
    pattern clone walking) will allow richer profiles to be inferred.
    """
    project = XYProject.from_bytes(xy_bytes)
    container = XYContainer.from_bytes(xy_bytes)
    header = container.header
    _, image = decode_project(xy_bytes)

    # Multi-pattern projects store patterns 2..N in overflow blocks
    # that our top-level-blocks-only extraction can't reach. Emitting
    # ``single_pattern_notes`` for them would ask the builder to
    # re-encode only pattern 1, which would break the template's
    # clone state. For those, we only surface decoded header intent.
    multi_pattern = _looks_multi_pattern(project)
    tracks = [] if multi_pattern else _extract_track_patterns(project)

    payload: Dict = {
        "version": SUPPORTED_SPEC_VERSION,
        "mode": "multi_pattern",
        "template": str(template_path),
        "header": {
            "tempo_tenths": header.tempo_tenths,
            "groove_type": header.groove_type,
            "groove_amount": header.groove_amount,
            "metronome_level": header.metronome_level,
        },
    }

    # Always include ``tracks`` (possibly empty) so ``parse_build_spec``
    # doesn't trip on the field being absent.
    payload["tracks"] = tracks
    payload["sound_state"] = _sound_state_from_image(image)
    payload["_decoded_global_state"] = _decoded_global_state(image)
    payload["_decoded_track_state"] = _decoded_track_state(image)

    # If multi-pattern, note the limitation in a ``_notes`` key the
    # reader can surface. (``_``-prefixed keys are ignored by the
    # BuildSpec parser.)
    if multi_pattern:
        payload["_notes"] = [
            "multi-pattern topology detected: pattern 2+ bodies are "
            "in the overflow region and not decoded by project_to_json "
            "yet. Only header changes will round-trip."
        ]

    # Infer the profile by running the same validators the build path
    # uses, against the payload we just assembled. Prefer the most
    # specific profile that matches.
    payload["profile"] = _infer_profile_from_payload(payload)

    return payload


def _infer_profile_from_payload(payload: Dict) -> str:
    """Pick the most-specific profile this payload fits.

    We mimic ``build_spec``'s parse step with a minimal in-memory
    object so we can call ``infer_profile`` from ``xy.profiles``.
    This avoids importing ``json_build_spec`` (which imports this
    module's peer ``project_builder`` and would risk a circular
    import).
    """
    # Build a lightweight duck-typed spec object for profile inference.
    class _FakeHeader:
        def __init__(self, hdr: Dict) -> None:
            self.tempo_tenths = hdr.get("tempo_tenths")
            self.groove_type = hdr.get("groove_type")
            self.groove_amount = hdr.get("groove_amount")
            self.metronome_level = hdr.get("metronome_level")

        def has_changes(self) -> bool:
            return any(
                v is not None
                for v in (
                    self.tempo_tenths,
                    self.groove_type,
                    self.groove_amount,
                    self.metronome_level,
                )
            )

    class _FakeSceneSong:
        def has_changes(self) -> bool:
            return False

    class _FakeSoundState:
        def __init__(self, raw: Dict | None) -> None:
            self.raw = raw or {}

        def has_changes(self) -> bool:
            return bool(self.raw.get("master_eq")) or bool(self.raw.get("tracks"))

    class _FakeTrackEntry:
        def __init__(self, track: int, patterns: List) -> None:
            self.track = track
            # Convert each pattern's notes list into a proxy list; only
            # the length matters to the validator, so we can pass raw
            # note dicts directly.
            self.patterns = [list(p) if p else None for p in patterns]

    class _FakeSpec:
        def __init__(self) -> None:
            self.mode = payload.get("mode", "multi_pattern")
            self.header = _FakeHeader(payload.get("header", {}))
            self.scene_song = _FakeSceneSong()
            self.scene_assignments = {}
            self.song_arrangement = []
            self.sound_state = _FakeSoundState(payload.get("sound_state"))
            self.descriptor_strategy = "strict"
            self.topology_policy = "none"
            self.multi_tracks = [
                _FakeTrackEntry(t["track"], t["patterns"])
                for t in payload.get("tracks", [])
            ]

    fake = _FakeSpec()
    inferred = infer_profile(fake)
    if inferred is None:
        # Nothing decoded that matches a profile — safest is header_only
        # if the header decoded, otherwise we can't say.
        if fake.header.has_changes():
            return "header_only"
        raise ValueError(
            "project_to_json: could not infer a profile from decoded "
            "content. File may have no decodable intent in the current "
            "profile catalog."
        )
    return inferred
