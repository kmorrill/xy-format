from __future__ import annotations

import json
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional

from .container import TrackBlock, XYContainer, XYHeader, XYProject
from .image_writer import ImageProject
from .note_events import Note
from .profiles import PROFILES, infer_profile, validate_against_profile
from .project_builder import append_notes_to_tracks, build_multi_pattern_project
from .scaffold_writer import apply_notes_to_matching_scaffold
from .scene_patcher import patch_set_scene_assignments
from .scene_records import read_scene_assignments, read_t16_scene_list, write_t16_scene_list
from .scene_song_tokens import (
    PRETRACK_PATCH_MODES,
    TRACK16_PATCH_MODES,
    apply_scene_song_patch,
)


SUPPORTED_SPEC_VERSION = 1
MULTI_PATTERN_MODE = "multi_pattern"
VALID_MODES = {MULTI_PATTERN_MODE}
VALID_DESCRIPTOR_STRATEGIES = {"strict", "heuristic_v1"}
VALID_TOPOLOGY_POLICIES = {"none", "bootstrap_t1_t8_p9"}
VALID_PRETRACK_PATCH_MODES = set(PRETRACK_PATCH_MODES)
VALID_TRACK16_PATCH_MODES = set(TRACK16_PATCH_MODES)
VALID_PROFILES = set(PROFILES.keys())


@dataclass(frozen=True)
class HeaderPatch:
    tempo_tenths: Optional[int] = None
    groove_type: Optional[int] = None
    groove_amount: Optional[int] = None
    metronome_level: Optional[int] = None

    def has_changes(self) -> bool:
        return any(
            value is not None
            for value in (
                self.tempo_tenths,
                self.groove_type,
                self.groove_amount,
                self.metronome_level,
            )
        )


@dataclass(frozen=True)
class MultiTrackSpec:
    track: int
    patterns: List[Optional[List[Note]]]


@dataclass(frozen=True)
class SceneSongPatch:
    pretrack_mode: str = "none"
    track16_mode: str = "none"

    def has_changes(self) -> bool:
        return self.pretrack_mode != "none" or self.track16_mode != "none"


@dataclass(frozen=True)
class SoundTrackPatch:
    track: int
    engine_id: Optional[int] = None
    engine_params: Dict[str, int] = field(default_factory=dict)
    amp_envelope: Dict[str, int] = field(default_factory=dict)
    m2_shift: Dict[str, int] = field(default_factory=dict)
    filter_type: Optional[int] = None
    filter_enabled: Optional[bool] = None
    filter_knobs: Dict[str, int] = field(default_factory=dict)
    sends: Dict[str, int] = field(default_factory=dict)
    lfo_current: Dict[str, int] = field(default_factory=dict)
    filter_envelope: Dict[str, int] = field(default_factory=dict)
    mix: Dict[str, int] = field(default_factory=dict)

    def has_changes(self) -> bool:
        return (
            self.engine_id is not None
            or bool(self.engine_params)
            or bool(self.amp_envelope)
            or bool(self.m2_shift)
            or self.filter_type is not None
            or self.filter_enabled is not None
            or bool(self.filter_knobs)
            or bool(self.sends)
            or bool(self.lfo_current)
            or bool(self.filter_envelope)
            or bool(self.mix)
        )


@dataclass(frozen=True)
class SoundStatePatch:
    master_eq: Dict[str, int] = field(default_factory=dict)
    tracks: List[SoundTrackPatch] = field(default_factory=list)

    def has_changes(self) -> bool:
        return bool(self.master_eq) or any(track.has_changes() for track in self.tracks)


@dataclass(frozen=True)
class BuildSpec:
    version: int
    mode: str
    template: Path
    output: Optional[Path] = None
    descriptor_strategy: str = "strict"
    topology_policy: str = "none"
    header: HeaderPatch = field(default_factory=HeaderPatch)
    scene_song: SceneSongPatch = field(default_factory=SceneSongPatch)
    scene_assignments: Dict[int, Dict[int, int]] = field(default_factory=dict)
    song_arrangement: List[int] = field(default_factory=list)
    sound_state: SoundStatePatch = field(default_factory=SoundStatePatch)
    multi_tracks: List[MultiTrackSpec] = field(default_factory=list)
    # ``profile`` names the validated build recipe. ``None`` means the spec
    # was authored before profiles existed (legacy spec); the compiler will
    # infer one and warn. New specs must declare it.
    profile: Optional[str] = None

    @property
    def track_count(self) -> int:
        return len(self.multi_tracks)


