# Spatial Variance Analyzer

`tools/analyze_spatial_variance.py` scans decoded OP-XY project images for
variance inside regions that are not fully decoded yet. It exists to prioritize
reverse-engineering work: high variance in a plausible region is a good place
to mine the corpus or design surgical captures.

The tool decodes each `.xy` with `xy/rle.py`, detects track structs by decoded
signature, and only samples track-relative regions that fit inside the next
detected track boundary. It does not inspect raw RLE bytes.

## Usage

```bash
python3 tools/analyze_spatial_variance.py src output \
  --md-out docs/logs/YYYY-MM-DD_spatial_variance_index.md \
  --json-out /tmp/opxy-spatial-variance.json
```

You can pass individual files or directories. Duplicate resolved paths are
deduplicated.

## Output

The Markdown report contains:

- corpus counts: decoded files, track structs, sample-slot observations, and
  decode errors;
- a summary table for every tracked opaque/partial region;
- a ranked list of highest-yield regions;
- per-region top variable offsets, including distinct value counts and common
  byte values;
- top engine ids and preset labels for track and slot regions.

The JSON output has the same summary data for follow-up scripts.

## Interpretation Rules

- Treat this as a variance index, not a semantic decoder.
- High broad-variance regions are best for corpus mining.
- Mostly-zero or narrow-variance regions need paired device captures.
- Slot-tail stats skip voice 23, because its nominal 128-byte region overlaps
  the preset-label string.
- Promote a byte to `docs/format/decoded_image_map.md` only after paired
  captures or writer/device validation.

See `docs/format/spatial_coverage_ledger.md` for the canonical spatial map and
`docs/logs/2026-06-15_spatial_variance_index.md` for the first full-corpus
report.
