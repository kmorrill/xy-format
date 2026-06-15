# 2026-06-15 Tonal Sampler Project-State Captures

Source files were exported from the OP-XY to the Desktop and normalized here by
modification-time order. Original names are preserved in this manifest.

| Normalized file | Original file | Interpreted step |
| --- | --- | --- |
| `smp00_fresh.xy` | `~/Desktop/unnamed.xy` | Fresh project / Track 7 default Axis state. |
| `smp01_t7_sampler_engine_only.xy` | `~/Desktop/unnamed1.xy` | Track 7 switched to tonal sampler engine, no sample loaded. |
| `smp02_t7_sample_loaded_default.xy` | `~/Desktop/unnamed2.xy` | Track 7 tonal sampler with `unnamed1-c4-0.wav` loaded from `/samples/user`. |
| `smp03_t7_sample_loaded_saved_preset.xy` | `~/Desktop/unnamed3.xy` | Same sample after saving preset `snapshot/2026-06-15 (1)`. |
| `smp04_reload_saved_preset_fresh_project.xy` | `~/Desktop/unnamed pre1.xy` | Fresh project with the saved sampler preset reloaded. |
| `smp06_project_loop_only.xy` | `~/Desktop/unnamed chg.xy` | Reloaded preset with loop/window controls changed in the project. |
| `presets/smp_default_2026-06-15.preset/` | `~/Desktop/2026-06-15 (1).preset/` | Saved preset folder, including `patch.json` and bundled WAV. |

The source WAV is mono 16-bit PCM at 44.1 kHz with 98,807 frames
(`2.2405 s`). `patch.json` records:

- `framecount = 98807`
- `sample.end = 98807`
- `loop.start = 19761`
- `loop.end = 79045`
- `pitch.keycenter = 60`
- `hikey = 60`

## Initial Findings

Track 7 starts at decoded-image offset `0x1B071` in this single-pattern
capture family.

For the tonal sampler, project-local sample/window values are in the
pre-sample gap immediately before the nominal 24 x 128-byte sample table:

| Track-relative offset | Default-loaded value | Meaning / current theory |
| --- | ---: | --- |
| `+0x393F` | `98807` (`0x181F7`) | sample frame count |
| `+0x3943` | `0` | sample/window start |
| `+0x3947` | `98807` (`0x181F7`) | sample/window end |
| `+0x394B` | `19761` (`0x04D31`) | loop start |
| `+0x394F` | `79045` (`0x134C5`) | loop end |
| `+0x3953` | `9880` (`0x2698`) when loaded from `/samples/user`; `0` after preset save/load | unknown, possibly derived preview/crossfade/default window helper |

The 8-byte slot header begins at `+0x3957`, followed by the sample path at
`+0x395F`.

Direct sample load:

```text
+0x395F: /fat32/samples/user/unnamed1-c4-0.wav
```

Saved/reloaded preset:

```text
+0x395F: /fat32/presets/snapshot/2026-06-15 (1).preset/unnamed1-c4-0.wav
+0x453F: snapshot/2026-06-15 (1)
```

The loop/window edit from `smp04` to `smp06` changes only the pre-slot window
values:

| Offset | Before | After |
| --- | ---: | ---: |
| `+0x3943` | `0` | `8037` (`0x1F65`) |
| `+0x3947` | `98807` | `95729` (`0x175F1`) |
| `+0x394B` | `19761` | `32586` (`0x7F4A`) |
| `+0x394F` | `79045` | `75967` (`0x128BF`) |

This strongly suggests the audible sampler bug belongs to the project-local
pre-slot window block, not only to the preset folder or the sample-table path.