def _require_dict(value: object, *, where: str) -> dict:
    if not isinstance(value, dict):
        raise ValueError(f"{where} must be an object")
    return value


def _require_list(value: object, *, where: str) -> list:
    if not isinstance(value, list):
        raise ValueError(f"{where} must be an array")
    return value


def _int_in_range(value: object, *, where: str, low: int, high: int) -> int:
    if not isinstance(value, int) or isinstance(value, bool):
        raise ValueError(f"{where} must be an integer")
    if not (low <= value <= high):
        raise ValueError(f"{where} must be in [{low}, {high}]")
    return value


def _parse_note(note_raw: object, *, where: str) -> Note:
    note_obj = _require_dict(note_raw, where=where)
    step = _int_in_range(note_obj.get("step"), where=f"{where}.step", low=1, high=65535)
    note = _int_in_range(note_obj.get("note"), where=f"{where}.note", low=0, high=127)
    velocity = _int_in_range(note_obj.get("velocity", 100), where=f"{where}.velocity", low=0, high=127)
    tick_offset = _int_in_range(
        note_obj.get("tick_offset", 0),
        where=f"{where}.tick_offset",
        low=0,
        high=65535,
    )
    gate_ticks = _int_in_range(
        note_obj.get("gate_ticks", 0),
        where=f"{where}.gate_ticks",
        low=0,
        high=2**32 - 1,
    )
    return Note(
        step=step,
        note=note,
        velocity=velocity,
        tick_offset=tick_offset,
        gate_ticks=gate_ticks,
    )


def _parse_header_patch(raw: object) -> HeaderPatch:
    if raw is None:
        return HeaderPatch()
    obj = _require_dict(raw, where="header")

    def _get_byte(name: str) -> Optional[int]:
        if name not in obj:
            return None
        return _int_in_range(obj[name], where=f"header.{name}", low=0, high=255)

    tempo = None
    if "tempo_tenths" in obj:
        tempo = _int_in_range(obj["tempo_tenths"], where="header.tempo_tenths", low=0, high=65535)
    return HeaderPatch(
        tempo_tenths=tempo,
        groove_type=_get_byte("groove_type"),
        groove_amount=_get_byte("groove_amount"),
        metronome_level=_get_byte("metronome_level"),
    )


def _parse_scene_song_patch(raw: object) -> SceneSongPatch:
    if raw is None:
        return SceneSongPatch()

    obj = _require_dict(raw, where="scene_song")
    pretrack_mode = obj.get("pretrack_mode", "none")
    track16_mode = obj.get("track16_mode", "none")

    if not isinstance(pretrack_mode, str) or pretrack_mode not in VALID_PRETRACK_PATCH_MODES:
        valid = ", ".join(PRETRACK_PATCH_MODES)
        raise ValueError(f"scene_song.pretrack_mode must be one of: {valid}")
    if not isinstance(track16_mode, str) or track16_mode not in VALID_TRACK16_PATCH_MODES:
        valid = ", ".join(TRACK16_PATCH_MODES)
        raise ValueError(f"scene_song.track16_mode must be one of: {valid}")

    return SceneSongPatch(
        pretrack_mode=pretrack_mode,
        track16_mode=track16_mode,
    )


def _parse_index_key(raw: object, *, where: str, prefix: str) -> int:
    if isinstance(raw, int) and not isinstance(raw, bool):
        return raw
    if not isinstance(raw, str):
        raise ValueError(f"{where} key must be an integer or '{prefix}N' string")
    key = raw.strip()
    if not key:
        raise ValueError(f"{where} key must be non-empty")
    if key.isdigit():
        return int(key)
    if key[0].lower() == prefix.lower() and key[1:].isdigit():
        return int(key[1:])
    raise ValueError(f"{where} key must be numeric or '{prefix}N', got {raw!r}")


