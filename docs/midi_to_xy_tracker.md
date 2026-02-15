# MIDI To XY JSON Tracker

This file tracks imported MIDI sources and conversion progress toward JSON specs used for `.xy` authoring.

Last refresh: `2026-02-15`

## Scope
- Source crawl root: `/Users/kevinmorrill/Desktop/cover wavs`
- Local MIDI cache (ignored by git): `raw/*.mid` (flattened)
- Planned JSON spec root (tracked): `specs/midi-to-xy/`
- Planned built XY root (generated): `output/from-midi/`

## Status Legend
- `queued`: copied, not started
- `in_progress`: currently being mapped into JSON
- `blocked`: needs decision/input before mapping
- `done`: JSON spec complete and validated

## Millionsongs Dedupe
Duplicate variants in `millionsongs` were reduced to one keep file per song based on arrangement-richness metrics (active note tracks, channel spread, note density, and duration).

| Song | Kept Variant | Dropped Variant Count |
|---|---|---|
| `Billy Joel - Piano Man` | `Billy Joel - Piano Man (1).mid` | `1` |
| `Bob Dylan - Forever Young` | `Bob Dylan - Forever Young (3).mid` | `2` |
| `Bruce Hornsby and the Range - The Show Goes On` | `Bruce Hornsby and the Range - The Show Goes On (1).mid` | `1` |
| `Cher - If I Could Turn Back Time` | `Cher - If I Could Turn Back Time (4).mid` | `3` |
| `Earth Wind & Fire - Sing A Song` | `Earth Wind & Fire - Sing A Song (2).mid` | `9` |
| `Evanescence - Bring Me To Life` | `Evanescence - Bring Me To Life (1).mid` | `4` |
| `John Paul Young - Love Is In The Air` | `John Paul Young - Love Is In The Air (15).mid` | `15` |
| `La Bouche - Be My Lover` | `La Bouche - Be My Lover (7).mid` | `7` |
| `Loggins & Messina - Dannys Song` | `Loggins & Messina - Dannys Song (2).mid` | `1` |
| `MGMT - Electric Feel` | `MGMT - Electric Feel (1).mid` | `1` |
| `N-Trance - Stayin Alive` | `N-Trance - Stayin Alive (1).mid` | `3` |
| `Steve Perry - Oh Sherrie` | `Steve Perry - Oh Sherrie (1).mid` | `3` |
| `Stevie Ray Vaughan - Little Wing` | `Stevie Ray Vaughan - Little Wing (2).mid` | `1` |

## Cross-Source Dedupe
| Song | Kept Source | Dropped Sources |
|---|---|---|
| `Whitney Houston - How Will I Know` | `/Users/kevinmorrill/Desktop/cover wavs/how will i know/WHITNEY_HOUSTON_-_How_will_I_know.mid` | `/Users/kevinmorrill/Desktop/cover wavs/how will i know/58501.mid`, `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Whitney Houston - How Will I Know (3).mid` |

## File Tracker

