# Docs Index

## Start Here
- Operating guide: `AGENTS.md`
- **Parse & author capability checklist: `docs/parse_capability_checklist.md`**
- **State of understanding (dated ledger of what we believe/doubt): `docs/state_of_understanding.md`**
- Roadmap: `docs/roadmap.md`
- Human explainer: `docs/human-explainer.md`

## Workflows
- **Contributor inspection workflow (2026-06): `docs/workflows/contributor_inspection_workflow.md`**
- Device probe capture recipes: `src/*-probes/*/README.md`
- Device test naming: `docs/workflows/device_test_naming.md`
- Inspector sweep: `docs/workflows/inspector_sweep.md`
- Crash capture protocol: `docs/workflows/crash_capture.md`

## Tools

User-facing tools live at `tools/`. Research, probing, and one-off scripts
have moved to `tools/analysis/` — see `tools/analysis/README.md`.

User-facing:
- Complete raw preset-state inspection: `tools/inspect_preset_state.py`
- Inspector: `docs/tools/inspect_xy.md` (`tools/inspect_xy.py`)
- JSON spec compiler: `docs/tools/spec_to_xy_image.md` (`tools/spec_to_xy_image.py`)
- Corpus index/query: `docs/tools/corpus_lab.md` (`tools/corpus_lab.py`)
- Spatial variance analyzer: `docs/tools/analyze_spatial_variance.md` (`tools/analyze_spatial_variance.py`)
- Header reader: `docs/tools/read_xy_header.md` (`tools/read_xy_header.py`)
- MIDI → .xy conversion: `tools/midi_to_xy.py`
- P-lock extraction: `tools/extract_plocks.py`
- Corpus-wide analyses: `tools/analyze_corpus.py`
- Multi-pattern device capture: `tools/capture_16pat.py`
- Round-trip verification: `tools/roundtrip_xy.py`

Research (under `tools/analysis/`):
- Structural compare: `docs/tools/corpus_compare.md` (`tools/analysis/corpus_compare.py`)

## Reference
- OP-XY documented limits: `docs/reference/opxy_limits.md`
- OP-XY MIDI CC map: `docs/reference/opxy_midi_cc_map.md`

## Format (Canonical)
- **Firmware serialization and full byte partition**: `docs/format/serialization.md`
- **Backward compatibility and migrations**: `docs/format/backward_compatibility.md`
- **Preset JSON import/export and repeated binary sound state**: `docs/format/preset_json.md`
- Partial editing API limitations: `docs/format/patch_json_adapter.md`
- Historical capture-based record model: `docs/format/record_structure.md`
  (superseded where noted by the firmware serialization reference)
- **Decoded image map (capture-derived fields)**: `docs/format/decoded_image_map.md`
- **Spatial coverage ledger (decoded vs opaque ranges)**: `docs/format/spatial_coverage_ledger.md`
- **Image coverage map (mapped vs unmapped at a glance)**:
  `docs/format/image_coverage_map.md`
- OP-XY user guide save audit: `docs/format/opxy_user_guide_save_audit.md`
- Header: `docs/format/header.md`
- Scenes and songs: `docs/format/scenes_songs.md`
- Step components: `docs/format/step_components.md`
- P-locks: `docs/format/plocks.md`
- Mod routing: `docs/format/mod_routing.md`
- Drum sampler sample paths: `docs/format/drum_sample_paths.md`

## Engineering
- **Authoring `.xy` files (canonical writer guide)**: `docs/engineering/authoring.md`
- Architecture notes: `docs/engineering/architecture.md`
- Complete project JSON target: `docs/engineering/json_project_spec_complete.md`

## Debug and Issues
- Crash catalog: `docs/debug/crashes.md`
- Issues index: `docs/issues/index.md`
- Sparse topology stability issue: `docs/issues/sparse_topology_stability.md`

## Logs
Historical logs live in `docs/logs/`. Pre-2026-06-09 logs are retained as
provenance and often use superseded terminology.

Selected current logs:
- Record-boundary reframe: `docs/logs/2026-06-09_record_boundary_reframe.md`
- App preset probe inspection: `docs/logs/2026-06-09_app_preset_probe_inspection.md`
- Drum sample path inspection: `docs/logs/2026-06-12_drum_sample_path_inspection.md`
- Drum pan/fade inspection: `docs/logs/2026-06-12_drum_pan_fade_inspection.md`
- Project config inspection: `docs/logs/2026-06-13_project_config_inspection.md`
- Global header inspection: `docs/logs/2026-06-13_global_header_inspection.md`
- Bar menu inspection: `docs/logs/2026-06-13_bar_menu_inspection.md`
- Spatial variance index: `docs/logs/2026-06-15_spatial_variance_index.md`
