"""Byte-level RLE codec for the `.xy` container (decoded 2026-06-09).

The `.xy` file after its 8-byte header (magic ``DD CC BB AA`` + firmware
version) is ONE continuous RLE stream over the firmware's in-RAM project
image ("the decoded image"):

    Encoding rule: a run of k >= 2 equal bytes is written as
        [v][v][k-2]            (chunked at k = 257 per emission)
    Single bytes are written literally. The extension byte resets the
    pair detector (C-style: pairing is on consecutive *input* bytes).

The firmware's encoder is canonical-greedy: ``encode(decode(f)) == f``
byte-for-byte for 245/246 corpus files (the sole exception, ``bleez.xy``,
contains non-greedy run splits and is believed tool-assembled — see
``docs/logs/2026-06-09_record_boundary_reframe.md`` Part 6).

Decoded-image facts established so far (offsets into the decoded image,
baseline ``unnamed 1.xy``, decoded size 289,521 bytes):

    0x00  tempo, 0x03 groove type, 0x04 metronome/click volume,
    0x06  song-related, 0x55/0x64 MIDI config,
    0xd7a T1 bar count, 0xd7f T1 track scale,
    0x3dd0 + 16*step  T1 step-component slots (16 bytes per step),
    notes cost exactly 12 bytes each; a pattern struct is 17,875 bytes;
    engine swaps are size-preserving in-place substitutions.

Use :func:`decode_project` / :func:`encode_project` for whole files.
"""
from __future__ import annotations

HEADER_LEN = 8
MAGIC = bytes.fromhex("ddccbbaa")
MAX_RUN = 257  # 2 literal bytes + extension 255


class RleError(ValueError):
    pass


def decode(buf: bytes, start: int = 0, end: int | None = None) -> bytes:
    """Decode an RLE stream. Pairing is on consecutive input bytes; the
    extension byte clears the pair state."""
    out = bytearray()
    i = start
    stop = len(buf) if end is None else end
    prev = -1
    while i < stop:
        b = buf[i]
        i += 1
        out.append(b)
        if b == prev:
            if i >= stop:
                raise RleError(f"extension byte needed past end at {i}")
            ext = buf[i]
            i += 1
            out.extend(bytes([b]) * ext)
            prev = -1
        else:
            prev = b
    return bytes(out)


def encode(data: bytes) -> bytes:
    """Canonical greedy encoder (the firmware's behaviour): maximal runs,
    chunked at 257."""
    out = bytearray()
    i = 0
    n = len(data)
    while i < n:
        v = data[i]
        j = i
        while j < n and data[j] == v:
            j += 1
        k = j - i
        while k >= 2:
            c = min(k, MAX_RUN)
            out.append(v)
            out.append(v)
            out.append(c - 2)
            k -= c
        if k:
            out.append(v)
        i = j
    return bytes(out)


def decode_project(data: bytes) -> tuple[bytes, bytes]:
    """Split a `.xy` file into (header, decoded RAM image)."""
    if data[:4] != MAGIC:
        raise RleError("not a .xy file (bad magic)")
    return data[:HEADER_LEN], decode(data, HEADER_LEN)


def encode_project(header: bytes, image: bytes) -> bytes:
    """Inverse of :func:`decode_project`."""
    if len(header) != HEADER_LEN or header[:4] != MAGIC:
        raise RleError("header must be the original 8 bytes incl. magic")
    return header + encode(image)
