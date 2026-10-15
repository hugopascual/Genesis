# Linux Genesis Guide

## Commands

```bash
./linux/linux.sh install <distro> <profile | package_list_file>
./linux/linux.sh update
./linux/linux.sh setup <distro> <setup_type>
./linux/linux.sh add-distro <new_distro> "<base_command>"
./linux/linux.sh help
```

Every command except `help` shows the selected options and asks for confirmation before running. Run `./linux/linux.sh help` to see the available distros, profiles and setup types.

### Distributions

| Distro key | Distribution | Tested version |
| --- | --- | --- |
| `arch` | Arch Linux | Rolling ([notes](Arch.md)) |
| `cachyos` | CachyOS | Rolling |
| `debian` | Debian | 13 (trixie) |
| `ubuntu` | Ubuntu | 24.10 |
| `raspberrypi` | Raspberry Pi OS | — |

## Install

```bash
# Profile (profiles/linux/<profile>.txt)
./linux/linux.sh install arch personal
./linux/linux.sh install debian server

# Custom package list
./linux/linux.sh install ubuntu my_packages.txt
```

Profiles and the `@include` syntax are described in [Profiles](Profiles.md). A custom package list example:

```txt
@include base

# Development
nodejs
vscode
```

`jq` is installed automatically if missing, since package definitions are JSON.

At the end, a summary lists the packages installed, not available on the distro, requiring a manual install (with their URL) and failed. The command exits with an error only if some package failed.

## Update

Update all system packages with every package manager found: `apt`, `snap`, `pacman`, `yay` and `flatpak`.

```bash
./linux/linux.sh update
```

## Setup

Configure the desktop environment, dotfiles and folder structure:

```bash
./linux/linux.sh setup <distro> <setup_type>
```

| Setup type | What it does |
| --- | --- |
| `gnome` | GNOME bundle, dark theme, background and lock screen pictures, desktop and keyboard preferences, startup apps. Configures locales on Debian and Ubuntu |
| `kde` | Lock screen, touchpad, session and virtual desktops preferences (with dynamic workspaces), keyboard layouts and shortcuts, startup apps (Obsidian, Thunderbird, Firefox) |
| `hyprland` | Hyprland bundle, `greetd` login with `tuigreet`, [mechabar](https://github.com/sejjy/mechabar) Waybar theme, dark theme, Bluetooth not started at boot. See [Arch notes](Arch.md) |
| `server` | Server bundle and dotfiles |

Every setup type also:

- Creates the folder structure: `~/devops/repos` (with `clone.sh`), `~/devops/deployments/volumes` and `~/nfs`; desktop types add `~/vpns` and `~/windows`.
- Copies the dotfiles of `linux/statics/types/<setup_type>/.config` to `~/.config`.
- Adds the custom shell configuration to `~/.bashrc` and `~/.zshrc`.

Each setup type installs the packages of its bundle in `linux/src/setups/bundles/<setup_type>.txt`, with the same syntax as profiles.

Pending: graphics drivers (see [Arch notes](Arch.md) for NVIDIA).

## Add a distribution

Add a new distro key to every package in `packages/` that is available on Linux, using a base command. Windows-only packages are skipped, and the distro is registered in [available_distros.txt](../linux/src/config/available_distros.txt).

```bash
./linux/linux.sh add-distro fedora "sudo dnf install -y {package}"
```

- `{package}` is replaced by the package file name (without `.json`).
- If `{package}` is not present, the package name is appended at the end.
- Review the generated entries afterwards: package names often differ between distros.

## Logs

Logs are saved in `linux/logs/` with the format `genesis_YYYYMMDD_HHMMSS.log`. They are enabled by default; set `GENESIS_LOG_ENABLED` to `false` to disable them:

```bash
GENESIS_LOG_ENABLED=false ./linux/linux.sh install ubuntu work
```

## For developers

### Project Structure

```text
Genesis/
├── packages/              # Software definitions shared with Windows (JSON)
├── profiles/linux/        # Installation profiles
└── linux/
    ├── linux.sh           # Main entrypoint
    ├── logs/              # Session logs
    ├── src/
    │   ├── commands/      # Command managers (install, update, setup, add-distro)
    │   ├── config/        # Available distros
    │   ├── setups/
    │   │   ├── bundles/   # Packages installed by each setup type
    │   │   └── types/     # One script per setup type
    │   └── utilities/     # Constants, help, logging and utilities
    └── statics/           # Dotfiles and scripts copied by the setups
```

### Valid distributions

Valid distro keys are loaded from [available_distros.txt](../linux/src/config/available_distros.txt): one key per line, lines starting with `#` are ignored. Use `add-distro` to add one to the file and to the packages at once.

### Adding a setup type

1. Create `linux/src/setups/types/<setup_type>.sh`. It is sourced by `setup`, so it can use the helpers of `setup_manager.sh` (`setup_install_bundle`, `copy_config_statics`, `setup_finalize_type`…).
2. Create `linux/src/setups/bundles/<setup_type>.txt` with its packages (it can be empty).
3. Optionally add its dotfiles in `linux/statics/types/<setup_type>/.config`.

New setup types are detected automatically.

### Adding software

See [Packages](../README.md#packages).
