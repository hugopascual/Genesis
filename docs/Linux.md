# Linux Genesis Guide

## Installation

```bash
# Profile installation (profiles/linux/<profile>.txt)
./linux/linux.sh install <distro> work
./linux/linux.sh install <distro> server

# Custom package list
./linux/linux.sh install <distro> <path/to/my_packages.txt>
```

Custom package list example. It can include any Linux profile:

```txt
@include base

# Development
nodejs
vscode
```

### Logs

If logs of the installation process are needed the `GENESIS_LOG_ENABLED` environment variable can be set to `true` or `false`. By default, saving logs in file is enabled.

```bash
export GENESIS_LOG_ENABLED=true
./linux/linux.sh install ubuntu work
```

Logs are saved in `logs` directory with the following format
`genesis_YYYYMMDD_HHMMSS.log`.

### Profiles

Profiles are defined in [profiles/linux/](../profiles/linux/) by levels: `base` is included by `server` and `desktop`, and `desktop` is included by `work` and `personal`. See [profiles/README.md](../profiles/README.md).

At the end of the installation a summary lists the installed packages, the ones not available on the distro, the ones that require a manual install and the failed ones.

## Update

Update all system packages:

```bash
./linux/linux.sh update <distro>
```

## Add New Distribution Commands To All Packages

Add a new distro key to every package in [packages/](../packages/) available on Linux, using a base command. Windows-only packages are skipped.

```bash
./linux/linux.sh add-distro <new_distro> "<base_command>"
```

Rules:

- Use `\{package\}` as placeholder to inject the JSON filename (without `.json`)
- If `\{package\}` is not included, package name is appended at the end

Example:

```bash
./linux/linux.sh add-distro fedora "sudo dnf install -y \{package\}"
```

## Environment Setup

Install dotfiles and desktop environment configurations:

```bash
./linux/linux.sh setup <distro> <environment>
```

### Setup configurations included

- Configure system locales (scripted)
- Configure desktop environment (scripted)
- Create basics folders structure (scripted)
- Add second keyboard distribution (scripted)
- Startup apps: Firefox, Obsidian, Thunderbird (scripted)
- Other setup configurations (scripted)
- Graphics drivers (TODO)

## For developers

### Valid distributions source

Valid distro keys are loaded from [linux/src/config/available_distros.txt](../linux/src/config/available_distros.txt).

- One distro key per line
- Lines starting with `#` are ignored

### Project Structure

```text
Genesis/
├── packages/              # Software definitions shared with Windows (JSON)
├── profiles/linux/        # Installation profiles
└── linux/
    ├── linux.sh           # Main entrypoint
    ├── src/               # Linux runtime code
    │   ├── commands/      # Command managers
    │   ├── config/        # Available distros
    │   ├── setups/        # Setup types and their package bundles
    │   └── utilities/     # Utilities and constants
    └── statics/           # Static configurations (dotfiles)
```

### Adding Software

Create `packages/<software_name>.json` following the [package format](../README.md#packages), and add the name to the profiles or setup bundles that need it.