def _parse_scene_assignments(raw: object) -> Dict[int, Dict[int, int]]:
    if raw is None:
        return {}

    obj = _require_dict(raw, where="scene_assignments")
    if not obj:
        raise ValueError("scene_assignments cannot be empty")

    parsed: Dict[int, Dict[int, int]] = {}
    for scene_key, tracks_raw in obj.items():
        scene_id = _parse_index_key(
            scene_key,
            where="scene_assignments",
            prefix="S",
        )
        if scene_id in parsed:
            raise ValueError(f"duplicate scene_assignments entry for scene {scene_id}")

        tracks_obj = _require_dict(
            tracks_raw,
            where=f"scene_assignments[{scene_key!r}]",
        )
        row: Dict[int, int] = {}
        for track_key, pattern_raw in tracks_obj.items():
            track_id = _parse_index_key(
                track_key,
                where=f"scene_assignments[{scene_key!r}]",
                prefix="T",
            )
            if track_id in row:
                raise ValueError(
                    f"duplicate scene_assignments track entry in scene {scene_id}: T{track_id}"
                )
            pattern = _int_in_range(
                pattern_raw,
                where=f"scene_assignments[{scene_key!r}][{track_key!r}]",
                low=1,
                high=9,
            )
            row[track_id] = pattern
        parsed[scene_id] = row

    scene_ids = sorted(parsed)
    expected_scene_ids = list(range(1, len(parsed) + 1))
    if scene_ids != expected_scene_ids:
        raise ValueError(
            f"scene_assignments scene ids must be contiguous 1..N, got {scene_ids}"
        )

    for scene_id, row in parsed.items():
        tracks = sorted(row)
        if tracks != list(range(1, 9)):
            raise ValueError(
                f"scene_assignments scene {scene_id} must contain tracks 1..8, got {tracks}"
            )

    return parsed


def _parse_song_arrangement(raw: object) -> List[int]:
    if raw is None:
        return []

    values = _require_list(raw, where="song_arrangement")
    if not values:
        raise ValueError("song_arrangement cannot be empty when provided")

    parsed: List[int] = []
    for idx, value in enumerate(values):
        scene_id = _int_in_range(value, where=f"song_arrangement[{idx}]", low=1, high=99)
        parsed.append(scene_id)
    return parsed


def _parse_u32_group(raw: object, *, where: str, allowed: set[str]) -> Dict[str, int]:
    if raw is None:
        return {}
    obj = _require_dict(raw, where=where)
    parsed: Dict[str, int] = {}
    for key, value in obj.items():
        if key not in allowed:
            valid = ", ".join(sorted(allowed))
            raise ValueError(f"{where}.{key} is not supported; valid keys: {valid}")
        parsed[key] = _int_in_range(value, where=f"{where}.{key}", low=0, high=2**32 - 1)
    return parsed


def _parse_sound_filter(raw: object, *, where: str) -> tuple[Optional[int], Optional[bool], Dict[str, int]]:
    if raw is None:
        return None, None, {}
    obj = _require_dict(raw, where=where)
    allowed = {"type", "enabled", "cutoff", "resonance", "env_amount", "key_tracking"}
    for key in obj:
        if key not in allowed:
            valid = ", ".join(sorted(allowed))
            raise ValueError(f"{where}.{key} is not supported; valid keys: {valid}")

    filter_type = None
    if "type" in obj:
        filter_type = _int_in_range(obj["type"], where=f"{where}.type", low=0, high=255)

    filter_enabled = None
    if "enabled" in obj:
        if not isinstance(obj["enabled"], bool):
            raise ValueError(f"{where}.enabled must be a boolean")
        filter_enabled = obj["enabled"]

    knobs = {
        key: _int_in_range(obj[key], where=f"{where}.{key}", low=0, high=2**32 - 1)
        for key in ("cutoff", "resonance", "env_amount", "key_tracking")
        if key in obj
    }
    return filter_type, filter_enabled, knobs


