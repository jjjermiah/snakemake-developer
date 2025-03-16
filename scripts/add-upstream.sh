#!/usr/bin/env bash

# add-upstream.sh - Adds user fork as upstream for each submodule
#
# Usage: ./add-upstream.sh YOUR-GITHUB-USERNAME
#
# This script:
# - Checks if the user's fork exists for each submodule
# - Adds the user's fork as an upstream remote if it exists

set -e

show_help() {
	echo "Usage: $0 YOUR-GITHUB-USERNAME"
	echo
	echo "This script adds your GitHub fork as an upstream remote for each submodule."
	echo
	echo "Arguments:"
	echo "  YOUR-GITHUB-USERNAME    Your GitHub username where the forks exist"
	echo
	echo "Example:"
	echo "pixi run add-upstream jjjermiah"
	exit 1
}

if [ -z "$1" ]; then
	show_help
fi

USERNAME="$1"

echo "[UPSTREAM] Checking if all repositories exist for user: $USERNAME"
# First check all repositories exist and create a mapping
declare -A repo_map
for check_repo in repos/*; do
	if [ -d "$check_repo" ]; then
		REPO_NAME=$(basename "$check_repo")
		REPO_URL="https://github.com/$USERNAME/$REPO_NAME"
		HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$REPO_URL")
		
		if [ "$HTTP_CODE" -eq 200 ]; then
			repo_map["$REPO_NAME"]="$REPO_URL"
		else
			repo_map["$REPO_NAME"]="MISSING"
		fi
	fi
done

# Function to print repository status mapping
print_repo_mapping() {
	local -n mapping=$1  # Use nameref to reference the associative array
	
	echo "[UPSTREAM] Repository status mapping:"
	printf "%-55s | %s\n" "Repository" "Status"
	printf "%$(tput cols)s\n" | tr ' ' '-'
	for repo in "${!mapping[@]}"; do
		printf "%-55s | %s\n" "$repo" "${mapping[$repo]}"
	done
}

# check if ANY repositories are missing
all_exist=true
for repo in "${!repo_map[@]}"; do
	if [ "${repo_map[$repo]}" = "MISSING" ]; then
		all_exist=false
		break
	fi
done

if [ "$all_exist" = false ]; then
	echo "[UPSTREAM] Some repositories are missing. Please check the status mapping below."
	print_repo_mapping repo_map
	exit 1
else
	echo "[UPSTREAM] All repository forks exist. Proceeding to add upstream remotes."
fi

# Check for existing upstreams
echo "[UPSTREAM] Checking for existing upstream remotes..."
declare -A upstream_status
need_updates=false

for repo in repos/*; do
	if [ -d "$repo" ]; then
		REPO_NAME=$(basename "$repo")
		REPO_URL="${repo_map[$REPO_NAME]}.git"
		
		# Check if upstream remote exists with correct URL
		if git -C "$repo" remote -v | grep -q "upstream.*$REPO_URL"; then
			upstream_status["$REPO_NAME"]="CONFIGURED"
		else
			upstream_status["$REPO_NAME"]="NEEDS_UPDATE"
			need_updates=true
		fi
	fi
done

# Display upstream status
print_repo_mapping upstream_status

if [ "$need_updates" = false ]; then
	echo "[UPSTREAM] All upstream remotes are already correctly configured. Nothing to do."
	exit 0
else
	echo "[UPSTREAM] Some repositories need upstream configuration. Proceeding with updates."
fi

# Add upstream remotes
echo "[UPSTREAM] Adding upstream remotes for user: $USERNAME"
for repo in repos/*; do
	if [ -d "$repo" ]; then
		REPO_NAME=$(basename "$repo")
		REPO_URL="${repo_map[$REPO_NAME]}"
		
		# Only update if needed
		if [ "${upstream_status[$REPO_NAME]}" = "NEEDS_UPDATE" ]; then
			echo "[UPSTREAM] Processing $REPO_NAME..."
			# Remove existing upstream if any
			git -C "$repo" remote remove upstream 2>/dev/null || true
			git -C "$repo" remote add upstream "$REPO_URL.git"
			echo "[UPSTREAM] Added upstream: $REPO_URL.git"
		else
			echo "[UPSTREAM] Skipping $REPO_NAME (already configured)"
		fi
	fi
done

echo "[UPSTREAM] Upstream remotes added. Run 'git remote -v' inside each repo to verify."

echo "[CONFIG] Enforcing Git settings for all submodules..."

git submodule foreach --recursive git config --local remote.pushDefault upstream
git submodule foreach --recursive git config --local branch.autoSetupMerge always
git submodule foreach --recursive git remote set-url --push origin no_push

echo "[CONFIG] Git settings applied to all submodules."