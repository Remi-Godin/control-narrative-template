#!/bin/bash

METADATA_FILE="metadata.json"

# Extracting Git Data
REV_COUNT=$(git rev-list --count HEAD)
GIT_HASH=$(git rev-parse --short HEAD)
GIT_DATE=$(git log -1 --format=%as)
AUTHOR=$(git log -1 --format='%an')

# Status Logic: "Released" if the commit is tagged, else "Draft"
if git describe --tags --exact-match >/dev/null 2>&1; then
    STATUS="Released"
else
    STATUS="Draft"
fi

# Write the JSON
cat <<EOF > "$METADATA_FILE"
{
  "rev": "$REV_COUNT",
  "hash": "$GIT_HASH",
  "date": "$GIT_DATE",
  "author": "$AUTHOR",
  "status": "$STATUS"
}
EOF

echo "Generated metadata: Rev $REV_COUNT ($STATUS)"
