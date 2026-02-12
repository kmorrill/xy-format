# OP-XY Project File Change Log

This document lists all changes made to OP-XY project files relative to their default state.

## Baseline Reference
- **unnamed_1** — Blank baseline project

## Project settings 

### Tempo, Groove, and Metronome
- **unnamed_4** — Changed tempo to 40 BPM (minimum)
- **unnamed_5** — Set tempo to 121.2 BPM
- **unnamed_10** — Muted tempo click track by setting its volume to minimum
- **unnamed_11** — Set tempo groove type to 'dis-funk'
- **unnamed_12** — Set groove type configuration to 'bombora'
- **unnamed_42** — Set groove type configuration to 'half-shuffle'
- **unnamed_44** — Set groove type configuration to 'danish'
- **unnamed_45** — Set groove type configuration to 'wobbly'
- **unnamed_46** — Set groove type configuration to 'gaussian'
- **unnamed_47** — Set groove type configuration to 'prophetic'
- **unnamed_48** — set groove amount low
- **unnamed_49** — set groove amount high

### MIDI
- **unnamed_41** — sets project settings for track 1 to be midi channel 1, track 16 to be channel 16, other tracks left off
- **unnamed_54** — set track three to MIDI channel eight (first track-only mapping capture)


## Sequencer Notes, Length, and Scales
- **unnamed_2** — Added a note trig on step one of track one, set to middle C
- **unnamed_3** — Recorded a C-E-G triad on step one
- **unnamed_6** — Entered song mode and created a new blank pattern
- **unnamed_7** — Added three blank patterns on track one
- **unnamed_8** — Added pulse step component on track one, pattern one, step one, to repeat once
- **unnamed_9** — Set pulse step component to highest setting for random repeats
- **unnamed_17** — Set track one, pattern one to two bars
- **unnamed_18** — Set number of bars to three
- **unnamed_19** — Set number of bars to four
- **unnamed_20** — Changed track scale to 'track scale 2'
- **unnamed_21** — Changed track scale to 9 ('track scale 16')
- **unnamed_22** — Changed track scale to 0 ('track scale 1/2')
- **unnamed_38** — track 4 step 1 triggers lowest possible note, step 2 triggers highest possible note
- **unnamed_39** — a single note is played on track 3 pattern 1 with pitch bend wobble applied
- **unnamed_50** — hand entered C4 note trig on track 3, step 6 with custom velocity, duration from record mode
- **unnamed_51** — starting from unnamed_50.xy, turn off the trig on step 6 using the sequencer, perhaps leaving example ring residue behind
- **unnamed_56** — Track three, pattern one trig on step nine stretched to cover two steps (long gate)
- **unnamed_57** — Same project, track three trig extended further to four steps
- **unnamed_59** — Added pulse step component on track one, pattern one, step nine at minimum configuration value
- **unnamed_60** — Set the pulse step component on track one, pattern one, step nine to its maximum configuration value
- **unnamed_61** — Added hold step component on track one, pattern one, step nine at minimum configuration value
- **unnamed_62** — Added trigger step component on track one, pattern one, step nine configured to fire every fourth trig
- **unnamed_63** — Enabled all available step components on track one, pattern one, step nine with default configuration values
- **unnamed_66** — Multiply step component on track one, pattern one, step nine dividing the step into four trigs
- **unnamed_67** — Velocity step component on track one, pattern one, step nine set to random
- **unnamed_68** — Ramp Up step component on track one, pattern one, step nine spanning four steps and three octaves
- **unnamed_69** — Ramp Down step component on track one, pattern one, step nine spanning three steps and one octave
- **unnamed_70** — Random step component on track one, pattern one, step nine spanning four steps with a one-octave range
- **unnamed_71** — Portamento step component on track one, pattern one, step nine set to 70 %
- **unnamed_72** — Bend step component on track one, pattern one, step nine using the up/down shape
- **unnamed_73** — Tonality step component on track one, pattern one, step nine shifting pitch up a fifth
- **unnamed_74** — Jump step component on track one, pattern one, step nine targeting step thirteen
- **unnamed_75** — Parameter component on track one, pattern one, step nine with the first four parameter toggles enabled
- **unnamed_76** — Conditional component on track one, pattern one, step nine firing every second trig
- **unnamed_77** — Conditional component on track one, pattern one, step nine firing every ninth trig
- **unnamed_78** — Added a quantised note trig and Multiply component (divide into two trigs) on track three, pattern one, step nine
- **unnamed_79** — Hand-entered, non-quantized note on track three landing on step thirteen with a micro-late offset
- **unnamed_81** — Added a single grid-quantised C4 trig on track one, pattern one, step nine (default velocity/gate; no other edits)
- **unnamed_80** — Added grid-entered notes on track one, pattern one: single C4 at step one, single D4 at step five, single E4 at step nine, and a stacked F4–G4–A4 chord at step thirteen
- **unnamed_85** — Track three switched to the Wavetable engine and, via step edit (no recording), a single C4 trig was placed on pattern one step nine with default velocity/gate
- **unnamed_86** — Same Wavetable setup as unnamed_85, but captured in real-time record: a live-played C4 trig lands near step eight and sustains across multiple steps
- **unnamed_87** — Live-recorded single C4 on track three (Prism) landing around step ten with a short hold (~0.7 step) while leaving all other tracks untouched
- **unnamed_91** — Track four engine changed from Pluck to Drum, single hit placed on step one (note 83, velocity 100). Uses 0x2d grid event type. No preamble 0x64 sentinel on track five (unlike note-only edits)
- **unnamed_92** — Three notes on track three with different gate lengths: step 1 (2 steps), step 5 (4 steps), step 11 (6 steps). Uses 0x21 sequential event with explicit gate encoding
- **unnamed_93** — MIDI harness capture: single C4 (note 60) on step 1 sent via MIDI to all 8 instrument tracks simultaneously. All 8 tracks activated (type 05→07). Reveals engine-dependent event types: T1(Drum)=0x25, T2(Drum)=0x21, T3(Prism)=0x21, T4(EPiano)=0x1F, T5(Dissolve)=0x21, T6(Hardsync)=0x1E, T7(Axis)=0x20, T8(Multisampler)=0x20. Gate recorded as explicit 480 ticks. Preamble 0x64 set on T2-T4, T6-T9 (T5 keeps original 0x2E — reason unknown)
- **unnamed_94** — MIDI harness capture (`selective_multi_note`): non-contiguous tracks with engine changes. T3 changed from Prism to Wavetable, T5 changed from Dissolve to Drum (empty sampler). MIDI sent via `tools/midi_harness.py` to channels 1/3/5/7: T1(ch1, Drum default) C4 step 1 + D4 step 5; T3(ch3, Wavetable) C4+E4+G4 chord step 1; T5(ch5, Drum) C4 step 1 velocity 50; T7(ch7, Axis default) E4 step 9 with 4-step hold. Tests: multi-note 0x25, MIDI chord serialization, 0x2D vs engine, velocity fidelity, non-contiguous preamble behavior, tick/gate encoding


