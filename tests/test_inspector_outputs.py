import difflib
import os
import re
import subprocess
import sys
from collections import Counter
from functools import lru_cache
from pathlib import Path

import pytest


ROOT = Path(__file__).resolve().parents[1]
INSPECTOR = ROOT / "tools" / "inspect_xy.py"
CHANGE_LOG = ROOT / "src" / "one-off-changes-from-default" / "op-xy_project_change_log.md"
DATA_DIR = ROOT / "src" / "one-off-changes-from-default"
BASELINE_FILE = DATA_DIR / "unnamed 1.xy"


def _label_to_filename(label: str) -> Path:
    name = label.replace("_", " ")
    return DATA_DIR / f"{name}.xy"


def _parse_change_log() -> list[tuple[str, str]]:
    entries: dict[str, str] = {}
    pattern = re.compile(r"\*\*(.+?)\*\*\s+—\s+(.+)")
    text = CHANGE_LOG.read_text()
    for label, description in pattern.findall(text):
        entries[label.strip()] = description.strip()
    return sorted(entries.items(), key=lambda pair: pair[0])


@lru_cache(maxsize=None)
def _run_inspector(path: Path) -> tuple[int, str, str]:
    env = os.environ.copy()
    existing_path = env.get("PYTHONPATH")
    if existing_path:
        env["PYTHONPATH"] = f"{ROOT}:{existing_path}"
    else:
        env["PYTHONPATH"] = str(ROOT)
    proc = subprocess.run(
        [sys.executable, str(INSPECTOR), str(path)],
        capture_output=True,
        text=True,
        check=False,
        env=env,
    )
    return proc.returncode, proc.stdout, proc.stderr


def _meaningful_diff(a: str, b: str) -> tuple[list[str], list[str]]:
    diff = difflib.unified_diff(
        a.splitlines(), b.splitlines(), lineterm="", fromfile="baseline", tofile="candidate"
    )
    additions: list[str] = []
    deletions: list[str] = []
    for line in diff:
        if line.startswith("+++ ") or line.startswith("--- "):
            continue
        if line.startswith("File:"):
            continue
        if line.startswith("+File:") or line.startswith("-File:"):
            continue
        if line.startswith("+"):
            content = line[1:]
            if content.strip():
                additions.append(content)
        elif line.startswith("-"):
            content = line[1:]
            if content.strip():
                deletions.append(content)
    return additions, deletions


CHANGE_LOG_ENTRIES = _parse_change_log()


def change_log_cases():
    for label, description in CHANGE_LOG_ENTRIES:
        path = _label_to_filename(label)
        yield {
            "label": label,
            "description": description,
            "path": path,
        }


ALL_CASES = list(change_log_cases())


BASELINE_CODE, BASELINE_OUT, BASELINE_ERR = _run_inspector(BASELINE_FILE)
assert BASELINE_CODE == 0, f"Baseline inspector run failed: {BASELINE_ERR}"


@pytest.mark.parametrize("case", ALL_CASES, ids=lambda case: case["label"])
def test_inspector_output_differs_from_baseline(case):
    path = case["path"]
    if not path.exists():
        pytest.skip(f"{path.name} not present in repository")

    label = case["label"]
    code, output, err = _run_inspector(path)
    assert code == 0, f"Inspector failed for {path.name}: {err}"

    if label == "unnamed_1":
        assert output == BASELINE_OUT, "Baseline inspector output drifted"
        return

    additions, deletions = _meaningful_diff(BASELINE_OUT, output)
    assert additions or deletions, f"No meaningful differences detected for {path.name}"


