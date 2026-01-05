#!/bin/bash

# 1. Get the latest tag name
# If no tags exist, we set this to a "Virtual Zero"
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null)
HAS_TAGS=$? # 0 if success, non-zero if no tags

# 2. Get the total commit count
TOTAL_COMMITS=$(git rev-list --count HEAD)

# 3. Check if the current commit has a tag pointing at it
CURRENT_TAG=$(git tag --points-at HEAD)

# 4. Handle Commits Since Tag logic
if [ $HAS_TAGS -eq 0 ]; then
    # Tags exist, do a range count
    COMMITS_SINCE_TAG=$(git rev-list "${LATEST_TAG}..HEAD" --count)
    DISPLAY_TAG="$LATEST_TAG"
else
    # No tags exist yet, the "since" count is just the total count
    COMMITS_SINCE_TAG=$TOTAL_COMMITS
    DISPLAY_TAG="v0.0"
fi

# 5. Determine Status and Version String
STATUS="DRAFT"
REVISION_LABEL="Draft after $DISPLAY_TAG"

if [ -n "$CURRENT_TAG" ]; then
    # If the tag contains "-rc", it's still a draft/candidate
    if [[ "$CURRENT_TAG" == *"-rc"* ]]; then
        STATUS="FOR REVIEW"
        REVISION_LABEL="Release Candidate: $CURRENT_TAG"
    else
        STATUS="RELEASED"
        REVISION_LABEL="Official Release: $CURRENT_TAG"
    fi
    VERSION="$CURRENT_TAG"
else
    VERSION="$DISPLAY_TAG (+$COMMITS_SINCE_TAG)"
fi

# 6. Output for Typst
cat <<EOF
{
  "formal_rev": "$DISPLAY_TAG",
  "build_count": "$TOTAL_COMMITS",
  "commits_since_tag": "$COMMITS_SINCE_TAG",
  "status": "$STATUS",
  "version_string": "$VERSION",
  "revision_label": "$REVISION_LABEL",
  "short_sha": "$(git rev-parse --short HEAD 2>/dev/null || echo "0000000")",
  "date": "$(date +'%Y-%m-%d')"
}
EOF
