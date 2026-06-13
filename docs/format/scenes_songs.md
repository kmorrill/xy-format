# Scenes and Songs

> **Flat decoded image (canonical for read/write):** 33-byte scene slots @
> `GLOBAL+0x95 + slot×33` (`sel[16] + mute[16] + flags`). See
> [`record_structure.md`](record_structure.md) §4, [`image_coverage_map.md`](image_coverage_map.md),
> P2-D volumes, P2-E mutes. Sections below on RLE insertions and Track 16
> tail bytes are **supplemental** (older probe narrative).

## Scope
This document captures stable format findings for scene/song state from
`unnamed 149/150/151/152/154/155` and follow-up `b/nl/lp` probes.

## Where Scene/Song Data Lives
Scene/song state is not isolated to a fixed header field.
Current stable model is split storage:

1. Pre-track control bytes/records (before Track 1).
2. Track 16 control bytes (tail control region in normalized branch).

## Stable Findings

### 0) Flat Scene Slot Layout

Decoded-image scene rows are 33-byte slots at `GLOBAL+0x95 + slot×33`:

- `+0..15`: 0-based pattern selection per track.
- `+16..31`: mute byte per track (`0x00` unmuted, `0x02` muted in device probes).
- `+32`: row flag. Existing device fixtures and `build_arrangement` use `0x01`
  for populated/present rows and `0x00` for empty trailing rows.

Examples: single-scene mute probes flag only slot 0; clean two-scene volume
probes flag slots 0 and 1; the eight-scene mute baseline flags slots 0..7.
Use row flags, not global `0x06`, when counting populated scene rows. HDR
active-scene probes show `0x06` is the active scene slot (zero-based), while
present scene count is derived from these row flags.

### 0.1) Active Scene And Song Selectors

Firmware 1.1.4 HDR probes isolate:

- `GLOBAL+0x06`: active scene slot, zero-based (`hdr-arr-act2` changes only
  `0x06: 00 -> 01`; `hdr-arr-act3` changes only `0x06: 00 -> 02`).
- `GLOBAL+0x07`: active song slot when explicitly selected. Fresh/default
  Song 1 reads `0x10`; selecting Song 2 writes `0x01`.

Adding scenes while staying on scene 1 changes the scene rows, not `0x06`.

### 1) Loop Is Per-Song (Normalized Branch)
Loop toggles were isolated as Track 16 control-byte changes:

- Song 1 (`150 nl` <-> `150 lp`):
  - `track16+0x0169/+0x016A`: `01 00` (off) <-> `00 01` (on)
- Song 2 (`154 loop` <-> `154 nl`):
  - `track16+0x016E`: `00` (on) <-> `01` (off)
- Song 3 (`151 nl` <-> `151 lp`):
  - `track16+0x0171/+0x0172`: `00 01` (on) <-> `01 00` (off)

Note: Off/on polarity above follows user-confirmed capture intent labels.

### 2) Scene Count/List Uses Track 16 Control Bytes
For Song 2 arrangement captures:

- `154` (Song2 + Scene2) includes `track16+0x0163 = 0x02` with a short
  structural payload.
- `155` (Song2 with 3 arranged scenes) includes `track16+0x0163 = 0x03` with a
  larger structural payload.

This strongly indicates scene-count/list control in Track 16 tail bytes.

### 3) Scene Mute State Is Persisted
Mute probes (`150b/152b/154b/155b`) show:

- Variable-length pre-track record insertions.
- Coordinated Track `9..16` normalized-branch rewrites.

So mute state is serialized (not transient UI state).

## Normalized Branch Fingerprint
Several loop/mute operations enter a shared structural branch where Tracks
`9..16` are rewritten with `+8` bytes per track. This branch change can mask
small loop-only diffs unless compared within the same branch.

## Unknowns (Still Open)

1. Full pre-track record schema for scene/song/mute tokens is not fully decoded.
2. Universal deterministic rewrite rules for normalized-branch transitions are
   not fully modeled.
3. Complete scene timeline serialization (all edit orders and corner cases) is
   still partial.
4. Song-slot control offsets beyond tested songs (1-3) remain unverified.

## Authoring Guidance (Current)
Safe approach today: scaffold-driven, topology-constrained writes with
branch-aware patching. Avoid full free-form scene/song synthesis until the
unknowns above are closed.

## Related
- Narrative analysis log: `docs/logs/2026-02-14_scene_song_delta_probe.md`
- Test-plan tracking: `docs/engineering/known_good_test_plan.md`
