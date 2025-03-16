#!/usr/bin/env bash

# setup.sh - Initializes submodules and installs dependencies with Pixi
#
# This script:
# - Ensures all submodules are properly initialized and updated.
# - Installs all dependencies using Pixi for consistent environments.
# - Informs the user about adding upstreams for easier contribution.

set -e

echo "[SETUP] Initializing submodules..."
git submodule update --init --recursive
echo "[SETUP] Submodules initialized."

echo "[SETUP] Installing dependencies with Pixi..."
pixi install
echo "[SETUP] Dependencies installed."

echo "[SETUP] Setup complete. If you forked the repositories, run:"
echo "  ./scripts/add-upstream.sh YOUR-GITHUB-USERNAME"