EXPECTATIONS: dict[str, dict] = {
    "unnamed_4": {"contains": [r"Tempo:\s+40\.0 BPM"]},
    "unnamed_5": {"contains": [r"Tempo:\s+121\.2 BPM"]},
    "unnamed_10": {"contains": [r"Metronome Level:\s+0x10"]},
    "unnamed_11": {"contains": [r"Groove Type:\s+0x08\s+\(\"dis-funk\"\)"]},
    "unnamed_12": {"contains": [r"Groove Type:\s+0x03\s+\(\"bombora\"\)"]},
    "unnamed_2": {
        "contains": [r"note=C4"],
        "expected_notes": ["C4"],
    },
    "unnamed_3": {
        "contains": [r"note=C4", r"note=E4", r"note=G4"],
        "expected_notes": ["C4", "E4", "G4"],
        "expected_tail_notes": ["E4"],
    },
    "unnamed_6": {"contains": [r"Max Slot Index @0x56:\s+0x0001"]},
    "unnamed_7": {"contains": [r"Max Slot Index @0x56:\s+0x0002"]},
    "unnamed_17": {"contains": [r"Pattern Length @0x007E:\s+2 bars \(0x20\)"]},
    "unnamed_18": {"contains": [r"Pattern Length @0x007E:\s+3 bars \(0x30\)"]},
    "unnamed_19": {"contains": [r"Pattern Length @0x007E:\s+4 bars \(0x40\)"]},
    "unnamed_20": {"contains": [r"Track 1\s+Block @0x0080\s+Engine ID: 0x00\s+Scale: Track Scale 2 \(0x05\)"]},
    "unnamed_21": {"contains": [r"Track 1\s+Block @0x0080\s+Engine ID: 0x00\s+Scale: Track Scale 16 \(0x0E\)"]},
    "unnamed_22": {"contains": [r"Track 1\s+Block @0x0080\s+Engine ID: 0x00\s+Scale: Track Scale 1 \(0x01\)"]},
    "unnamed_39": {
        "contains": [r"Live trig @0x", r"EventType 0x21"],
        "expected_tail_notes": [],
    },
    "unnamed_50": {
        "contains": [r"Live trig @0x", r"step 6\b"],
        "expected_tail_notes": [],
    },
    "unnamed_56": {
        "contains": [r"gate=960 ticks \(~2\.00 steps\)"],
        "expected_tail_notes": [],
    },
    "unnamed_57": {
        "contains": [r"gate=1920 ticks \(~4\.00 steps\)"],
        "expected_tail_notes": [],
    },
    "unnamed_59": {"contains": [r"tag=0x00\s+raw=00000160000004ff7f"]},
    "unnamed_60": {"contains": [r"tag=0x01\s+raw=0160000004ff7f"]},
    "unnamed_61": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_62": {"contains": [r"tag=0x1E\s+raw=1e250000094000000140"]},
    "unnamed_63": {"contains": [r"tag=0x1E\s+raw=1e250000094000000140"]},
    "unnamed_66": {"contains": [r"tag=0x00\s+raw=0001400000014000000160000004ff7f"]},
    "unnamed_67": {"contains": [r"tag=0x01\s+raw=0160000004ff7f"]},
    "unnamed_68": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_69": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_70": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_71": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_72": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_73": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_74": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_75": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_76": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_77": {"contains": [r"tag=0x01\s+raw=014000000160000004ff7f"]},
    "unnamed_78": {
        "contains": [r"tag=0x01\s+raw=014000000160000004ff7f"],
        "expected_tail_notes": [],
    },
    "unnamed_79": {
        "contains": [r"Live trig @0x"],
        "expected_tail_notes": [],
    },
    "unnamed_80": {
        "contains": [
            r"note=C4",
            r"note=D4",
            r"note=E4",
            r"note=G4",
            r"note=A4",
            r"EventType 0x21",
            r"note data unresolved",
        ],
        "expected_notes": ["C4", "D4", "E4", "F4", "G4", "A4"],
        "expected_tail_notes": ["G4"],
    },
    "unnamed_38": {
        "contains": [
            r"Track 4",
            r"EventType 0x21",
            r"note data unresolved",
        ],
        "expected_notes": [],
    },
    "unnamed_14": {"contains": [r"Low\s+value=0xFFFF\s+id=0x000E", r"Mid\s+value=0x0500"]},
    "unnamed_15": {"contains": [r"High value=0x0500"]},
    "unnamed_16": {"contains": [r"High value=0x0100"]},
    "unnamed_34": {"contains": [r"Engine ID: 0x16\s+\(Axis\)"]},
    "unnamed_23": {"contains": [r"Track 3", r"Engine ID: 0x00"]},
    "unnamed_24": {"contains": [r"Track 3", r"Engine ID: 0x00"]},
    "unnamed_25": {"contains": [r"Track 3", r"Engine ID: 0x00"]},
    "unnamed_26": {"contains": [r"Track 3", r"Engine ID: 0x00"]},
    "unnamed_27": {"contains": [r"Track 3", r"Engine ID: 0x00"]},
    "unnamed_28": {"contains": [r"Track 3", r"Engine ID: 0x12"]},
    "unnamed_29": {"contains": [r"Track 3", r"M3 Filter=off"]},
    "unnamed_31": {
        "contains": [
            r"M4 LFO=on",
        ],
    },
    "unnamed_32": {"contains": [r"tag=0x01\s+raw=0160000004ff7f"]},
    "unnamed_33": {"contains": [r"tag=0x00\s+raw=00014000000160000004ff7f"]},
    "unnamed_35": {"contains": [r"tag=0x00\s+raw=0000ff0000ff0000ffffff"]},
    "unnamed_36": {"contains": [r"Slot 0x00FF @0x0FF0 → tag=0x00"]},
    "unnamed_37": {"contains": [r"Slot 0x00FF @0x0FF0 → tag=0x00"]},
    "unnamed_40": {"contains": [r"tag=0x00\s+raw=00094000000140000001400000016000"]},
    "unnamed_41": {"contains": [r"Slot 0x00D6 @0x0D60"]},
    "unnamed_52": {
        "contains": [r"note=C4"],
        "expected_notes": ["C4"],
    },
    "unnamed_53": {"contains": [r"no quantised events detected"]},
    "unnamed_54": {"contains": [r"Slot 0x0140 @0x1400"]},
    "unnamed_65": {
        "contains": [
            r"Track 3",
            r"Live trig @0x",
            r"step 9\b",
            r"form=pointer-21",
            r"note data unresolved",
        ],
        "expected_tail_notes": [],
    },
    "unnamed_81": {
        "contains": [
            r"nearest_step=9",
            r"note=C4",
        ],
        "expected_notes": ["C4"],
        "expected_tail_notes": [],
    },
    "unnamed_85": {
        "contains": [
            r"Track 3",
            r"EventType 0x21",
        ],
        "expected_tail_notes": [],
    },
    "unnamed_86": {
        "contains": [
            r"Track 3",
            r"EventType 0x21",
        ],
        "expected_tail_notes": [],
    },
    "unnamed_87": {
        "contains": [
            r"Track 3",
            r"EventType 0x21",
        ],
        "expected_tail_notes": [],
    },
}


