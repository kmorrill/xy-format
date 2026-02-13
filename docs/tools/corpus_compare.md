# corpus_compare.py

`tools/corpus_compare.py` performs structural two-file compares using indexed logical entries.

## Usage
- `python tools/corpus_compare.py <fileA.xy> <fileB.xy>`
- Example: `python tools/corpus_compare.py k03_song_safefix_12347.xy k04_song_safefix2_12347.xy`

## Output
- File-level deltas.
- Exact `(track,pattern)` field deltas (for example `pre1 0x64->0x2E`).
