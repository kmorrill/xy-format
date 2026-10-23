# patch.json adapter coverage

OP-XY `.preset` folders store a `patch.json` file next to their audio files.
This page describes the existing **partial editing adapter**, including its
remaining limitations. It is not the firmware import/export specification.
For the complete field inventory, replacement defaults, scalar conversions,
file lifecycle and binary crosswalk, use [Preset JSON and project state](preset_json.md).
The firmware trace supersedes earlier corpus-based inferences about slot
ownership, gain, tuning and defaulting; existing writer APIs have not all been
reconciled. A successful adapter call is not full firmware preset-load emulation.

## Top-level fields

| Field | Meaning | `.xy` write status |
| --- | --- | --- |
| `platform` | Preset platform marker, observed as `OP-XY`. | Ignored; not project sound state. |
| `version` | patch schema version, observed as `4`. | Ignored; not project sound state. |
| `name` | Optional input metadata; not emitted by the traced firmware exporter. | Ignored; project stores short preset identity separately. |
| `type` | Preset engine family such as `drum`, `sampler`, `axis`, etc. | `drum` and `sampler` are writable; other types are rejected. |
| `octave` | Track keyboard octave. | Confirmed readable for T1 at decoded-image `0x003D` as a signed byte; manual device testing shows this is track-global, not pattern-local. The adapter does not write it yet. |
| `engine` | Engine-level settings and params. | Confirmed common lanes are written for supported sound patches; see below. |
| `envelope` | Amp/filter envelope blocks. | Confirmed amp/filter ADSR lanes are written for supported sound patches. |
| `fx` | Preset-local FX state. | Confirmed type/active/params lanes are written for supported sound patches; `params[5]` serializes as max. |
| `lfo` | Preset-local LFO state. | Confirmed type/active/params lanes are written for supported sound patches. |
| `regions` | Sample-region list. | Source for writable drum and one-shot sampler fields. |

## Common engine fields

Known `engine` keys include:

```text
bendrange
highpass
playmode
transpose
volume
width
velocity.sensitivity
portamento.amount
portamento.type
tuning.root
tuning.scale
params
modulation.aftertouch.amount
modulation.aftertouch.target
modulation.modwheel.amount
modulation.modwheel.target
modulation.pitchbend.amount
modulation.pitchbend.target
modulation.velocity.amount
modulation.velocity.target
```

The adapter writes the confirmed common project-image lanes when applying a
supported drum or sampler patch. This does **not** make synth-engine preset
loading complete: unsupported preset types still need a complete replacement implementation
and qualification against firmware application, including state omitted from JSON.

| Field | `.xy` write status |
| --- | --- |
| `type` | Written as the engine byte at `track+0x14` for known engine families. |
| `engine.params[0..7]` | Written as q16 words at `track+0x3857..0x3873`. |
| `engine.playmode` | `poly` and `mono` are written as the confirmed raw words at `track+0x3887`. |
| `engine.portamento.amount` | Written as q16 at `track+0x388B`. |
| `engine.bendrange` | Written as q16 at `track+0x388F`. |
| `engine.volume` | Written as q16 at `track+0x3893`. |
| `engine.modulation.*.target/amount` | Written as q16 words at `track+0x38FF..0x3937`. |
| `engine.velocity.sensitivity` | Written as q16 at `track+0x3917`. |
| `engine.portamento.type` | Written as q16 at `track+0x391B`. |
| `engine.tuning.scale` | Written as q16 at `track+0x391F`. |
| `engine.width` | Written as q16 at `track+0x3923`. |
| `engine.transpose` | Not written; general conversion is now firmware-traced in the preset reference. |
| `engine.tuning.root` | Written as q16 at `track+0x392B`. |
| `engine.highpass` | Written as q16 at `track+0x392F`. |
| `engine.tuning[]` | Not written; firmware locates it at the first 48-byte suffix after controller vectors. |
| `envelope.amp.*` | Written as q16 words at `track+0x3877..0x3883`. |
| `envelope.filter.*` | Written as q16 words at `track+0x38D7..0x38E3`. |
| `fx.type` | `z lowpass`, `svf`, `ladder`, and `z hipass` are written to `track+0x21`. |
| `fx.active` | Written as boolean byte at `track+0x25`. |
| `fx.params[0..7]` | Written as q16 words at `track+0x3897..0x38B3`, except `params[5]`, which this API forces to raw `0x7FFFFFFF`. Firmware instead preserves the existing ID21 on non-MIDI import; export reads it normally. |
| `lfo.type` | `tremolo`, `value`, `random`, and `element` are written to `track+0x1C`. |
| `lfo.active` | Written as boolean byte at `track+0x20`. |
| `lfo.params[0..7]` | Written as q16 words at `track+0x38B7..0x38D3`. |

## Drum region fields

For `type: "drum"`, the adapter authors the clean full-kit mapping validated by
the preset corpus: `voice = hikey - 53`; out-of-range regions are ignored.
Firmware instead assigns regions by array order, up to 24, independently of
`hikey`. This legacy adapter mapping is not the full importer and can disagree
for sparse or reordered kits (`nt-cherry` and `nt-hard spunch` were prior clues).

