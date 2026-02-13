# OP-XY Project Format Lab

This repo is our working notebook for reverse-engineering Teenage Engineering’s OP-XY project container. We captured a corpus of minimally changed `.xy` files plus the official manual breakdown so we can diff, decode, and eventually round-trip projects off-device.

## Mission
- Document how every byte inside an `.xy` project maps to sequencer data, track engines, sampler metadata, scenes, songs, MIDI routing, and global mix controls.
- Build tooling that inspects, compares, and (eventually) writes projects so we can automate edits without the hardware.
- Keep stable format facts in `docs/format/*` and chronology/debug history in `docs/logs/*`.

## Reference Material
- `docs/index.md` — navigation index for canonical docs, workflows, and logs.
- `docs/OP-XY_project_breakdown.txt` — plaintext dump of the official format expectations.
- `src/one-off-changes-from-default/op-xy_project_change_log.md` — UI action log describing what changed in each capture.
- `src/one-off-changes-from-default/*.xy` — baseline (`unnamed 1.xy`) plus one-change samples for tempo, trigs, engines, automation, etc.

## Repo Layout
- `tools/` — helper scripts (e.g., `inspect_xy.py`, `read_xy_header.py`) for parsing header, pattern, and track blocks.
- `tests/` — growing regression suite for inspectors and future writer once we can serialize bytes back out.
- `output/` — scratch space for parsed JSON, hexdump diffs, or notebook artifacts.
- `xy/` — any working assets or reconstructed projects.
- `AGENTS.md` — compact operating index + links to canonical docs.

## How to Get Involved
1. Read `AGENTS.md` for operating rules, then `docs/roadmap.md` for current priorities.
2. Use `docs/format/*` for canonical format behavior and `docs/logs/*` for discovery history.
3. Use the change log to pick a capture. Run `python tools/inspect_xy.py path/to/file.xy` to see how the inspector currently interprets it.
4. Compare tool output to the logged UI change and file notes/TODOs whenever the inspector misses data or crashes.
5. If you hit a crash, follow `docs/workflows/crash_capture.md` (artifact, metadata, corpus record, follow-up pass file).
6. When adding tooling, keep scripts deterministic and small so outputs remain corpus-diff friendly.

## Writer Prototype Status
- `xy/writer.py` plus `tools/write_xy.py` (single-trig Track 1 path) remains experimental. This path is still missing key structure for general device-safe authoring and should be treated as crash-prone.
- `xy/project_builder.py` has a separate constrained known-good profile for validated multi-pattern topologies (notably `T1+T3` scaffold-compatible paths).
- Keep these two paths conceptually separate when evaluating writer status, tests, and docs.

## Housekeeping
- `.gitignore` hides OS junk (`.DS_Store`), Python caches, and virtualenv directories so experimental scripts don’t pollute the repo.
- Do **not** delete the captured `.xy` files; they are our canonical fixtures for diff-driven decoding.
- Prefer ASCII in new docs/code and leave non-default files untouched unless you are extending the decoder with proof from the change log.
