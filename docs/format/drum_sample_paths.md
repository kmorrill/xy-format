# Drum sampler — per-voice sample path strings

> Storage: 24 slots × 128 bytes at **track struct `+0x3957`**; path string at
> **slot `+0x08`** (null-padded). See `decoded_image_map.md` § drum sampler.

Read API: `xy/drum_sample_inspection.py`  
Fixtures: `src/drum-sample-probes/`
Capture logs: `docs/logs/2026-06-12_drum_sample_path_inspection.md`,
`docs/logs/2026-06-12_round0_nt-z-fx_sample_paths.md`

## Track kit vs per-voice path

A drum track has two related concepts:

1. **Track kit identity** — short label near `+0x453F` (e.g. `drum/pp`). Stays
   `pp` when you swap individual pad samples.
2. **Per-voice sample assignment** — each of 24 slots has its own path at
   `+0x08`. Slots can mix path families (see below).

Swapping one pad’s sample changes **one slot**; other slots and the track kit
string typically stay on the loaded kit.

## Pad index vs voice index (kit `pp`)

On kit **`pp`**, the **leftmost keyboard pad (low F)** is **voice 23** (MIDI
key 53), not voice 0. Next pad right → voice 0 (F#3), then voice 1 (G3), etc.
Only voices **0–23** exist.

Evidence: round 0 and round 1 probe captures (same map in both).

## Path families (device-validated)

### A — Kit-embedded (default slots on loaded drum kit)

```text
/fat32/presets/drum/<kit>.preset/unnamed-<opaque>.wav
```

Example: `/fat32/presets/drum/pp.preset/unnamed-f#2-31.wav`

- `<kit>` is the drum preset bundle name (`pp`, etc.).
- `unnamed-…` is the internal sample id inside that bundle (common on
  user-created kits).

### B — User preset sample (cross-category nested path)

When a pad sample is picked from a **user preset** (e.g. FX bank) while the
track still uses drum kit `pp`:

```text
/fat32/presets/<category>/<preset>.preset/unnamed-<opaque>.wav
```

Example: `/fat32/presets/fx/nt-z-fx.preset/unnamed-a2-3.wav`

- Category reflects the **source preset type** (`fx`), not the track’s drum kit.
- `nt-z-fx` is the **preset bundle name** in the path.
- Track kit string remains `drum/pp`.

Fixture evidence: `src/drum-sample-probes/archive-round0-nt-z-fx/`.

### C — Built-in / library-relative

When a pad sample is picked from the factory sample browser (e.g. `perc/chi box`):

```text
content/samples/<folder>/<display name>.wav
```

Example: `content/samples/perc/chi box.wav`

- `<folder>` is a sample library category (`perc`), **not** a `.preset` file.
- Does **not** use `/fat32/presets/...`.

Fixture evidence: `src/drum-sample-probes/2026-06-sample-paths/` (round 1).

## Quick reference

| UI action | Typical slot path shape | Track kit `+0x453F` |
|-----------|-------------------------|---------------------|
| Load drum kit `pp` | Family A on all slots | `drum/pp` |
| Change pad → sample from user preset `nt-z-fx` | Family B on that slot only | still `drum/pp` |
| Change pad → built-in `perc/chi box` | Family C on that slot only | still `drum/pp` |

## Open gaps

- Full pad→voice map for kits other than `pp`.
- Whether family B can use non-`unnamed` sample ids inside user presets.
- Sampler / multisampler path layout on non-drum engines.
