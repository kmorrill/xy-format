# OP-XY Project Format Lab

This repo is our working notebook for reverse-engineering Teenage Engineering’s OP-XY project container. We captured a corpus of minimally changed `.xy` files plus the official manual breakdown so we can diff, decode, and eventually round-trip projects off-device.

## Mission
- Document how every byte inside an `.xy` project maps to sequencer data, track engines, sampler metadata, scenes, songs, MIDI routing, and global mix controls.
- Build tooling that inspects, compares, and (eventually) writes projects so we can automate edits without the hardware.
- Keep a living log (see `AGENTS.md`) of discoveries, hypotheses, and outstanding questions as the format map grows.

## Reference Material
- `docs/OP-XY_project_breakdown.txt` — plaintext dump of the official format expectations.
- `src/one-off-changes-from-default/op-xy_project_change_log.md` — UI action log describing what changed in each capture.
- `src/one-off-changes-from-default/*.xy` — baseline (`unnamed 1.xy`) plus one-change samples for tempo, trigs, engines, automation, etc.

## Repo Layout
- `tools/` — helper scripts (e.g., `inspect_xy.py`, `read_xy_header.py`) for parsing header, pattern, and track blocks.
- `tests/` — growing regression suite for inspectors and future writer once we can serialize bytes back out.
- `output/` — scratch space for parsed JSON, hexdump diffs, or notebook artifacts.
- `xy/` — any working assets or reconstructed projects.
- `AGENTS.md` — detailed reverse-engineering log; start here for the full narrative, offsets, and hypotheses.

## How to Get Involved
1. Read `AGENTS.md` to learn the current state of format knowledge and the immediate decoding targets.
2. Use the change log to pick a capture. Run `python tools/inspect_xy.py path/to/file.xy` to see how the inspector currently interprets it.
3. Compare the tool output to the logged UI change and file fresh notes or TODOs whenever the inspector misses data or crashes.
4. When adding tooling, keep scripts deterministic and small so we can diff outputs across the sample set.

## Writer Prototype Status
- `xy/writer.py` plus the CLI wrapper `tools/write_xy.py` can promote the baseline (`unnamed 1.xy`) into the firmware’s “touched” state and author a single quantized trig on Track 1 by replaying reference slabs captured from `unnamed 53.xy`/`unnamed 81.xy`. Tests under `tests/test_writer_roundtrip.py` guard the exact bytes we currently understand (pointer table rotation, slot descriptor, node/tail/slab contents).
- The effort is paused because several fundamentals remain unsolved: gate duration is still hard-coded to the 100 % case, the per-step mask slab is copied from a template instead of being derived, and multi-note/tail-linked events are still undecoded by the inspector. Until those gaps close we risk baking incorrect assumptions into the writer, so it stays limited to the happy-path Track 1 trig for now.
- Current writer outputs crash the device when the project is opened, which confirms we are still missing critical structure (probably checksums, slot linkages, or automation tables) even for the simple cases above. Treat writer-generated files as experimental artifacts only.

## Housekeeping
- `.gitignore` hides OS junk (`.DS_Store`), Python caches, and virtualenv directories so experimental scripts don’t pollute the repo.
- Do **not** delete the captured `.xy` files; they are our canonical fixtures for diff-driven decoding.
- Prefer ASCII in new docs/code and leave non-default files untouched unless you are extending the decoder with proof from the change log.
