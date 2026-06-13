# 2026-06-13 — Global header inspection

Fixture pack: `src/project-config-probes/2026-06-global-header/`

Firmware 1.1.4 probe pack targeting the remaining checklist §2 rows.

## Decoded fields

| Field | Offset | Encoding | Fixtures |
| --- | --- | --- | --- |
| Groove amount | `0x02` | signed i8; default `0`, right clicks `+2/+4`, left clicks `-2/-4`, min `-127`, max `+127` | `hdr-grv-*` |
| Click volume / metronome persistence | `0x04` | baseline `0xA8`, min/off `0x00`, max `0xFF`; no independent on/off bit moved | `hdr-mclk-*` |
| Active scene | `0x06` | zero-based scene slot; scene 2 = `0x01`, scene 3 = `0x02` | `hdr-arr-act*` |
| Active song | `0x07` | explicit zero-based song slot; Song 2 = `0x01`; fresh/default Song 1 = `0x10` sentinel | `hdr-arr-song*` |
| Project display name | outside decoded image | no ASCII project/file name string appears in decoded image; project-list name is external filename | `hdr0` decode search |

## Arrange notes

Scene count is not stored at `0x06`. Adding scene 2/3 while staying on scene 1
changes the scene row area (`0x95 + slot*33`) but leaves `0x06` at `0`.
Switching active scene changes only `0x06` in same-branch comparisons.

Present scene count should be read from scene row flags. `0x07` is song
selection, not active scene.

## Code

- Read API: `xy/project_config_inspection.py`
- Scene read model: `xy/scene_volume_inspection.py`
- Writer helpers: `ImageProject.set_groove_amount`, `set_active_scene`,
  `set_active_song`
- Human report: `[Project Config]` and `[Scene Mix]` in `tools/inspect_xy.py`
- Tests: `tests/test_project_config_inspection.py`,
  `tests/test_scene_volume_inspection.py`, `tests/test_inspector_outputs.py`
