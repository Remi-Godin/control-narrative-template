#!/bin/bash

METADATA_FILE="metadata.json"

# 1. Get the Revision Number (Total Commit Count)
REV_COUNT=$(git rev-list --count HEAD)

# 2. Extract Commit Metadata
GIT_HASH=$(git rev-parse --short HEAD)
GIT_DATE=$(git log -1 --format=%as)
AUTHOR=$(git log -1 --format='%an')

# 3. Status Logic: Strict Uppercase Trigger
# Grab the full body of the latest commit message
COMMIT_MSG=$(git log -1 --pretty=%B)

# Check if the message contains the exact string "RELEASE"
if [[ "$COMMIT_MSG" == *"RELEASE"* ]]; then
    STATUS="Released"
else
    STATUS="Draft"
fi

# 4. Generate the JSON file
cat <<EOF > "$METADATA_FILE"
{
  "rev": "$REV_COUNT",
  "hash": "$GIT_HASH",
  "date": "$GIT_DATE",
  "author": "$AUTHOR",
  "status": "$STATUS"
}
EOF

echo "Metadata Updated: Rev $REV_COUNT is currently [$STATUS]"
