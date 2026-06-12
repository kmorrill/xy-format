# 2026-06-12 Round 0 — `nt-z-fx` user-preset sample paths on a `pp` drum kit

Decoded analysis of archived captures in
`user_probes/.../archive-round0-nt-z-fx/` (also copied to
`src/app-sample-probes/archive-round0-nt-z-fx/`).

## Operator intent

- Start from drum kit preset **`pp`** on track 1.
- For three pads, replace the default sample with a sample from the **user FX
  preset `nt-z-fx`** (samples inside that preset still named `unnamed-…`).
- UI showed shorthand like `nt-z-fx/unnamed-a2-3`; the project file stores a
  longer canonical path (below).

## Decoded results (authoritative)

| File | Pad | Voice | MIDI key | Path in voice slot `+0x08` |
|------|-----|-------|----------|----------------------------|
| `c0-baseline-pp.xy` | — | — | — | 24× `/fat32/presets/drum/pp.preset/unnamed-….wav` |
| `c0-pad01-lowf-v23-nt-z-fx-a2-3.xy` | 1 (low F) | 23 | 53 F3 | `/fat32/presets/fx/nt-z-fx.preset/unnamed-a2-3.wav` |
| `c0-pad02-v00-nt-z-fx-a3-3.xy` | 2 | 0 | 54 F#3 | `/fat32/presets/fx/nt-z-fx.preset/unnamed-a3-3.wav` |
| `c0-pad03-v01-nt-z-fx-b2-4.xy` | 3 | 1 | 55 G3 | `/fat32/presets/fx/nt-z-fx.preset/unnamed-b2-4.wav` |

Each variant differs from baseline in **exactly one** of 24 voice slots.

## Where `nt-z-fx` lives in the file

`nt-z-fx` appears **only in the changed voice slot path** (and nowhere in
baseline). There is no separate “preset name” field in the slot beyond the path
string itself.

Example breakdown:

```text
/fat32/presets/fx/nt-z-fx.preset/unnamed-a2-3.wav
|          |  |  |            |  |
|          |  |  |            |  +-- sample id inside preset bundle
|          |  |  +-- user preset bundle name
|          |  +-- preset category (fx, not drum)
|          +-- presets root
+-- device volume prefix
```

Compare to unchanged slots on the same file:

```text
/fat32/presets/drum/pp.preset/unnamed-f#2-31.wav
```

## Kit preset vs per-pad sample source

This is the answer to “start with preset `pp`, then tune with other stuff”:

| Layer | What it stores | In these captures |
|-------|----------------|-------------------|
| **Track kit identity** | Short string ~`+0x453F` | Always `drum/pp` |
| **Per-voice sample slot** | Path at slot `+0x08` | Either `…/drum/pp.preset/…` **or** `…/fx/nt-z-fx.preset/…` |
| **Engine** | Drum sampler | Unchanged |

Swapping one pad’s sample to content from **`nt-z-fx`** does **not** change the
track-level kit string to `nt-z-fx`. It changes **only that voice’s path** to
point into the **fx preset bundle** where that wav lives.

So the device represents “I’m still on kit pp, but pad X now plays this sample
from over there” as a **cross-category preset-nested path** in the one slot.

## Three path families (compare round 0 vs round 1)

| Source | Example path | Preset name in path? |
|--------|--------------|----------------------|
| Kit default (`pp`) | `/fat32/presets/drum/pp.preset/unnamed-f#2-31.wav` | Yes — `pp` |
| User preset sample (`nt-z-fx`) | `/fat32/presets/fx/nt-z-fx.preset/unnamed-a2-3.wav` | Yes — `nt-z-fx` (category `fx`) |
| Built-in library (`perc/chi *`) | `content/samples/perc/chi box.wav` | No — library folder only |

Round 1 (`c1-*`) proves the built-in library shape. Round 0 (`c0-*`) proves the
user-preset-nested shape. Both use the **same pad→voice map** on kit `pp`.

## Tests

`tests/test_drum_sample_inspection_round0.py` locks the four paths above.

## Why round 0 was superseded for primary tests

`unnamed-…` filenames are hard to verify on hardware. Round 1 uses built-in
`chi *` names for human-readable probes. Round 0 remains valuable as evidence
for **user-preset-nested** paths and is fully decoded.
