#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

cd $SCRIPT_DIR

GIT_COMMIT_ID=$(git rev-parse --short HEAD)
GIT_UNIX_TIMESTAMP=$(git log -1 --format=%at)

echo "#macro GIT_COMMIT_ID \"$GIT_COMMIT_ID\"" > "$SCRIPT_DIR/scripts/scrGitConstants/scrGitConstants.gml"
echo "#macro GIT_UNIX_TIMESTAMP \"$GIT_UNIX_TIMESTAMP\"" >> "$SCRIPT_DIR/scripts/scrGitConstants/scrGitConstants.gml"