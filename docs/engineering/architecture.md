# Architecture Notes

## Reader/Writer Architecture Principles
- Keep container parsing separate from subsystem payload decoding.
- Hard-validate expected section sizes and version-sensitive layouts.
- Preserve unknown bytes as opaque blobs for byte-stable round-trips.
- Split parsing by subsystem (header, pre-track, tracks, scenes/songs, globals).
- Use decode->encode byte comparison as a first-line regression check.

## C++ Mental Model Resources
- Long-form hypotheses and reconstructed in-memory model: `docs/cpp_hypotheses.md`
- Legacy synthesis notes snapshot: `docs/logs/2026-02-13_agents_legacy_snapshot.md`
