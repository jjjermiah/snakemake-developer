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
git clone --recurse-submodules https://github.com/$GIT_USER/snakemake-developer.git
cd snakemake-developer
```

### 3. Set Up Upstream Remotes

For each submodule, set up an upstream remote to the original repository:

```console
$ pixi run setup
...
```

### 4. [Optional] Add upstream remotes for your forks

Fork each of the repos you want to work on, and add them as remotes:

```console
$ pixi run add-remotes $GIT_USER
...
```

### 5. Run Test

```console
$➜ pixi run test      
✨ Pixi task (test in dev): ./scripts/test.sh
[TEST] Root manifest: /Users/bhklab/dev/snakemake-dev/snakemake-developer/pixi.toml
[TEST] Found tests in the following files:
repos/snakemake-interface-storage-plugins/tests/tests.py
repos/snakemake-interface-report-plugins/tests/tests.py
repos/snakemake-interface-logger-plugins/tests/tests.py
repos/snakemake-interface-common/tests/tests.py
repos/snakemake-interface-executor-plugins/tests/tests.py
repos/snakemake-interface-software-deployment-plugins/tests/tests.py
============================================================================================ test session starts ============================================================================================
platform darwin -- Python 3.12.9, pytest-8.3.5, pluggy-1.5.0
rootdir: /Users/bhklab/dev/snakemake-dev/snakemake-developer
collected 32 items                                                                                                                                                                                          

test_links/test_snakemake-interface-common.py .......                                                                                                                                                 [ 21%]
test_links/test_snakemake-interface-executor-plugins.py ........                                                                                                                                      [ 46%]
test_links/test_snakemake-interface-logger-plugins.py ...                                                                                                                                             [ 56%]
test_links/test_snakemake-interface-report-plugins.py ...                                                                                                                                             [ 65%]
test_links/test_snakemake-interface-software-deployment-plugins.py ...                                                                                                                                [ 75%]
test_links/test_snakemake-interface-storage-plugins.py ........                                                                                                                                       [100%]

