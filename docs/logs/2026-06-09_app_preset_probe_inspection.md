# 2026-06-09 App preset probe inspection

This log records an app-driven reverse-engineering pass. The external product
need was project inspection for a computer-side OP-XY library manager: show
which preset is assigned to each track/pattern without attempting note editing.

The work was AI-assisted. The resulting code and tests are intended to make the
finding reproducible from fixture files rather than rely on narrative claims.

## Capture families

Fixture subset:

- `src/preset-probes/2026-06-app-required/`
- `src/preset-probes/2026-06-phase-b/`

The A-series app-required captures isolate tracks 1-4 with nine active patterns
on the target track. Patterns P1-P9 use drum preset folders `pp` through `xx`.

The Phase B captures sweep engine/preset cases on track 1:

| Engine | Preset |
| --- | --- |
| Axis | `nt-accord` |
| Dissolve | `nt-cold brew` |
| Drum | `nt-aeroplane` |
| EPiano | `nt-crowded` |
| Hardsync | `nt-cabin pressure` |
| Multisampler | `bandpasser` |
| Organ | `nt-castle vania` |
| Prism | `nt-blip tips` |
| Sampler | `nt-106 bass` |
| Simple | `nt-dunce cap` |
| Wavetable | `nt-tall drink` |

## Finding

Active drum pattern bodies contain repeated preset/sample folder references such
as:

```text
/fat32/presets/drum/nt-aeroplane.preset
```

In the A-series captures, each active drum pattern body contains 24 hits for the
selected drum preset folder, one per drum region/sample slot. This is strong
evidence for project-level pattern-to-preset assignment.

Non-drum engines often expose selected preset identity as short path fragments
inside the active track body. These fragments can be split by NUL bytes and
commonly appear near byte marker `0xF7`, for example:

```text
wind/nt-acc\0ord
bell\0s/nt-crowded
synth/nt-cabin press\0ure
synth/nt-tall\0 drink
```

For read-only inspection, joining adjacent printable fragments across single
NUL bytes recovers useful preset names. Treat these as medium confidence until
the surrounding structure is decoded structurally (see
`ImageProject.set_preset()` regions in `xy/image_writer.py` and
`docs/format/decoded_image_map.md`).

## Implementation note

`xy.project_inspection` adds a conservative read-only parser over existing
`XYProject` and logical-entry extraction. It reports:

- tracks;
- patterns;
- active state;
- engine ID/name;
- body length;
- inferred preset references;
- hit count and confidence.

`tools/inspect_xy.py` now includes a `[Pattern Presets]` section when active
pattern preset references are found.

## Open questions

- Decode the exact structure around marker `0xF7`.
- Generalize category mapping beyond observed categories.
- Determine whether fragmented names always identify selected presets or can
  also include nearby browser/history/cache text.
- Expand fixture coverage for tracks 5-8 and auxiliary slots if product needs
  require it.
