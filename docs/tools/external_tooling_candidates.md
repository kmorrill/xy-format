# External Tooling Candidates

## Purpose
This document lists open-source tooling that can help the OP-XY `.xy` reverse-engineering workflow.
It is scoped to current bottlenecks seen in this repo: structural crash repro, pointer-tail decode gaps, and repeated rule refinements in writer logic.

## Current Workflow Gaps
- Manual alignment of shifted binary regions is still expensive during descriptor and tail analysis.
- Crash repro artifacts are not automatically minimized to the smallest byte delta.
- Parser/writer invariants are mostly example-based; property-based stress is still limited.
- Pointer-tail and pointer-21 regions need better visual structure overlays than plain hex dumps.

## Candidate Shortlist

### 1) ImHex + ImHex Patterns
- Repo:
  - [ImHex](https://github.com/WerWolv/ImHex)
  - [ImHex-Patterns](https://github.com/WerWolv/ImHex-Patterns)
- Best fit for:
  - Visual decoding of pre-track descriptors and pointer-tail slabs.
  - Declaring known structures while leaving unknown regions opaque.
  - Fast side-by-side inspection when offsets drift after activation or insertion.
- Why it is high value:
  - Directly supports the current pointer-tail / pointer-21 decode problem.
  - Helps convert format knowledge from prose into executable structure overlays.

### 2) Kaitai Struct + Visualizer
- Repo:
  - [Kaitai Struct](https://github.com/kaitai-io/kaitai_struct)
  - [Kaitai Visualizer](https://github.com/kaitai-io/kaitai_struct_visualizer)
- Best fit for:
  - Building machine-checkable `.xy` format specs from stable findings.
  - Regression-friendly decode outputs for CI and docs sync.
- Why it is high value:
  - Strong complement to current Python parsing by formalizing field layout and boundaries.

### 3) Shrinkray
- Repo: [Shrinkray](https://github.com/DRMacIver/shrinkray)
- Best fit for:
  - Reducing crash-inducing files to minimal repro artifacts.
- Why it is high value:
  - Directly improves crash-capture quality and speeds root-cause isolation.

### 4) Picire
- Repo: [Picire](https://github.com/renatahodovan/picire)
- Best fit for:
  - Delta-debugging binary mutations that trigger a pass/crash boundary.
- Why it is high value:
  - Useful backup reducer when a single minimizer strategy stalls.

### 5) Hypothesis (and optional HypoFuzz)
- Repo:
  - [Hypothesis](https://github.com/HypothesisWorks/hypothesis)
  - [HypoFuzz](https://github.com/Zac-HD/hypofuzz)
- Best fit for:
  - Property-based parser/writer invariant testing.
  - Auto-shrinking counterexamples for structural regressions.
- Why it is high value:
  - Matches the repo's strict round-trip and crash-avoidance goals.

### 6) AFL++
- Repo: [AFL++](https://github.com/AFLplusplus/AFLplusplus)
- Best fit for:
  - Hardening parsers and inspector logic with fuzzed corpus mutations.
  - Using `afl-tmin` style reduction for pathological inputs.
- Why it is high value:
  - Good for defensive parser stability once format rules are broader.

### 7) Rizin / VBinDiff (supplemental diff viewers)
- Repo:
  - [Rizin](https://github.com/rizinorg/rizin)
  - [VBinDiff](https://github.com/madsen/vbindiff)
- Best fit for:
  - Secondary low-level binary diff workflows.
- Why it is lower priority:
  - Helpful, but less aligned to structure overlay needs than ImHex/Kaitai.

## Suggested Adoption Order
1. ImHex + ImHex Patterns
2. Shrinkray
3. Hypothesis
4. Kaitai Struct
5. Picire / AFL++ (as needed)

## Notes
- These are candidates, not adopted dependencies.
- Keep canonical findings in `docs/format/*` and use external tools as analysis aids.
- Preserve unknown bytes in authoring paths until decoded and device-validated.
