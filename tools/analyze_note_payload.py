#!/usr/bin/env python3
import sys
from pathlib import Path

def analyze_payload(file_path, offset, count):
    data = Path(file_path).read_bytes()
    # Start after 0x25 <count>
    # In unnamed 80, 0x25 is at 0x07BA. Count is 0x06.
    # So payload starts at 0x07BC.
    
    cursor = offset
    print(f"Analyzing {file_path} at {hex(cursor)} with count {count}")
    
    # We expect 'count' notes.
    # Let's try to find the pattern: [Timestamp] [Coarse] [Voice] [Note] [Vel]
    
    # Known notes in unnamed 3:
    # C4 (3C), E4 (40), G4 (43)
    known_notes = [0x3C, 0x40, 0x43] # Order to be verified
    
    current_note_idx = 0
    
    while current_note_idx < count:
        print(f"\n--- Note {current_note_idx + 1} ---")
        print(f"Cursor: {hex(cursor)}")
        
        # Peek next 32 bytes
        chunk = data[cursor:cursor+32]
        print(f"Next bytes: {chunk.hex(' ')}")
        
        # Search for next known note
        target_note = known_notes[current_note_idx]
        # We look for [01 <note> <vel>] or just [<note> <vel>]
        # Velocity is likely > 0.
        
        # Simple search for the note byte
        found_at = -1
        for i in range(len(chunk)):
            if chunk[i] == target_note:
                # Check if it looks like a note payload
                # Expecting Voice ID (01) before it?
                if i > 0 and chunk[i-1] == 0x01:
                    found_at = i
                    break
        
        if found_at != -1:
            # Found note!
            note_offset = cursor + found_at
            print(f"Found Note {hex(target_note)} at {hex(note_offset)} (local offset {found_at})")
            
            # Analyze bytes BEFORE the note
            preamble = data[cursor:note_offset-1] # -1 for Voice ID
            print(f"Preamble ({len(preamble)} bytes): {preamble.hex(' ')}")
            
            # Analyze Note Payload
            # Voice (1) + Note (1) + Vel (1) + Gate/Flags (3?)
            payload = data[note_offset-1:note_offset+5]
            print(f"Payload candidate: {payload.hex(' ')}")
            
            # Advance cursor
            # Assume Payload is 6 bytes?
            cursor = note_offset - 1 + 6
            current_note_idx += 1
        else:
            print(f"Could not find note {hex(target_note)}")
            # Debug: print raw hex to see what's there
            print(f"Raw chunk: {chunk.hex(' ')}")
            break

if __name__ == "__main__":
    # unnamed 3.xy
    path = "src/one-off-changes-from-default/unnamed 3.xy"
    # 0x25 is at 0x07A6 (based on diff_3.txt or assumption).
    # Let's verify with hexdump first? 
    # Previous hexdump said 07A6: 25 03 ...
    # So payload starts at 07A8.
    
    # Notes: C4 (3C), E4 (40), G4 (43)
    # Order might be different.
    analyze_payload(path, 0x07A8, 3)
