# Authoring `.xy` Files (Canonical)

> Established 2026-06-09 after the serialization-model breakthrough. This
> is the authoritative guide for **writing** `.xy` files. It supersedes
> the pre-RLE writer docs (`writer_alignment_and_type05_type07.md`,
> `writer_track1.md`, `json_authoring_bridge.md`) and the scaffold/
> transplant writer modules.

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

### `ImageProject` API

```python
p = ImageProject.from_file("src/one-off-changes-from-default/unnamed 1.xy")

# global project settings
p.set_tempo(121.2)                       # BPM
p.set_groove(groove_type)                # groove enum
p.set_click_volume(0)
p.set_midi_channel(track, channel)       # 1..16, or None = off
p.set_master_eq(low=..., mid=..., high=...)

# sequencer content
p.set_bars(track, bars)                  # 1..4
p.add_note(track, step=9, note=60, velocity=100, gate=240)   # tick optional
p.set_track_scale(track, 2)              # 0.5 / 1 / 2 / 16 (or raw byte)

# instrument / sound
p.set_engine(track, engine_id)
p.set_engine_param(track, index, value)  # index 1..4, internal u32
p.set_filter(track, type=..., enabled=...)
p.set_preset(track, donor_path, donor_track)   # whole-instrument copy
p.set_track_block(track, offset, data)   # envelopes/filter/mod-routing blocks

# per-step modifiers
p.set_step_component(track, step, "pulse", value)   # 14 component names
p.set_plock(track, step, "cutoff", value)           # ~30 param names

# drum voices (24)
p.set_drum_voice(track, voice, tune=+7, play_mode=4, start=..., end=..., gain=...)

p.save("out.xy")
```

Every method above is validated by byte-exact replication of its device
capture (`tests/test_image_writer.py`). Component names:
`STEP_COMPONENTS`; p-lock param names: `PLOCK_PARAMS`.

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

## Legacy writers (superseded, retained)

These modules predate the RLE model. They produce valid output for their
**validated scopes** but encode the format via the old mental model
(manual byte patching, scaffolds, preamble/descriptor rules, the velocity
nudge). They remain for the tools/tests that still import them; **new work
should use `image_writer`.**

- `xy/writer.py` — Track 1 single-trig writer (known bugs)
- `xy/project_builder.py` — event-insertion recipe (type 05→07, pure-append / insert-before-tail)
- `xy/scaffold_writer.py` — scaffold-driven multi-pattern writer
- `xy/scene_patcher.py`, `xy/scene_records.py` — scene byte-patching
- `xy/json_build_spec.py` — JSON→bytes via the legacy path
- `xy/note_events.py`, `xy/step_components.py`, `xy/profiles.py` — legacy payload encoders

Migration target (`docs/roadmap.md` Tier 3): route `midi_to_xy` through
`spec_to_xy_image`, then retire the legacy stack.
