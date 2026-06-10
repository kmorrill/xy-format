#!/usr/bin/env python3
"""AURORA ENGINE — a composition for OP-XY, authored entirely from structs.

A ~2:10 piece in A minor at 104 BPM. Eight scenes arranged into a song
(intro → build → groove → variation → breakdown → climax ×2 → outro),
exercising the full decoded feature surface:

  multi-pattern (8 patterns × 8 tracks) · scenes + per-scene mutes ·
  song chain (loop off, finite piece) · preset transfer (boop kit → T8
  as an FX kit) · drum-voice tweaks (reversed one-shot crash swells,
  detuned metal/chimes) · step components (multiply snare rolls, pulse
  stutter, portamento + bend on the breakdown solo) · p-locks (rising
  cutoff through the breakdown pad, ping-pong pan on arps) ·
  micro-timing (rubato breakdown lead) · velocity contours · long gates
  · one deliberate note==velocity (E5 at vel 76) for the disproven bug.

Baseline instruments: T1/T2 drums (boop / in phase), T3 Prism bass,
T4 EPiano pluck, T5 Dissolve pad, T6 Hardsync lead, T7 Axis bells,
T8 = boop kit transplanted + tweaked into an FX kit.
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from xy.image_writer import ImageProject, build_arrangement  # noqa: E402
from xy.rle import decode_project  # noqa: E402

BASE = "src/one-off-changes-from-default/unnamed 1.xy"
OUT = "output/image-probes/10_j_aurora_engine.xy"

# ---------------------------------------------------------------- helpers
def N(bar, s, note, vel=100, gate=240, off=0):
    """Note at bar (1-4), step-in-bar (1-16)."""
    return {"step": (bar - 1) * 16 + s, "note": note, "velocity": vel,
            "gate_ticks": gate, "tick_offset": off}

# drum keys (T1/T2/T8 share the boop/in-phase layout)
KICK, KICK2, SN, SN2, RIM, CLAP, TAMB, SHKR = 48, 49, 50, 51, 52, 53, 54, 55
CH, CH2, OH, LT, RIDE, MT, CRASH, HT = 56, 57, 58, 60, 61, 62, 63, 64
TRI, LC, HC, COW, GUI, MTL, CHI = 65, 66, 67, 68, 69, 70, 71

# harmony: | Am9 | Fmaj7 | Cmaj7 | Gadd9 |
ROOTS = [33, 29, 36, 31]                       # A1 F1 C2 G1
PADS = [[57, 60, 64, 71], [53, 57, 60, 64],    # pad voicings
        [55, 60, 64, 71], [55, 59, 62, 69]]
ARPS = [[57, 64, 71, 72, 76], [53, 60, 65, 69, 72],   # arp note pools
        [55, 60, 64, 67, 72], [55, 62, 67, 71, 74]]
ARP_UP = [0, 1, 2, 3, 4, 3, 2, 1, 0, 2, 1, 3, 2, 4, 3, 1]   # 16-step contour
ARP_VAR = [0, 2, 4, 2, 3, 1, 3, 0, 4, 2, 3, 1, 2, 4, 1, 3]

def arp_bar(bar, pool, contour, base_vel=72, oct_up=0, eighths=False):
    notes = []
    for i in range(16):
        if eighths and i % 2:
            continue
        vel = base_vel + (24 if i % 4 == 0 else 0) + (8 if i == 0 else 0)
        gate = 480 if i == 15 else 240
        notes.append(N(bar, i + 1, pool[contour[i]] + oct_up, min(vel, 120), gate))
    return notes

def hats_bar(bar, lo=50, hi=85, skip=(7, 15)):
    out = []
    for i in range(16):
        s = i + 1
        if s in skip:
            continue
        wave = [hi, lo, lo + 12, lo][i % 4]
        out.append(N(bar, s, CH if i % 2 == 0 else CH2, wave, 240))
    return out

# ---------------------------------------------------------------- T1 drums
def t1_patterns():
    P = []
    # P1 intro heartbeat
    p = []
    for b in range(1, 5):
        p += [N(b, 1, KICK, 100, 480), N(b, 11, KICK, 72, 240)]
    p.append(N(4, 13, SN, 58, 480))
    P.append(p)
    # P2 build: four-on-floor + roll into the groove
    p = []
    for b in range(1, 5):
        for s in (1, 5, 9, 13):
            p.append(N(b, s, KICK, 102, 240))
        for s in range(1, 17, 2):
            p.append(N(b, s, CH, 58, 240))
        if b >= 3:
            p += [N(b, 5, CLAP, 84, 240), N(b, 13, CLAP, 86, 240)]
    p += [N(4, 14, SN, 58, 240), N(4, 15, SN, 74, 240), N(4, 16, SN, 92, 240)]
    P.append(p)
    # P3 groove (core beat)
    def groove(fill=True, extra=False):
        p = []
        for b in range(1, 5):
            p += [N(b, 1, KICK, 106, 240), N(b, 8, KICK, 84, 240), N(b, 11, KICK, 96, 240)]
            p += [N(b, 5, SN, 101, 240)]
            p += hats_bar(b)
            p += [N(b, 7, OH, 74, 360), N(b, 15, OH, 68, 360)]
            p += [N(b, 10, SN2, 38, 240)]
            if extra and b in (2, 4):
                p.append(N(b, 14, KICK2, 70, 240))
            if b < 4 or not fill:
                p.append(N(b, 13, SN, 103, 240))
        if fill:
            p += [N(4, 13, SN, 100, 240), N(4, 14, SN2, 55, 240),
                  N(4, 15, MT, 82, 240), N(4, 16, LT, 88, 240)]
        return p
    P.append(groove())                 # P3
    P.append(groove(extra=True))       # P4 variant
    P.append(groove())                 # P5 (scene 5 mutes T1; content irrelevant)
    # P6 climax: forward crash on the downbeat + drive
    def climax():
        p = [N(1, 1, CRASH, 110, 960)]
        for b in range(1, 5):
            p += [N(b, 1, KICK, 108, 240), N(b, 7, KICK, 88, 240), N(b, 11, KICK, 100, 240)]
            p += [N(b, 5, SN, 106, 240), N(b, 13, SN, 107, 240)]
            p += hats_bar(b, lo=58, hi=92)
            p += [N(b, 7, OH, 78, 360), N(b, 15, OH, 74, 360)]
        p += [N(4, 14, SN, 76, 240), N(4, 15, SN, 90, 240), N(4, 16, HT, 92, 240)]
        return p
    P.append(climax())                 # P6
    P.append(climax())                 # P7 (stutter via pulse component, added later)
    # P8 outro decay
    p = []
    for b in range(1, 5):
        p.append(N(b, 1, KICK, 92 - (b - 1) * 12, 480))
    p += [N(1, 1, CRASH, 96, 1440), N(2, 13, SN, 66, 480),
          N(3, 5, RIM, 48, 240), N(4, 5, RIM, 40, 240)]
    P.append(p)
    return P

# ---------------------------------------------------------------- T2 perc
def t2_patterns():
    P = []
    P.append([N(1, 1, CHI, 50, 960)])                       # P1
    p = []                                                  # P2 shaker 8ths
    for b in range(1, 5):
        for s in range(1, 17, 2):
            p.append(N(b, s, SHKR, 52 + (6 if s in (1, 9) else 0), 240))
        if b >= 3:
            p += [N(b, 5, TAMB, 58, 240), N(b, 13, TAMB, 60, 240)]
    P.append(p)
    def perc(ride=None):
        p = []
        for b in range(1, 5):
            for i in range(16):
                p.append(N(b, i + 1, SHKR, [66, 42, 50, 44][i % 4], 240))
            p += [N(b, 4, LC, 74, 240), N(b, 12, LC, 70, 240), N(b, 7, HC, 68, 240)]
            p += [N(b, 5, TAMB, 54, 240), N(b, 13, TAMB, 52, 240)]
            if ride == "quarters":
                for s in (1, 5, 9, 13):
                    p.append(N(b, s, RIDE, 68, 480))
            elif ride == "off":
                for s in (3, 7, 11, 15):
                    p.append(N(b, s, RIDE, 62, 480))
        return p
    P.append(perc())                   # P3
    P.append(perc())                   # P4
    P.append(perc())                   # P5 (muted by scene 5)
    P.append(perc(ride="quarters"))    # P6
    P.append(perc(ride="off"))         # P7
    p = []                             # P8 fade
    for b in range(1, 5):
        for s in range(1, 17, 2):
            p.append(N(b, s, SHKR, max(28, 50 - (b - 1) * 8), 240))
    p.append(N(1, 1, CHI, 44, 960))
    P.append(p)
    return P

# ---------------------------------------------------------------- T3 bass
def t3_patterns():
    P = [[]]                                               # P1 empty (intro)
    p = []                                                 # P2 half notes
    for b in range(1, 5):
        p += [N(b, 1, ROOTS[b - 1], 96, 1920), N(b, 9, ROOTS[b - 1], 80, 1920)]
    P.append(p)
    def groove(walk=False, drive=False):
        p = []
        for b in range(1, 5):
            r = ROOTS[b - 1]
            if drive:
                for i, s in enumerate(range(1, 17, 2)):
                    p.append(N(b, s, r, 104 if i % 2 == 0 else 84, 300))
                p += [N(b, 8, r + 12, 70, 240), N(b, 16, r + 12, 72, 240)]
            else:
                p += [N(b, 1, r, 110, 480), N(b, 4, r + 12, 70, 240),
                      N(b, 7, r, 90, 240), N(b, 11, r, 100, 480),
                      N(b, 14, r + 7, 80, 240)]
        if walk:
            p += [N(4, 13, 31, 88, 240), N(4, 14, 33, 90, 240),
                  N(4, 15, 35, 92, 240), N(4, 16, 40, 96, 240)]
        return p
    P.append(groove())                  # P3
    P.append(groove(walk=True))        # P4
    p = []                             # P5 breakdown subs
    for b in range(1, 5):
        p.append(N(b, 1, ROOTS[b - 1] + 12, 95, 7200))
    P.append(p)
    P.append(groove(drive=True))       # P6
    P.append(groove(drive=True, walk=True))  # P7
    p = []                             # P8 outro
    for b in range(1, 5):
        p.append(N(b, 1, ROOTS[b - 1], 100 - (b - 1) * 15, 7200))
    P.append(p)
    return P

# ---------------------------------------------------------------- T4 arp
def t4_patterns():
    P = []
    P.append(sum([arp_bar(b, ARPS[b - 1][:3] + ARPS[b - 1][:2], ARP_UP, 58, eighths=True)
                  for b in range(1, 5)], []))                       # P1 sparse 8ths
    p = []                                                          # P2 8ths→16ths
    for b in (1, 2):
        p += arp_bar(b, ARPS[b - 1], ARP_UP, 64, eighths=True)
    for b in (3, 4):
        p += arp_bar(b, ARPS[b - 1], ARP_UP, 68)
    P.append(p)
    P.append(sum([arp_bar(b, ARPS[b - 1], ARP_UP, 72) for b in range(1, 5)], []))   # P3
    P.append(sum([arp_bar(b, ARPS[b - 1], ARP_VAR, 74) for b in range(1, 5)], []))  # P4 (pan locks later)
    p = []                                                          # P5 echoes
    for b in range(1, 5):
        pool = ARPS[b - 1]
        p += [N(b, 1, pool[2], 70, 720), N(b, 4, pool[4], 62, 720),
              N(b, 7, pool[3], 58, 960), N(b, 11, pool[1], 54, 960)]
    P.append(p)
    P.append(sum([arp_bar(b, ARPS[b - 1], ARP_UP, 78, oct_up=12) for b in range(1, 5)], []))   # P6
    P.append(sum([arp_bar(b, ARPS[b - 1], ARP_VAR, 78, oct_up=12) for b in range(1, 5)], []))  # P7
    p = []                                                          # P8 fade 8ths
    for b in range(1, 5):
        for n in arp_bar(b, ARPS[b - 1], ARP_UP, max(40, 62 - b * 6), eighths=True):
            p.append(n)
    P.append(p)
    return P

# ---------------------------------------------------------------- T5 pad
def t5_patterns():
    def chords(vel=75, gate=7200, voicings=PADS, only=None):
        p = []
        for b in range(1, 5):
            if only and b not in only:
                continue
            for note in voicings[b - 1]:
                p.append(N(b, 1, note, vel, gate))
        return p
    P = []
    P.append(chords(65, 7200, [PADS[0], PADS[1], PADS[0], PADS[1]]))   # P1 Am/F sway
    P.append(chords(70))                                               # P2
    P.append(chords(75))                                               # P3
    P.append(chords(75))                                               # P4
    low = [[45, 52, 57, 60], [41, 48, 53, 57], [48, 55, 60, 64], [43, 50, 55, 59]]
    P.append(chords(85, 7680, low))                                    # P5 dark low (cutoff locks later)
    P.append(chords(85))                                               # P6
    P.append(chords(85))                                               # P7
    P.append(chords(70, 7200, [PADS[0], PADS[1], PADS[2], PADS[0]]))   # P8 resolve home
    return P

# ---------------------------------------------------------------- T6 lead
def t6_patterns():
    P = [[], []]                                            # P1, P2 silent
    P.append([N(2, 9, 76, 75, 960), N(4, 9, 74, 70, 960)])  # P3 hints
    P.append([N(2, 9, 76, 80, 480), N(2, 11, 74, 70, 240), N(2, 12, 72, 75, 480),
              N(4, 9, 71, 78, 480), N(4, 11, 72, 72, 240), N(4, 12, 69, 76, 720)])  # P4
    # P5 breakdown solo (rubato micro-timing; bend/portamento added later)
    P.append([
        N(1, 3, 69, 85, 900, off=80), N(1, 7, 72, 78, 700, off=40),
        N(1, 10, 71, 70, 480), N(1, 13, 76, 95, 1400, off=-60),
        N(2, 5, 74, 82, 700), N(2, 9, 72, 75, 700), N(2, 12, 69, 88, 1800),
        N(3, 3, 76, 90, 900), N(3, 8, 79, 92, 700, off=90), N(3, 13, 77, 96, 1500),
        N(4, 5, 74, 84, 700), N(4, 9, 71, 78, 600), N(4, 11, 67, 85, 2400),
    ])
    anthem = [
        N(1, 1, 76, 108, 1320), N(1, 5, 72, 92, 600), N(1, 7, 74, 95, 600),
        N(1, 9, 76, 105, 1320), N(1, 13, 79, 110, 900), N(1, 15, 76, 76, 420),  # E5 @ vel 76: note==vel
        N(2, 1, 74, 104, 1320), N(2, 5, 71, 90, 600), N(2, 7, 72, 92, 600),
        N(2, 9, 69, 100, 2400),
        N(3, 1, 69, 95, 600), N(3, 3, 72, 98, 600), N(3, 5, 76, 106, 1320),
        N(3, 9, 77, 108, 1320), N(3, 13, 76, 100, 900), N(3, 15, 72, 85, 420),
        N(4, 1, 71, 96, 600), N(4, 5, 74, 104, 1320), N(4, 9, 67, 98, 2880),
    ]
    P.append(list(anthem))                                  # P6
    harm = list(anthem)                                     # P7 + thirds below on accents
    for b, s, h in [(1, 1, 72), (1, 9, 72), (1, 13, 76), (2, 1, 71), (2, 9, 64),
                    (3, 5, 72), (3, 9, 72), (4, 5, 71), (4, 9, 62)]:
        harm.append(N(b, s, h, 82, 900))
    P.append(harm)
    P.append([N(1, 1, 76, 70, 1200), N(2, 1, 72, 60, 1200),
              N(3, 1, 71, 50, 1200), N(4, 1, 69, 55, 2400)])  # P8 echo
    return P

# ---------------------------------------------------------------- T7 bells
def t7_patterns():
    P = []
    P.append([N(1, 1, 76, 60, 960), N(3, 1, 71, 55, 960)])              # P1
    P.append([N(2, 11, 69, 65, 480), N(4, 11, 67, 60, 480)])            # P2
    off7 = [71, 69, 67, 69]
    off15 = [76, 77, 76, 74]
    p = []
    for b in range(1, 5):
        p += [N(b, 7, off7[b - 1], 70, 240), N(b, 15, off15[b - 1], 62, 240)]
    P.append(p)                                                          # P3
    P.append(p + [N(2, 3, 72, 58, 240), N(4, 3, 74, 58, 240)])           # P4
    P.append([])                                                         # P5
    high = [81, 77, 79, 74]
    p = []
    for b in range(1, 5):
        p += [N(b, 5, high[b - 1], 75, 480), N(b, 13, high[b - 1] - 2, 68, 360)]
    P.append(p)                                                          # P6
    P.append(p)                                                          # P7
    P.append([N(1, 1, 81, 55, 1440), N(3, 1, 76, 45, 1440)])             # P8
    return P

# ---------------------------------------------------------------- assemble
def main():
    tracks = {1: t1_patterns(), 2: t2_patterns(), 3: t3_patterns(),
              4: t4_patterns(), 5: t5_patterns(), 6: t6_patterns(),
              7: t7_patterns(), 8: [[] for _ in range(8)]}   # T8 notes added post-preset
    for t, pats in tracks.items():
        for k, p in enumerate(pats):
            assert len(p) <= 120, (t, k, len(p))

    scenes = [{t: k for t in range(1, 9)} for k in range(8)]
    scene_mutes = [[], [], [], [], [1, 2], [], [], []]       # S5 breakdown mutes drums
    chain = [0, 1, 2, 2, 3, 2, 3, 4, 5, 6, 5, 6, 7, 7]       # the song

    raw = build_arrangement(BASE, tracks, scenes=scenes, scene_mutes=scene_mutes,
                            song_chain=chain, song_loop=False)
    Path(OUT).write_bytes(raw)

    p = ImageProject.from_file(OUT)
    p.set_tempo(104.0)

    def idx(t, pat):                  # 1-based struct index for (track, pattern 1..8)
        return (t - 1) * 8 + pat

    # --- T8: transplant boop kit, sculpt into an FX kit, add hits --------
    for pat in range(1, 9):
        i = idx(8, pat)
        p.set_preset(i, BASE, donor_track=1)
        p.set_drum_voice(i, 15, direction=1, play_mode=2, tune=-3)   # reversed one-shot crash
        p.set_drum_voice(i, 22, tune=-12)                            # dark metal
        p.set_drum_voice(i, 23, tune=+7)                             # bright chimes
    t8_hits = {
        1: [N(4, 9, CRASH, 70)],
        2: [N(4, 9, CRASH, 85), N(1, 1, MTL, 50)],
        3: [N(1, 1, MTL, 55), N(3, 1, CHI, 40)],
        4: [N(1, 1, MTL, 55), N(4, 9, CRASH, 80)],
        5: [N(1, 1, MTL, 60), N(4, 5, CRASH, 95)],
        6: [N(1, 1, MTL, 65), N(2, 1, CHI, 45), N(4, 9, CRASH, 85)],
        7: [N(1, 1, MTL, 62), N(4, 9, CRASH, 90)],
        8: [N(1, 1, CRASH, 70)],
    }
    for pat, hits in t8_hits.items():
        for n in hits:
            p.add_note(idx(8, pat), step=n["step"], note=n["note"],
                       velocity=n["velocity"], gate=n["gate_ticks"])

    # --- step components ---------------------------------------------------
    p.set_step_component(idx(1, 2), 61, "multiply", 4)    # build: snare roll ÷4
    p.set_step_component(idx(1, 6), 63, "multiply", 4)    # climax fill roll
    p.set_step_component(idx(1, 7), 13, "pulse", 2)       # climax-var snare stutter
    for s in (7, 23, 39, 55):                             # arp echo slides (P5)
        p.set_step_component(idx(4, 5), s, "portamento", 6)
    p.set_step_component(idx(6, 5), 13, "bend", 1)        # solo: bend dip
    p.set_step_component(idx(6, 5), 28, "portamento", 6)  # solo: slide

    # --- parameter automation ---------------------------------------------
    # Each entry below is logged to the automation map so it can be verified
    # on the device. ramp()/wave() generate per-step value curves; automate
    # writes the value lane + per-step flags + master flag.
    def ramp(steps, lo, hi):
        n = len(steps)
        return {s: round(lo + (hi - lo) * i / max(1, n - 1)) for i, s in enumerate(steps)}

    def wave(steps, lo, hi, period):
        import math
        return {s: round(lo + (hi - lo) * (0.5 - 0.5 * math.cos(2 * math.pi * i / period)))
                for i, s in enumerate(steps)}

    automations = []  # (section, track, pattern, param, curve, note)

    def auto(section, track, pat, param, curve, note):
        p.automate_param(idx(track, pat), param, curve)
        automations.append((section, f"T{track}", pat, param,
                            f"{min(curve.values())}→{max(curve.values())} over {len(curve)} steps", note))

    allsteps = list(range(1, 65))

    # CUTOFF — the signature breakdown filter open (smooth 64-step sweep)
    auto("breakdown", 5, 5, "cutoff", ramp(allsteps, 1200, 31000),
         "pad opens from near-closed to wide over all 4 bars")
    # CUTOFF — gentle groove swell (LFO-ish wobble on the pad)
    auto("groove", 5, 3, "cutoff", wave(allsteps, 9000, 22000, 16),
         "pad breathes once per bar")
    # CUTOFF — climax brightness rising through the anthem (lead)
    auto("climax", 6, 6, "cutoff", ramp(list(range(1, 33)), 14000, 30000),
         "lead brightens across the first half of the chorus")
    auto("climax-var", 6, 7, "cutoff", ramp(allsteps, 16000, 32000),
         "lead pushed fully bright in the final chorus")
    # SYNTH PARAM — bass grit driving the climaxes (param1 movement)
    auto("climax", 3, 6, "param1", wave(allsteps, 6000, 26000, 8),
         "bass timbre pulses every half-beat for drive")
    auto("climax-var", 3, 7, "param1", wave(allsteps, 8000, 30000, 8),
         "bass grit intensified")
    # SYNTH PARAM — pad texture evolving through the breakdown
    auto("breakdown", 5, 5, "param1", ramp(allsteps, 4000, 20000),
         "pad character morphs as the filter opens")
    # LFO PARAM ramp — tension/energy rising across the song sections
    auto("build", 5, 2, "lfo_param", ramp(allsteps, 3000, 9000),
         "LFO begins slow, edges up through the build")
    auto("groove", 5, 3, "lfo_param", ramp(allsteps, 9000, 14000),
         "LFO faster in the groove")
    auto("breakdown", 5, 5, "lfo_param", ramp(allsteps, 6000, 24000),
         "LFO accelerates dramatically as the breakdown swells")
    auto("climax", 5, 6, "lfo_param", ramp(allsteps, 22000, 30000),
         "LFO fast and intense at the peak")
    # PAN — ping-pong on the variation arp (now actually armed)
    p.automate_param(idx(4, 4), "pan",
                     {b * 16 + s: v for b in range(4) for s, v in
                      [(1, 9000), (5, 23000), (9, 9000), (13, 23000)]})
    automations.append(("groove-var", "T4", 4, "pan", "ping-pong L/R every 4 steps",
                        "arp bounces across the stereo field"))

    p.save(OUT)

    # --- automation map (for device verification) --------------------------
    SCENE_OF = {1: "1 intro", 2: "2 build", 3: "3 groove", 4: "4 groove-var",
                5: "5 breakdown", 6: "6 climax", 7: "7 climax-var", 8: "8 outro"}
    print("\nAUTOMATION MAP — watch/listen for these on device:")
    print(f"  {'section':<12}{'track':<6}{'scene played':<14}{'param':<11}{'curve':<26}what to notice")
    for sec, trk, pat, param, curve, note in automations:
        print(f"  {sec:<12}{trk:<6}{SCENE_OF[pat]:<14}{param:<11}{curve:<26}{note}")

    # --- verification -------------------------------------------------------
    data = Path(OUT).read_bytes()
    _, img = decode_project(data)
    import re
    sigs = len(re.findall(rb"\x00\x00\x00[\x00-\x0f]\xff\x00\xfc\x00", img))
    total = sum(len(pp) for ps in tracks.values() for pp in ps) + sum(len(h) for h in t8_hits.values())
    secs = len(chain) * 16 * 60 / 104       # 14 scenes × 4 bars × 4 beats
    print(f"\nAURORA ENGINE: {len(data):,} bytes raw, {len(img):,} decoded, "
          f"{sigs} structs (expect 72), ~{total} notes, "
          f"{len(chain)} scene-plays ≈ {int(secs//60)}:{int(secs%60):02d} at 104 BPM")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
