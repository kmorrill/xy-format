# Contributor inspection workflow (2026-06)

> **Scope:** How external read-only inspection contributions fit **this**
> repository. Does **not** replace [`docs/roadmap.md`](../roadmap.md) tier
> priorities — it documents what landed in a June 2026 probe pass and how to
> verify each claim.

## Principles (from `AGENTS.md`)

1. Stable offsets → `docs/format/decoded_image_map.md` + tests.
2. Narrative / open questions → dated `docs/logs/*`.
3. Belief changes → append `docs/state_of_understanding.md` (do not rewrite old entries).
4. Prefer byte-pinned reads over heuristics; label confidence when heuristic.
5. Promoted fixtures live under `src/*-probes/` in **this repo** (self-contained).

## Promotion checklist

When closing a read gap:

1. Capture one-variable device diff → add fixture under `src/*-probes/`.
2. Write `docs/logs/YYYY-MM-DD_<topic>.md` (procedure, findings, open questions).
3. Add `xy/*_inspection.py` + `tests/test_*_inspection.py`.
4. Update `decoded_image_map.md`, `image_coverage_map.md`, `parse_capability_checklist.md`.
5. Wire `tools/inspect_xy.py` when the field is user-visible in inspection.
6. Record device outcome with `python tools/corpus_lab.py record …` when possible.

Fixture capture recipes: `src/*-probes/*/README.md` (operator procedure + results per pack).

## Inspection modules landed (2026-06)

Each row is evidence-backed in-repo. **Do not treat as device-validated**
unless the log marks E2/E3 (see checklist evidence tiers).

| Module | Tier touch | Fixtures | Tests | Log |
| --- | --- | --- | --- | --- |
| `xy/project_inspection.py` | Tier 1 §3 (partial; heuristic preset refs) | `src/preset-probes/` | `test_project_inspection.py` | `2026-06-09_app_preset_probe_inspection.md` |
| `xy/preset_path_inspection.py` | Tier 1 §3 (structural path) | `2026-06-preset-path/` | `test_preset_path_structural.py` | `2026-06-12_preset_path_structural.md` |
| `xy/drum_sample_inspection.py` | Tier 1 §4 | `2026-06-sample-paths/`, pan-fade | `test_drum_sample_inspection*.py`, `test_drum_pan_fade_inspection.py` | `2026-06-12_drum_sample_path_inspection.md`, `2026-06-12_drum_pan_fade_inspection.md` |
| `xy/mixer_static_inspection.py` | Tier 1 mix static offsets | `2026-06-static/` | `test_mixer_static_inspection.py` | `2026-06-12_mixer_static_inspection.md` |
| `xy/scene_volume_inspection.py` | Tier 2 scene storage | `2026-06-volumes/` | `test_scene_volume_inspection.py` | `2026-06-12_scene_volume_inspection.md` |
| scene mutes (`read_scene_muted_tracks`) | Tier 2 §1 (mute=2) | `2026-06-track-mutes/` | `test_scene_track_mute_inspection.py` | `2026-06-12_scene_track_mute_inspection.md` |
| `xy/master_eq_inspection.py` | header EQ | `2026-06-eq/` | `test_master_eq_inspection.py` | `2026-06-12_master_eq_inspection.md` |
| `xy/master_saturator_inspection.py` | saturator | `2026-06-saturator/` | `test_master_saturator_inspection.py` | `2026-06-12_master_saturator_inspection.md` |
| `xy/sampler_sample_inspection.py` | Tier 1 §4 one-shot | `2026-06-oneshot/` | `test_sampler_sample_inspection.py` | `2026-06-12_sampler_oneshot_inspection.md` |

Paths above are under the relevant `src/*-probes/` fixture directory unless noted.

## Open / partial (honest gaps)

| Topic | Status | Next test |
| --- | --- | --- |
| Scene-stored volume **playback** on 1.1.4 | bytes differ per scene; operator heard global mix | chained scene switch + re-save capture |
| Scene volume storage matrix (all 16×N) | partial — P2-D validated subset | more P2-D variants |
| Preset ref heuristic (`0xF7` fragments) | medium confidence | structural decode vs `ImageProject.set_preset` |
| Multisampler zones | not captured | P2-C when presets available |
| Aux tracks T9–T16 | not captured | P3-A |

## Related docs

- [`parse_capability_checklist.md`](../parse_capability_checklist.md) — checkbox status + evidence
- [`format/image_coverage_map.md`](../format/image_coverage_map.md) — mapped vs `?` regions
- [`state_of_understanding.md`](../state_of_understanding.md) — 2026-06-13 entry
