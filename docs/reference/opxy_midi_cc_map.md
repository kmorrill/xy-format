# OP-XY MIDI CC Map

Source: Official OP-XY MIDI implementation chart (firmware 09 13 03 86).

## Tracks 1-8 (Instrument Tracks)

| CC | Synth Engines | Sample/Multi-sample |
|----|---------------|---------------------|
| 7  | Track Volume  | Track Volume        |
| 9  | Track Mute    | Track Mute          |
| 10 | Track Pan     | Track Pan           |
| 12 | Param 1       |                     |
| 13 | Param 2       |                     |
| 14 | Param 3       |                     |
| 15 | Param 4       | Link channel        |
| 20 | Amp attack    |                     |
| 21 | Amp decay     |                     |
| 22 | Amp sustain   |                     |
| 23 | Amp release   |                     |
| 24 | Filter attack |                     |
| 25 | Filter decay  |                     |
| 26 | Filter sustain|                     |
| 27 | Filter release|                     |
| 28 | poly/mono/legato |                  |
| 29 | portamento    |                     |
| 30 | PB amount     |                     |
| 31 | engine volume |                     |
| 32 | Filter cutoff |                     |
| 33 | resonance     |                     |
| 34 | env amount    |                     |
| 35 | key tracking amount |               |
| 36 | send to ext   |                     |
| 37 | send to tape  |                     |
| 38 | send to fx i  |                     |
| 39 | send to fx ii |                     |
| 40 | LFO destination | LFO shape        |
| 41 | LFO parameter/envelope | LFO onset (random) / LFO dest (value) |

## Tracks 9-16 (Auxiliary Tracks)

| CC | T9 Brain | T10 Punch-in | T11 Midi Out | T12 CV Out | T13 Audio In | T14 Tape | T15 FX 1 | T16 FX 2 |
|----|----------|-------------|--------------|------------|-------------|----------|----------|----------|
| 7  | Track Volume | Track Volume | Track Volume | Track Volume | Track Volume | Track Volume | Track Volume | Track Volume |
| 9  | Track Mute | Track Mute | Track Mute | Track Mute | Track Mute | Track Mute | Track Mute | Track Mute |
| 10 | Track Pan | Track Pan | Track Pan | Track Pan | Track Pan | Track Pan | Track Pan | Track Pan |
| 12 | | | Channel | | Input | x Speed | param1 | param1 |
| 13 | | | Bank | | Drive | Tape Speed | param2 | param2 |
| 14 | | | Program | | | Key scale | param3 | param3 |
| 15 | | | | | Mix | Mix | param 4 | param 4 |
| 32 | | | send cc value | | HP cutoff | HP cutoff | HP cutoff | HP cutoff |
| 33 | | | send cc value | | | | | |
| 34 | | | send cc value | | | | | |
| 35 | | | send cc value | | LP cutoff | LP cutoff | LP cutoff | LP cutoff |
| 36 | | | which cc | | | | | |
| 37 | | | which cc | | send to tape | | | |
| 38 | | | which cc | | send to fx i | send to fx i | | |
| 39 | | | which cc | | send to fx ii | send to fx ii | send to fx ii | |
| 40 | LFO shape | LFO shape | LFO shape | LFO shape | LFO shape | LFO shape | LFO shape | LFO shape |
| 41 | LFO onset/dest | LFO onset/dest | LFO onset/dest | LFO onset/dest | LFO onset/dest | LFO onset/dest | LFO onset/dest | LFO onset/dest |

## Notes

- CC 7/9/10 are universal mixer-level controls across all 16 tracks
- CC 12-15 (Param 1-4) map to engine-specific parameters on synth tracks, and to different functions on aux tracks
- CC 20-39 are synth-only (tracks 1-8) except where noted for aux tracks
- CC 40-41 (LFO) are universal across all tracks but with different functions per track type
- Track 11 (Midi Out) CC 32-39 control outbound MIDI routing, not synthesis parameters
- Performance controllers (Pitchbend, Aftertouch, Modwheel/CC1) are NOT in this table — they use a separate keyframe automation system

## Related
- P-lock canonical decode and param IDs: `docs/format/plocks.md`
- Hold-record discovery chronology: `docs/logs/2026-02-13_midi_cc_plock_discovery.md`
