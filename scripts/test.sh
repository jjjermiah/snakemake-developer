#!/usr/bin/env bash

# test.sh - Runs tests across all repositories
#
# This script:
# - Iterates through all submodules and runs tests using Pixi.
# - Ensures that cross-repository changes do not break compatibility.

set -e

echo "[TEST] Running tests across all repositories..."
for repo in repos/*; do
	if [ -d "$repo" ]; then
		REPO_NAME=$(basename "$repo")
		echo "[TEST] Running tests in $REPO_NAME..."
		(cd "$repo" && pixi run pytest || exit 1)
		echo "[TEST] Completed tests for $REPO_NAME."
	fi
done

echo "[TEST] All tests passed!"