## Songs and Arrangement
- **unnamed_13** — Created an empty Song 2 in song mode

## Mix and Master Adjustments
- **unnamed_14** — Turned EQ leftmost setting (low range) to zero
- **unnamed_16** — Turned rightmost EQ setting (high-end) to zero
- **unnamed_15** — Created a new empty song for mid-range

## Track Sound Design Parameters
- **unnamed_34** — Changed track 1 to have axis synth with no preset from engine picker
- **unnamed_23** — Set parameter one on track three from 15 to 99
- **unnamed_24** — Set parameter one on track three to zero
- **unnamed_25** — Set parameter four from 22 to 99
- **unnamed_26** — Adjusted M2 page on track three: amp attack ↑, decay ↑, sustain ↑, release ↓
- **unnamed_27** — Maxed filter envelope on M2: attack, decay, sustain, release
- **unnamed_28** — Changed filter type on M3 page from SVF to Ladder
- **unnamed_29** — Turned off filter on M3 page
- **unnamed_30** — Maxed out all filter knobs (cutoff, resonance, key tracking) on M3
- **unnamed_31** — Turned on M4 page on track three
- **unnamed_32** — Switched M4 LFO from tremolo to duck
- **unnamed_33** — Maxed rate, vibrato, volume, envelope, and shape on M4
- **unnamed_35** — synth parameter 1 of track 3 has been automated to adjust throughout the 16 steps
- **unnamed_36** — fx1 changed to chorus
- **unnamed_37** — fx2 changed to phaser
- **unnamed_40** — set the high pass filter on track 1 to a max value of 100
- **unnamed_50** — hand entered C4 note trig on track 3, step 6 with custom velocity, duration from record mode
- **unnamed_51** — starting from unnamed_50.xy, turned off the trig on step 6 using the sequencer
- **unnamed_52** — enabled a single note trig on track 1
- **unnamed_53** — starting from unnamed_52.xy, removed the step 1 trig on track 1
- **unnamed_65** — Added quantised note trigs on step 9 for track 3 (Prism synth) and track 8 (Multisampler)
- **unnamed_82** — Set track 1 high pass filter to value 1 and reduced velocity sensitivity to 0
- **unnamed_83** — Remapped track 1 modulation routings: modwheel→synth2 (-50), aftertouch→LFO4 (+50), pitchbend→ADSR1 (+25), velocity→filter3 (-25)
- **unnamed_84** — Rerouted track 1 pitch bend target from synth1 to filter3 (other mod routings left at defaults)
