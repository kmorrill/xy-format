#!/usr/bin/env python3
"""Convert MIDI into OP-XY authoring artifacts.

Default mode writes a JSON build spec compatible with `tools/build_xy_from_json.py`.

Examples
--------
JSON spec (default):
    python tools/midi_to_xy.py input.mid
    python tools/midi_to_xy.py input.mid -o specs/midi-to-xy/song.json --patterns 9

Legacy direct XY build:
    python tools/midi_to_xy.py input.mid --format xy -o output/song.xy --patterns 9

Analysis only:
    python tools/midi_to_xy.py input.mid --info
"""

from __future__ import annotations

import argparse
import json
import math
import struct
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Tuple

# Add project root to path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import mido

from xy.container import XYProject
from xy.note_events import Note, STEP_TICKS
from xy.project_builder import append_notes_to_tracks, build_multi_pattern_project

# ── GM Drum → OP-XY Drum mapping ──────────────────────────────────────

# OP-XY "boop" drum kit: 24 keys C3 (48) through B4 (71)
# Known assignments: Kick=48/49, Snare=50/51, Rim=52, Clap=53,
#                    CH Hat=56/57, OH Hat=58
GM_TO_OPXY_DRUM = {
    35: 48,  # Acoustic Bass Drum → Kick 1
    36: 48,  # Bass Drum 1 → Kick 1
    37: 52,  # Side Stick → Rim
    38: 50,  # Acoustic Snare → Snare 1
    39: 53,  # Hand Clap → Clap
    40: 51,  # Electric Snare → Snare 2
    41: 60,  # Low Floor Tom → Tom slot
    42: 56,  # Closed HH → CH Hat 1
    43: 61,  # High Floor Tom → Tom slot
    44: 57,  # Pedal HH → CH Hat 2
    45: 62,  # Low Tom → Tom slot
    46: 58,  # Open HH → OH Hat
    47: 63,  # Low-Mid Tom → Tom slot
    48: 64,  # Hi-Mid Tom → Tom slot
    49: 54,  # Crash Cymbal 1
    50: 65,  # High Tom → Tom slot
    51: 55,  # Ride Cymbal 1
    52: 66,  # Chinese Cymbal
    53: 67,  # Ride Bell
    54: 57,  # Tambourine → CH Hat 2
    55: 68,  # Splash Cymbal
    56: 69,  # Cowbell
    57: 54,  # Crash Cymbal 2 → same slot as Crash 1
}

# Role-to-slot layout requested for arrangement usefulness
ROLE_SLOTS = {
    1: "drum",
    2: "drum",
    3: "bass",
    4: "lead",
    5: "lead",
    6: "lead",
    7: "chord",
    8: "chord",
}

ROLE_MIN_SCORE = {
    "drum": 40.0,
    "bass": 18.0,
    "lead": 12.0,
    "chord": 16.0,
}

ROLE_MIN_NOTES = {
    "drum": 12,
    "bass": 12,
    "lead": 10,
    "chord": 18,
}

ROLE_MIN_ACTIVE_BARS = {
    "drum": 3,
    "bass": 3,
    "lead": 2,
    "chord": 3,
}

# Maximum notes per OP-XY pattern (device hard cap)
MAX_NOTES_PER_PATTERN = 120


@dataclass
class MidiNote:
    """A note extracted from MIDI with absolute timing."""

    abs_tick: int
    note: int
    velocity: int
    gate_ticks: int
    channel: int


@dataclass
class PartCandidate:
    """One candidate source part (track+channel lane)."""

    key: Tuple[int, int]  # (midi_track_index, midi_channel)
    notes_all: List[MidiNote]
    notes_window: List[MidiNote]
    note_count: int
    unique_pitches: int
    pitch_min: int
    pitch_max: int
    mean_pitch: float
    active_bars: int
    polyphony_ratio: float
    avg_notes_per_onset: float
    is_drum_channel: bool
    drum_note_ratio: float
    utility_score: float
    role_scores: Dict[str, float]
    fingerprint: set[Tuple[int, int]]


@dataclass
class SelectionResult:
    assignments: Dict[int, PartCandidate]  # OP-XY track -> source part
    ranked_parts: List[PartCandidate]
    dropped_duplicates: List[Tuple[PartCandidate, PartCandidate, float]]


def remap_drum_note(gm_note: int) -> int:
    """Map a GM drum note to OP-XY drum range (48-71)."""

    if gm_note in GM_TO_OPXY_DRUM:
        return GM_TO_OPXY_DRUM[gm_note]
    return max(48, min(71, gm_note))


def _jaccard_similarity(a: set[Tuple[int, int]], b: set[Tuple[int, int]]) -> float:
    if not a and not b:
        return 1.0
    if not a or not b:
        return 0.0
    inter = len(a & b)
    union = len(a | b)
    if union == 0:
        return 0.0
    return inter / union


