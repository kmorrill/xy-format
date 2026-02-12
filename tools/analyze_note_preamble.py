#!/usr/bin/env python3
import sys
from pathlib import Path

def analyze_preamble(file_path, offset, count, known_notes):
    data = Path(file_path).read_bytes()
    cursor = offset
    print(f"Analyzing {file_path} at {hex(cursor)} with count {count}")
    
    for i in range(count):
        target_note = known_notes[i]
        
        # Find note byte
        # Look ahead up to 32 bytes
        chunk = data[cursor:cursor+32]
        found_at = -1
        
        # Heuristic: Look for Note byte.
        # Check if byte before is 00 or 01 (Voice ID)
        for j in range(len(chunk)):
            if chunk[j] == target_note:
                if j > 0 and chunk[j-1] in [0x00, 0x01]:
                    found_at = j
                    break
        
        if found_at != -1:
            note_offset = cursor + found_at
            # Preamble starts at cursor, ends at note_offset - 1 (Voice ID)
            preamble = data[cursor:note_offset-1]
            
            # Parse Ticks (first 2 bytes)
            ticks = int.from_bytes(preamble[:2], 'little')
            
            # Remaining Preamble
            remainder = preamble[2:]
            
            print(f"Note {i+1} ({hex(target_note)}): Ticks={ticks} ({hex(ticks)}) | Rem={remainder.hex(' ')}")
            
            # Advance cursor past payload
            # Payload: Voice(1) + Note(1) + Vel(1) + Gate/Flags(??)
            # Let's assume payload ends when next preamble starts?
            # Or assume fixed length?
            # unnamed 80: 01 3C 64 00 00 00 (6 bytes)
            # unnamed 3: 3C 4B 00 00 (4 bytes?)
            
            # Hack: Advance by found_at + payload_len
            # unnamed 80: 01 3C 64 00 00 00 (6 bytes)
            # unnamed 3: 00 3C 4B 00 00 (5 bytes)
            
            if "80.xy" in file_path:
                payload_len = 6
            else:
                payload_len = 5
                
            cursor = note_offset + payload_len - 1 # -1 because note_offset includes Voice ID which is part of payload
            # Wait, note_offset is index of Note Byte.
            # Voice ID is at note_offset - 1.
            # Payload starts at note_offset - 1.
            # So we want to jump to (note_offset - 1) + payload_len.
            cursor = (note_offset - 1) + payload_len
            # Then scan for next preamble start?
            # Actually, the loop will handle the scan.
            # But we need to be careful not to skip too far.
            
        else:
            print(f"Note {i+1} not found")
            break

if __name__ == "__main__":
    print("--- unnamed 80.xy ---")
    analyze_preamble("src/one-off-changes-from-default/unnamed 80.xy", 0x07BC, 6, [0x3C, 0x3E, 0x40, 0x45, 0x43, 0x41])
    
    print("\n--- unnamed 3.xy ---")
    analyze_preamble("src/one-off-changes-from-default/unnamed 3.xy", 0x07A8, 3, [0x3C, 0x43, 0x40]) # Order: C, G, E?
