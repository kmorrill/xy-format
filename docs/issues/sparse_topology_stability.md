# Sparse Multi-Pattern Topology Stability — RESOLVED (2026-06-09)

## Resolution

**Closed.** The crashes were never caused by sparseness. They were
incoherent serialized state produced by the scaffold/transplant writers
(scene-pool counts, tail bytes, or selection records that disagreed with
the actual record stream — see `docs/format/record_structure.md`).

The image writer (`xy/image_writer.build_arrangement`) constructs the
decoded RAM image directly from coherent state, then RLE-encodes it.
Sparse arrangements built this way load and play:

- **`09_i_tiesto_img_sparse_song.xy`** — Adagio for Strings, **T4-only**,
  6 patterns, 6 scenes, full song chain (exactly the
  `T3+T6`-style sparse shape that crashed before) → **device PASS**
  (loads, T4 plays, song mode advances scenes 1→6), user-verified.

The old mitigation ("always bootstrap full `T1..T8 × 9`") is obsolete.
Sparse is fine; coherent state is the actual requirement.

## Original Problem (historical)

Certain sparse multi-pattern exports crashed on device even when
parse/inspect looked valid (e.g. `u01_chase_u1_minphrases.xy`, T3+T6,
5 patterns). The working hypothesis at the time was a
topology/descriptor-branch dependency. With the serialization model
decoded, those crashes are explained as state-coherence failures of the
byte-patching writers, not a property of sparse topologies.

See `docs/state_of_understanding.md` for the full arc.