def extract_midi_parts(mid: mido.MidiFile) -> Dict[Tuple[int, int], List[MidiNote]]:
    """Extract note lanes keyed by (midi_track_index, midi_channel).

    This is more robust than whole-track extraction when a single MIDI track
    contains multiple channels.
    """

    lane_notes: Dict[Tuple[int, int], List[MidiNote]] = {}

    # pending[(track, channel, pitch)] -> stack[(onset_tick, velocity)]
    pending: Dict[Tuple[int, int, int], List[Tuple[int, int]]] = {}

    for track_idx, track in enumerate(mid.tracks):
        abs_tick = 0
        for msg in track:
            abs_tick += msg.time
            if msg.type == "note_on" and msg.velocity > 0:
                key = (track_idx, msg.channel, msg.note)
                pending.setdefault(key, []).append((abs_tick, msg.velocity))
                continue

            if msg.type == "note_off" or (msg.type == "note_on" and msg.velocity == 0):
                key = (track_idx, msg.channel, msg.note)
                starts = pending.get(key)
                if not starts:
                    continue
                onset, velocity = starts.pop()
                gate = max(abs_tick - onset, 1)
                lane_key = (track_idx, msg.channel)
                lane_notes.setdefault(lane_key, []).append(
                    MidiNote(
                        abs_tick=onset,
                        note=msg.note,
                        velocity=velocity,
                        gate_ticks=gate,
                        channel=msg.channel,
                    )
                )
                if not starts:
                    pending.pop(key, None)

    for lane in list(lane_notes):
        lane_notes[lane].sort(key=lambda n: n.abs_tick)

    return lane_notes


def select_bar_window(notes: List[MidiNote], midi_tpb: int, start_bar: int, num_bars: int) -> List[MidiNote]:
    """Return notes inside [start_bar, start_bar+num_bars)."""

    ticks_per_bar = midi_tpb * 4  # 4/4 assumption for OP-XY patterns
    lo = start_bar * ticks_per_bar
    hi = (start_bar + num_bars) * ticks_per_bar
    return [n for n in notes if lo <= n.abs_tick < hi]


def _part_fingerprint(
    notes_window: List[MidiNote],
    midi_tpb: int,
    start_bar: int,
    *,
    is_drum_channel: bool,
) -> set[Tuple[int, int]]:
    """Create a coarse signature for duplicate-lane detection."""

    if not notes_window:
        return set()

    ticks_per_bar = midi_tpb * 4
    lo = start_bar * ticks_per_bar
    scale = 1920.0 / midi_tpb

    sig: set[Tuple[int, int]] = set()
    for n in notes_window:
        rel_tick = n.abs_tick - lo
        xy_tick = round(rel_tick * scale)
        # 120 ticks = 1/16 of an OP-XY step (480); good compromise for similarity.
        q_tick = round(xy_tick / 120) * 120
        pitch = remap_drum_note(n.note) if is_drum_channel else n.note
        sig.add((q_tick, pitch))
    return sig


def _compute_role_scores(
    *,
    is_drum_channel: bool,
    drum_note_ratio: float,
    note_count: int,
    active_bars: int,
    mean_pitch: float,
    unique_pitches: int,
    polyphony_ratio: float,
    avg_notes_per_onset: float,
    pitch_span: int,
) -> Dict[str, float]:
    """Compute role-fit scores for drum/bass/lead/chord."""

    # Drum
    drum_score = 0.0
    if is_drum_channel:
        drum_score += 120.0
    else:
        # Strongly discourage melodic lanes from occupying drum slots.
        drum_score -= 75.0
    drum_score += drum_note_ratio * 35.0
    drum_score += min(note_count / 12.0, 25.0)
    drum_score += active_bars * 1.2
    if unique_pitches <= 2:
        drum_score -= 8.0

    if is_drum_channel:
        bass_score = -1_000.0
        lead_score = -1_000.0
        chord_score = -1_000.0
        return {
            "drum": drum_score,
            "bass": bass_score,
            "lead": lead_score,
            "chord": chord_score,
        }

    # Bass: low pitch + mostly monophonic + strong coverage
    low_pitch_pref = max(0.0, 72.0 - mean_pitch)
    bass_score = low_pitch_pref * 1.7
    bass_score += active_bars * 1.4
    bass_score += min(note_count / 18.0, 20.0)
    bass_score += 10.0 if polyphony_ratio < 0.2 else -20.0 * polyphony_ratio
    bass_score -= max(0.0, mean_pitch - 76.0) * 2.2

    # Chord: stacked onsets + polyphony + pitch variety
    chord_score = polyphony_ratio * 120.0
    chord_score += max(0.0, avg_notes_per_onset - 1.0) * 32.0
    chord_score += min(unique_pitches, 24) * 0.8
    chord_score += active_bars * 1.2
    if mean_pitch < 45.0:
        chord_score -= 22.0
    if note_count < 24:
        chord_score -= (24 - note_count) * 2.4
    if active_bars < 3:
        chord_score -= (3 - active_bars) * 20.0

    # Lead: melodic motion + moderate monophony + useful pitch range
    lead_score = min(note_count / 16.0, 25.0)
    lead_score += active_bars * 1.1
    lead_score += min(pitch_span, 36) * 0.7
    lead_score += 10.0 if 52.0 <= mean_pitch <= 90.0 else -abs(mean_pitch - 71.0) * 0.55
    if polyphony_ratio < 0.35:
        lead_score += 8.0
    else:
        lead_score -= (polyphony_ratio - 0.35) * 30.0

    return {
        "drum": drum_score,
        "bass": bass_score,
        "lead": lead_score,
        "chord": chord_score,
    }


