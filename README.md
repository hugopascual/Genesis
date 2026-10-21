# Genesis

Automated installation and configuration system for Linux and Windows operating systems.

## Overview

Genesis installs and configures software on new machines from a single package catalog shared by Linux and Windows:

- **Packages**: one JSON file per program, describing how to install it on each platform.
- **Profiles**: lists of packages for each kind of machine (`server`, `desktop`, `work`, `personal`…), organised by levels.
- **Setups** (Linux only): desktop environment and dotfiles configuration.

## Supported Systems

- **Linux**: Arch Linux, CachyOS, Debian, Ubuntu, Raspberry Pi OS
- **Windows**: PowerShell with [Chocolatey](https://chocolatey.org/)

## Quick Start

### Linux

```bash
./linux/linux.sh install <distro> <profile>
./linux/linux.sh update
./linux/linux.sh setup <distro> <setup_type>
./linux/linux.sh add-distro <new_distro> "<base_command>"
./linux/linux.sh help
```

### Windows

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -Profile <profile>
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 update
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 help
```

Both entrypoints show the selected options and ask for confirmation before running, print a summary at the end and save a log (see each guide).

## Project Structure

```text
Genesis/
├── packages/       # Package catalog shared by Linux and Windows (JSON)
├── profiles/       # Installation profiles
│   ├── linux/
│   └── windows/
├── schema/         # JSON Schema for package definitions
├── linux/          # Linux entrypoint, source code, statics and logs
│   ├── linux.sh
│   ├── src/
│   ├── statics/
│   └── logs/
├── windows/        # Windows entrypoint, source code and logs
│   ├── windows.ps1
│   ├── src/
│   └── logs/
└── docs/           # Detailed documentation
```

## Packages

One JSON file per logical package in `packages/`, shared by Linux and Windows. The file name (without `.json`) is the name used in [profiles](docs/Profiles.md) and setup bundles.

The format is defined in [package.schema.json](schema/package.schema.json). Editors that support JSON Schema validate each file through its `$schema` key.

### Format

```json
{
  "$schema": "../schema/package.schema.json",
  "description": "Password manager (KeePassXC on Linux, KeePass on Windows)",
  "install": {
    "arch": { "pacman": "keepassxc" },
    "cachyos": { "pacman": "keepassxc" },
    "debian": { "flatpak": "org.keepassxc.KeePassXC" },
    "ubuntu": { "flatpak": "org.keepassxc.KeePassXC" },
    "raspberrypi": { "flatpak": "org.keepassxc.KeePassXC" },
    "windows": { "choco": "keepass.install" }
  }
}
```

- `install` has one key per platform: the Linux distros in [available_distros.txt](linux/src/config/available_distros.txt) and `windows`.
- Every platform is written explicitly, even when its entry is identical to another one.
- A platform that is not listed means the package is not available there: it is skipped and reported in the installation summary.
- Each platform entry has exactly one installation method.

### Installation methods

| Method | Platforms | Runs |
| --- | --- | --- |
| `pacman` | Linux | `sudo pacman -Syu --noconfirm <pkgs>` |
| `yay` | Linux | `yay -Syu --noconfirm <pkgs>` |
| `apt` | Linux | `sudo apt install -y <pkgs>` |
| `flatpak` | Linux | `sudo flatpak install -y flathub <ids>` |
| `choco` | Windows | `choco install -y <pkgs> --ignore-checksums` |
| `commands` | All | The listed commands in order (bash on Linux, PowerShell on Windows) |
| `manual` | All | Nothing: the URL is listed in the summary as a manual install |

Typed methods accept a single package (`"pacman": "git"`) or several (`"pacman": ["docker", "docker-compose"]`), installed in one call.

Use `commands` when the installation needs more than one step:

```json
"debian": {
  "commands": [
    "wget --content-disposition https://discord.com/api/download?platform=linux&format=deb",
    "sudo apt install -y ./*.deb",
    "rm ./*.deb"
  ]
}
```

### Naming

Use one logical name per tool, even when each platform installs a different product (`keepass`, `docker`, `openvpn`, `gog`). Keep separate packages only when they are different tools that can coexist or conflict (`vscode` and `codeoss`).

### Adding a package

1. Create `packages/<name>.json` with an entry for each platform where it can be installed.
2. Add `<name>` to the profiles ([docs/Profiles.md](docs/Profiles.md)) or Linux setup bundles that need it.

## Documentation

- **[Profiles](docs/Profiles.md)** - Profile levels and `@include` syntax
- **[Linux](docs/Linux.md)** - Linux commands, setups and development guide
  - [Arch](docs/Arch.md) - Arch Linux and Hyprland notes
- **[Windows](docs/Windows.md)** - Windows commands and manual configuration

## License

See [LICENSE](LICENSE) file
