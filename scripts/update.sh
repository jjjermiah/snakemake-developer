#!/usr/bin/env bash

# update.sh - Updates all submodules and dependencies
#
# This script:
# - Fetches the latest updates from the upstream repositories.
# - Merges changes into the submodules.
# - Updates dependencies in Pixi.

set -e

echo "[UPDATE] Updating submodules..."
git submodule update --remote --merge
echo "[UPDATE] Submodules updated."

echo "[UPDATE] Updating Pixi dependencies..."
pixi update
echo "[UPDATE] Pixi dependencies updated."

echo "[UPDATE] Updates complete."