def _parse_sound_state_patch(raw: object) -> SoundStatePatch:
    if raw is None:
        return SoundStatePatch()
    obj = _require_dict(raw, where="sound_state")

    allowed_top = {"master_eq", "tracks"}
    for key in obj:
        if key not in allowed_top:
            valid = ", ".join(sorted(allowed_top))
            raise ValueError(f"sound_state.{key} is not supported; valid keys: {valid}")

    master_eq = _parse_u32_group(
        obj.get("master_eq"),
        where="sound_state.master_eq",
        allowed={"low", "mid", "high"},
    )

    tracks_raw = obj.get("tracks", [])
    tracks_values = _require_list(tracks_raw, where="sound_state.tracks")
    tracks: List[SoundTrackPatch] = []
    seen_tracks: set[int] = set()
    allowed_track_keys = {
        "track",
        "engine_id",
        "engine_params",
        "amp_envelope",
        "m2_shift",
        "filter",
        "sends",
        "lfo_current",
        "filter_envelope",
        "mix",
    }
    for idx, raw_track in enumerate(tracks_values):
        where = f"sound_state.tracks[{idx}]"
        track_obj = _require_dict(raw_track, where=where)
        for key in track_obj:
            if key not in allowed_track_keys:
                valid = ", ".join(sorted(allowed_track_keys))
                raise ValueError(f"{where}.{key} is not supported; valid keys: {valid}")
        track = _int_in_range(track_obj.get("track"), where=f"{where}.track", low=1, high=16)
        if track in seen_tracks:
            raise ValueError(f"duplicate sound_state track {track}")
        seen_tracks.add(track)

        engine_id = None
        if "engine_id" in track_obj:
            engine_id = _int_in_range(track_obj["engine_id"], where=f"{where}.engine_id", low=0, high=255)
        filter_type, filter_enabled, filter_knobs = _parse_sound_filter(
            track_obj.get("filter"),
            where=f"{where}.filter",
        )
        parsed = SoundTrackPatch(
            track=track,
            engine_id=engine_id,
            engine_params=_parse_u32_group(
                track_obj.get("engine_params"),
                where=f"{where}.engine_params",
                allowed={"param1", "param2", "param3", "param4"},
            ),
            amp_envelope=_parse_u32_group(
                track_obj.get("amp_envelope"),
                where=f"{where}.amp_envelope",
                allowed={"attack", "decay", "sustain", "release"},
            ),
            m2_shift=_parse_u32_group(
                track_obj.get("m2_shift"),
                where=f"{where}.m2_shift",
                allowed={"play_mode", "portamento", "pitch_bend_range", "engine_volume"},
            ),
            filter_type=filter_type,
            filter_enabled=filter_enabled,
            filter_knobs=filter_knobs,
            sends=_parse_u32_group(
                track_obj.get("sends"),
                where=f"{where}.sends",
                allowed={"ext", "tape", "fx1", "fx2"},
            ),
            lfo_current=_parse_u32_group(
                track_obj.get("lfo_current"),
                where=f"{where}.lfo_current",
                allowed={"cc40", "cc41"},
            ),
            filter_envelope=_parse_u32_group(
                track_obj.get("filter_envelope"),
                where=f"{where}.filter_envelope",
                allowed={"attack", "decay", "sustain", "release"},
            ),
            mix=_parse_u32_group(
                track_obj.get("mix"),
                where=f"{where}.mix",
                allowed={"pan", "volume"},
            ),
        )
        if not parsed.has_changes():
            raise ValueError(f"{where} must contain at least one sound_state edit")
        tracks.append(parsed)

    return SoundStatePatch(master_eq=master_eq, tracks=tracks)


