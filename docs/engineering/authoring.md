# Authoring `.xy` Files (Canonical)

> Established 2026-06-09 after the serialization-model breakthrough. This
> is the authoritative guide for **writing** `.xy` files. It replaces the
> removed pre-RLE scaffold/transplant writer modules.

## The model in one paragraph

The `.xy` file is the firmware's ~290 KB project struct, RLE-compressed
(see `docs/format/record_structure.md` §0 and `docs/format/decoded_image_map.md`).
Authoring is therefore: **decode a known-good baseline to its RAM image,
edit fields/vectors the way the firmware would, re-encode.** No scaffolds,
donor transplants, descriptor schemes, preamble propagation, event-type
bytes, or velocity nudges — those were all artifacts of not knowing about
the RLE layer.

## Canonical writer stack

| layer | module | role |
|---|---|---|
| codec | `xy/rle.py` | `decode_project` / `encode_project`; the byte-level RLE (greedy-canonical, round-trips 245/246 corpus files byte-exact) |
| image edits | `xy/image_writer.py` | `ImageProject` (single-project edits) + `build_arrangement` (full multi-pattern/scene/song assembly) |
| spec compiler | `tools/spec_to_xy_image.py` | midi-to-xy spec JSON → image-authored `.xy` |
| diff workhorse | `tools/analysis/decoded_diff.py` | decoded-space field diffing |

The long-term authoring surface should be structured JSON that compiles into
decoded-image edits. `ImageProject` is the proven low-level substrate: it keeps
RLE, vector counts, clones, scenes, and field widths coherent. Higher-level
JSON adapters should call into those primitives rather than copy raw byte
ranges or invent a second serializer.

### `ImageProject` API

```python
p = ImageProject.from_file("src/one-off-changes-from-default/unnamed 1.xy")

# global project settings
p.set_tempo(121.2)                       # BPM
p.set_groove(groove_type)                # groove enum
p.set_groove_amount(-4)                  # signed amount
p.set_click_volume(0)
p.set_project_transpose(-12)
p.set_time_signature(0x11)               # raw enum
p.set_voice_allocation(1, 4)             # T1..T8; None/0 = auto
p.set_midi_channel(track, channel)       # 1..16, or None = off
p.set_active_scene(1)
p.set_active_song(1)
p.set_master_eq(low=..., mid=..., high=...)

# sequencer content
p.set_bars(track, bars)                  # 1..4
p.set_pattern_steps(track, steps)        # total active steps, incl. partial final bar
p.add_note(track, step=9, note=60, velocity=100, gate=240)   # tick optional
p.set_track_scale(track, 2)              # 0.5 / 1 / 2 / 16 (or raw byte)
p.set_default_step_length_ticks(track, 240)
p.set_track_quantization_ui(track, 99)
p.set_track_quantization_raw(track, 0xFF)
p.set_track_groove_ui(track, 14)         # displayed BAR groove value
p.set_plock_shape_raw(track, 0)

# instrument / sound
p.set_engine(track, engine_id)
p.set_engine_param(track, index, value)  # index 1..8, internal u32
p.set_m2_shift(track, play_mode=..., portamento=..., pitch_bend_range=...,
               engine_volume=...)       # raw current-value u32 lanes
p.set_filter(track, type=..., enabled=...)
p.set_sends(track, ext=..., tape=..., fx1=..., fx2=...)
p.set_lfo_current(track, cc40=..., cc41=...)
p.set_track_mix(track, pan=..., volume=...)
p.set_preset(track, donor_path, donor_track)   # low-level pristine donor copy
p.set_track_block(track, offset, data)   # envelopes/filter/mod-routing blocks

# per-step modifiers
p.set_step_component(track, step, "pulse", value)   # 14 component names
p.set_plock(track, step, "cutoff", value)           # ~30 param names
p.rotate_pattern(track, 1, pattern=1)    # notes + p-locks + components together

# drum voices (24)
p.set_drum_voice(track, voice, path="/fat32/presets/drum/kit.preset/kick.wav",
                 tune=+7, key_assignment=53, play_mode=4,
                 start=..., loop_start=..., end=..., gain=...)

# patch.json adapter for drum/sampler presets
from xy.patch_json import PatchJsonSoundPatchOptions, apply_patch_json_sound
apply_patch_json_sound(
    p, track, patch_json,
    PatchJsonSoundPatchOptions(preset_device_path="/fat32/presets/drum/kit.preset"),
)
```

