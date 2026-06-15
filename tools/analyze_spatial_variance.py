#!/usr/bin/env python3
"""Index variance in not-fully-decoded OP-XY decoded-image regions.

The goal is not to decode every byte automatically. It is to make the
mystery regions measurable across a local corpus so humans can prioritize the
regions whose variance is most likely to reveal structure.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from collections import Counter
from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterable

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from xy.rle import RleError, decode_project


SIG_RE = re.compile(rb"\x00\x00\x00[\x00-\x0f]\xff\x00\xfc\x00", re.S)


@dataclass(frozen=True)
class Region:
    name: str
    scope: str
    start: int
    end: int
    description: str
    speculation: str
    skip_slot_23: bool = False
    sample_engines_only: bool = False
    zero_note_tracks_only: bool = False

    @property
    def length(self) -> int:
        return self.end - self.start + 1


REGIONS: tuple[Region, ...] = (
    Region(
        "global.pre_scene_cluster",
        "global",
        0x0008,
        0x0054,
        "Global cluster before MIDI channels and scene records.",
        "Likely selected track/pattern, UI focus, edit mode, transport/project flags.",
    ),
    Region(
        "global.eq_gap",
        "global",
        0x0065,
        0x0067,
        "Three bytes between MIDI channel array and master EQ values.",
        "Could be transpose, key/scale, sync, or compact project flags.",
    ),
    Region(
        "global.pre_scene_slab_gap",
        "global",
        0x0074,
        0x0094,
        "Thirty-three bytes before the scene-record slab.",
        "Suspiciously one scene-record length; maybe live-selection alternate state or scene prologue.",
    ),
    Region(
        "track.low_preset_state",
        "track",
        0x0026,
        0x029F,
        "Opaque lower preset/track state copied by set_preset.",
        "Likely play mode, width, portamento, bend range, engine switches, routing defaults, UI mirrors.",
    ),
    Region(
        "track.post_plock_value_gap",
        "track",
        0x17A0,
        0x2C4D,
        "Large gap after p-lock value rows and before automation flags.",
        "Candidate for inactive automation buffers, UI mirrors, per-step metadata, or reserved capacity.",
    ),
    Region(
        "track.plock_activation_slab",
        "track",
        0x2C4E,
        0x304D,
        "P-lock activation/mask slab; first byte every 8 bytes is known step-active flag.",
        "Remaining bytes probably parameter masks, current selection, or inactive lane flags.",
    ),
    Region(
        "track.post_plock_master_gap",
        "track",
        0x304F,
        0x3056,
        "Eight bytes after the p-lock master flag and before step components.",
        "Likely automation summary bytes or selected p-lock lane state.",
    ),
    Region(
        "track.preset_identity_prefix",
        "track",
        0x3457,
        0x3856,
        "Start of major preset identity/sound-state donor-copy region.",
        "Likely preset-engine internal state, hidden params, modulation defaults, routing defaults, engine tails.",
    ),
    Region(
        "track.m1_to_amp_gap",
        "track",
        0x3867,
        0x3876,
        "Gap between M1 params and amp ADSR.",
        "Candidate for M1 shift params 5-8, engine hidden params, or UI mirrors.",
    ),
    Region(
        "track.amp_to_filter_gap",
        "track",
        0x3887,
        0x3896,
        "Gap between amp ADSR and filter knob block.",
        "Candidate for amp-envelope shift params, curves, velocity sensitivity mirror, engine volume.",
    ),
    Region(
        "track.filter_to_lfo_gap",
        "track",
        0x38A7,
        0x38B6,
        "Gap between filter knobs and LFO params.",
        "Candidate for filter shift params, filter mode tails, drive, Z-filter state.",
    ),
    Region(
        "track.lfo_to_filter_env_gap",
        "track",
        0x38C7,
        0x38D6,
        "Gap between LFO params and filter envelope.",
        "Strong candidate for LFO hidden/shift params; captures point to shape near +0x38D3.",
    ),
    Region(
        "track.post_filter_env_gap",
        "track",
        0x38E7,
        0x38FF,
        "Gap before modulation routing matrix.",
        "Candidate for modulation matrix header, pitchbend/velocity defaults, high-pass preamble.",
    ),
    Region(
        "track.mod_routing_matrix",
        "track",
        0x3900,
        0x393B,
        "Partly decoded modulation routing matrix.",
        "Need exact row/field names and signed amount encoding for every controller target.",
    ),
    Region(
        "track.pre_sample_gap",
        "track",
        0x393C,
        0x3956,
        "Gap before the sample/region table.",
        "Candidate for final preset performance flags, high-pass/filter tails, sampler-mode flags, table header.",
    ),
    Region(
        "track.sample_table_pre_label",
        "track",
        0x3957,
        0x453E,
        "Non-overlapping sample/region table area before preset label.",
        "Sample paths and many slot params live here; semantics vary across drum/sampler/multisampler.",
        sample_engines_only=True,
    ),
    Region(
        "track.post_note_count_tail",
        "track",
        0x4570,
        0x45D3,
        "Opaque fixed-body tail after note count in pristine donor structs.",
        "Preserved by set_preset; may be firmware default state or reserved trailing fields.",
        zero_note_tracks_only=True,
    ),
    Region(
        "slot.byte_01",
        "slot",
        0x01,
        0x01,
        "Unknown sample-slot byte.",
        "Candidate for low key, velocity low, slot enable, or alignment.",
    ),
    Region(
        "slot.byte_04",
        "slot",
        0x04,
        0x04,
        "Unknown sample-slot byte.",
        "Candidate for velocity high, region enable, group, or loop flag.",
    ),
    Region(
        "slot.bytes_05_06",
        "slot",
        0x05,
        0x06,
        "Provisional pan/fade/crossfade-adjacent signed bytes.",
        "Need captures to identify which byte maps to which shift control.",
    ),
    Region(
        "slot.tail_68_7f",
        "slot",
        0x68,
        0x7F,
        "Sample-slot numeric tail, excluding voice 23 to avoid preset-label overlap.",
        "Engine-dependent start/end/loop/gain/crossfade/length semantics.",
        skip_slot_23=True,
    ),
)


@dataclass
class OffsetStat:
    distinct: int
    nonzero_count: int
    top_values: list[tuple[int, int]]


@dataclass
class RegionStats:
    region: Region
    observations: int = 0
    files: set[str] = field(default_factory=set)
    engines: Counter[int] = field(default_factory=Counter)
    labels: Counter[str] = field(default_factory=Counter)
    digests: Counter[str] = field(default_factory=Counter)
    zero_observations: int = 0
    first: bytes | None = None
    variable: bytearray | None = None
    nonzero: bytearray | None = None
    counters: list[Counter[int]] | None = None

    def add(self, blob: bytes, file_label: str, engine: int | None = None, label: str = "") -> None:
        if len(blob) != self.region.length:
            return
        if self.first is None:
            self.first = blob
            self.variable = bytearray(self.region.length)
            self.nonzero = bytearray(self.region.length)
            self.counters = [Counter() for _ in range(self.region.length)]
        assert self.variable is not None
        assert self.nonzero is not None
        assert self.counters is not None
        self.observations += 1
        self.files.add(file_label)
        if engine is not None:
            self.engines[engine] += 1
        if label:
            self.labels[label] += 1
        if not any(blob):
            self.zero_observations += 1
        self.digests[hashlib.sha1(blob).hexdigest()[:12]] += 1
        first = self.first
        for idx, value in enumerate(blob):
            if value != first[idx]:
                self.variable[idx] = 1
            if value:
                self.nonzero[idx] = 1
            self.counters[idx][value] += 1

    def summary(self) -> dict:
        variable_positions = int(sum(self.variable or []))
        nonzero_positions = int(sum(self.nonzero or []))
        unique_digests = len(self.digests)
        variable_density = variable_positions / self.region.length if self.region.length else 0.0
        zero_observation_fraction = self.zero_observations / self.observations if self.observations else 0.0
        top_offsets = self.top_offsets()
        return {
            "name": self.region.name,
            "scope": self.region.scope,
            "range": f"0x{self.region.start:04X}..0x{self.region.end:04X}",
            "length": self.region.length,
            "observations": self.observations,
            "files": len(self.files),
            "unique_digests": unique_digests,
            "variable_positions": variable_positions,
            "variable_density": round(variable_density, 4),
            "nonzero_positions": nonzero_positions,
            "zero_observation_fraction": round(zero_observation_fraction, 4),
            "top_engines": [[f"0x{k:02X}", v] for k, v in self.engines.most_common(6)],
            "top_labels": self.labels.most_common(6),
            "priority": priority_label(self.observations, unique_digests, variable_density, zero_observation_fraction),
            "top_offsets": [
                {
                    "offset": f"+0x{self.region.start + offset:04X}",
                    "slot_offset": f"+0x{self.region.start + offset:02X}" if self.region.scope == "slot" else None,
                    "distinct": stat.distinct,
                    "nonzero_count": stat.nonzero_count,
                    "top_values": [[f"0x{value:02X}", count] for value, count in stat.top_values],
                }
                for offset, stat in top_offsets
            ],
        }

    def top_offsets(self, limit: int = 10) -> list[tuple[int, OffsetStat]]:
        if not self.counters:
            return []
        ranked: list[tuple[int, OffsetStat]] = []
        for offset, counter in enumerate(self.counters):
            distinct = len(counter)
            if distinct <= 1:
                continue
            nonzero_count = self.observations - counter.get(0, 0)
            ranked.append(
                (
                    offset,
                    OffsetStat(
                        distinct=distinct,
                        nonzero_count=nonzero_count,
                        top_values=counter.most_common(5),
                    ),
                )
            )
        ranked.sort(key=lambda item: (item[1].distinct, item[1].nonzero_count), reverse=True)
        return ranked[:limit]


def priority_label(observations: int, unique_digests: int, variable_density: float, zero_fraction: float) -> str:
    if observations == 0:
        return "no-data"
    if variable_density == 0:
        return "low-fixed"
    if zero_fraction > 0.95 and variable_density < 0.05:
        return "low-mostly-zero"
    if unique_digests > 100 and variable_density > 0.25:
        return "high-broad-variance"
    if unique_digests > 20 and variable_density > 0.05:
        return "medium-structured-variance"
    return "medium-narrow-variance"


def iter_xy_files(roots: Iterable[Path]) -> Iterable[Path]:
    seen: set[Path] = set()
    for root in roots:
        if root.is_file() and root.suffix.lower() == ".xy":
            path = root.resolve()
            if path not in seen:
                seen.add(path)
                yield path
            continue
        if not root.exists():
            continue
        for path in sorted(root.rglob("*.xy")):
            resolved = path.resolve()
            if resolved in seen:
                continue
            seen.add(resolved)
            yield resolved


def c_string(blob: bytes) -> str:
    return blob.split(b"\0", 1)[0].decode("utf-8", "replace")


def track_starts(image: bytes) -> list[int]:
    return [m.start() - 3 for m in SIG_RE.finditer(image)]


def collect(paths: list[Path]) -> tuple[dict[str, RegionStats], dict]:
    stats = {region.name: RegionStats(region) for region in REGIONS}
    meta = {
        "files_seen": 0,
        "files_decoded": 0,
        "decode_errors": [],
        "track_observations": 0,
        "slot_observations": 0,
    }
    global_regions = [r for r in REGIONS if r.scope == "global"]
    track_regions = [r for r in REGIONS if r.scope == "track"]
    slot_regions = [r for r in REGIONS if r.scope == "slot"]

    for path in paths:
        meta["files_seen"] += 1
        file_label = str(path)
        try:
            _, image = decode_project(path.read_bytes())
        except (OSError, RleError, ValueError) as exc:
            meta["decode_errors"].append({"path": file_label, "error": str(exc)})
            continue
        meta["files_decoded"] += 1

        for region in global_regions:
            if region.end < len(image):
                stats[region.name].add(image[region.start : region.end + 1], file_label)

        starts = track_starts(image)
        for index, start in enumerate(starts):
            next_start = starts[index + 1] if index + 1 < len(starts) else len(image)
            if start + 0x45D3 >= len(image):
                continue
            meta["track_observations"] += 1
            engine = image[start + 0x14]
            label = c_string(image[start + 0x453F : start + 0x456F])
            note_count = image[start + 0x456F]
            for region in track_regions:
                if region.sample_engines_only and engine not in {0x02, 0x03, 0x1E}:
                    continue
                if region.zero_note_tracks_only and note_count != 0:
                    continue
                lo = start + region.start
                hi = start + region.end + 1
                if hi <= len(image) and hi <= next_start:
                    stats[region.name].add(image[lo:hi], file_label, engine=engine, label=label)

            if engine not in {0x02, 0x03, 0x1E}:
                continue
            for voice in range(24):
                slot_base = start + 0x3957 + voice * 0x80
                if slot_base + 0x80 > len(image):
                    continue
                meta["slot_observations"] += 1
                for region in slot_regions:
                    if region.skip_slot_23 and voice == 23:
                        continue
                    lo = slot_base + region.start
                    hi = slot_base + region.end + 1
                    if hi <= len(image):
                        stats[region.name].add(image[lo:hi], file_label, engine=engine, label=label)

    return stats, meta


def markdown_report(stats: dict[str, RegionStats], meta: dict, source_roots: list[Path]) -> str:
    summaries = [stats[region.name].summary() for region in REGIONS]
    lines: list[str] = []
    lines.append("# Spatial Variance Index")
    lines.append("")
    lines.append("This is a corpus index for not-fully-decoded regions in the decoded OP-XY project image.")
    lines.append("")
    lines.append("## Corpus")
    lines.append("")
    lines.append("| Item | Count |")
    lines.append("| --- | ---: |")
    lines.append(f"| Source roots | `{', '.join(str(p) for p in source_roots)}` |")
    lines.append(f"| `.xy` files seen | `{meta['files_seen']}` |")
    lines.append(f"| `.xy` files decoded | `{meta['files_decoded']}` |")
    lines.append(f"| Track structs observed | `{meta['track_observations']}` |")
    lines.append(f"| Sample-slot observations | `{meta['slot_observations']}` |")
    lines.append(f"| Decode errors | `{len(meta['decode_errors'])}` |")
    lines.append("")
    if meta["decode_errors"]:
        lines.append("Decode errors are omitted from the region statistics. The first few are:")
        lines.append("")
        for err in meta["decode_errors"][:8]:
            lines.append(f"- `{err['path']}`: {err['error']}")
        lines.append("")

    lines.append("## Region Summary")
    lines.append("")
    lines.append("| Region | Scope | Range | Len | Obs | Unique | Var bytes | Zero obs | Priority |")
    lines.append("| --- | --- | --- | ---: | ---: | ---: | ---: | ---: | --- |")
    for item in summaries:
        lines.append(
            f"| `{item['name']}` | {item['scope']} | `{item['range']}` | {item['length']} | "
            f"{item['observations']} | {item['unique_digests']} | "
            f"{item['variable_positions']} ({item['variable_density']:.1%}) | "
            f"{item['zero_observation_fraction']:.1%} | {item['priority']} |"
        )
    lines.append("")

    lines.append("## Highest-Yield Regions")
    lines.append("")
    priority_order = {
        "high-broad-variance": 0,
        "medium-structured-variance": 1,
        "medium-narrow-variance": 2,
        "low-mostly-zero": 3,
        "low-fixed": 4,
        "no-data": 5,
    }
    ranked = sorted(
        summaries,
        key=lambda item: (
            priority_order.get(item["priority"], 9),
            -item["unique_digests"],
            -item["variable_positions"],
        ),
    )
    for item in ranked[:8]:
        lines.append(
            f"- `{item['name']}`: {item['priority']}, {item['unique_digests']} unique bodies, "
            f"{item['variable_positions']}/{item['length']} variable bytes. "
            f"Speculation: {stats[item['name']].region.speculation}"
        )
    lines.append("")

    lines.append("## Top Variable Offsets By Region")
    lines.append("")
    for item in summaries:
        lines.append(f"### `{item['name']}`")
        lines.append("")
        region = stats[item["name"]].region
        lines.append(region.description)
        lines.append("")
        lines.append(f"Speculation: {region.speculation}")
        lines.append("")
        lines.append(
            f"Observations: `{item['observations']}`; unique region bodies: `{item['unique_digests']}`; "
            f"variable bytes: `{item['variable_positions']}` / `{item['length']}`."
        )
        lines.append("")
        if item["top_engines"]:
            engine_text = ", ".join(f"{engine}={count}" for engine, count in item["top_engines"])
            lines.append(f"Top engines: {engine_text}")
            lines.append("")
        if item["top_labels"]:
            label_text = ", ".join(f"`{label or '<blank>'}`={count}" for label, count in item["top_labels"][:5])
            lines.append(f"Top labels: {label_text}")
            lines.append("")
        if not item["top_offsets"]:
            lines.append("No variable offsets in this corpus pass.")
            lines.append("")
            continue
        lines.append("| Offset | Distinct values | Nonzero obs | Top values |")
        lines.append("| --- | ---: | ---: | --- |")
        for offset in item["top_offsets"]:
            offset_label = offset["slot_offset"] if offset["slot_offset"] else offset["offset"]
            values = ", ".join(f"{value}={count}" for value, count in offset["top_values"])
            lines.append(
                f"| `{offset_label}` | {offset['distinct']} | {offset['nonzero_count']} | {values} |"
            )
        lines.append("")

    lines.append("## How To Use This")
    lines.append("")
    lines.append("- High broad-variance regions are most useful for mining existing corpus structure.")
    lines.append("- Low/fixed regions are better tested with surgical device captures, not broad corpus scans.")
    lines.append("- Slot tail stats skip voice 23, because its nominal tail overlaps the preset label region.")
    lines.append("- The report is an index of variance, not proof of semantics. Promote a byte only after paired captures or writer/device validation.")
    lines.append("")
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "roots",
        nargs="*",
        type=Path,
        default=[Path("src"), Path("output")],
        help="files or directories to scan for .xy files",
    )
    parser.add_argument("--json-out", type=Path, help="optional JSON summary output")
    parser.add_argument("--md-out", type=Path, help="optional Markdown report output")
    args = parser.parse_args()

    paths = list(iter_xy_files(args.roots))
    stats, meta = collect(paths)
    summaries = {name: stat.summary() for name, stat in stats.items()}
    payload = {
        "corpus": {
            **meta,
            "source_roots": [str(path) for path in args.roots],
        },
        "regions": summaries,
    }
    if args.json_out:
        args.json_out.parent.mkdir(parents=True, exist_ok=True)
        args.json_out.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    report = markdown_report(stats, meta, args.roots)
    if args.md_out:
        args.md_out.parent.mkdir(parents=True, exist_ok=True)
        args.md_out.write_text(report)
    else:
        print(report)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