def parse_build_spec(data: object, *, base_dir: Path) -> BuildSpec:
    obj = _require_dict(data, where="spec")

    version = _int_in_range(
        obj.get("version", SUPPORTED_SPEC_VERSION),
        where="version",
        low=1,
        high=65535,
    )
    if version != SUPPORTED_SPEC_VERSION:
        raise ValueError(
            f"unsupported spec version {version}; supported version is {SUPPORTED_SPEC_VERSION}"
        )

    mode = obj.get("mode")
    if mode not in VALID_MODES:
        modes = ", ".join(sorted(VALID_MODES))
        raise ValueError(f"mode must be one of: {modes}")

    template_raw = obj.get("template")
    if not isinstance(template_raw, str) or not template_raw:
        raise ValueError("template must be a non-empty string path")
    template = Path(template_raw)
    if not template.is_absolute():
        template = (base_dir / template).resolve()

    output = None
    output_raw = obj.get("output")
    if output_raw is not None:
        if not isinstance(output_raw, str) or not output_raw:
            raise ValueError("output must be a non-empty string path when provided")
        output = Path(output_raw)
        if not output.is_absolute():
            output = (base_dir / output).resolve()

    descriptor_strategy = obj.get("descriptor_strategy", "strict")
    if descriptor_strategy not in VALID_DESCRIPTOR_STRATEGIES:
        valid = ", ".join(sorted(VALID_DESCRIPTOR_STRATEGIES))
        raise ValueError(f"descriptor_strategy must be one of: {valid}")

    topology_policy = obj.get("topology_policy", "none")
    if topology_policy not in VALID_TOPOLOGY_POLICIES:
        valid = ", ".join(sorted(VALID_TOPOLOGY_POLICIES))
        raise ValueError(f"topology_policy must be one of: {valid}")

    # ``profile`` is required on new specs. When absent, we retain None and
    # let ``build_xy_bytes`` handle the legacy-migration flow (infer + warn).
    profile_raw = obj.get("profile")
    if profile_raw is not None:
        if not isinstance(profile_raw, str) or profile_raw not in VALID_PROFILES:
            valid = ", ".join(sorted(VALID_PROFILES))
            raise ValueError(
                f"profile must be one of: {valid} (got {profile_raw!r})"
            )

    # ``tracks`` is optional: header_only and scene_song_tokens profiles
    # produce track-less specs. Profile validators enforce track-presence
    # rules specific to each recipe.
    tracks_raw = obj.get("tracks")
    if tracks_raw is None:
        tracks_raw = []
    else:
        tracks_raw = _require_list(tracks_raw, where="tracks")

    seen_tracks: set[int] = set()
    multi_tracks: List[MultiTrackSpec] = []

    for idx, track_raw in enumerate(tracks_raw):
        where = f"tracks[{idx}]"
        track_obj = _require_dict(track_raw, where=where)
        track = _int_in_range(track_obj.get("track"), where=f"{where}.track", low=1, high=16)
        if track in seen_tracks:
            raise ValueError(f"duplicate track {track} in tracks")
        seen_tracks.add(track)

        if "patterns" not in track_obj:
            raise ValueError(f"{where}.patterns is required in {MULTI_PATTERN_MODE} mode")
        patterns_raw = _require_list(track_obj["patterns"], where=f"{where}.patterns")
        if len(patterns_raw) < 1:
            raise ValueError(f"{where}.patterns must contain at least 1 pattern entry")

        parsed_patterns: List[Optional[List[Note]]] = []
        for pidx, pattern_raw in enumerate(patterns_raw):
            pwhere = f"{where}.patterns[{pidx}]"
            if pattern_raw is None:
                parsed_patterns.append(None)
                continue
            notes = _require_list(pattern_raw, where=pwhere)
            if not notes:
                parsed_patterns.append(None)
                continue
            parsed_patterns.append(
                [_parse_note(n, where=f"{pwhere}[{nidx}]") for nidx, n in enumerate(notes)]
            )

        multi_tracks.append(MultiTrackSpec(track=track, patterns=parsed_patterns))

    return BuildSpec(
        version=version,
        mode=mode,
        template=template,
        output=output,
        descriptor_strategy=descriptor_strategy,
        topology_policy=topology_policy,
        header=_parse_header_patch(obj.get("header")),
        scene_song=_parse_scene_song_patch(obj.get("scene_song")),
        scene_assignments=_parse_scene_assignments(obj.get("scene_assignments")),
        song_arrangement=_parse_song_arrangement(obj.get("song_arrangement")),
        sound_state=_parse_sound_state_patch(obj.get("sound_state")),
        multi_tracks=multi_tracks,
        profile=profile_raw,
    )


def load_build_spec(path: Path | str) -> BuildSpec:
    spec_path = Path(path).expanduser().resolve()
    payload = json.loads(spec_path.read_text(encoding="utf-8"))
    return parse_build_spec(payload, base_dir=spec_path.parent)


