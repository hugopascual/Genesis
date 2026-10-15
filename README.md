# Genesis

Automated installation and configuration system for Linux and Windows operating systems.

## Overview

Genesis provides automated scripts to install and configure software packages across different operating systems and distributions. It simplifies the process of setting up new machines with predefined or custom software configurations.

## Supported Systems

- **Linux**: Ubuntu, Debian, Arch Linux, Raspberry Pi, CachyOS
- **Windows**: PowerShell-based installation

## Quick Start

### Linux

```bash
./linux/linux.sh install <distro> <profile>
./linux/linux.sh update <distro>
./linux/linux.sh setup <distro> <environment>
./linux/linux.sh add-distro <new_distro> "<base_command>"
```

### Windows

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -Profile <profile>
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 update
```

## Project Structure

```text
Genesis/
├── packages/       # Package catalog shared by Linux and Windows (JSON)
├── profiles/       # Installation profiles
│   ├── linux/
│   └── windows/
├── schema/         # JSON Schema for package definitions
├── linux/          # Linux entrypoint, source code and statics
│   ├── linux.sh
│   ├── src/
│   └── statics/
├── windows/        # Windows entrypoint and source code
│   ├── windows.ps1
│   └── src/
└── docs/           # Detailed documentation
```

# Packages

One JSON file per logical package, shared by Linux and Windows. The file name (without `.json`) is the name used in [profiles](profiles/README.md) and setup bundles.

The format is defined in [package.schema.json](schema/package.schema.json). Editors that support JSON Schema validate each file through its `$schema` key.

## Format

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

## Installation methods

| Method | Platforms | Runs |
|---|---|---|
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

## Naming

Use one logical name per tool, even when each platform installs a different product (`keepass`, `docker`, `openvpn`, `gog`). Keep separate packages only when they are different tools that can coexist or conflict (`vscode` and `codeoss`).

## Documentation

- **[Packages](#packages)** - Package definition format
- **[Profiles](profiles/README.md)** - Profile levels and `@include` syntax
- **[Linux](docs/Linux.md)** - Linux installation and configuration guide
  - [Ubuntu](docs/Ubuntu.md)
  - [Debian](docs/Debian.md)
  - [Arch](docs/Arch.md)
- **[Windows](docs/Windows.md)** - Windows installation and configuration guide

## License

See [LICENSE](LICENSE) file
