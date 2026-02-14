# OP-XY Project Format Lab

This project helps you edit OP-XY `.xy` project files outside the device.

The goal is simple: make safe, repeatable edits to real projects without breaking them.

## What This Is

Think of this repo as a research + tooling workspace:
- We collected many real OP-XY project files with one small change each.
- We compare those files to learn what each part of the format means.
- We use that knowledge to build tools that can read files and make limited safe edits.

## Why Off-Device Editing Is Useful

Editing `.xy` files on a computer is interesting because it can unlock workflows
that are slow or awkward on the hardware alone:

- **MIDI -> OP-XY conversion**: turn MIDI clips into OP-XY-ready project data.
- **OP-XY -> DAW export**: move patterns back out to Ableton (or other DAWs) for arranging, mixing, or collaboration.
- **Whole-pattern visibility**: see an entire pattern at once instead of paging through bars on the device.
- **At-a-glance modulation view**: inspect all parameter locks and step components affecting a pattern in one place.

The long-term goal is to make these workflows reliable enough for real music production, not just reverse-engineering experiments.

## Who This Is For

- Musicians who want to batch-edit projects or generate project variations.
- Technical users who want to script OP-XY edits instead of clicking everything by hand.

You do not need to understand byte offsets to use the safer workflows.

## What You Can Expect To Work (As of 2026-02-13)

- Open and re-save project files while preserving unknown data.
- Read key project info reliably (including core note/event data in common cases).
- Change transport settings like tempo/groove/metronome with high confidence.
- Build edited `.xy` files from a simple JSON "edit recipe" in constrained modes.
- Do tested multi-pattern edits for known-safe track combinations:
  - Track 1 only, Track 2 only, Track 3 only, Track 4 only, Track 7 only
  - Track 1 + Track 2
  - Track 1 + Track 3
  - Track 1 + Track 4
  - Track 1 + Track 2 + Track 3
  - Any T3+-only combination via Scheme A encoder (T5, T6, T8, T3+T7, etc.)
- Clone pattern bodies are byte-identical to leaders except for the note event bytes.
  This is confirmed across a 9-pattern x 8-track specimen (n110), which means
  authoring multiple patterns per track is: copy the leader body, change only the
  note bytes for each clone.

Current automated test status in this repo:
- `909 passed, 14 skipped` (`pytest -q`)

## What Is Risky

- Using older "general writer" scripts as if they can safely generate any project.
- Making multi-pattern edits outside the known-safe combinations above.
- Assuming every note timing/gate value is fully decoded in all advanced event types.
- Large edits that combine many changes at once before device-testing.

Risk here means: file may still load, may load with wrong behavior, or may crash on device.

## What Is Not Ready Yet

- Arbitrary pattern counts on arbitrary track combinations (descriptor Scheme B
  is not fully generalized — only known topologies are safe).
- Fully reliable from-scratch project generation for every OP-XY feature.
- Reliable scene/song authoring coverage.
- Reliable sample-path and related asset-directory authoring.
- Full firmware package manipulation workflows.

## Recommended Real-World Workflow

1. Start from a real OP-XY project file that is close to what you want.
2. Make small edits (tempo first, then notes, then multi-pattern if needed).
3. For multi-pattern edits, keep strict/safe mode enabled.
4. Inspect the result and diff against the source before device load.
5. Test on hardware in small steps and log pass/crash outcomes.

If your main goal is "make music, not reverse engineer," this workflow is the safest path.

## Repo Guide (Plain English)

- `docs/index.md`: map of all docs.
- `docs/roadmap.md`: what we are working on now.
- `docs/issues/index.md`: current known problems.
- `docs/format/`: stable format knowledge (deeper technical detail).
- `docs/workflows/crash_capture.md`: what to do if a file crashes on device.
- `tools/inspect_xy.py`: inspect what a file currently contains.
- `tools/build_xy_from_json.py`: build a file from a JSON edit recipe.
- `tools/capture_9pat.py`: interactive MIDI harness for multi-pattern device captures.
- `src/one-off-changes-from-default/`: the key fixture files used for learning and testing.

## House Rules

- Do not delete fixture `.xy` files in `src/one-off-changes-from-default/`.
- Keep edits deterministic and easy to diff.
- Record crashes with artifacts and notes so regressions can be prevented.
