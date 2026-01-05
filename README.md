# Summary
This repository is meant to be used as a template. When creating a new narrative, create a new repository using this repo as a template.

# How to use
- Update the `doc_info.toml` file with the appropriate information
- Write your narrative
- When creating new commits, use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/). This will ensure that the changelog generation works correctly.
  - Use the following commit types:
    - `feat:` for changes to the repo and CI/CD pipeline
    - `logic:` for logic and diagram changes
    - `docs:` for documentation changes
    - `fix:` for fixes in the document
  - Other commit types will be ignored during changelog generation, but keep using conventional commit regardless. This will allow us to easily inspect internal changes.
- Once ready to release, create a new Pre-Release by creating a tag through the GitHub web UI
  - Tag format should be as follows:
    - `v<major>.<minor>`
    - `v<major>.<minor>-rc<number>`
  - GitHub Actions will automatically create the actual Release and generate the changelogs.

## Local usage
- To run the metadata generation locally, simply run the script found at `scripts/generate_metadata.sh`
- To run the changelog file generation locally, run `git-cliff -c cliff-typ.toml -o changelog.typ`