def apply_header_patch(data: bytes, patch: HeaderPatch) -> bytes:
    if not patch.has_changes():
        return data

    container = XYContainer.from_bytes(data)
    old = container.header
    new_header = XYHeader(
        raw=old.raw,
        tempo_tenths=patch.tempo_tenths if patch.tempo_tenths is not None else old.tempo_tenths,
        groove_type=patch.groove_type if patch.groove_type is not None else old.groove_type,
        groove_flags=old.groove_flags,
        groove_amount=patch.groove_amount if patch.groove_amount is not None else old.groove_amount,
        metronome_level=(
            patch.metronome_level
            if patch.metronome_level is not None
            else old.metronome_level
        ),
        field_0x0C=old.field_0x0C,
        field_0x10=old.field_0x10,
        field_0x14=old.field_0x14,
    )
    return XYContainer(raw=container.raw, header=new_header).to_bytes()


def _apply_song_arrangement(project: XYProject, arrangement: List[int]) -> XYProject:
    scene_map = read_scene_assignments(project)
    if not scene_map:
        raise ValueError(
            "song_arrangement requires scene assignments readable from this template"
        )
    count, ids = read_t16_scene_list(project.tracks[15].body)
    if count <= 0 or count > 96 or len(ids) != count or any(scene_id < 0 or scene_id > 98 for scene_id in ids):
        raise ValueError(
            "song_arrangement requires template with a valid existing Track16 scene list"
        )

    max_scene = max(scene_map)
    for scene_id in arrangement:
        if scene_id < 1 or scene_id > max_scene:
            raise ValueError(
                f"song_arrangement references scene {scene_id}, but available scenes are 1..{max_scene}"
            )

    song_scene_ids_0based = [scene_id - 1 for scene_id in arrangement]
    t16 = project.tracks[15]
    new_t16_body = write_t16_scene_list(t16.body, song_scene_ids_0based)
    new_t16 = TrackBlock(index=15, preamble=t16.preamble, body=new_t16_body)
    return XYProject(project.pre_track, list(project.tracks[:15]) + [new_t16])


def apply_sound_state_patch(data: bytes, patch: SoundStatePatch) -> bytes:
    if not patch.has_changes():
        return data

    project = ImageProject.from_bytes(data)
    if patch.master_eq:
        project.set_master_eq(
            low=patch.master_eq.get("low"),
            mid=patch.master_eq.get("mid"),
            high=patch.master_eq.get("high"),
        )

    for track in patch.tracks:
        if track.engine_id is not None:
            project.set_engine(track.track, track.engine_id)
        if track.engine_params:
            project.set_engine_params(track.track, **track.engine_params)
        if track.amp_envelope:
            project.set_amp_envelope(track.track, **track.amp_envelope)
        if track.m2_shift:
            project.set_m2_shift(track.track, **track.m2_shift)
        if track.filter_type is not None or track.filter_enabled is not None:
            project.set_filter(track.track, type=track.filter_type, enabled=track.filter_enabled)
        if track.filter_knobs:
            project.set_filter_knobs(track.track, **track.filter_knobs)
        if track.sends:
            project.set_sends(track.track, **track.sends)
        if track.lfo_current:
            project.set_lfo_current(track.track, **track.lfo_current)
        if track.filter_envelope:
            project.set_filter_envelope(track.track, **track.filter_envelope)
        if track.mix:
            project.set_track_mix(track.track, **track.mix)

    return project.to_bytes()


def _enforce_profile(spec: BuildSpec) -> None:
    """Validate a spec against its declared profile.

    For new specs (``profile`` set) this is strict: any violation raises.
    For legacy specs (``profile`` absent) we attempt to infer and still
    validate against the inferred profile — so the safety contract applies
    either way. Inference failure is a hard error; the user needs to set
    ``profile`` explicitly.
    """
    if spec.profile is not None:
        validate_against_profile(spec, spec.profile)
        return

    inferred = infer_profile(spec)
    if inferred is None:
        known = ", ".join(sorted(PROFILES))
        raise ValueError(
            "spec has no 'profile' field and does not match any registered "
            f"profile ({known}). Add a 'profile' field explicitly. See "
            "docs/engineering/json_authoring_bridge.md for the profile catalog."
        )
    # Legacy spec matched an existing profile. Warn once and continue.
    # Callers that want strict enforcement should inspect spec.profile
    # before calling build_xy_bytes.
    import warnings
    warnings.warn(
        f"spec has no 'profile' field; inferred {inferred!r}. "
        "Add \"profile\": \"" + inferred + "\" to the spec to silence this "
        "warning and make intent explicit.",
        DeprecationWarning,
        stacklevel=3,
    )
    validate_against_profile(spec, inferred)


