# Linux Genesis Guide

## Installation

```bash
# Desktop installation
./linux/linux.sh install <distro> desktop

# Server installation
./linux/linux.sh install <distro> server

# Custom configuration
./linux/linux.sh install <distro> <path/to/my_config.txt>
```

Custom configuration file example:

```txt
# System
htop
neofetch

# Development
git
docker
vscode
```

### Logs

If logs of the installation process are needed the `GENESIS_LOG_ENABLED`
environment variable can be set to `true`. By default, saving logs in file is
disabled.

```bash
export GENESIS_LOG_ENABLED=true
./linux/linux.sh install ubuntu desktop
```

Logs are saved in `logs` directory with the following format
`genesis_YYYYMMDD_HHMMSS.log`.

### Default configurations

#### Desktop

- **System**: htop, tree, nfs, rename, rsync, lshw, wget, curl, vim, neovim, fastfetch, nvtop
- **Development**: git, ghcli, java_jdk, docker, lazydocker, python, nodejs, vscode, jetbrains-toolbox, postman
- **Browsers**: firefox
- **Communication**: thunderbird, discord
- **Media**: vlc, gimp
- **Utilities**: 7zip, kitty, keepassxc, obsidian, autofirma, config_fnmt, rustdesk, raspberry_pi_imager
- **VPNs**: wireguard, openvpnv3
- **Drivers**: displaylink
- **Videogames**: steam, lutris, minecraft, battle.net, curseforge

#### Server

- **System**: htop, tree, nfs, rename, rsync, lshw, wget, curl, vim, neovim, fastfetch
- **Development**: git, java_jdk, docker, lazydocker, python, nodejs

## Update

Update all system packages:

```bash
./linux/linux.sh update <distro>
```

## Add New Distribution Commands To All Packages

Add a new distro key to every JSON file in `linux/packages/` using a base command.

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

Valid distro keys are loaded from [linux/configs/available_distros.txt](linux/configs/available_distros.txt).

- One distro key per line
- Lines starting with `#` are ignored
- Override path with environment variable `GENESIS_DISTROS_CONFIG_FILE`

### Project Structure

```text
Genesis/
├── linux/
│   ├── linux.sh           # Main entrypoint
│   ├── src/               # Linux runtime code
│   │   ├── commands/      # Command managers
│   │   ├── utilities/     # Utilities and constants
│   │   └── functions/     # Distribution-specific scripts
│   ├── packages/          # Software definitions (JSON)
│   ├── configs/           # Predefined configurations
│   │   ├── default_desktop.txt
│   │   └── default_server.txt
│   └── statics/           # Static configurations (dotfiles)
```

### Adding Software

Create a file in `linux/packages/software_name.json`:

```json
{
  "description": "Software description",
  "arch": [
    "sudo pacman -Syu --noconfirm package"
  ],
  "ubuntu": [
    "sudo apt install -y package"
  ],
  "debian": [
    "sudo apt install -y package"
  ]
}
```

For complex installations, use multiple commands:

```json
{
  "description": "Discord communication platform",
  "arch": [
    "sudo pacman -Syu --noconfirm discord"
  ],
  "debian": [
    "wget --content-disposition https://discord.com/api/download?platform=linux&format=deb",
    "sudo apt-get install -y ./*.deb",
    "rm ./*.deb"
  ]
}
```

## Available software installations

- sudo, htop, tree, NFS, rename, rsync, lshw, wget, curl, vim, nvim, Fastfetch, NVtop, Git, GitHub CLI, Java Development Kit, Java Runtime Environment, Docker, lazydocker, Python, NodeJS, Visual Studio Code, JetBrains Toolbox, Postman, Raspberry Pi Imager, kitty, DisplayLink Driver, Firefox, Google Chrome, Thunderbird, KeePass XC, Autofirma, Config FNMT, Obsidian, VLC, Spotify, Telegram, Discord, Rust Desk, GIMP, Wireguard, 7zip, OpenVPNv3, Steam, Minecraft Launcher
