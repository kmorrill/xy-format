# Scenes and Songs

Scenes and songs are decoded-image structs. Do not author them by editing
pre-track tokens or branch-specific raw bytes.

## Scene Rows

Scene rows are 33-byte records in the global header area:

```text
pattern selections[16]  mute values[16]  present flag[1]
```

`xy/image_writer.py` names the constants used by the current writer:

- `SCENE_SLOT0`: live selection row.
- `SCENE_SLOT_SIZE = 33`.
- `GLOBAL_ACTIVE_SCENE`: active scene selector.
- `SCENE_MUTE_VALUE = 2`: device-verified muted value.

Slot 0 is the live selection row. Authored scenes start at slot 1.

## Pattern Selection

Each selection byte is a 0-based pattern index for one track. If a track has
fewer patterns than the scene row asks for, generated specs should clamp to the
last available pattern rather than create an impossible state.

`build_arrangement(...)` writes scene rows from:

```python
scenes=[{track: pattern_index, ...}, ...]
```

## Mutes

Scene mutes use the second 16-byte region of the scene row. Device tests showed
value `2` displays and behaves as muted; the image writer emits `2`
canonically.

`build_arrangement(...)` accepts:

```python
scene_mutes=[[muted_track, ...], ...]
```

## Song Footer

The footer stores 14 variable-length song slots:

```text
[scene count][0-based scene IDs...][loop byte][reserved byte]
```

The device fixtures establish `0` as loop on, `1` as loop off, and `0` for the
reserved byte. `ImageProject.get_song_chain(song)` reads any slot and
`set_song_chain(song, ...)` rewrites it while preserving following slots.

The arrangement builder supports Song 1 chaining via:

```python
song_chain=[scene_id, ...]
song_loop=True
```

The user guide advertises fewer visible songs than the 14 serialized slots;
visible-slot reconciliation remains a minor limit/documentation item.

## Validation

Current scene/song authoring is validated by:

- byte-exact j05/j06 replication in `tests/test_image_writer.py`
- device-passing sparse arrangements
- the Whitney capstone project with 9 scenes and a Song 1 chain

Historical scene-token experiments remain in `docs/logs/*`; they are not the
current authoring model.
