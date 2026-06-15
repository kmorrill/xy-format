from __future__ import annotations

from dataclasses import replace
from typing import Dict, List, Tuple

from .container import TrackBlock, XYProject
from .scaffold_writer import LogicalEntry, extract_logical_entries


PRETRACK_PATCH_MODES: Tuple[str, ...] = (
    "none",
    "song2_s2s3_bytes",
    "song2_scene2_bytes",
    "song2_byte_0f",
    "song2_byte_10",
    "song2_byte_11",
)

TRACK16_PATCH_MODES: Tuple[str, ...] = (
    "none",
    "scene_count_3_byte",
    "song2_scene2_struct_154",
    "song2_s2s3_struct_155",
)


def _rebuild_project(template: XYProject, entries: List[LogicalEntry]) -> XYProject:
    if len(entries) < 16:
        raise ValueError(f"need >=16 logical entries, got {len(entries)}")

    tracks: List[TrackBlock] = []
    for i in range(15):
        entry = entries[i]
        tracks.append(TrackBlock(index=i, preamble=entry.preamble, body=entry.body))

    overflow = entries[15:]
    first = overflow[0]
    parts = [first.body]
    for entry in overflow[1:]:
        parts.append(entry.preamble)
        parts.append(entry.body)
    tracks.append(TrackBlock(index=15, preamble=first.preamble, body=b"".join(parts)))
    return XYProject(pre_track=template.pre_track, tracks=tracks)


def _entry_index(entries: List[LogicalEntry]) -> Dict[tuple[int, int], int]:
    return {(entry.track, entry.pattern): i for i, entry in enumerate(entries)}


def patch_pretrack_bytes(pre: bytes, mode: str) -> bytes:
    if mode not in PRETRACK_PATCH_MODES:
        raise ValueError(f"unknown pretrack mode: {mode}")
    if mode == "none":
        return pre

    if len(pre) < 0x12:
        raise ValueError("pre-track too short for scene/song token patch")

    b = bytearray(pre)
    if mode == "song2_s2s3_bytes":
        # Non-structural token approximation of 150->155 around 0x0F.
        # Keeps pre-track length unchanged for safer probing.
        b[0x0F] = 0x02
        b[0x10] = 0x01
        b[0x11] = 0x00
    elif mode == "song2_scene2_bytes":
        # Known-safe tuple for Time After Time j06-family branch.
        b[0x0F] = 0x01
        b[0x10] = 0x01
        b[0x11] = 0x00
    elif mode == "song2_byte_0f":
        b[0x0F] = 0x02
    elif mode == "song2_byte_10":
        b[0x10] = 0x01
    elif mode == "song2_byte_11":
        b[0x11] = 0x00
    return bytes(b)


def patch_track16_entries(entries: List[LogicalEntry], mode: str) -> List[LogicalEntry]:
    if mode not in TRACK16_PATCH_MODES:
        raise ValueError(f"unknown track16 mode: {mode}")
    if mode == "none":
        return entries

    idx = _entry_index(entries)
    key = (16, 1)
    if key not in idx:
        raise ValueError("missing logical Track16/P1 entry")

    i = idx[key]
    entry = entries[i]
    body = bytearray(entry.body)

    if mode == "scene_count_3_byte":
        # Minimal non-structural byte probe inspired by 150->155 first delta.
        # unnamed150: body[0x15F] = 0x01, unnamed155: 0x03.
        if len(body) <= 0x15F:
            raise ValueError("Track16 body too short for +0x15F patch")
        body[0x15F] = 0x03
    elif mode == "song2_scene2_struct_154":
        # Transplant exact Track16 structural op from unnamed150 -> unnamed154:
        # insert at +0x15F: 02 00 01 01 00 00
        # delete old tail bytes at +0x18F..+0x192 (original +0x18F:+0x193)
        if len(body) < 403:
            raise ValueError("Track16 body too short for 154 structural patch")
        if body[399:403] != b"\x01\x00\x00\x01":
            raise ValueError("unexpected Track16 tail sentinel for 154 patch")
        new_body = body[:351] + bytes.fromhex("020001010000") + body[351:399]
        body = bytearray(new_body)
    elif mode == "song2_s2s3_struct_155":
        # Transplant exact Track16 structural op from unnamed150 -> unnamed155:
        # insert at +0x15F: 03 00 01 02 00 00 00
        # delete old tail bytes at +0x18F..+0x192 (original +0x18F:+0x193)
        if len(body) < 403:
            raise ValueError("Track16 body too short for 155 structural patch")
        if body[399:403] != b"\x01\x00\x00\x01":
            raise ValueError("unexpected Track16 tail sentinel for 155 patch")
        new_body = body[:351] + bytes.fromhex("03000102000000") + body[351:399]
        body = bytearray(new_body)

    entries[i] = replace(entry, body=bytes(body))
    return entries


def apply_scene_song_patch(
    project: XYProject,
    *,
    pretrack_mode: str = "none",
    track16_mode: str = "none",
) -> XYProject:
    if pretrack_mode not in PRETRACK_PATCH_MODES:
        raise ValueError(f"unknown pretrack mode: {pretrack_mode}")
    if track16_mode not in TRACK16_PATCH_MODES:
        raise ValueError(f"unknown track16 mode: {track16_mode}")

    entries = extract_logical_entries(project)
    entries = patch_track16_entries(list(entries), track16_mode)
    patched = _rebuild_project(project, entries)
    return XYProject(
        pre_track=patch_pretrack_bytes(patched.pre_track, pretrack_mode),
        tracks=patched.tracks,
    )
