# Roadmap

> Rewritten 2026-06-09 after the serialization-model breakthrough
> (`docs/state_of_understanding.md`). The format is understood
> generatively: RLE codec round-trips the corpus, the image writer
> replicates device captures byte-exactly, and image-authored files —
> including the full Whitney arrangement (8×9 patterns, scenes, song
> chain) — load and play on device. No structural mysteries remain on
> the critical path; remaining work is field semantics and product.

## Tier 1 — Pure corpus lookups (no device needed)

Field-semantics sweeps in decoded space (`tools/analysis/decoded_diff.py`
× change log):

1. **P-locks**: map per-step parameter-lock storage from the CC capture
   corpus (unnamed 95–100, 122) against `docs/format/plocks.md`.
2. **Step-component slot byte order**: complete the 16-byte per-step
   slot map (which byte = which of the 14 component types + values)
   from unnamed 8/9 and 59–77.
3. **Engine/preset region**: engine ID field, preset path string
   location, param-block layout — from the engine-change one-offs
   (34, 85, 91, 94, 113, 116, 117, 122).
4. **Sample tables** (optional): per-drum-voice tune/level fields are
   not in the corpus, but `set_preset` already copies the whole table,
   so this is only for exposing per-voice tweaks — not a blocker.

## Tier 2 — Enum-value probes (cheap device looks, only as needed)

One tiny probe file + a glance at the device UI each:

1. Scene mute byte: value 2 = muted; is 1 solo? 3?
2. The note struct's two trailing flag bytes (always 0 in corpus —
   micro-timing? probability?).
3. Scene-row flag byte semantics (0x01 vs 0x00 visible behavior).
4. Limits certification pack: 99 scenes, 14 songs, 120-note patterns,
   full 9-pattern topology — confirm writer bounds match device bounds.

## Tier 3 — Product (device = acceptance testing, not discovery)

1. **Preset/instrument assignment from structs** (path string + param
   block) — unlocks authoring beyond baseline's default instruments.
2. **Custom sample kits** (after Tier 1 §4).
3. **midi_to_xy v2** on the image writer (replace scaffold/transplant
   paths; drop ghost placeholders and the velocity nudge).
4. Retire legacy code paths (`xy/writer.py`, descriptor lookups,
   preamble rules) and close superseded issue docs.

## Done (highlights)

1. 2026-06-09: serialization model (byte-level RLE over C structs);
   `xy/rle.py` round-trips 245/246 corpus files byte-exactly.
2. Decoded image map (`docs/format/decoded_image_map.md`): global
   header, 17,876-byte track structs, scene slots, song-table footer.
3. Crash ledger fully explained (preamble/tails/scene-edit/note==vel/
   event-types — all RLE artifacts or impossible-state writes).
4. `xy/image_writer.py`: byte-exact replication of device captures;
   device-verified probes incl. note==velocity; Whitney capstone plays
   end-to-end with scenes + song chain.

---

## Field-level status (supplement — does not replace tiers above)

Per-field read/write/inspect status with evidence links lives in
[`parse_capability_checklist.md`](parse_capability_checklist.md).

Recent contributor work (2026-06, pending upstream review) adds
read-only inspection modules and device probe fixtures. That progress is
tracked in the checklist and dated logs — not by rewriting this tier
list. See [`workflows/contributor_inspection_workflow.md`](workflows/contributor_inspection_workflow.md)
for how those contributions map back to Tier 1–3 items.
