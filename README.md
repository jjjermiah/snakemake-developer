# Snakemake Meta-Repository

## Overview

This repository is a meta-repository that manages all major Snakemake-related
repositories as submodules. It is designed to make cross-repository development
and dependency management seamless.

## Why Use This?

- Consistent Environment: Automatically sets up all necessary repositories
  and dependencies using Pixi.
- Simplified Updates: Provides scripts to update all submodules and
  dependencies in one command.
- Cross-Repo Testing: Ensures compatibility across all Snakemake packages.
- Easy Forking & Contribution: Guides developers on forking and setting up
  upstream remotes for smooth contribution workflows.

## Getting Started

### 1. Fork Each Repository

Before using this meta-repo, fork the following repositories to your own GitHub
account:

- snakemake
- snakemake-executor-kubernetes
- snakemake-google-cloud-storage
- (Add more as needed)

### 2. Clone This Meta-Repo

```bash
git clone --recurse-submodules https://github.com/$GIT_USER/snakemake-meta.git
cd snakemake-meta
```

### 3. Set Up the Environment

Run the setup script to initialize submodules and install dependencies:

```bash
./scripts/setup.sh
```

### 4. Add Your Fork as the Upstream Remote (Optional)

This repository provides an automated way to add your personal forks as
remotes. Run:

```bash
./scripts/add-upstream.sh YOUR-GITHUB-USERNAME
```

This will add your forks as remotes to each submodule, making it easy to push
changes.

### 5. Updating Repositories & Dependencies

To pull the latest changes from upstream and update dependencies, run:

```bash
./scripts/update.sh
```

### 6. Running Cross-Repository Tests

```bash
./scripts/test.sh
```

## Contributing

- Always update your forks before making changes.
- Run tests before submitting PRs.
- Follow best practices for submodules.

## Troubleshooting

- Submodules not initializing? Run `git submodule update --init --recursive`.
- Conflicts with upstream? Use `git pull --rebase upstream main` in each submodule.
- Pixi installation issues? Check [Pixi Docs](https://pixi.sh).
