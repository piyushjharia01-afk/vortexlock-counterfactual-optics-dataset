# VORTEXLOCK Optical Surgery Corpus

## Identity and purpose

VORTEXLOCK v1.3.0 is an original, deterministic, physics-inspired synthetic corpus for learning blind optical control algebra and dual falsification certificates. Each scene contains intensity-only coded observations of six charged phase singularities, eight phase-plate operations, and a requested signed-crossing target. Training releases all 56 ordered two-operation outcomes, from which 112 oriented three-operation cycle holonomies and their unit dual witnesses are derived. Test outcomes are private.

The data were generated from scratch; they do not contain people, personal data, copyrighted images, or LLM outputs. Dataset licence: CC BY 4.0. Software licence: MIT.

## Files and shapes

- `train.csv` and `test.csv` have identical ordered feature columns: `scene_id`, `scene_file`, `candidate_catalog_json`, `goal_json`.
- `scenes/<scene_id>.npz` contains `frames` (`uint16`, shape `[6,8,64,64]`), `probe_order` (`int8`, length 6), `carrier_phase_rad` (`float32`, radians, length 6), and `plane_z` (`float32`, dimensionless normalized propagation coordinate, length 9).
- `train_targets.csv` contains the oriented three-control cycle with maximum directed circulation, its closed-loop braid holonomy, and its 32-value unit dual witness under the exact submission schema.
- `train_landscapes.jsonl` contains all 56 legal ordered pairs per training scene with their outcome braid, response, signed-crossing signature, and scalar utility.
- `sample_submission.csv` defines the submission contract.

## Field semantics and units

- `scene_id` is an opaque categorical key. It has no physical or predictive meaning.
- Candidate `cx` and `cy` are dimensionless aperture-plane coordinates on `[-1,1]`; `radius` uses the same normalized coordinate; `strength` and `twist` are dimensionless signed control amplitudes. Candidate list order is randomized independently per scene.
- `goal_json.signed_crossings` is a length-15 integer vector, one canonical unordered vortex-pair entry. Each integer is the oriented count of x-order exchanges across the nine propagation planes. It is not a class probability.
- Absolute landscape braid coordinates are dimensionless normalized sensor-plane positions. Prepared target `dxy` values are signed differences between A>B and B>A positions. `charge` is the integer topological charge `-1` or `+1`.
- Absolute landscape responses are normalized detector intensities in `[0,1]`. A prepared response target is the dimensionless L2-unit direction of the cycle detector holonomy after removing the public 18-dimensional coordinate/nuisance span. It is a dual certificate, not detector power, probability, or a raw intensity trace. There are 32 angular detectors and the residual subspace has rank 14.
- `utility` is a dimensionless pair-level construction objective in `(0,1]` computed before grading from target-signature error, trajectory curvature, and displacement. The action target maximizes the sum of three directed utility differences around a cycle; utility is not itself the final leaderboard score.
- `carrier_phase_rad` is in radians. Frame pixels are unsigned 16-bit digitizer counts on `[0,65535]`, not calibrated radiance.

## Construction and split

There are 1,024 training scenes and 320 test scenes. Scene seeds, opaque IDs, optical states, candidate IDs, candidate order, noise, and intervention landscapes are disjoint. Test scenes use held-out mechanism-composition cells across eight trajectory and five intervention families; family labels and test outcomes remain private. No test target, latent state, construction seed, or family appears in participant files.

## Known limitations, biases, and generalizability

This is a simplified scalar, paraxial, two-dimensional simulator, not a Maxwell solver or laboratory calibration standard. It fixes six unit-charge singularities, eight candidates, nine target planes, 32 detectors, a square aperture, and bounded noise. It omits polarization, chromatic dispersion, sensor saturation drift, higher-charge defects, three-dimensional material effects, and fabrication errors. The procedural basis and bounded parameter ranges create simulator bias; performance may not transfer to real optical benches, other apertures, other defect counts, or controls outside the released ranges. Signed crossings derived from nine planes can miss exchanges occurring between sampled planes. The OOD split measures recombination within this simulator, not universal physical generalization. Results must not be used for safety-critical laser control without experimental validation.
