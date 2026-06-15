> **SUPERSEDED (2026-06-09).** This describes the pre-RLE writer model.
> The format is RLE-compressed C structs; author via the decoded image.
> See `docs/engineering/authoring.md` and `docs/format/decoded_image_map.md`.
> Retained for historical context.

# JSON Authoring Bridge (op-xy-live -> xy-format)

This repo now has a JSON-to-`.xy` compile path via:
- `xy/json_build_spec.py`
- `tools/build_xy_from_json.py`

## Inspiration Taken From `op-xy-live`
- Pattern-oriented JSON payloads are easy for coding agents to edit.
- `toConfig()`/`dumpSystemState()` style snapshots are useful as an LLM-facing contract.
- Keep JSON human-readable and shallow enough for quick iterative edits.

## Intentional Differences
- `op-xy-live` JSON surfaces describe live MIDI/runtime behavior.
- `xy-format` JSON spec describes an offline file build request that compiles to binary `.xy`.
- The compiler is constrained to existing known-safe writer paths, not arbitrary synthesis.

## Current JSON Contract Scope
- `multi_pattern` mode only:
  - one-pattern form (all listed tracks have `patterns` length `1`) maps to `append_notes_to_tracks`.
  - multi-pattern form (all listed tracks have `patterns` length `>=2`) maps to `build_multi_pattern_project`.
  - pass through `descriptor_strategy` (`strict` or `heuristic_v1`) for multi-pattern form.
- Optional header patch:
  - `tempo_tenths`, `groove_type`, `groove_amount`, `metronome_level`.
- Optional `sound_state` patch:
  - `master_eq.low/mid/high`.
  - Per-track `engine_id`, `engine_params.param1..param4`,
    `amp_envelope.attack/decay/sustain/release`,
    `m2_shift.play_mode/portamento/pitch_bend_range/engine_volume`,
    `filter.type/enabled/cutoff/resonance/env_amount/key_tracking`,
    `sends.ext/tape/fx1/fx2`, `lfo_current.cc40/cc41`,
    `filter_envelope.attack/decay/sustain/release`, and
    `mix.pan/volume`.
  - Values are raw decoded-image u32 lanes unless noted (`engine_id`,
    `filter.type`, and `filter.enabled`).
- `project_to_json` also emits underscore-prefixed diagnostic sections:
  - `_decoded_global_state` for decoded-image master EQ and candidate master
    mix bytes.
  - `_decoded_track_state` for per-track current values: engine params,
    amp/filter envelopes, filter knobs, M2 shift lanes, sends, pinned LFO
    current lanes, and mixer pan/volume.
  - These diagnostics are ignored by `parse_build_spec`; they are for
    inspection/debugging and for preserving offset context alongside editable
    `sound_state`.

## Profiles (required on new specs)

Every spec must declare a `profile` string. The profile names a validated
build recipe and acts as a safety gate: the compiler validates the spec
matches the profile before any template mutation. See `xy/profiles.py` for
the authoritative registry.

| Profile | What it does | Evidence |
|---|---|---|
| `header_only` | Header patch (tempo/groove/metronome) only, no track changes. | `xy/container.py` round-trip (206/206 corpus) |
| `single_pattern_notes` | Append notes to tracks that each hold exactly one pattern. | T004: `unnamed 2`, `unnamed 81`; `output/ode_to_joy*.xy` |
| `multi_pattern_strict` | Multi-pattern build with device-verified descriptor. Track set must be in the strict lookup (`{T1}`, `{T2}`, `{T1,T2}`, `{T1,T3}`, `{T1,T4}`, `{T1,T2,T3}`, all 8, or single T3/T4/T7) or any T3+-only Scheme A combination. | T005, `docs/format/descriptor_encoding.md` |
| `bootstrap_t1_t8_p9` | 8-track × 9-pattern strict topology from `unnamed 1`/`j06`. Safe mitigation for sparse-topology crashes. | `docs/issues/sparse_topology_stability.md` |
| `scene_song_tokens` | Pre-track and Track16 token patches for scene/song control. Scaffold must have matching pre-track shape. | `docs/format/scenes_songs.md` §§4–6 |
| `scene_assignments` | Scene pattern-map / song arrangement rewrite on a decoded scene-family scaffold (tag-record or matrix). | `docs/format/scenes_songs.md` §§15, 17; `xy/scene_patcher.py` |
| `sound_state` | Decoded-image sound-state patch with no note/scene changes. May also be included alongside note/scene profiles. | `docs/format/decoded_image_map.md`; current-lane tests in `tests/test_image_writer.py` |

### Migrating legacy specs

Specs authored before profiles existed emit a `DeprecationWarning` with the
inferred profile. Use the migration command to write the inferred value back:

    python tools/build_xy_from_json.py path/to/spec.json --migrate-profile

The command is idempotent (skips specs that already declare a profile) and
inserts `"profile": "…"` immediately after `"mode"`.

### Rejecting out-of-contract requests

- A spec with a declared `profile` that doesn't match the recipe fails hard
  with a profile-specific message (e.g. `profile=multi_pattern_strict: track
  set {T1,T5} is not device-verified`).
- A spec without a profile that doesn't match any recipe fails with a
  catalog hint naming all registered profiles.
- Generalising an existing profile or adding a new one requires (1) corpus
  evidence, (2) a regression test, and (3) a docs entry — see the block
  comment at the top of `xy/profiles.py`.

## Guardrails
- Spec versioned (`version: 1`).
- Strong range checks for track/note/timing fields.
- Output re-parsed through `XYProject` for structural round-trip sanity.
- Profile gate runs before any template mutation.

## Near-Term Extensions
- Add optional event-type override only where backed by preset evidence.
- Add step-component/p-lock sections once pointer-tail decode reaches stable coverage.
- Add scaffold presets so agents can select topology-safe templates by name.
