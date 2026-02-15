# Scenes and Songs

## Scope
This document captures stable format findings for scene/song state from
`unnamed 149/150/151/152/154/155` and follow-up `b/nl/lp` probes.

## Where Scene/Song Data Lives
Scene/song state is not isolated to a fixed header field.
Current stable model is split storage:

1. Pre-track control bytes/records (before Track 1).
2. Track 16 control bytes (tail control region in normalized branch).

## Stable Findings

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