def build_xy_bytes(spec: BuildSpec) -> bytes:
    _enforce_profile(spec)

    template_bytes = spec.template.read_bytes()
    project = XYProject.from_bytes(template_bytes)

    if spec.mode != MULTI_PATTERN_MODE:
        raise ValueError(f"unsupported mode {spec.mode!r}")

    # Track-bearing profiles require tracks; header/scene-only profiles skip
    # the track-build stage entirely. The profile validator already ensures
    # this combination is coherent.
    if spec.multi_tracks:
        pattern_lengths = {len(entry.patterns) for entry in spec.multi_tracks}
        if pattern_lengths == {1}:
            track_notes: Dict[int, List[Note]] = {}
            for entry in spec.multi_tracks:
                notes = entry.patterns[0]
                if not notes:
                    raise ValueError(
                        f"track {entry.track} has empty/null patterns[0]; "
                        "single-pattern form requires note data in patterns[0]"
                    )
                track_notes[entry.track] = notes
            project = append_notes_to_tracks(project, track_notes)
        else:
            if 1 in pattern_lengths:
                raise ValueError(
                    "mixed pattern counts are not supported: when using "
                    "multi-pattern builds all listed tracks must have at "
                    "least 2 patterns"
                )
            track_patterns: Dict[int, List[Optional[List[Note]]]] = {
                entry.track: entry.patterns for entry in spec.multi_tracks
            }
            if spec.topology_policy == "bootstrap_t1_t8_p9":
                track_patterns = _apply_bootstrap_t1_t8_p9(track_patterns)
            scaffold_result = apply_notes_to_matching_scaffold(project, track_patterns)
            if scaffold_result is not None:
                project = scaffold_result
            else:
                project = build_multi_pattern_project(
                    project,
                    track_patterns,
                    descriptor_strategy=spec.descriptor_strategy,
                )

    project = apply_scene_song_patch(
        project,
        pretrack_mode=spec.scene_song.pretrack_mode,
        track16_mode=spec.scene_song.track16_mode,
    )
    if spec.scene_assignments:
        project = patch_set_scene_assignments(project, spec.scene_assignments)
    if spec.song_arrangement:
        project = _apply_song_arrangement(project, spec.song_arrangement)

    data = apply_sound_state_patch(project.to_bytes(), spec.sound_state)
    return apply_header_patch(data, spec.header)


def _apply_bootstrap_t1_t8_p9(
    track_patterns: Dict[int, List[Optional[List[Note]]]],
) -> Dict[int, List[Optional[List[Note]]]]:
    """Normalize sparse multi-pattern specs into the known-safe 8x9 topology.

    This policy is used for MIDI conversion safety after crash findings on
    sparse topologies: emit explicit tracks 1..8 with fixed 9 patterns.
    Existing patterns are preserved in-order and padded with blanks.
    """

    invalid = sorted(track for track in track_patterns if track < 1 or track > 8)
    if invalid:
        bad = ", ".join(f"T{t}" for t in invalid)
        raise ValueError(
            "topology_policy=bootstrap_t1_t8_p9 only supports tracks 1..8; "
            f"got {bad}"
        )

    normalized: Dict[int, List[Optional[List[Note]]]] = {}
    for track in range(1, 9):
        patterns = track_patterns.get(track)
        if patterns is None:
            normalized[track] = [None] * 9
            continue

        if len(patterns) < 2:
            raise ValueError(
                "topology_policy=bootstrap_t1_t8_p9 requires multi-pattern input "
                f"for listed tracks; track {track} has {len(patterns)} pattern entry"
            )
        if len(patterns) > 9:
            raise ValueError(
                "topology_policy=bootstrap_t1_t8_p9 supports at most 9 patterns; "
                f"track {track} has {len(patterns)}"
            )

        expanded = list(patterns)
        if len(expanded) < 9:
            expanded.extend([None] * (9 - len(expanded)))
        normalized[track] = expanded

    return normalized
