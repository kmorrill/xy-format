#!/usr/bin/env python3
"""Refactored writer for adding multiple note triggers to Track 1.

Based on reverse-engineering of unnamed 80.xy (Grid Notes).
Supports:
- Arbitrary steps (Absolute Ticks calculation).
- Multiple notes (Count + Loop).
- Correct Preamble generation for Grid notes.
"""

import sys
from pathlib import Path
import struct

def create_note_event(notes):
    """
    Creates a 0x25 Note Event byte sequence for the given list of notes.
    
    Args:
        notes: List of dicts, each containing:
            - step: 1-based step index (1-16)
            - note: MIDI note number (0-127)
            - vel: Velocity (0-127)
            - gate: Gate length (0-255, default 0)
            - voice: Voice ID (default 1)
            
    Returns:
        bytes: The complete 0x25 event payload.
    """
    count = len(notes)
    if count == 0:
        return b''
        
    # Sort notes by step/ticks?
    # unnamed 80 notes are ordered by step: 1, 5, 9, 13.
    # Within step 13 (chord), order is E4, G4, F4? No, let's stick to input order for now.
    # But generally should be sorted by time.
    notes.sort(key=lambda x: x['step'])
    
    payload = bytearray()
    
    # Event Header
    payload.append(0x25)
    payload.append(count)
    
    for i, note_data in enumerate(notes):
        step = note_data['step']
        note_val = note_data['note']
        vel = note_data['vel']
        voice = note_data.get('voice', 1)
        
        # Calculate Absolute Ticks
        # Step 1 = 0 ticks
        # Step 2 = 480 ticks (assuming 1920 ppqn / 4 steps per beat? No.)
        # unnamed 80:
        # Step 1 = 0
        # Step 5 = 1920 (0x0780) -> 480 * 4. So 480 ticks per step.
        ticks = (step - 1) * 480
        
        # Ticks (u16 LE)
        payload.extend(struct.pack('<H', ticks))
        
        # Preamble
        # Hypothesis: Ticks=0 uses 02 F0 00 00 (4 bytes).
        # Ticks>0 uses 00 00 00 F0 00 00 (6 bytes).
        if ticks == 0:
            # First note preamble (Step 1): 02 F0 00 00
            payload.extend(bytes.fromhex("02 F0 00 00"))
        else:
            # Subsequent note preamble or Step > 1: 00 00 00 F0 00 00
            payload.extend(bytes.fromhex("00 00 00 F0 00 00"))
            
        # Note Payload (6 bytes for Grid)
        # Voice (1) + Note (1) + Vel (1) + Gate/Flags (3)
        payload.append(voice)
        payload.append(note_val)
        payload.append(vel)
        
        # Gate/Flags: 00 00 [Gate]
        # unnamed 80: 00 00 00
        # unnamed 81: 00 00 64
        gate = note_data.get('gate', 0)
        payload.append(0x00)
        payload.append(0x00)
        payload.append(gate)
        
    # Tail Pointer
    # The tail (01 10 F0) is present in the original file after the sentinel.
    # We should NOT append it here if we are just inserting before part5.
    # part5 starts with 01 10 F0 in unnamed 1.xy.
    # So we just return the payload.
    # payload.extend(bytes.fromhex("01 10 F0"))
    
    return payload

def main():
    if len(sys.argv) < 3:
        print("Usage: write_note.py <input_file> <output_file> [preset_name]")
        print("Presets: single_step1, single_step9, grid_80")
        sys.exit(1)

    input_path = Path(sys.argv[1])
    output_path = Path(sys.argv[2])
    preset = sys.argv[3] if len(sys.argv) > 3 else "single_step1"

    data = bytearray(input_path.read_bytes())

    # 1. Modify Track 1 Header
    # Locate 05 08 00 01 at 0x0089
    if data[0x0089:0x008D] != b'\x05\x08\x00\x01':
        print("Warning: Track 1 header signature mismatch at 0x0089. Proceeding...")
    
    # Construct new header part
    # Remove 2 bytes: 05 08 00 01 -> 07 01
    part1 = data[:0x0089]
    new_header = b'\x07\x01'
    
    # Find Sentinel 8A.
    # In unnamed 1.xy, it's at 0x07A8.
    sentinel_offset = 0x07A8
    
    part3 = data[0x008D:sentinel_offset]
    
    # Define Notes based on preset
    notes = []
    if preset == "single_step1":
        # unnamed 2.xy: Gate 64 (100)
        notes.append({'step': 1, 'note': 60, 'vel': 100, 'gate': 100})
    elif preset == "single_step9":
        # unnamed 81.xy: Gate 64 (100)
        notes.append({'step': 9, 'note': 60, 'vel': 100, 'gate': 100})
    elif preset == "grid_80":
        # unnamed 80.xy: Gate 0
        # Step 1: C4 (60)
        notes.append({'step': 1, 'note': 60, 'vel': 100, 'gate': 0})
        # Step 5: D4 (62)
        notes.append({'step': 5, 'note': 62, 'vel': 100, 'gate': 0})
        # Step 9: E4 (64)
        notes.append({'step': 9, 'note': 64, 'vel': 100, 'gate': 0})
        # Step 13: F4 (65), G4 (67), A4 (69)
        notes.append({'step': 13, 'note': 69, 'vel': 100, 'gate': 0}) # A4
        notes.append({'step': 13, 'note': 67, 'vel': 100, 'gate': 0}) # G4
        notes.append({'step': 13, 'note': 65, 'vel': 100, 'gate': 0}) # F4
        # Note: Order in unnamed 80 was E4, A4, G4, F4?
        # Let's trust the sort in create_note_event for step, but for same step?
        # We'll see.
        
    # Generate Payload
    payload = create_note_event(notes)
    
    # Part 5: Rest of file (after Sentinel)
    part5 = data[sentinel_offset+1:]
    
    # Assemble
    new_data = part1 + new_header + part3 + payload + part5
    
    print(f"Original size: {len(data)}")
    print(f"New size: {len(new_data)}")
    delta = len(new_data) - len(data)
    print(f"Delta: {delta}")
    
    output_path.write_bytes(new_data)
    print(f"Wrote to {output_path}")

if __name__ == "__main__":
    main()
