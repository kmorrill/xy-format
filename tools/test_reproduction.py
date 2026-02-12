#!/usr/bin/env python3
import subprocess
import sys
from pathlib import Path

def run_test(preset, target_file, output_file):
    print(f"\n--- Testing {preset} -> {target_file} ---")
    
    # Run writer
    cmd = ["python3", "tools/write_note.py", "src/one-off-changes-from-default/unnamed 1.xy", output_file, preset]
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Writer failed:\n{result.stderr}")
        return False
    print(result.stdout.strip())
    
    # Run Diff
    target_path = f"src/one-off-changes-from-default/{target_file}"
    cmd_diff = ["python3", "tools/diff_xy.py", output_file, target_path]
    result_diff = subprocess.run(cmd_diff, capture_output=True, text=True)
    
    if "Files are identical" in result_diff.stdout:
        print("SUCCESS: Files are identical.")
        return True
    else:
        print("FAILURE: Files differ.")
        # Save diff output
        diff_out = f"output/diff_{preset}.txt"
        Path(diff_out).write_text(result_diff.stdout)
        print(f"Diff saved to {diff_out}")
        # Print first few lines of diff
        print("\n".join(result_diff.stdout.splitlines()[:20]))
        return False

def main():
    success = True
    
    # Test 1: unnamed 81 (Single Note Step 9)
    if not run_test("single_step9", "unnamed 81.xy", "output/repro_81.xy"):
        success = False
        
    # Test 2: unnamed 80 (Grid Pattern)
    if not run_test("grid_80", "unnamed 80.xy", "output/repro_80.xy"):
        success = False
        
    if not success:
        sys.exit(1)

if __name__ == "__main__":
    main()
