# 2026-06-12 — Drum voice param read API (no new probes)

Extended `xy/drum_sample_inspection.py` to read all eight drum-knob fields
already mapped by `cap_drum_params.xy` and `set_drum_voice()`:

| field | slot offset | `DrumVoiceSample` |
|---|---|---|
| tune | +0x00 | `tune_semitones` (from `0x3C` center) |
| play mode | +0x03 | `play_mode` |
| direction | +0x07 | `direction` / `direction_label` |
| start / loop start / end | +0x68 / +0x6C / +0x70 | `start`, `loop_start`, `end` |
| gain | +0x7C | `gain_u32` |
| loop crossfade | preceding +0x7C | `loop_fade_ui` (pad-centric) |

`tools/inspect_xy.py` `[Drum Samples]` section now prints the full row.

Tests: `tests/test_drum_voice_params_inspection.py` (capture + writer roundtrip);
`test_drum_pan_fade_inspection.py` asserts `loop_fade_ui` on edited pad.

Note: `+0x7C` is shared — gain on pad *N* and fade storage for pad *N+1* use the
same u32 on slot *N*. Max gain (`0x7FFFFFFF`) decodes identically to fade UI 99.

Follow-up: the previously skipped u32 at slot `+0x6C` is now exposed as
`loop_start`. In `cap_drum_params.xy`, voice 10 has `+0x6C = 0x00001011` while
`+0x70` moves to `0x00001F40`; other changed voices leave `+0x6C` at zero. This
matches the expected position between sample start and end, but still wants a
future clean loop-start-only capture before marking the UI semantics as fully
device-isolated.
