"""Firmware-derived boundaries, raw preservation, and adapter path regressions."""
from pathlib import Path
import struct

import pytest

from xy.patch_json import PatchJsonSoundPatchOptions, sampler_patch_from_patch_json
from xy.preset_state import inspect_preset_state
from xy.rle import MAGIC, RleError, decode_project, encode, encode_project
from xy.serialization import LayoutError, parse_image

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / "src/one-off-changes-from-default/unnamed 1.xy"
CORPUS = sorted((ROOT / "src").rglob("*.xy"))


@pytest.mark.parametrize("path", CORPUS, ids=lambda p: str(p.relative_to(ROOT)))
def test_every_corpus_byte_has_a_count_driven_region(path):
    header, image = decode_project(path.read_bytes())
    assert header[4:6] == bytes([9, 19])
    layout = parse_image(image)
    cursor = 0
    for span in layout.spans:
        assert span.start == cursor
        cursor = span.end
    assert cursor == len(image)
    assert layout.reassemble() == image
    assert len(layout.pattern_counts) == 16


@pytest.mark.parametrize("header", [
    MAGIC + bytes([9, 19, 0, 0]),  # run inside decoded header
    MAGIC + bytes([9, 19, 1, 0]),  # run across header/payload boundary
])
def test_header_and_payload_share_one_rle_state(header):
    image = b"\0" * 260 + b"\x01"
    physical = encode(header + image)
    assert decode_project(physical) == (header, image)
    assert encode_project(header, image) == physical


@pytest.mark.parametrize("length", range(8))
def test_truncated_decoded_header_is_rejected(length):
    with pytest.raises(RleError, match="truncated"):
        decode_project(encode((MAGIC + bytes([9, 19, 0, 0]))[:length]))


def variable_project():
    header, image = decode_project(BASE.read_bytes())
    layout = parse_image(image)
    first = layout.pattern(1)
    fixed = bytearray(image[first.start:first.origin + 0x456F])
    # Distinguish full-width IDs, all parameter words, and the last sample.
    struct.pack_into("<I", fixed, 0x14 - 1, 0x12345678)
    struct.pack_into("<I", fixed, 0x1C - 1, 0x87654321)
    struct.pack_into("<I", fixed, 0x21 - 1, 0x80000009)
    for i in range(58):
        struct.pack_into("<I", fixed, 0x3857 - 1 + i * 4, 0x40000001 + i)
    slot = 0x393F - 1 + 23 * 128
    struct.pack_into("<6I", fixed, slot, 123, 10, 0xFFFFFFFF, 11, 99, 0x7FFFFFFF)
    fixed[slot + 0x18:slot + 0x20] = bytes([61, 0xAB, 80, 0xC3, 0xFB, 0xF4, 0x9C, 1])
    fixed[slot + 0x20:slot + 0x80] = b"last.wav\0" + bytes([0xFE]) * 87
    fixed[0x453F - 1:0x456F - 1] = b"kit/name\0" + bytes([0xFD]) * 39
    # One note and all four controller vectors precede the tuning suffix.
    vectors = b"\x01" + bytes(12)
    for count in (2, 1, 3, 2):
        vectors += bytes([count]) + b"".join(
            struct.pack("<Hh", j * 120, -123 + j) for j in range(count)
        )
    tuning = struct.pack("<12I", *range(0xFFFE0001, 0xFFFE000D))
    first_body = fixed + vectors + tuning + bytes([0xFF]) * 48
    clone = image[first.start:first.end]
    modified = bytearray(image[:first.start - 1])
    modified[0x3D] = 0xFE
    modified += b"\x02" + first_body + clone + image[first.end:]
    return header, bytes(modified), len(first_body)


def test_inspection_preserves_full_state_and_follows_variable_vectors():
    header, image, first_size = variable_project()
    result = inspect_preset_state(encode_project(header, image))
    assert result["pattern_counts"] == [2] + [1] * 15
    assert len(result["patterns"]) == 17
    state, clone, track2 = result["patterns"][:3]
    assert (state["track"], state["pattern"]) == (1, 1)
    assert (clone["track"], clone["pattern"]) == (1, 2)
    assert (track2["track"], track2["pattern"]) == (2, 1)
    assert clone["body_start"] == state["body_start"] + first_size
    assert track2["body_start"] == clone["body_end"] + 1
    assert state["engine_id"] == 0x12345678
    assert state["lfo_type"] == 0x87654321
    assert state["fx_type"] == 0x80000009
    assert state["octave"] == clone["octave"] == -2
    assert state["controller_counts"] == dict(pitchbend=2, modwheel=1, aftertouch=3, sustain=2)
    assert [p["raw_u32"] for p in state["parameter_words"]] == list(range(0x40000001, 0x4000003B))
    assert state["tuning_words_raw_u32"] == list(range(0xFFFE0001, 0xFFFE000D))
    assert state["unresolved_tail_raw_hex"] == "ff" * 48
    assert state["preset_identity"] == "kit/name"
    assert state["preset_identity_raw_hex"].endswith("fd" * 39)
    sample = state["samples"][23]
    assert len(state["samples"]) == 24
    assert sample["frame_count"] == 123
    assert sample["sample_start"] == 10
    assert sample["sample_end"] == 0xFFFFFFFF
    assert sample["fade_or_crossfade_raw"] == 0x7FFFFFFF
    assert sample["root_key"] == 61
    assert sample["unknown_19"] == 0xAB
    assert sample["high_key"] == 80
    assert sample["mode"] == 3
    assert sample["mode_flags_raw"] == 0xC3
    assert (sample["tune_raw_signed"], sample["gain_raw_signed"], sample["pan_raw_signed"]) == (-5, -12, -100)
    assert sample["path"] == "last.wav"
    assert sample["path_raw_hex"].endswith("fe" * 87)
    origin = state["virtual_origin"]
    assert bytes.fromhex(sample["raw_hex"]) == image[origin + 0x393F + 23 * 128:origin + 0x453F]
    assert clone["engine_id"] != state["engine_id"]


def test_legacy_version_never_uses_current_offsets():
    header, image = decode_project(BASE.read_bytes())
    with pytest.raises(LayoutError, match="requires format 9.19; got 9.18"):
        inspect_preset_state(encode_project(header[:5] + b"\x12" + header[6:], image))


@pytest.mark.parametrize("cut", [0, 3448, 3449, 21224, 289520])
def test_truncation_is_rejected(cut):
    _, image = decode_project(BASE.read_bytes())
    with pytest.raises(LayoutError):
        parse_image(image[:cut])


def test_suffix_must_be_explained_and_can_be_preserved_explicitly():
    _, image = decode_project(BASE.read_bytes())
    with pytest.raises(LayoutError, match="trailing bytes"):
        parse_image(image + b"extra")
    assert parse_image(image + b"extra", allow_trailing=True).reassemble() == image + b"extra"


@pytest.mark.parametrize("sample,expected", [
    ("kick.wav", "/fat32/presets/drum/kit.preset/kick.wav"),
    ("/fat32/samples/kick.wav", "/fat32/samples/kick.wav"),
    ("content/drum/kick.wav", "content/drum/kick.wav"),
    ("<samples>/kick.wav", "<samples>/kick.wav"),
    ("sub/kick.wav", "sub/kick.wav"),
])
def test_only_slash_free_sample_names_are_joined_to_preset_folder(sample, expected):
    patch = sampler_patch_from_patch_json(
        {"type": "sampler", "regions": [{"sample": sample}]},
        PatchJsonSoundPatchOptions(preset_device_path="/fat32/presets/drum/kit.preset"),
    )
    assert patch.path == expected