def _candidate_utility(
    *,
    note_count: int,
    active_bars: int,
    unique_pitches: int,
    is_drum_channel: bool,
    pitch_span: int,
) -> float:
    score = 0.0
    score += active_bars * 3.2
    score += min(note_count / 10.0, 35.0)
    score += min(unique_pitches, 32) * 0.9
    score += min(pitch_span, 48) * 0.3
    if is_drum_channel:
        score += 4.0
    return score


def build_part_candidates(
    lane_notes: Dict[Tuple[int, int], List[MidiNote]],
    midi_tpb: int,
    start_bar: int,
    total_bars: int,
) -> List[PartCandidate]:
    """Extract and score non-empty part candidates inside the target window."""

    ticks_per_bar = midi_tpb * 4
    lo = start_bar * ticks_per_bar

    candidates: List[PartCandidate] = []
    for key, notes_all in lane_notes.items():
        notes_window = select_bar_window(notes_all, midi_tpb, start_bar, total_bars)
        if not notes_window:
            continue

        note_count = len(notes_window)
        if note_count < 3:
            # Usually noise/ghost lanes.
            continue

        pitches = [n.note for n in notes_window]
        unique_pitches = len(set(pitches))
        pitch_min = min(pitches)
        pitch_max = max(pitches)
        mean_pitch = sum(pitches) / note_count
        pitch_span = pitch_max - pitch_min

        bars = {
            max(0, min(total_bars - 1, (n.abs_tick - lo) // ticks_per_bar))
            for n in notes_window
        }
        active_bars = len(bars)

        onset_counts: Dict[int, int] = {}
        for n in notes_window:
            onset_counts[n.abs_tick] = onset_counts.get(n.abs_tick, 0) + 1
        chord_onsets = sum(1 for c in onset_counts.values() if c > 1)
        polyphony_ratio = chord_onsets / max(1, len(onset_counts))
        avg_notes_per_onset = note_count / max(1, len(onset_counts))

        channel = key[1]
        is_drum_channel = channel == 9
        drum_note_hits = sum(1 for p in pitches if 27 <= p <= 87)
        drum_note_ratio = drum_note_hits / note_count

        role_scores = _compute_role_scores(
            is_drum_channel=is_drum_channel,
            drum_note_ratio=drum_note_ratio,
            note_count=note_count,
            active_bars=active_bars,
            mean_pitch=mean_pitch,
            unique_pitches=unique_pitches,
            polyphony_ratio=polyphony_ratio,
            avg_notes_per_onset=avg_notes_per_onset,
            pitch_span=pitch_span,
        )
        utility_score = _candidate_utility(
            note_count=note_count,
            active_bars=active_bars,
            unique_pitches=unique_pitches,
            is_drum_channel=is_drum_channel,
            pitch_span=pitch_span,
        )

        candidates.append(
            PartCandidate(
                key=key,
                notes_all=notes_all,
                notes_window=notes_window,
                note_count=note_count,
                unique_pitches=unique_pitches,
                pitch_min=pitch_min,
                pitch_max=pitch_max,
                mean_pitch=mean_pitch,
                active_bars=active_bars,
                polyphony_ratio=polyphony_ratio,
                avg_notes_per_onset=avg_notes_per_onset,
                is_drum_channel=is_drum_channel,
                drum_note_ratio=drum_note_ratio,
                utility_score=utility_score,
                role_scores=role_scores,
                fingerprint=_part_fingerprint(
                    notes_window,
                    midi_tpb,
                    start_bar,
                    is_drum_channel=is_drum_channel,
                ),
            )
        )

    candidates.sort(
        key=lambda c: (c.utility_score, c.note_count, c.active_bars),
        reverse=True,
    )
    return candidates


def dedupe_candidates(
    candidates: List[PartCandidate],
) -> Tuple[List[PartCandidate], List[Tuple[PartCandidate, PartCandidate, float]]]:
    """Drop near-duplicate lanes so role assignment gets unique mix parts."""

    kept: List[PartCandidate] = []
    dropped: List[Tuple[PartCandidate, PartCandidate, float]] = []

    for cand in candidates:
        duplicate_of: Optional[PartCandidate] = None
        duplicate_sim = 0.0

        for ref in kept:
            # Only compare similar families; avoids suppressing bass vs chord by rhythm.
            if cand.is_drum_channel != ref.is_drum_channel:
                continue

            sim = _jaccard_similarity(cand.fingerprint, ref.fingerprint)
            if sim >= 0.92 and cand.note_count <= ref.note_count * 1.25:
                duplicate_of = ref
                duplicate_sim = sim
                break

        if duplicate_of is None:
            kept.append(cand)
        else:
            dropped.append((cand, duplicate_of, duplicate_sim))

    return kept, dropped


def _role_candidate_ok(
    cand: PartCandidate,
    role: str,
    total_bars: int,
    *,
    relaxed: bool = False,
) -> bool:
    """Role-specific eligibility checks before score ranking."""

    min_notes = ROLE_MIN_NOTES[role]
    min_bars = ROLE_MIN_ACTIVE_BARS[role]
    if relaxed:
        min_notes = max(6, min_notes // 2)
        min_bars = max(1, min_bars - 1)

    if cand.note_count < min_notes or cand.active_bars < min_bars:
        return False

    if role == "drum":
        if cand.is_drum_channel:
            return True
        # Allow non-ch9 lanes only as fallback, and only when they look strongly percussive.
        if not relaxed:
            return False
        return (
            cand.role_scores["drum"] >= ROLE_MIN_SCORE["drum"] * 0.7
            and cand.polyphony_ratio <= 0.08
            and cand.mean_pitch <= 58.0
            and (cand.pitch_max - cand.pitch_min) <= 20
        )

    if role == "bass":
        if cand.is_drum_channel:
            return False
        poly_limit = 0.30 if relaxed else 0.20
        return cand.mean_pitch <= 62.0 and cand.polyphony_ratio <= poly_limit

    if role == "lead":
        if cand.is_drum_channel:
            return False
        floor = 45.0 if relaxed else 50.0
        return cand.mean_pitch >= floor and cand.pitch_max >= 55

    if role == "chord":
        if cand.is_drum_channel:
            return False
        min_poly = 0.12 if relaxed else 0.20
        min_onset_stack = 1.25 if relaxed else 1.35
        min_cov = max(2, round(total_bars * (0.12 if relaxed else 0.18)))
        return (
            (cand.polyphony_ratio >= min_poly or cand.avg_notes_per_onset >= min_onset_stack)
            and cand.active_bars >= min_cov
        )

    return True


def assign_parts_to_slots(
    candidates: List[PartCandidate],
    total_bars: int,
) -> Dict[int, PartCandidate]:
    """Assign up to 8 OP-XY tracks using role-aware scoring.

    Role map is fixed:
    - T1/T2 drums
    - T3 bass
    - T4/T5/T6 leads
    - T7/T8 chords
    """

    remaining = list(candidates)
    assignments: Dict[int, PartCandidate] = {}

    def pick_for_role(role: str, *, relaxed: bool = False) -> Optional[PartCandidate]:
        pool = [c for c in remaining if _role_candidate_ok(c, role, total_bars, relaxed=relaxed)]
        if not pool:
            return None
        best = max(
            pool,
            key=lambda c: (
                c.role_scores[role],
                c.utility_score,
                c.note_count,
                -c.key[0],
                -c.key[1],
            ),
        )
        min_score = ROLE_MIN_SCORE[role] * (0.75 if relaxed else 1.0)
        if best.role_scores[role] < min_score:
            return None
        remaining.remove(best)
        return best

    # Pass 1: explicit role slots.
    for slot in (1, 2, 3, 4, 5, 6, 7, 8):
        role = ROLE_SLOTS[slot]
        picked = pick_for_role(role)
        if picked is not None:
            assignments[slot] = picked

    # Pass 2: relaxed role-constrained assignment.
    for slot in (1, 2, 3, 4, 5, 6, 7, 8):
        if slot in assignments:
            continue
        role = ROLE_SLOTS[slot]
        picked = pick_for_role(role, relaxed=True)
        if picked is not None:
            assignments[slot] = picked

    # Pass 3: utility fallback for unassigned lead slots only.
    # Drum/bass/chord slots should stay role-faithful if no candidate matches.
    for slot in (4, 5, 6):
        if slot in assignments or not remaining:
            continue
        best = max(
            remaining,
            key=lambda c: (
                c.role_scores["lead"],
                c.utility_score,
                c.note_count,
                c.active_bars,
            ),
        )
        if best.utility_score < 8.0:
            continue
        remaining.remove(best)
        assignments[slot] = best

    return assignments


def select_best_parts(
    mid: mido.MidiFile,
    start_bar: int,
    total_bars: int,
) -> SelectionResult:
    """End-to-end part selection pipeline for useful/unique arrangement lanes."""

    lane_notes = extract_midi_parts(mid)
    candidates = build_part_candidates(lane_notes, mid.ticks_per_beat, start_bar, total_bars)
    deduped, dropped = dedupe_candidates(candidates)
    assignments = assign_parts_to_slots(deduped, total_bars)

    return SelectionResult(
        assignments=assignments,
        ranked_parts=deduped,
        dropped_duplicates=dropped,
    )


def midi_to_xy_notes(
    midi_notes: List[MidiNote],
    midi_tpb: int,
    start_bar: int,
    *,
    is_drum: bool = False,
    quantize: bool = True,
) -> List[Note]:
    """Convert MIDI notes to OP-XY Note objects.

    Timing conversion:
        MIDI tick → OP-XY tick = midi_tick_in_pattern * (1920 / midi_tpb)
        step = xy_tick // 480 + 1  (1-based)
        tick_offset = xy_tick % 480

    When quantize=True (default), snaps notes to nearest 16th-note step and
    ensures the first note starts at step 1 (tick 0), matching known-safe paths.
    """

    ticks_per_bar_midi = midi_tpb * 4
    bar_offset = start_bar * ticks_per_bar_midi
    scale = 1920.0 / midi_tpb

    xy_notes: List[Note] = []
    for mn in midi_notes:
        midi_tick_in_pattern = mn.abs_tick - bar_offset
        xy_tick = round(midi_tick_in_pattern * scale)

        if quantize:
            xy_tick = round(xy_tick / STEP_TICKS) * STEP_TICKS

        step_0 = xy_tick // STEP_TICKS
        step = step_0 + 1
        tick_offset = xy_tick % STEP_TICKS

        if step < 1 or step > 64:
            continue

        xy_gate = round(mn.gate_ticks * scale)
        if quantize:
            xy_gate = max(STEP_TICKS, round(xy_gate / STEP_TICKS) * STEP_TICKS)
        gate_ticks = xy_gate if xy_gate > 0 else 0

        note_num = remap_drum_note(mn.note) if is_drum else mn.note
        vel = max(1, min(127, mn.velocity))

        xy_notes.append(
            Note(
                step=step,
                note=note_num,
                velocity=vel,
                tick_offset=tick_offset,
                gate_ticks=gate_ticks,
            )
        )

    if not xy_notes:
        return []

    xy_notes.sort(key=lambda n: (n.step - 1) * STEP_TICKS + n.tick_offset)
    first = xy_notes[0]
    if first.step != 1 or first.tick_offset != 0:
        placeholder_note = first.note
        placeholder_vel = 1
        # Avoid firmware note==velocity crash edge.
        if placeholder_note == placeholder_vel:
            placeholder_vel = 2
        xy_notes.insert(
            0,
            Note(
                step=1,
                note=placeholder_note,
                velocity=placeholder_vel,
                tick_offset=0,
                gate_ticks=STEP_TICKS,
            ),
        )

    return xy_notes


def _derive_secondary_drum_window(notes_window: List[MidiNote]) -> List[MidiNote]:
    """Derive a complementary drum layer from a primary drum lane.

    Preference:
    1) Higher percussion (hats/cymbals/perc by mapped OP-XY pitch)
    2) If unavailable, downsample alternate hits as a sparse complement
    """

    if not notes_window:
        return []

    high_perc: List[MidiNote] = []
    base_hits: List[MidiNote] = []
    for n in notes_window:
        mapped = remap_drum_note(n.note)
        if mapped >= 56 or mapped in {54, 55, 67, 68, 69, 70, 71}:
            high_perc.append(n)
        else:
            base_hits.append(n)

    if high_perc:
        return high_perc

    if len(base_hits) <= 1:
        return base_hits

    base_hits.sort(key=lambda n: (n.abs_tick, n.note))
    derived = [n for i, n in enumerate(base_hits) if i % 2 == 1]
    if derived:
        return derived
    return base_hits[:1]


def _derive_secondary_chord_window(notes_window: List[MidiNote]) -> List[MidiNote]:
    """Derive an alternate chord voice layer from a primary chord lane.

    Preference:
    1) Upper voices from polyphonic onsets
    2) Notes above median pitch
    3) Fallback to every other note for sparse/monophonic content
    """

    if not notes_window:
        return []

    by_onset: Dict[int, List[MidiNote]] = {}
    for n in notes_window:
        by_onset.setdefault(n.abs_tick, []).append(n)

    upper_voices: List[MidiNote] = []
    for onset in sorted(by_onset):
        grp = sorted(by_onset[onset], key=lambda n: n.note)
        if len(grp) >= 2:
            keep = max(1, len(grp) // 2)
            upper_voices.extend(grp[-keep:])
    if upper_voices:
        return upper_voices

    pitches = sorted(n.note for n in notes_window)
    median = pitches[len(pitches) // 2]
    high_notes = [n for n in notes_window if n.note >= median]
    if high_notes:
        return high_notes

    notes_sorted = sorted(notes_window, key=lambda n: (n.abs_tick, n.note))
    return [n for i, n in enumerate(notes_sorted) if i % 2 == 1] or notes_sorted[:1]


def _bar_density(parts: Dict[Tuple[int, int], List[MidiNote]], tpb: int) -> Dict[int, int]:
    ticks_per_bar = tpb * 4
    density: Dict[int, int] = {}
    for notes in parts.values():
        for n in notes:
            bar = n.abs_tick // ticks_per_bar
            density[bar] = density.get(bar, 0) + 1
    return density


def _slot_label(slot: int) -> str:
    role = ROLE_SLOTS.get(slot, "?")
    if role == "drum":
        return f"T{slot} drum"
    if role == "bass":
        return f"T{slot} bass"
    if role == "lead":
        return f"T{slot} lead"
    if role == "chord":
        return f"T{slot} chord"
    return f"T{slot}"


def show_info(mid: mido.MidiFile, start_bar: int, num_patterns: int) -> None:
    """Print analysis including dedupe + role-aware selection."""

    tpb = mid.ticks_per_beat
    total_bars = num_patterns * 4

    tempo_bpm = 120.0
    for track in mid.tracks:
        for msg in track:
            if msg.type == "set_tempo":
                tempo_bpm = mido.tempo2bpm(msg.tempo)
                break
        else:
            continue
        break

    lane_notes = extract_midi_parts(mid)
    print(f"Tempo: {tempo_bpm:.1f} BPM")
    print(f"Ticks per beat: {tpb}")
    print(f"Length: {mid.length:.1f}s")
    print(f"Source note lanes (track+channel): {len(lane_notes)}")
    print(f"Selection window: bars {start_bar}-{start_bar + total_bars - 1}")
    print()

    density = _bar_density(lane_notes, tpb)
    if density:
        print("4-bar window density:")
        for b in range(0, max(density) + 1, 4):
            total = sum(density.get(b + j, 0) for j in range(4))
            if total > 0:
                print(f"  bars {b:>3}-{b+3:<3}: {total:>5} notes")
        print()

    result = select_best_parts(mid, start_bar, total_bars)

    print(f"Candidates after dedupe: {len(result.ranked_parts)}")
    if result.dropped_duplicates:
        print(f"Dropped near-duplicate lanes: {len(result.dropped_duplicates)}")
    print()

    print("Top source candidates:")
    for cand in result.ranked_parts[:16]:
        trk, ch = cand.key
        print(
            f"  trk {trk:>2} ch{ch:>2} "
            f"notes={cand.note_count:>5} bars={cand.active_bars:>2} "
            f"range={cand.pitch_min:>2}-{cand.pitch_max:<3} "
            f"poly={cand.polyphony_ratio:>4.2f} "
            f"scores[d={cand.role_scores['drum']:.1f} "
            f"b={cand.role_scores['bass']:.1f} "
            f"l={cand.role_scores['lead']:.1f} "
            f"c={cand.role_scores['chord']:.1f}]"
        )
    print()

    print("Assigned OP-XY tracks:")
    for slot in range(1, 9):
        cand = result.assignments.get(slot)
        if cand is None:
            print(f"  {_slot_label(slot):<10}: (empty)")
            continue
        trk, ch = cand.key
        print(
            f"  {_slot_label(slot):<10}: MIDI trk {trk} ch{ch} "
            f"notes={cand.note_count} range={cand.pitch_min}-{cand.pitch_max}"
        )


def _notes_to_json(notes: List[Note]) -> List[dict]:
    return [
        {
            "step": n.step,
            "note": n.note,
            "velocity": n.velocity,
            "tick_offset": n.tick_offset,
            "gate_ticks": n.gate_ticks,
        }
        for n in notes
    ]


def build_track_patterns(
    selection: SelectionResult,
    midi_tpb: int,
    start_bar: int,
    num_patterns: int,
) -> Dict[int, List[Optional[List[Note]]]]:
    """Build per-slot note lists per 4-bar pattern."""

    track_patterns: Dict[int, List[Optional[List[Note]]]] = {}

    drum_primary = selection.assignments.get(1) or selection.assignments.get(2)
    chord_primary = selection.assignments.get(7) or selection.assignments.get(8)

    for slot in range(1, 9):
        role = ROLE_SLOTS[slot]
        cand = selection.assignments.get(slot)
        patterns: List[Optional[List[Note]]] = []

        for pidx in range(num_patterns):
            pat_start = start_bar + pidx * 4
            source_notes: List[MidiNote] = []
            if cand is not None:
                source_notes = select_bar_window(cand.notes_all, midi_tpb, pat_start, 4)
            elif role == "drum" and drum_primary is not None:
                base = select_bar_window(drum_primary.notes_all, midi_tpb, pat_start, 4)
                source_notes = _derive_secondary_drum_window(base)
                if not source_notes:
                    source_notes = base
            elif role == "chord" and chord_primary is not None:
                base = select_bar_window(chord_primary.notes_all, midi_tpb, pat_start, 4)
                source_notes = _derive_secondary_chord_window(base)
                if not source_notes:
                    source_notes = base

            if not source_notes:
                patterns.append(None)
                continue

            window_notes = source_notes
            if not window_notes:
                patterns.append(None)
                continue

            xy_notes = midi_to_xy_notes(
                window_notes,
                midi_tpb,
                pat_start,
                is_drum=(role == "drum"),
            )
            if not xy_notes:
                patterns.append(None)
                continue

            patterns.append(xy_notes[:MAX_NOTES_PER_PATTERN])

        track_patterns[slot] = patterns

    return track_patterns


def _count_active_patterns(patterns: List[Optional[List[Note]]]) -> int:
    return sum(1 for p in patterns if p)


def build_json_payload(
    *,
    track_patterns: Dict[int, List[Optional[List[Note]]]],
    template_path: str,
    xy_output_path: str,
    num_patterns: int,
) -> dict:
    """Build a schema-valid JSON payload for tools/build_xy_from_json.py."""

    payload = {
        "version": 1,
        "mode": "multi_pattern",
        "template": template_path,
        "output": xy_output_path,
        "descriptor_strategy": "strict",
        "tracks": [],
    }

    if num_patterns == 1:
        # Compiler one-pattern form: include only tracks with actual notes.
        for slot in range(1, 9):
            patterns = track_patterns.get(slot, [None])
            notes = patterns[0] if patterns else None
            if not notes:
                continue
            payload["tracks"].append(
                {
                    "track": slot,
                    "patterns": [_notes_to_json(notes)],
                }
            )
    else:
        # Multi-pattern form: include all 8 slots so role layout is explicit.
        for slot in range(1, 9):
            patterns = track_patterns.get(slot, [None] * num_patterns)
            serialised_patterns: List[Optional[List[dict]]] = []
            for notes in patterns:
                serialised_patterns.append(_notes_to_json(notes) if notes else None)
            payload["tracks"].append(
                {
                    "track": slot,
                    "patterns": serialised_patterns,
                }
            )

    if not payload["tracks"]:
        raise ValueError("no note data selected for JSON payload")

    return payload


def write_json_spec(payload: dict, output_path: str) -> None:
    out = Path(output_path)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(payload, indent=2), encoding="utf-8")
    print(f"Wrote JSON spec -> {out}")


def convert_to_xy(
    *,
    baseline_path: str,
    output_path: str,
    bpm: float,
    num_patterns: int,
    track_patterns: Dict[int, List[Optional[List[Note]]]],
) -> None:
    """Legacy path: emit .xy directly from selected track patterns."""

    print(f"Loading baseline: {baseline_path}")
    proj = XYProject.from_bytes(Path(baseline_path).read_bytes())

    # Set tempo
    tempo_tenths = round(bpm * 10)
    pre_track = bytearray(proj.pre_track)
    pre_track[0x08:0x0A] = struct.pack("<H", tempo_tenths)
    proj = XYProject(pre_track=bytes(pre_track), tracks=proj.tracks)

    if num_patterns == 1:
        track_note_map: Dict[int, List[Note]] = {}
        for slot in range(1, 9):
            patterns = track_patterns.get(slot, [None])
            notes = patterns[0] if patterns else None
            if notes:
                track_note_map[slot] = notes

        if not track_note_map:
            raise ValueError("no notes after conversion")

        result = append_notes_to_tracks(proj, track_note_map)
        total_notes = sum(len(n) for n in track_note_map.values())
        print(f"Converted: {total_notes} notes across {len(track_note_map)} tracks")
    else:
        # In multi-pattern mode keep all slots explicit for consistent topology.
        multi = {slot: track_patterns[slot] for slot in range(1, 9)}
        result = build_multi_pattern_project(proj, multi, descriptor_strategy="strict")

        total_notes = 0
        for slot in range(1, 9):
            counts = [len(p) if p else 0 for p in multi[slot]]
            active = _count_active_patterns(multi[slot])
            if active:
                print(f"  T{slot}: {active}/{num_patterns} patterns active, notes/pat={counts}")
                total_notes += sum(counts)
        print(f"Total notes: {total_notes}")

    data = result.to_bytes()
    out = Path(output_path)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_bytes(data)
    print(f"Wrote {len(data)} bytes -> {out}")


def _auto_detect_patterns(midi_path: str, start_bar: int) -> int:
    """Auto-detect number of 4-bar patterns based on song length."""

    mid = mido.MidiFile(midi_path)
    tpb = mid.ticks_per_beat
    ticks_per_bar = tpb * 4

    lane_notes = extract_midi_parts(mid)
    max_tick = 0
    for notes in lane_notes.values():
        for n in notes:
            max_tick = max(max_tick, n.abs_tick)

    total_bars = max_tick // ticks_per_bar + 1
    remaining_bars = max(1, total_bars - start_bar)
    patterns = min(9, math.ceil(remaining_bars / 4))
    return max(1, patterns)


def _pick_default_output(input_path: str, fmt: str) -> str:
    stem = Path(input_path).stem
    if fmt == "json":
        return f"specs/midi-to-xy/{stem}.json"
    return f"output/{stem}.xy"


def _pick_default_xy_output(input_path: str) -> str:
    stem = Path(input_path).stem
    return f"output/from-midi/{stem}.xy"


def _source_summary(selection: SelectionResult) -> None:
    print("Selected source lanes:")
    for slot in range(1, 9):
        cand = selection.assignments.get(slot)
        if cand is None:
            print(f"  {_slot_label(slot):<10}: (empty)")
            continue
        trk, ch = cand.key
        role = ROLE_SLOTS[slot]
        score = cand.role_scores[role]
        print(
            f"  {_slot_label(slot):<10}: MIDI trk {trk} ch{ch} "
            f"notes={cand.note_count} bars={cand.active_bars} score={score:.1f}"
        )


def main() -> None:
    parser = argparse.ArgumentParser(
        description=(
            "Convert MIDI to OP-XY JSON spec (default) or direct .xy output "
            "using role-aware 8-track selection"
        )
    )
    parser.add_argument("input", help="Input MIDI file")
    parser.add_argument(
        "-o",
        "--output",
        help="Output path (.json spec by default; .xy when --format xy)",
    )
    parser.add_argument(
        "--format",
        choices=("json", "xy"),
        default="json",
        help="Output format (default: json)",
    )
    parser.add_argument(
        "--xy-output",
        default=None,
        help=(
            "When --format json, set spec.output (planned XY path). "
            "Default: output/from-midi/<song>.xy"
        ),
    )
    parser.add_argument(
        "--baseline",
        default="src/one-off-changes-from-default/unnamed 1.xy",
        help="Baseline .xy file template",
    )
    parser.add_argument(
        "--start-bar",
        type=int,
        default=None,
        help="First bar to extract (0-based, default: 0)",
    )
    parser.add_argument(
        "--bars",
        default=None,
        help="Legacy single-pattern range (e.g. '28-31')",
    )
    parser.add_argument(
        "--patterns",
        type=int,
        default=None,
        help="Number of 4-bar patterns (1-9, default: auto-detect)",
    )
    parser.add_argument(
        "--info",
        action="store_true",
        help="Show analysis and selection summary only",
    )
    args = parser.parse_args()

    if args.bars and args.start_bar is None:
        start_bar = int(args.bars.split("-")[0])
    elif args.start_bar is not None:
        start_bar = args.start_bar
    else:
        start_bar = 0

    if args.patterns is not None:
        num_patterns = max(1, min(9, args.patterns))
    elif args.bars:
        num_patterns = 1
    else:
        num_patterns = _auto_detect_patterns(args.input, start_bar)
        print(f"Auto-detected {num_patterns} pattern(s) from song length")

    if args.info:
        mid = mido.MidiFile(args.input)
        show_info(mid, start_bar, num_patterns)
        return

    output_path = args.output or _pick_default_output(args.input, args.format)

    mid = mido.MidiFile(args.input)
    tpb = mid.ticks_per_beat
    total_bars = num_patterns * 4

    bpm = 120.0
    for track in mid.tracks:
        for msg in track:
            if msg.type == "set_tempo":
                bpm = mido.tempo2bpm(msg.tempo)
                break
        else:
            continue
        break

    print(f"MIDI: {Path(args.input).name}")
    print(f"Tempo: {bpm:.1f} BPM, ticks/beat: {tpb}")
    if num_patterns > 1:
        print(f"Multi-pattern: {num_patterns} patterns x 4 bars = {total_bars} bars")
        print(f"Window: bars {start_bar}-{start_bar + total_bars - 1}")
    else:
        print(f"Window: bars {start_bar}-{start_bar + 3}")
    print()

    selection = select_best_parts(mid, start_bar, total_bars)
    if not selection.assignments:
        raise ValueError("no usable MIDI parts in the selected window")

    if selection.dropped_duplicates:
        print(f"Dropped near-duplicate lanes: {len(selection.dropped_duplicates)}")
    _source_summary(selection)
    print()

    track_patterns = build_track_patterns(selection, tpb, start_bar, num_patterns)

    # Keep output summaries concise but clear.
    for slot in range(1, 9):
        patterns = track_patterns[slot]
        active = _count_active_patterns(patterns)
        if active:
            counts = [len(p) if p else 0 for p in patterns]
            print(f"  T{slot}: {active}/{num_patterns} patterns active, notes/pat={counts}")
    print()

    if args.format == "json":
        xy_output = args.xy_output or _pick_default_xy_output(args.input)
        template_path = str(Path(args.baseline).expanduser().resolve())
        payload = build_json_payload(
            track_patterns=track_patterns,
            template_path=template_path,
            xy_output_path=xy_output,
            num_patterns=num_patterns,
        )
        write_json_spec(payload, output_path)
        print(f"JSON tracks emitted: {len(payload['tracks'])}")
        print(f"Spec output path set to: {xy_output}")
        return

    convert_to_xy(
        baseline_path=args.baseline,
        output_path=output_path,
        bpm=bpm,
        num_patterns=num_patterns,
        track_patterns=track_patterns,
    )


if __name__ == "__main__":
    main()
