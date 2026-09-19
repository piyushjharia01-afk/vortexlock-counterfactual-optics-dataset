# GitHub publication checklist

Repository name: `vortexlock-counterfactual-optics-dataset`

Repository URL: `https://github.com/anjalikhatri019-hub/vortexlock-counterfactual-optics-dataset`

Canonical Source URL after publication: `https://github.com/anjalikhatri019-hub/vortexlock-counterfactual-optics-dataset/releases/tag/v1.2.0`

## Files committed to the repository

1. Rename `github_source_release/README.md` to repository-root `README.md`.
2. Upload `DATASET_DESCRIPTION.md` from the VORTEXLOCK workspace root.
3. Upload `DATASET_CARD.md` from the VORTEXLOCK workspace root.
4. Upload `LICENSE` from the VORTEXLOCK workspace root.
5. Upload `dataset-metadata.json`.
6. Upload `SOURCE_MANIFEST.json`.
7. Upload `CITATION.cff`.
8. Upload `RELEASE_NOTES.md`.
9. Upload `SHA256SUMS`.
10. Upload `.gitignore`.

Do not commit the 629 MB dataset ZIP to the repository. Attach it to the GitHub Release instead.

## Release

1. Open **Releases** and select **Draft a new release**.
2. Create tag `v1.2.0` from the default branch.
3. Set release title to `VORTEXLOCK Blind Optical Holonomy Corpus v1.2.0`.
4. Paste the contents of `RELEASE_NOTES.md` into the release description.
5. Attach `release_final/VORTEXLOCK_public_dataset.zip` as the binary release asset.
6. Confirm the asset name is exactly `VORTEXLOCK_public_dataset.zip`.
7. Publish the release and mark it as the latest release.

## Verification and Eris

1. Sign out or use a private browser window and open the canonical Source URL.
2. Confirm the page and release asset download without authentication.
3. Run `verify_release.ps1` from PowerShell.
4. In Eris, keep `VORTEXLOCK_raw_organizer.zip` as the uploaded organizer dataset.
5. Set Source URL to the versioned GitHub Release page.
6. Set dataset licence to `CC BY 4.0`.
7. Set licence URL to `https://creativecommons.org/licenses/by/4.0/` if a separate field exists.
8. Re-run Prepare, Dataset Quality, and all downstream checks.

Never publish `VORTEXLOCK_raw_organizer.zip`, `answers.csv`, `truth/`, `grade.py`, the creator kit, construction seeds, or private prepared data.
