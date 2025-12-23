# Summary
This repository is meant to be used as a template. When creating a new narrative, create a new repository using this repo as a template.

# How to use
- Update the `doc_info.toml` file with the appropriate information
- Write your narrative
- When creating new commits, use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/). This will ensure that the changelog generation works as expected.
  - In the commit message body, include the word `RELEASE` to generate a compiled document with the "Released" status.
  - All other commits will generate a "Draft" copy.
  - GitHub actions will take care of generating the appropriate metadata file and compiling the PDF.
  - To run the metadata generation locally, simply run the script found at `scripts/generate_metadata.sh`
