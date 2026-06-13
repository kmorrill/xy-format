# inspect_xy.py

`tools/inspect_xy.py` emits a multi-section report for a single `.xy` file.

## Current Coverage
- Header summary.
- Pattern directory/pre-track observations.
- Structural track preset paths @ `+0x453F` (`xy/preset_path_inspection.py`) —
  short `category/name` strings; works on blank patterns.
- Active track/pattern preset-reference inference when project bodies expose
  preset folder or fragmented preset-name strings (`xy/project_inspection.py`).
- Drum-engine track voices: paths plus tune/play/direction/pan/start/end/gain/fade
  (`xy/drum_sample_inspection.py`).
- One-shot sampler sample-edit screen (`xy/sampler_sample_inspection.py`).
- Static mixer: T1 vol/pan/sends + master buses (`xy/mixer_static_inspection.py`).
- Scene mix: scene count, active scene, master vol, T1–T8 volume bytes
  (`xy/scene_volume_inspection.py`).
- Scene mutes: per-slot muted tracks when any mutes present (`read_scene_muted_tracks`).
- Master EQ bands (`xy/master_eq_inspection.py`).
- Master saturator (`xy/master_saturator_inspection.py`).
- Project config: transpose, scene length, time signature, groove, T1–T8 voice
  allocation, T1–T16 MIDI channels (`xy/project_config_inspection.py`).
- P-lock lane summary for standard and known T10 9-byte p-lock headers.
- Per-track scan and event summaries.
- Legacy EQ/global snippets (older offsets).

## Usage
- `python tools/inspect_xy.py 'src/app-mixer-probes/2026-06-static/f0-baseline-mix-default.xy'`
- `python tools/inspect_xy.py 'src/app-preset-probes/2026-06-app-required/a1-t1-p9.xy'`
- `python tools/inspect_xy.py 'src/app-project-config-probes/2026-06-project-config/prjconf-v-mix-1234.xy'`

## Notes
- Pointer-tail and pointer-21 note decode is still incomplete; see `docs/issues/pointer_tail_decoding.md`.
- Use with `docs/workflows/inspector_sweep.md` for structured corpus validation.
- Preset reference inference is heuristic — see confidence in `[Pattern Presets]` output.