| ID | Status | Source MIDI | Raw MIDI | Planned JSON Spec | Planned XY Output | Source Group | Notes |
|---|---|---|---|---|---|---|---|
| M001 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Abba - Lay All Your Love On Me.mid` | `raw/Abba - Lay All Your Love On Me.mid` | `specs/midi-to-xy/Abba - Lay All Your Love On Me.json` | `output/from-midi/Abba - Lay All Your Love On Me.xy` | `millionsongs` |  |
| M002 | queued | `/Users/kevinmorrill/Desktop/cover wavs/knock on wood/A.STEWART.Knock on wood K.mid` | `raw/Amii Stewart - Knock on Wood.mid` | `specs/midi-to-xy/Amii Stewart - Knock on Wood.json` | `output/from-midi/Amii Stewart - Knock on Wood.xy` | `non_millionsongs` |  |
| M003 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Armin van Buuren - Communication.mid` | `raw/Armin van Buuren - Communication.mid` | `specs/midi-to-xy/Armin van Buuren - Communication.json` | `output/from-midi/Armin van Buuren - Communication.xy` | `millionsongs` |  |
| M004 | queued | `/Users/kevinmorrill/Desktop/cover wavs/staying alive/BEEGEES.Staying alive K.mid` | `raw/Bee Gees - Stayin Alive.mid` | `specs/midi-to-xy/Bee Gees - Stayin Alive.json` | `output/from-midi/Bee Gees - Stayin Alive.xy` | `non_millionsongs` |  |
| M005 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Billy Joel - Piano Man (1).mid` | `raw/Billy Joel - Piano Man.mid` | `specs/midi-to-xy/Billy Joel - Piano Man.json` | `output/from-midi/Billy Joel - Piano Man.xy` | `millionsongs` | kept from duplicate set (1 dropped) |
| M006 | queued | `/Users/kevinmorrill/Desktop/cover wavs/call me/BLONDIE.Call me K.mid` | `raw/Blondie - Call Me.mid` | `specs/midi-to-xy/Blondie - Call Me.json` | `output/from-midi/Blondie - Call Me.xy` | `non_millionsongs` |  |
| M007 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Bob Dylan - Forever Young (3).mid` | `raw/Bob Dylan - Forever Young.mid` | `specs/midi-to-xy/Bob Dylan - Forever Young.json` | `output/from-midi/Bob Dylan - Forever Young.xy` | `millionsongs` | kept from duplicate set (2 dropped) |
| M008 | queued | `/Users/kevinmorrill/Desktop/cover wavs/chase/midnightexpress.mid` | `raw/Bob Frazier - Chase.mid` | `specs/midi-to-xy/Bob Frazier - Chase.json` | `output/from-midi/Bob Frazier - Chase.xy` | `non_millionsongs` |  |
| M009 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Bruce Hornsby and the Range - The Show Goes On (1).mid` | `raw/Bruce Hornsby and the Range - The Show Goes On.mid` | `specs/midi-to-xy/Bruce Hornsby and the Range - The Show Goes On.json` | `output/from-midi/Bruce Hornsby and the Range - The Show Goes On.xy` | `millionsongs` | kept from duplicate set (1 dropped) |
| M010 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Cher - If I Could Turn Back Time (4).mid` | `raw/Cher - If I Could Turn Back Time.mid` | `specs/midi-to-xy/Cher - If I Could Turn Back Time.json` | `output/from-midi/Cher - If I Could Turn Back Time.xy` | `millionsongs` | kept from duplicate set (3 dropped) |
| M011 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Coldplay - Lovers In Japan.mid` | `raw/Coldplay - Lovers In Japan.mid` | `specs/midi-to-xy/Coldplay - Lovers In Japan.json` | `output/from-midi/Coldplay - Lovers In Japan.xy` | `millionsongs` |  |
| M012 | queued | `/Users/kevinmorrill/Desktop/cover wavs/one more time/Daft Punk - One More Time.mid` | `raw/Daft Punk - One More Time.mid` | `specs/midi-to-xy/Daft Punk - One More Time.json` | `output/from-midi/Daft Punk - One More Time.xy` | `non_millionsongs` |  |
| M013 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Earth Wind & Fire - Sing A Song (2).mid` | `raw/Earth Wind & Fire - Sing A Song.mid` | `specs/midi-to-xy/Earth Wind & Fire - Sing A Song.json` | `output/from-midi/Earth Wind & Fire - Sing A Song.xy` | `millionsongs` | kept from duplicate set (9 dropped) |
| M014 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Eminem - Lose Yourself.mid` | `raw/Eminem - Lose Yourself.mid` | `specs/midi-to-xy/Eminem - Lose Yourself.json` | `output/from-midi/Eminem - Lose Yourself.xy` | `millionsongs` |  |
| M015 | queued | `/Users/kevinmorrill/Desktop/cover wavs/sweet dreams/EURYTHMICS.Sweet dreams K.mid` | `raw/Eurythmics - Sweet Dreams (Are Made of This).mid` | `specs/midi-to-xy/Eurythmics - Sweet Dreams (Are Made of This).json` | `output/from-midi/Eurythmics - Sweet Dreams (Are Made of This).xy` | `non_millionsongs` |  |
| M016 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Evanescence - Bring Me To Life (1).mid` | `raw/Evanescence - Bring Me To Life.mid` | `specs/midi-to-xy/Evanescence - Bring Me To Life.json` | `output/from-midi/Evanescence - Bring Me To Life.xy` | `millionsongs` | kept from duplicate set (4 dropped) |
| M017 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Fall Out Boy - Thnks fr th Mmrs.mid` | `raw/Fall Out Boy - Thnks fr th Mmrs.mid` | `specs/midi-to-xy/Fall Out Boy - Thnks fr th Mmrs.json` | `output/from-midi/Fall Out Boy - Thnks fr th Mmrs.xy` | `millionsongs` |  |
| M018 | queued | `/Users/kevinmorrill/Desktop/cover wavs/what a feeling/46804.mid` | `raw/Irene Cara - What a Feeling.mid` | `specs/midi-to-xy/Irene Cara - What a Feeling.json` | `output/from-midi/Irene Cara - What a Feeling.xy` | `non_millionsongs` |  |
| M019 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/John Paul Young - Love Is In The Air (15).mid` | `raw/John Paul Young - Love Is In The Air.mid` | `specs/midi-to-xy/John Paul Young - Love Is In The Air.json` | `output/from-midi/John Paul Young - Love Is In The Air.xy` | `millionsongs` | kept from duplicate set (15 dropped) |
| M020 | queued | `/Users/kevinmorrill/Desktop/cover wavs/don't stop/dont_stop_believin.mid` | `raw/Journey - Don't Stop Believin'.mid` | `specs/midi-to-xy/Journey - Don't Stop Believin'.json` | `output/from-midi/Journey - Don't Stop Believin'.xy` | `non_millionsongs` |  |
| M021 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Kings Of Leon - Use Somebody.mid` | `raw/Kings Of Leon - Use Somebody.mid` | `specs/midi-to-xy/Kings Of Leon - Use Somebody.json` | `output/from-midi/Kings Of Leon - Use Somebody.xy` | `millionsongs` |  |
| M022 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/La Bouche - Be My Lover (7).mid` | `raw/La Bouche - Be My Lover.mid` | `specs/midi-to-xy/La Bouche - Be My Lover.json` | `output/from-midi/La Bouche - Be My Lover.xy` | `millionsongs` | kept from duplicate set (7 dropped) |
| M023 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Loggins & Messina - Dannys Song (2).mid` | `raw/Loggins & Messina - Dannys Song.mid` | `specs/midi-to-xy/Loggins & Messina - Dannys Song.json` | `output/from-midi/Loggins & Messina - Dannys Song.xy` | `millionsongs` | kept from duplicate set (1 dropped) |
| M024 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/MGMT - Electric Feel (1).mid` | `raw/MGMT - Electric Feel.mid` | `specs/midi-to-xy/MGMT - Electric Feel.json` | `output/from-midi/MGMT - Electric Feel.xy` | `millionsongs` | kept from duplicate set (1 dropped) |
| M025 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/MIKA - Grace Kelly.mid` | `raw/MIKA - Grace Kelly.mid` | `specs/midi-to-xy/MIKA - Grace Kelly.json` | `output/from-midi/MIKA - Grace Kelly.xy` | `millionsongs` |  |
| M026 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Muse - Feeling Good.mid` | `raw/Muse - Feeling Good.mid` | `specs/midi-to-xy/Muse - Feeling Good.json` | `output/from-midi/Muse - Feeling Good.xy` | `millionsongs` |  |
| M027 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/N-Trance - Stayin Alive (1).mid` | `raw/N-Trance - Stayin Alive.mid` | `specs/midi-to-xy/N-Trance - Stayin Alive.json` | `output/from-midi/N-Trance - Stayin Alive.xy` | `millionsongs` | kept from duplicate set (3 dropped) |
| M028 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Radiohead - No Surprises.mid` | `raw/Radiohead - No Surprises.mid` | `specs/midi-to-xy/Radiohead - No Surprises.json` | `output/from-midi/Radiohead - No Surprises.xy` | `millionsongs` |  |
| M029 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Scissor Sisters - I Dont Feel Like Dancin.mid` | `raw/Scissor Sisters - I Dont Feel Like Dancin.mid` | `specs/midi-to-xy/Scissor Sisters - I Dont Feel Like Dancin.json` | `output/from-midi/Scissor Sisters - I Dont Feel Like Dancin.xy` | `millionsongs` |  |
| M030 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Steve Perry - Oh Sherrie (1).mid` | `raw/Steve Perry - Oh Sherrie.mid` | `specs/midi-to-xy/Steve Perry - Oh Sherrie.json` | `output/from-midi/Steve Perry - Oh Sherrie.xy` | `millionsongs` | kept from duplicate set (3 dropped) |
| M031 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Stevie Ray Vaughan - Little Wing (2).mid` | `raw/Stevie Ray Vaughan - Little Wing.mid` | `specs/midi-to-xy/Stevie Ray Vaughan - Little Wing.json` | `output/from-midi/Stevie Ray Vaughan - Little Wing.xy` | `millionsongs` | kept from duplicate set (1 dropped) |
| M032 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/The Wallflowers - One Headlight.mid` | `raw/The Wallflowers - One Headlight.mid` | `specs/midi-to-xy/The Wallflowers - One Headlight.json` | `output/from-midi/The Wallflowers - One Headlight.xy` | `millionsongs` |  |
| M033 | queued | `/Users/kevinmorrill/Desktop/cover wavs/millionsongs/Tiesto - Adagio For Strings.mid` | `raw/Tiesto - Adagio For Strings.mid` | `specs/midi-to-xy/Tiesto - Adagio For Strings.json` | `output/from-midi/Tiesto - Adagio For Strings.xy` | `millionsongs` |  |
| M034 | queued | `/Users/kevinmorrill/Desktop/cover wavs/how will i know/WHITNEY_HOUSTON_-_How_will_I_know.mid` | `raw/Whitney Houston - How Will I Know.mid` | `specs/midi-to-xy/Whitney Houston - How Will I Know.json` | `output/from-midi/Whitney Houston - How Will I Know.xy` | `non_millionsongs` | selected best of 3 cross-source variants (2 dropped) |
| M035 | queued | `/Users/kevinmorrill/Desktop/cover wavs/wanna dance/110134.mid` | `raw/Whitney Houston - I Wanna Dance With Somebody.mid` | `specs/midi-to-xy/Whitney Houston - I Wanna Dance With Somebody.json` | `output/from-midi/Whitney Houston - I Wanna Dance With Somebody.xy` | `non_millionsongs` |  |
