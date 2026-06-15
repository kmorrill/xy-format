# Tonal Sampler Project-State Capture Analysis

Corpus added:

- `src/sampler-project-state/2026-06-15/`
- Saved preset folder:
  `src/sampler-project-state/2026-06-15/presets/smp_default_2026-06-15.preset/`

This capture set covers Track 7 switched from the default Axis engine to the
tonal sampler engine, loading `unnamed1-c4-0.wav`, saving that as a preset,
reloading the preset in a fresh project, and then changing the project-local
loop/window controls.

## Main Result

The tonal sampler's project-local sample/window values are not stored in the
same slot-tail positions used by the drum sampler start/end/gain model. In
this capture family they live in the track pre-sample gap:

```text
track+0x393F  frame count
track+0x3943  sample/window start
track+0x3947  sample/window end
track+0x394B  loop start
track+0x394F  loop end
track+0x3953  unknown derived/helper value
track+0x3957  8-byte tonal sampler slot header
track+0x395F  sample path string
```

The saved preset `patch.json` gives direct semantic anchors:

| Preset field | Value | Project offset |
| --- | ---: | --- |
| `framecount` | `98807` | `track+0x393F` |
| `sample.end` | `98807` | `track+0x3947` |
| `loop.start` | `19761` | `track+0x394B` |
| `loop.end` | `79045` | `track+0x394F` |
| `sample` | `unnamed1-c4-0.wav` | path at `track+0x395F` |

The `smp04 -> smp06` loop/window edit changes only four values in that
pre-slot block:

| Offset | Before | After |
| --- | ---: | ---: |
| `track+0x3943` | `0` | `8037` |
| `track+0x3947` | `98807` | `95729` |
| `track+0x394B` | `19761` | `32586` |
| `track+0x394F` | `79045` | `75967` |

This is the strongest evidence so far that tonal sampler audibility depends on
project-local window values in `track+0x393F..+0x3956`.

## Unique Preset Alignment Capture

The generated preset `t7-map-unique.preset` used deliberately distinct values
across envelopes, FX, LFO, modulation routing, highpass/width, and sampler
window fields. Loading it on Track 7 and exporting `~/Desktop/unnamed x.xy`
produced `src/sampler-project-state/2026-06-15/smp07_t7_unique_sampler_preset_loaded.xy`.

The preset identity and bundled sample path are project-local:

```text
0x453F: snapshot/t7-map-unique
+0x395F: /fat32/presets/snapshot/t7-map-unique.preset/unnamed1-c4-0.wav
```

The copied q16 field map is:

| Project offset | Meaning | Evidence |
| --- | --- | --- |
| `+0x3877..+0x3883` | amp envelope attack/decay/sustain/release | exactly matches preset values `3328, 6656, 9984, 13312` |
| `+0x3887` | poly playmode enum | remains `0x15555555` |
| `+0x388B` | portamento amount | matches `2560` |
| `+0x388F` | pitch-bend range | matches `4096` |
| `+0x3893` | engine volume | matches `29696` |
| `+0x3897..+0x38B3` | FX params | params 0-4 and 6-7 match; lane 5 serialized as `0x7FFFFFFF` instead of preset `16896` |
| `+0x38B7..+0x38D3` | LFO params 0-7 | exactly matches preset values `1280..19200` |
| `+0x38D7..+0x38E3` | filter envelope attack/decay/sustain/release | exactly matches preset values `16640, 19968, 23296, 26624` |
| `+0x38FF..+0x3913` | modwheel/aftertouch/pitchbend targets and amounts | exactly matches preset values |
| `+0x3917` | velocity sensitivity | matches `26624` |
| `+0x391B` | portamento type | matches `30720` |
| `+0x3923` | width | matches `22528` |
| `+0x392F` | highpass | matches `29184` |
| `+0x3933..+0x3937` | velocity target/amount | exactly matches preset values `12288, 18432` |

The sampler frame/window values also align directly:

| Preset field | Value | Project offset |
| --- | ---: | --- |
| `framecount` | `98807` | `+0x393F` |
| `sample.end` | `88926` | `+0x3947` |
| `loop.start` | `24701` | `+0x394B` |
| `loop.end` | `74105` | `+0x394F` |

`+0x3943` remained `0`, consistent with sample/window start. `+0x3953`
became `0x02A73100`, so it is not a raw copy of `loop.crossfade = 2048`.
It remains a derived/helper field.

Important negative result: the generated preset's `engine.params` values
(`2048, 5120, 8192, ...`) did not populate `+0x3857..+0x3876`; all eight
lanes stayed centered at `0x40000000`. For tonal sampler tracks, sampler
start/end/loop state must be authored in the pre-slot sampler window block,
not through `engine.params`.

## Path Behavior

Direct sample load stores the sample path as:

```text
/fat32/samples/user/unnamed1-c4-0.wav
```

Saving and reloading the preset repoints the project path to the preset folder:

```text
/fat32/presets/snapshot/2026-06-15 (1).preset/unnamed1-c4-0.wav
```

The track preset label at `track+0x453F` becomes:

```text
snapshot/2026-06-15 (1)
```

So packaging samples alongside the preset folder is valid, but the generated
project also needs the pre-slot sample/window block to be coherent.

## Open Questions

1. `track+0x3953` is `0x2698` after direct sample load but `0` after
   preset save/load. It may be a derived helper, preview/cache value, or
   default crossfade/window helper. It is not pinned yet.
2. The 8-byte slot header at `track+0x3957` is `3c 00 3c 80 00 00 00 00`
   for this one-zone tonal sampler. It likely includes root/key/flag state,
   but needs a pitch/key-range capture to label confidently.
3. This capture set does not include a start/end-only project edit separate
   from loop changes. One more capture changing only start/end would confirm
   whether `+0x3943/+0x3947` are exactly start/end independent of loop mode.

## Immediate Implementation Implication

Generated tonal sampler presets/projects should copy or set the full
`track+0x393F..+0x3956` pre-slot block together with the path at
`track+0x395F`, not only the slot path or drum-style slot tail fields.