EXPECTATION_PARAMS = []
EXPECTATION_IDS: list[str] = []
for label, spec in EXPECTATIONS.items():
    marks = []
    if "xfail" in spec:
        marks.append(pytest.mark.xfail(reason=spec["xfail"]))
    EXPECTATION_PARAMS.append(pytest.param(label, spec, marks=marks))
    EXPECTATION_IDS.append(label)


@pytest.mark.parametrize("label, spec", EXPECTATION_PARAMS, ids=EXPECTATION_IDS)
def test_inspector_contains_expected_patterns(label, spec):
    path = _label_to_filename(label)
    if not path.exists():
        pytest.skip(f"{path.name} not present in repository")

    code, output, err = _run_inspector(path)
    assert code == 0, f"Inspector failed for {path.name}: {err}"

    for pattern in spec.get("contains", []):
        assert re.search(pattern, output), f"{path.name} missing pattern {pattern}"

    expected_notes = spec.get("expected_notes")
    if expected_notes is not None:
        actual_notes = _extract_note_names(output)
        assert Counter(actual_notes) == Counter(expected_notes), (
            f"{path.name} note inventory mismatch.\n"
            f"  expected: {Counter(expected_notes)}\n"
            f"  actual:   {Counter(actual_notes)}\n"
            f"  output:\n{output}"
        )

    expected_tail_notes = spec.get("expected_tail_notes")
    if expected_tail_notes is not None:
        actual_tail_notes = _extract_tail_note_names(output)
        assert Counter(actual_tail_notes) == Counter(expected_tail_notes), (
            f"{path.name} tail-note inventory mismatch.\n"
            f"  expected: {Counter(expected_tail_notes)}\n"
            f"  actual:   {Counter(actual_tail_notes)}\n"
            f"  output:\n{output}"
        )


NOTE_LINE_PATTERN = re.compile(r"^\s*• note\[\d+\]:.*?note=([A-G](?:#|b)?-?\d{1,2})\b")
TAIL_LINE_PATTERN = re.compile(r"tail\[\d+\]:\s+note=([A-G](?:#|b)?-?\d{1,2})\b")


def _extract_note_names(report: str) -> list[str]:
    notes: list[str] = []
    for line in report.splitlines():
        match = NOTE_LINE_PATTERN.search(line)
        if match:
            notes.append(match.group(1))
    return notes


def _extract_tail_note_names(report: str) -> list[str]:
    return TAIL_LINE_PATTERN.findall(report)
