#!/usr/bin/env python3
"""Advanced writer for reproducing complex OP-XY note triggers.

Supports:
- Multiple Event Types: 0x25 (Grid), 0x21 (Live), 0x2d (Synth Grid).
- Arbitrary Tracks (1-16).
- Engine ID Modification.
- Full Parameter Control: Ticks, Gate, Note, Velocity.
"""

import sys
from pathlib import Path
import struct

def create_payload(event_type, notes):
    """
    Creates the event payload based on type.
    
    Args:
        event_type: 0x25, 0x21, or 0x2d.
        notes: List of dicts with keys: ticks, note, vel, gate, voice.
    """
    payload = bytearray()
    count = len(notes)
    
    if event_type in [0x25, 0x2d]:
        # Grid Structure
        # [Type] [Count] [Ticks:2] [Preamble:4/6] [Voice] [Note] [Vel] [Gate:3]
        # Note: 0x2d seems to use same structure as 0x25.
        
        payload.append(event_type)
        payload.append(count)
        
        for i, note_data in enumerate(notes):
            ticks = note_data['ticks']
            note_val = note_data['note']
            vel = note_data['vel']
            voice = note_data.get('voice', 1)
            gate = note_data.get('gate', 0) # Byte value (0-100)
            
            # Ticks (u16 LE)
            payload.extend(struct.pack('<H', ticks))
            
            # Preamble
            if ticks == 0:
                payload.extend(bytes.fromhex("02 F0 00 00"))
            else:
                payload.extend(bytes.fromhex("00 00 00 F0 00 00"))
                
            # Payload
            payload.append(voice)
            payload.append(note_val)
            payload.append(vel)
            payload.append(0x00)
            payload.append(0x00)
            payload.append(gate)
            
    elif event_type == 0x21:
        # Live Structure (derived from unnamed 50, 79, 56)
        # [21] [Count] [Ticks:4] [00] [Gate:2] [00 00] [Note] [Vel] [00 00] [64 01]
        
        payload.append(0x21)
        payload.append(count)
        
        for note_data in notes:
            ticks = note_data['ticks']
            note_val = note_data['note']
            vel = note_data['vel']
            gate = note_data.get('gate', 0) # Ticks value
            
            # Start Ticks (u32 LE)
            payload.extend(struct.pack('<I', ticks))
            
            # Padding
            payload.append(0x00)
            
            # Gate Ticks (u16 LE)
            payload.extend(struct.pack('<H', gate))
            
            # Padding (3 bytes)
            payload.extend(bytes.fromhex("00 00 00"))
            
            # Field A: [Note] [Vel] [00 00]
            # Note: For Synth tracks, C4 seems to be 48 (0x30).
            # We use the provided note value directly.
            payload.append(note_val)
            payload.append(vel)
            payload.extend(bytes.fromhex("00 00"))
            
            # Field B: [64] (Tail marker?)
            # The 01 that follows is likely the start of the tail pointer (01 10 F0).
            payload.append(0x64)
            
    return payload

