# Inspector Sweep Workflow

## Goal
Compare `inspect_xy.py` output against the one-off change log to catch decode gaps, regressions, and crashes.

## Procedure
1. Run `python tools/inspect_xy.py '<path/to/file>'` for every file listed in `src/one-off-changes-from-default/op-xy_project_change_log.md`.
2. Compare each report section against the corresponding human annotation in the change log.
3. Record mismatches and missing fields directly in docs/issues and/or logs before parser changes.
4. If a generated file crashes on device, follow `docs/workflows/crash_capture.md`.

## Suggested Follow-up
- File or update issues for each decode gap.
- Add regression tests for any bug fixed during the sweep.
