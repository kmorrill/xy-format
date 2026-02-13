# read_xy_header.py

`tools/read_xy_header.py` dumps fixed header fields for one or many `.xy` files.

## Usage
- Single file: `python tools/read_xy_header.py 'src/one-off-changes-from-default/unnamed 1.xy'`
- Glob: `python tools/read_xy_header.py 'src/one-off-changes-from-default/*.xy'`

## Output Fields
- Tempo (raw + BPM).
- Groove type and amount.
- Metronome level byte.
- 32-bit words at `0x0C`, `0x10`, and `0x14`.

## Purpose
Fast consistency checks while refining `docs/format/header.md`.