============================================================================================ 32 passed in 1.58s =============================================================================================
Name                                                                                                                         Stmts   Miss  Cover
------------------------------------------------------------------------------------------------------------------------------------------------
repos/snakemake-interface-common/src/snakemake_interface_common/__init__.py                                                      0      0   100%
repos/snakemake-interface-common/src/snakemake_interface_common/_common.py                                                      47     18    62%
repos/snakemake-interface-common/src/snakemake_interface_common/exceptions.py                                                   50      9    82%
repos/snakemake-interface-common/src/snakemake_interface_common/logging.py                                                      10      1    90%
repos/snakemake-interface-common/src/snakemake_interface_common/plugin_registry/__init__.py                                     73     11    85%
repos/snakemake-interface-common/src/snakemake_interface_common/plugin_registry/attribute_types.py                              22      1    95%
repos/snakemake-interface-common/src/snakemake_interface_common/plugin_registry/plugin.py                                      177     58    67%
repos/snakemake-interface-common/src/snakemake_interface_common/plugin_registry/tests.py                                        40      0   100%
repos/snakemake-interface-common/src/snakemake_interface_common/rules.py                                                        11      0   100%
repos/snakemake-interface-common/src/snakemake_interface_common/settings.py                                                     33      1    97%
repos/snakemake-interface-common/src/snakemake_interface_common/utils.py                                                        44     25    43%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/__init__.py                                      4      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/_common.py                                       6      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/cli.py                                          10      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/dag.py                                          14      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/executors/__init__.py                            4      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/executors/base.py                               64     24    62%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/executors/real.py                               83     42    49%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/executors/remote.py                            172    108    37%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/jobs.py                                         84      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/logging.py                                      12      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/persistence.py                                  13      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/registry/__init__.py                            31      2    94%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/registry/plugin.py                              24      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/scheduler.py                                    13      0   100%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/settings.py                                     90      8    91%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/utils.py                                       100     42    58%
repos/snakemake-interface-executor-plugins/snakemake_interface_executor_plugins/workflow.py                                     54      0   100%
repos/snakemake-interface-logger-plugins/src/snakemake_interface_logger_plugins/__init__.py                                      0      0   100%
repos/snakemake-interface-logger-plugins/src/snakemake_interface_logger_plugins/base.py                                         32      6    81%
repos/snakemake-interface-logger-plugins/src/snakemake_interface_logger_plugins/common.py                                       34     10    71%
repos/snakemake-interface-logger-plugins/src/snakemake_interface_logger_plugins/registry/__init__.py                            20      2    90%
repos/snakemake-interface-logger-plugins/src/snakemake_interface_logger_plugins/registry/plugin.py                              23      0   100%
repos/snakemake-interface-logger-plugins/src/snakemake_interface_logger_plugins/settings.py                                     20      0   100%
repos/snakemake-interface-report-plugins/snakemake_interface_report_plugins/__init__.py                                          0      0   100%
repos/snakemake-interface-report-plugins/snakemake_interface_report_plugins/common.py                                            6      0   100%
repos/snakemake-interface-report-plugins/snakemake_interface_report_plugins/interfaces.py                                      108      0   100%
repos/snakemake-interface-report-plugins/snakemake_interface_report_plugins/registry/__init__.py                                27      2    93%
repos/snakemake-interface-report-plugins/snakemake_interface_report_plugins/registry/plugin.py                                  23      0   100%
repos/snakemake-interface-report-plugins/snakemake_interface_report_plugins/reporter.py                                         23      9    61%
repos/snakemake-interface-report-plugins/snakemake_interface_report_plugins/settings.py                                          9      0   100%
repos/snakemake-interface-software-deployment-plugins/snakemake_interface_software_deployment_plugins/__init__.py              164     89    46%
repos/snakemake-interface-software-deployment-plugins/snakemake_interface_software_deployment_plugins/_common.py                 6      0   100%
repos/snakemake-interface-software-deployment-plugins/snakemake_interface_software_deployment_plugins/registry/__init__.py      19      0   100%
repos/snakemake-interface-software-deployment-plugins/snakemake_interface_software_deployment_plugins/registry/plugin.py        35      0   100%
repos/snakemake-interface-software-deployment-plugins/snakemake_interface_software_deployment_plugins/settings.py               11      1    91%
repos/snakemake-interface-software-deployment-plugins/snakemake_interface_software_deployment_plugins/tests.py                  73     73     0%
repos/snakemake-interface-storage-plugins/snakemake_interface_storage_plugins/__init__.py                                        0      0   100%
repos/snakemake-interface-storage-plugins/snakemake_interface_storage_plugins/common.py                                         15      0   100%
repos/snakemake-interface-storage-plugins/snakemake_interface_storage_plugins/io.py                                             53      8    85%
repos/snakemake-interface-storage-plugins/snakemake_interface_storage_plugins/registry/__init__.py                              22      1    95%
repos/snakemake-interface-storage-plugins/snakemake_interface_storage_plugins/registry/plugin.py                                30      0   100%
repos/snakemake-interface-storage-plugins/snakemake_interface_storage_plugins/settings.py                                       10      0   100%
repos/snakemake-interface-storage-plugins/snakemake_interface_storage_plugins/storage_object.py                                138     60    57%
repos/snakemake-interface-storage-plugins/snakemake_interface_storage_plugins/storage_provider.py                              111     24    78%
repos/snakemake-interface-storage-plugins/snakemake_interface_storage_plugins/tests.py                                          90     19    79%
------------------------------------------------------------------------------------------------------------------------------------------------
TOTAL                                                                                                                         2387    654    73%
```

## Contributing

- Always update your forks before making changes.
- Run tests before submitting PRs.
- Follow best practices for submodules.

## Troubleshooting

- Submodules not initializing? Run `git submodule update --init --recursive`.
- Conflicts with upstream? Use `git pull --rebase upstream main` in each submodule.
- Pixi installation issues? Check [Pixi Docs](https://pixi.sh).