| Region field | `.xy` write status |
| --- | --- |
| `sample` | Written to the drum voice sample path. If `preset_device_path` is supplied, only slash-free names are prefixed. Any string containing `/` remains unchanged; DLC alias resolution is not implemented here. |
| `hikey` | Written as drum key assignment and used to select voice index. |
| `lokey` | Ignored; observed drum presets use `lokey == hikey`. |
| `pitch.keycenter` | Ignored by this adapter; firmware adds transpose to this keycenter byte. |
| `playmode` | Preset-load experiment confirmed string labels: `gate=0`, `key=1`, `oneshot=1`, `group=2`, `loop=3`. Numeric JSON values are rejected because device preset loading did not preserve numeric `1..4` as raw bytes. |
| `reverse` | Written as drum direction. |
| `transpose` | Written as drum tune when present. |
| `tune` | Used as a fallback for the same coarse tune API. Firmware stores tune independently in signed slot byte `0x1c`; this fallback does not reproduce it. |
| `pan` | Written as signed drum pan byte. |
| `sample.start` | Passed to the legacy drum writer; complete-record `+0x04` ownership must be reconciled before treating this as a firmware-equivalent write. |
| `sample.end` | Legacy writer retains a mistaken record origin. Firmware places end at complete record `+0x08` (record origin `track+0x393f+128*slot`), not a neighboring voice. Boundary writes need reconciliation. |
| `framecount` | Used as drum sample end only when `sample.end` is absent; same caveat as `sample.end`. |
| `gain` | Legacy writer uses a u32 assumption; firmware gain is a signed byte at complete record `+0x1d`. This write is not firmware-equivalent. |
| `fade.out` | Written through the confirmed drum fade storage rule. |
| `fade.in` | Ignored by adapter. Firmware selects max(fade.in, fade.out, 0) into record `+0x14` and stores direction in mode bit7. |

## Sampler region fields

For `type: "sampler"`, this adapter writes one-shot sampler state from the
first region. Multi-zone behavior is intentionally not claimed here.

| Region field | `.xy` write status |
| --- | --- |
| `sample` | Written to the sampler slot path. If `preset_device_path` is supplied, only slash-free names are prefixed. Any string containing `/` remains unchanged; DLC alias resolution is not implemented here. |
| `sample.start` | Written as sampler sample start u32. |
| `sample.end` | Written as sampler sample end u32. |
| `framecount` | Written as sampler framecount u32 at `track+0x393F`; also used as sample end when `sample.end` is absent. |
| `loop.start` | Written as sampler loop start u32. |
| `loop.end` | Written as sampler loop end u32. |
| `loop.crossfade` | Written as sampler loop crossfade frames, normalized against `framecount` into the raw u32 at track `+0x3953` using the device's single-precision float calculation; if `framecount` is absent, `sample.end` is used as a fallback denominator. |
| `loop.enabled` | Patch.json preset loading uses bit `0x40` when `false`; missing/true does not set that bit. This is the patch-load byte, not a direct sampler-edit UI label. |
| `loop.onrelease` | Patch.json preset loading uses bit `0x80` when `true`; missing/false does not set that bit. This is the patch-load byte, not a direct sampler-edit UI label. |
| `tune` | Written to sampler slot `+0x04` as signed cents (`4 -> +0.04`, `-5 -> -0.05`, stored as `0xFB`). This is distinct from the direct sample-edit tune encoder. |
| `gain` | Written as sampler gain byte. |
| `reverse` | Written as sampler direction. |
| `hikey` | Ignored for one-shot sampler authoring; conflict probes show it does not drive the loaded root/key byte when `pitch.keycenter` differs. |
| `lokey` | Ignored for one-shot sampler authoring. |
| `pitch.keycenter` | Written as the sampler root/key byte at `track+0x3957`. Conflict probes confirm this field wins over `hikey`; `lokey` does not participate. |

## Unsupported preset types

Synth engine presets and multi-zone sampler presets require an implementation
of the complete firmware apply behavior and device qualification before this
adapter can claim support.
The adapter rejects unsupported `type` values instead of silently producing a
partial or incoherent project state.

## Additional differences from full firmware application

The adapter ignores platform/version validation, preserves most omitted state,
rounds float values, excludes booleans from numeric fields, and compacts invalid
members of parameter arrays. Firmware uses presence-sensitive defaults, clears
all sample records, retains array positions, and has distinct integer/float
coercion. Sampler `sample.end` and crossfade denominator fallbacks in this API
also differ from the firmware's sentinel and zero-framecount rules. See the
[complete importer comparison](../logs/2026-10-23_preset_json_import.md#differences-from-upstream-adapter-at-7a74acc).
Use `tools/inspect_preset_state.py` for complete raw state inspection; the older
`patch_sound_state` reader exposes only its original subset.
