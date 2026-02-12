#!/usr/bin/env python3
import subprocess
import sys
from pathlib import Path

def run_test(preset, original_filename):
    print(f"\n--- Testing {preset} -> {original_filename} ---")
    
    original_path = Path(f"src/one-off-changes-from-default/{original_filename}")
    output_path = Path(f"output/{preset}.xy")
    input_path = Path("src/one-off-changes-from-default/unnamed 1.xy")
    
    # Run Writer
    cmd = [
        "python3", "tools/write_note_v2.py",
        str(input_path),
        str(output_path),
        preset
    ]
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Writer failed:\n{result.stderr}")
        return False
        
    print(result.stdout.strip())
    
    # Compare Files
    if not output_path.exists():
        print("Output file not created.")
        return False
        
    orig_data = original_path.read_bytes()
    new_data = output_path.read_bytes()
    
    if orig_data == new_data:
        print("SUCCESS: Files are identical.")
        return True
    else:
        print("FAILURE: Files differ.")
        print(f"Original size: {len(orig_data)}")
        print(f"New size: {len(new_data)}")
        
        # Run Diff Tool
        diff_cmd = [
            "python3", "tools/diff_xy.py",
            str(output_path),
            str(original_path)
        ]
        subprocess.run(diff_cmd)
        return False

def main():
    tests = [
        ("repro_50", "unnamed 50.xy"),
        ("repro_79", "unnamed 79.xy"),
        ("repro_56", "unnamed 56.xy"),
        ("repro_85", "unnamed 85.xy")
    ]
    
    results = []
    for preset, filename in tests:
        success = run_test(preset, filename)
        results.append((preset, success))
        
    print("\n=== Summary ===")
    for preset, success in results:
        status = "PASS" if success else "FAIL"
        print(f"{preset}: {status}")

if __name__ == "__main__":
    main()