def main():
    if len(sys.argv) < 4:
        print("Usage: write_note_v2.py <input> <output> <preset>")
        print("Presets: repro_50, repro_79, repro_56, repro_85, repro_38")
        sys.exit(1)

    input_path = Path(sys.argv[1])
    output_path = Path(sys.argv[2])
    preset = sys.argv[3]

    data = bytearray(input_path.read_bytes())
    
    # Preset Configuration
    track_idx = 1
    engine_id = None # Optional change
    event_type = 0x25
    notes = []
    
    if preset == "repro_50":
        # Track 3, Engine 03 (Default), Live C4 (48), Vel 33, Gate 329, Ticks 2251
        track_idx = 3
        # engine_id = 0x00 # Don't change engine ID
        event_type = 0x21
        notes.append({'ticks': 2251, 'gate': 329, 'note': 48, 'vel': 33})
        
    elif preset == "repro_79":
        # Track 3, Engine 00, Live C4 (48), Vel 122, Gate 395, Ticks 5877
        track_idx = 3
        engine_id = 0x00
        event_type = 0x21
        notes.append({'ticks': 5877, 'gate': 395, 'note': 48, 'vel': 122})
        
    elif preset == "repro_56":
        # Track 3, Engine 03 (Drum), Live C4 (48), Vel 100, Gate 960, Ticks 3840
        track_idx = 3
        engine_id = 0x03
        event_type = 0x21
        notes.append({'ticks': 3840, 'gate': 960, 'note': 48, 'vel': 100})
        
    elif preset == "repro_85":
        # Track 3, Engine 00, Grid C4 (48), Vel 100, Gate 100, Ticks 3840
        track_idx = 3
        engine_id = 0x00
        event_type = 0x2d # Synth Grid
        notes.append({'ticks': 3840, 'gate': 100, 'note': 48, 'vel': 100, 'voice': 1})
        
    # Locate Track Block
    # We iterate through blocks to find the Nth block.
    # Blocks start with 00 00 01 [EngineID].
    # But we need to be careful.
    # Let's use fixed offsets for unnamed 1.xy for simplicity, or scan.
    # Track 1: 0x0080
    # Track 2: 0x07AC
    # Track 3: 0x0EB0
    # Track 4: 0x1057
    # ...
    # Wait, these offsets are from inspect output of MODIFIED files.
    # Offsets in unnamed 1.xy might be different if previous tracks changed size.
    # But we are starting from unnamed 1.xy.
    # Let's find offsets in unnamed 1.xy.
    # Track 1: 0x0080
    # Track 2: 0x0800
    # Track 3: 0x0F04
    # Track 4: 0x10AB
    
    # Map track index to offset in unnamed 1.xy
    track_offsets = {
        1: 0x0080,
        2: 0x07AC,
        3: 0x0EB0,
        4: 0x1057,
        5: 0x1245,
        6: 0x13EC,
        7: 0x15A1,
        8: 0x176B,
        9: 0x1A5D,
        10: 0x1BBA,
        11: 0x1D17,
        12: 0x1E28,
        13: 0x1F85,
        14: 0x20D9,
        15: 0x222A,
        16: 0x2388
    }
    
    block_start = track_offsets.get(track_idx)
    if not block_start:
        print(f"Error: Track {track_idx} offset not defined.")
        sys.exit(1)
        
    print(f"Processing Track {track_idx} at {hex(block_start)}")
    
    # 1. Modify Engine ID if needed
    if engine_id is not None:
        # Engine ID is at block_start + 3
        # 00 00 01 [ID]
        old_id = data[block_start + 3]
        print(f"Changing Engine ID from {hex(old_id)} to {hex(engine_id)}")
        data[block_start + 3] = engine_id
        
    # 2. Modify Track Header (Active Signature)
    # Header signature is at block_start + 9?
    # Track 1: 0x0080. Sig at 0x0089. (+9)
    # Track 3: 0x0F04. Sig at 0x0F0D. (+9)
    sig_offset = block_start + 9
    if data[sig_offset:sig_offset+4] == b'\x05\x08\x00\x01':
        print("Modifying Track Header to Active")
        # Remove 2 bytes: 05 08 00 01 -> 07 01
        # We need to shift everything before we insert payload?
        # Actually, we replace 4 bytes with 2 bytes. So we shrink by 2.
        # Then we insert payload (replacing sentinel).
        
        # Let's do it in one pass.
        part1 = data[:sig_offset]
        new_header = b'\x07\x01'
        part2_start = sig_offset + 4
        
        # Find Sentinel
        # Sentinel varies (0x8A for Drum, 0x86 for Prism).
        # It is always followed by the tail pointer: 01 10 F0.
        # We search for the tail pointer.
        tail_ptr = bytes.fromhex("01 10 F0")
        sentinel_offset = -1
        
        # Search in the current block
        # We limit search to next track start to avoid false positives?
        # But we don't know next track start easily here.
        # Just search from block_start.
        
        try:
            tail_idx = data.index(tail_ptr, block_start)
            sentinel_offset = tail_idx - 1
        except ValueError:
            print("Error: Tail pointer 01 10 F0 not found.")
            sys.exit(1)
            
        print(f"Sentinel found at {hex(sentinel_offset)} (Value: {hex(data[sentinel_offset])})")
        
        # Check for 2-byte sentinel (e.g. 00 86)
        # Reverted: The 00 is likely padding, not part of sentinel to be consumed.
        # If we consume it, we break alignment with original file.
        sentinel_start = sentinel_offset
        sentinel_end = sentinel_offset + 1
        
        # if sentinel_offset > 0 and data[sentinel_offset-1] == 0x00:
        #      print("Found 00 byte before sentinel, consuming it.")
        #      sentinel_start -= 1
        
        part2 = data[part2_start:sentinel_start]
        
        # Construct Payload
        payload = create_payload(event_type, notes)
        
        part3 = data[sentinel_end:]
        
        new_data = part1 + new_header + part2 + payload + part3
        
        print(f"Original size: {len(data)}")
        print(f"New size: {len(new_data)}")
        delta = len(new_data) - len(data)
        print(f"Delta: {delta}")
        
        output_path.write_bytes(new_data)
        print(f"Wrote to {output_path}")
        
    else:
        print("Track header already modified or unknown format.")
        # If already modified, we might just need to insert payload?
        # But we assume unnamed 1.xy input.
        sys.exit(1)

if __name__ == "__main__":
    main()
