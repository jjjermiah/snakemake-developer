#!/usr/bin/env bash

# add-upstream.sh - Adds user fork as upstream for each submodule
#
# Usage: ./add-upstream.sh YOUR-GITHUB-USERNAME
#
# This script:
# - Iterates over all submodules and adds the user's fork as an upstream remote.

set -e

if [ -z "$1" ]; then
	echo "[UPSTREAM] Usage: $0 YOUR-GITHUB-USERNAME"
	exit 1
fi

USERNAME="$1"

echo "[UPSTREAM] Adding upstream remotes for user: $USERNAME"
for repo in repos/*; do
	if [ -d "$repo" ]; then
		REPO_NAME=$(basename "$repo")
		echo "[UPSTREAM] Processing $REPO_NAME..."
		git -C "$repo" remote add upstream "https://github.com/$USERNAME/$REPO_NAME.git" || true
		echo "[UPSTREAM] Added upstream: https://github.com/$USERNAME/$REPO_NAME.git"
	fi
done

echo "[UPSTREAM] Upstream remotes added. Run 'git remote -v' inside each repo to verify."
