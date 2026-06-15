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
