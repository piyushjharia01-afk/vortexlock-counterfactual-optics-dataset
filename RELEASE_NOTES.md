# VORTEXLOCK Blind Optical Holonomy Corpus v1.2.0

This is the canonical participant-safe release of the VORTEXLOCK Optical Surgery Corpus.

## Release asset

`VORTEXLOCK_public_dataset.zip`

- Size: 629,488,570 bytes
- SHA-256: `2ce91621da624a43934f9d3ba55b648242c3d49a8640c53b26337fa55556eeeb`
- Train scenes: 1,024
- Test scenes: 320
- Licence: CC BY 4.0

Version 1.2.0 preserves every scene tensor and all 56 directed pair outcomes per scene while changing the prepared learning target to oriented three-operation holonomy. Each target selects one of 112 oriented cycles and predicts the signed circulation of pairwise braid and detector effects around that closed control loop. Cyclic rotations denote the same action; reversing orientation negates the continuous target. This converts the benchmark from pair-effect prediction into scene-local discrete-curvature cartography without regenerating the physical corpus.

This release intentionally excludes organizer truth, private answers, grading code, construction seeds, and creator-only materials.