Use `apply_patch_json_text(...)` or `apply_patch_json_file(...)` when starting
from serialized JSON instead of an already parsed object. See
`docs/format/patch_json_adapter.md` for the field-by-field coverage table.

```python
p.save("out.xy")
```

The core image-authoring paths are validated by byte-exact replication and
probe-specific regression tests (`tests/test_image_writer.py`,
`tests/test_project_config_inspection.py`, `tests/test_bar_menu_inspection.py`).
Component names: `STEP_COMPONENTS`; p-lock param names: `PLOCK_PARAMS`.

The M2 shift, send, LFO-current, and mix helpers write static/current u32
lanes. They do not create automation. To create step automation, use
`set_plock`/`automate_param`, which also writes the firmware's per-step and
master automation flags and seeds the sparse predecessor carry cell used by
firmware sequence shifts. Step 1 uses the lane current-value boundary rather
than a wraparound predecessor. `rotate_pattern` preserves that carry/cache
curve while moving the lock activation and step-component rows with the notes.

### `build_arrangement` (multi-pattern / scenes / songs)

```python
build_arrangement(base_path, track_patterns,
                  scenes=[{track: pattern_idx, ...}, ...],
                  scene_mutes=[[muted_track, ...], ...],
                  song_chain=[scene_id, ...], song_loop=True)
```

Patterns become clone structs; scenes are the 33-byte scene structs;
mutes use device value 2; the song chain writes the 14-slot footer table.

## Validation standard

Every authoring path is proven two ways:

1. **Byte-exact replication** of device captures (`tests/test_image_writer.py`,
   `tests/test_rle.py`): unnamed 2/19/81/92, j05, j06, the M-page captures,
   drum-voice tune.
2. **Device pass** of files authored from first principles
   (`output/image-probes/`, recorded in corpus lab): notes, note==velocity
   (the disproven "bug"), multi-pattern, scenes, songs, mutes, preset
   transfer, sparse arrangements, the full Whitney conversion.

The standard for any new feature: replicate a device capture byte-exact
before claiming it, then device-test one authored file.

## Why image-authoring is inherently safe

`rle.encode` handles all RLE escaping automatically, so problems the old
writers hand-patched simply cannot occur in image space:

- **note == velocity**: in the decoded image the bytes are written
  literally; `encode` emits the `[n][n][00]` escape. No nudge needed (and
  the nudge was musically destructive — it altered velocities to dodge a
  bug that never existed).
- **gate/tick "tokens"**: plain little-endian integers in the image;
  `encode` produces the zero-run forms.
- **"tail bytes" / "preamble propagation" / "descriptor schemes"**: all
  fall out of encoding a coherent image; nothing to compute.

The only authoring rule that matters: **build a coherent machine state**
(the firmware asserts rather than validates — a wrong file is an
*impossible* state, not bad syntax). Start from a real baseline, apply
edits, keep counts/selections/scene state consistent.

Preset-copy donors are part of that coherence rule. `ImageProject.set_preset()`
copies post-note-count storage as part of the device-validated preset identity
transfer, so its donor track must be a pristine single-pattern, zero-note
preset-load track. Do not pass generated arrangement tracks as preset donors;
if a workflow needs sound state from a generated project, copy only the known
sound identity ranges before `track+0x456F` and leave the target note vector
local.

For generated material, prefer JSON/spec-level construction over donor copying
wherever the fields are decoded. Preset-copy is a compatibility primitive for
loading a known-good device-authored sound state, not the organizing model for
future pattern, scene, drum, or sampler authoring.

## Removed Legacy Writers

The old scaffold, descriptor, preamble, event-type, profile, and velocity-nudge
writer stack has been deleted. If a feature cannot be expressed through
`ImageProject`, add a decoded-image method backed by byte-exact fixture
replication instead of restoring raw-byte patching.
