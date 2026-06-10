"""Tests for the .xy byte-level RLE codec (xy/rle.py)."""
from __future__ import annotations

import glob
import random

import pytest

from xy.rle import RleError, decode, decode_project, encode, encode_project

CORPUS = sorted(glob.glob("src/one-off-changes-from-default/*.xy"))
ALL_SRC = sorted(glob.glob("src/*.xy")) + CORPUS
# Known non-canonical file (tool-assembled lineage; decodes fine but the
# raw bytes contain non-greedy run splits, so re-encode is not identical).
NON_CANONICAL = {"bleez.xy"}


def test_simple_runs():
    assert encode(b"\x00\x00\x00") == b"\x00\x00\x01"
    assert decode(b"\x00\x00\x01") == b"\x00\x00\x00"
    assert encode(b"\x05") == b"\x05"
    assert encode(b"\x05\x05") == b"\x05\x05\x00"
    assert decode(b"\x05\x05\x00") == b"\x05\x05"


def test_gate_token_decodes_to_u32_240():
    # The legacy "default gate token" F0 00 00 01 is a u32 LE gate of 240.
    assert decode(b"\xf0\x00\x00\x01") == b"\xf0\x00\x00\x00"


def test_long_run_chunking():
    raw = b"\x00" * 600
    enc = encode(raw)
    assert enc == b"\x00\x00\xff" + b"\x00\x00\xff" + b"\x00\x00\x54"
    assert decode(enc) == raw


def test_pair_state_resets_after_extension():
    # value run, extension, then the same value again as a fresh literal
    assert decode(b"\x08\x08\x02\x08\x09") == b"\x08" * 5 + b"\x09"


def test_truncated_extension_raises():
    with pytest.raises(RleError):
        decode(b"\x00\x00")


def test_fuzz_roundtrip():
    rng = random.Random(7)
    for _ in range(500):
        raw = bytes(
            rng.choice([0, 0, 0, 1, 2, 0xFF])
            for _ in range(rng.randint(0, 600))
        )
        assert decode(encode(raw)) == raw


@pytest.mark.parametrize("path", ALL_SRC, ids=lambda p: p.split("/")[-1])
def test_corpus_roundtrip_byte_exact(path):
    data = open(path, "rb").read()
    if data[:4] != bytes.fromhex("ddccbbaa"):
        pytest.skip("not a .xy container")
    header, image = decode_project(data)
    rebuilt = encode_project(header, image)
    if path.split("/")[-1] in NON_CANONICAL:
        # decodes, but raw bytes are not canonical-greedy
        assert rebuilt != data
        assert decode(rebuilt, 8) == image  # still the same image
    else:
        assert rebuilt == data
