# OP-XY Format Lab Guidelines

## Companion Repositories

- `/Users/kevinmorrill/Documents/op-xy-live` is the musical generation repo. It builds OP-XY preset packs, drum kits, full-track plans, and rendered `.xy` exports using this repo's format knowledge.
- This repo is the source of truth for byte-level `.xy` structure: RLE encoding, decoded-image offsets, track/pattern structs, scenes, songs, p-locks, step components, sample tables, and device-capture evidence.
- When `op-xy-live` discovers a stable low-level format fact, move or mirror that finding into `docs/format/*` here. When this repo exposes a higher-level authoring capability, document how `op-xy-live` should consume it.

## High-Value Cross-Repo Docs

- `/Users/kevinmorrill/Documents/op-xy-live/docs/op-xy-file-map-decoded-vs-mystery.md` - worked map of a generated `.xy` file, with decoded versus mysterious regions.
- `/Users/kevinmorrill/Documents/op-xy-live/docs/op-xy-project-sound-state-capture-plan.md` - device capture protocol for preset-to-project sound-state questions, especially sampler start/end/loop fields.
- `/Users/kevinmorrill/Documents/op-xy-live/docs/op-xy-track-generation-tools.md` - high-level generation architecture that should stay above raw byte manipulation.

## Local Source Of Truth

- `docs/format/record_structure.md` - canonical RLE and record model.
- `docs/format/decoded_image_map.md` - canonical decoded-image field map.
- `docs/engineering/authoring.md` - canonical image-authoring workflow using `xy/rle.py` and `xy/image_writer.py`.
- `docs/state_of_understanding.md` - dated belief ledger; read before changing format claims.
- `AGENTS.md` - repo map, operating norms, and device-validation rules.

