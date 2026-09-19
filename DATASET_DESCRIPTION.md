# VORTEXLOCK Optical Surgery Corpus v1.3.0

## Intended use

VORTEXLOCK is an original synthetic dataset for training and evaluating blind optical intervention-algebra models. Given intensity-only measurements, a requested topological signature, and eight phase-plate controls, a model chooses an oriented three-control cycle, predicts its closed-loop braid holonomy, and synthesizes a unit dual witness for detector behavior outside the coordinate/nuisance explanation space. It supports research in inverse problems, discrete control curvature, proof-carrying prediction, antisymmetric operator learning, and constrained control. It is not a laboratory calibration standard or a safety-certified laser-control dataset.

## Source and generation process

No external images, measurements, personal data, or LLM outputs were collected. The corpus was generated from scratch by the deterministic NumPy pipeline in the private creator kit using master seed `1511506142`.

For each scene, the generator:

1. Samples six phase singularities, exactly three with topological charge `-1` and three with charge `+1`. Their dimensionless positions evolve over nine normalized propagation planes through a quadratic trajectory model plus weak charge-coupled rotation.
2. Samples eight scene-specific phase-plate controls. Each has a normalized center (`cx`, `cy`), normalized influence `radius`, and dimensionless signed `strength` and `twist`.
3. Replays all 56 legal ordered pairs. The first control changes the trajectories and the second acts on that changed state, so `A>B` generally differs from `B>A`.
4. Chooses a reachable length-15 signed-crossing goal. For every pair it records the resulting six-track braid, 32 angular-detector intensities, crossing vector, and construction utility. Utility is `exp(-0.85*topology_error - 1.6*trajectory_curvature - 0.18*mean_displacement)`. It is dimensionless and is not the leaderboard score.
5. Renders six coded intensity probes at eight observed planes on a `64 x 64` grid. Analytic interference fringes and Gaussian intensity nulls at vortex cores receive additive zero-mean Gaussian measurement noise with standard deviation from `0.035` to `0.063` in normalized intensity units. Values are clipped to `[0,1]` and quantized to unsigned 16-bit digitizer counts `[0,65535]`.
6. Independently shuffles probe and candidate order and generates opaque IDs from answer-independent construction keys.

The 1,024 training scenes occupy 32 mechanism/control composition cells. The 320 test scenes occupy eight different cells. Every individual mechanism and control value in test occurs in training, but the test pairings are held out. Scene seeds, IDs, candidate IDs, noise, and landscapes are disjoint.

## Prepared CSV files

`train.csv` has 1,024 rows and `test.csv` has 320 rows. Both have exactly these ordered columns:

- `scene_id`: opaque categorical join key with no physical unit or predictive meaning.
- `scene_file`: categorical relative NPZ path. The filename is not a feature.
- `candidate_catalog_json`: JSON array of eight objects. `id` is categorical; `cx` and `cy` are dimensionless aperture coordinates on `[-1,1]`; `radius` uses the same coordinate scale; `strength` and `twist` are dimensionless signed control amplitudes. Array position is randomized.
- `goal_json`: JSON object whose `signed_crossings` value is a length-15 integer vector in canonical unordered vortex-pair order. Each value is an oriented count of x-order exchanges across nine planes, not a probability.

`train_targets.csv` has 1,024 rows and these ordered columns. Its action is the oriented cycle maximizing `G(A,B,C)=C(A,B)+C(B,C)+C(C,A)`, where `C(A,B)=U(A>B)-U(B>A)`:

- `scene_id`: training join key.
- `action_json`: JSON object containing three distinct categorical IDs `first`, `second`, and `third`, defining one cycle orientation. Cyclic rotations are equivalent; reversed orientation is different.
- `braid_json`: JSON object containing six tracks. Each track has integer `charge` (`-1` or `+1`) and `dxy`, nine dimensionless closed-loop sums `D_x(A,B)+D_x(B,C)+D_x(C,A)` in `[-0.25,0.25]`. Track list order is not semantic.
- `response_json`: JSON array containing the 32 components of a dimensionless unit dual witness `lambda`. It is obtained by projecting the selected cycle's detector holonomy away from the 12 coordinate-Jacobian and six declared nuisance directions, then L2-normalizing the residual. Components lie in `[-1,1]`; they are neither probabilities nor optical power in watts.

`sample_submission.csv` has 320 test rows and exactly the same four ordered columns as `train_targets.csv`. Values are valid, nonconstant, label-free examples derived only from public candidate parameters. Participants construct 112 oriented-cycle labels from the absolute training landscapes by joining the six directed/reversed pair records on each cycle.

## Training landscapes

`train_landscapes.jsonl` contains one JSON object per training scene. `scene_id` is the join key. `landscape` maps each `<first_id>><second_id>` string to:

- `braid`: six charged tracks with nine coordinates each;
- `response`: 32 normalized detector intensities;
- `signature`: 15 integer signed-crossing counts;
- `utility`: dimensionless construction utility in `(0,1]`.

Every training scene has all 56 ordered pairs, sufficient to derive all 112 oriented three-control cycles. No test landscape is public.

## NPZ tensor structure

Each `scenes/<scene_id>.npz` contains:

- `frames`: `uint16`, shape `[6,8,64,64]`, layout `[stored_probe, observed_plane, y, x]`. Pixels are digitizer intensity counts, not radiance or probabilities.
- `probe_order`: `int8`, shape `[6]`. Entry `k` gives the pre-shuffle probe index stored at probe-axis position `k`.
- `carrier_phase_rad`: `float32`, shape `[6]`, carrier phase in radians aligned with stored-probe order.
- `plane_z`: `float32`, shape `[9]`, dimensionless target propagation coordinates from `-1` to `1`. The eight frame planes use evenly spaced rounded indices from this grid; braid labels contain all nine planes.

Arrays use NumPy C-order. Names, dtypes, shapes, and axis meanings are fixed; values are scene-specific.

## Organizer-only raw files

The private organizer archive additionally contains:

- `manifest.csv` with ordered columns `scene_id`, `scene_file`, `candidate_catalog_json`, `goal_json`, `split`, `truth_file`, `family`. The last three are categorical construction fields removed from participant inputs.
- `truth/<scene_id>.json` with all 56 outcomes, best action, best braid/response, and private family.
- `BUILD_INFO.json` with dataset identity, deterministic seed, row counts, and frame shape.
- `DATASET_CARD.md` and this description.

The organizer archive must not be shared with competitors. Platform preparation supplies public files; a public source release is a provenance mirror, not a runtime dependency.

## Licence and limitations

Dataset licence: **CC BY 4.0**. Licence URL: https://creativecommons.org/licenses/by/4.0/

The simulator is scalar, paraxial, two-dimensional, bounded, and physics-inspired rather than a full Maxwell solver. It fixes singularity count/charges, square geometry, detector layout, candidate count, and noise family. It omits polarization, chromatic dispersion, higher-charge defects, fabrication tolerances, sensor drift, real photon statistics, three-dimensional material effects, and laboratory backgrounds. Nine-plane sampling can miss crossings between planes. Results measure compositional generalization inside this simulator and may not transfer to real optical systems or interventions outside the released ranges.
