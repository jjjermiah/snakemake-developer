#!/usr/bin/env bash

# test.sh - Runs tests across all repositories
#
# This script:
# - Iterates through all submodules and runs tests using Pixi.
# - Ensures that cross-repository changes do not break compatibility.

set -e

root_manifest=$(realpath $PWD/pixi.toml)
echo "[TEST] Root manifest: $root_manifest"

# gathering list of files to test 
test_files=$(find repos -name tests.py -not -path 'repos/snakemake/*')
if [ -z "$test_files" ]; then
	echo "[TEST] No tests found."
	exit 0
else
	echo "[TEST] Found tests in the following files:"
	echo "$test_files"
fi

mkdir -p test_links

# cop  all test files to a single directory
for test_file in $test_files; do
	repo_name=$(basename $(dirname $(dirname $test_file)))
	# since they all have the same name, we need to rename them
	new_file="test_links/test_$repo_name.py"
	cp $test_file $new_file
done

# run tests
pixi run \
	--manifest-path "$root_manifest" \
	pytest test_links/*.py





# echo "[TEST] Running tests across all repositories..."
# for repo in repos/*; do

# 	# skip the snakemake repo for now because its alot
# 	if [ "$(basename "$repo")" == "snakemake" ]; then
# 		echo "[TEST] Skipping snakemake repo for now."
# 		continue
# 	fi

# 	if [ -d "$repo" ]; then
# 		REPO_NAME=$(basename "$repo")
# 		printf "\n%$(tput cols)s\n" | tr ' ' '-'
# 		echo "[TEST] Running tests in $REPO_NAME..."

# 		test_file=$(realpath "$repo/tests/tests.py")
# 		if [ ! -f "$test_file" ]; then
# 			echo "[TEST] No tests found for $REPO_NAME."
# 			continue
# 		fi

# 		echo "[TEST] Running tests..."
# 		pixi run \
# 			--manifest-path "$root_manifest" \
# 			pytest $test_file 

# 		echo "[TEST] Completed tests for $REPO_NAME."
# 	fi
# done

# echo "[TEST] All tests passed!"
