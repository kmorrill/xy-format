# Crash Capture Workflow

## Goal
Capture every device crash in a reproducible way and preserve both the failing artifact and the follow-up file that fixes it.

## Required Immediately After A Crash
1. Preserve the exact failing `.xy` file under `output/crashes/` (do not overwrite it later).
2. Record the crash in corpus lab:
   - `python tools/corpus_lab.py record <path/to/crash.xy> crash --note "<short summary>"`
3. Add/update an entry in `docs/debug/crashes.md`.

## Required Crash Metadata
- Artifact path to the failing file.
- Template/source reference file used to generate it.
- Generation command or script + parameters.
- Device context (firmware/build if known, date, test action).
- Crash text/assertion, plus stack trace text if shown.
- Screenshot/photo path if available.
- Hypothesized root cause.

## Required Follow-Up
1. Create a follow-up candidate file and preserve it (for example in `output/crashes/` with a `_fix` suffix).
2. Test on device.
3. Record outcome in corpus lab:
   - pass: `python tools/corpus_lab.py record <path/to/fix.xy> pass --note "<what changed>"`
   - crash: `python tools/corpus_lab.py record <path/to/fix.xy> crash --note "<what changed>"`
4. Update the same crash entry in `docs/debug/crashes.md` with:
   - follow-up file path(s)
   - pass/crash result(s)
   - final resolution status

## Naming Guidance
- Keep names short and sortable.
- Recommended pattern:
  - failing: `output/crashes/YYMMDD_<short>_crash.xy`
  - follow-up: `output/crashes/YYMMDD_<short>_fix01.xy`
