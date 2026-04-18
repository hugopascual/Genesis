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
environment variable can be set to `true`. By default, logging is disabled.

```bash
export GENESIS_LOG_ENABLED=true
./linux/linux.sh install ubuntu desktop
```

Logs are saved in `logs` directory with the following format
`genesis_YYYYMMDD_HHMMSS.log`.

### Default configurations

#### Desktop

- **System**: htop, tree, nfs, rename, rsync, lshw, wget, curl, vim, neovim,
fastfetch, nvtop
- **Development**: git, ghcli, java_jdk, docker, lazydocker, python, nodejs,
vscode, jetbrains-toolbox, postman
- **Browsers**: firefox
- **Communication**: thunderbird, discord
- **Media**: vlc, gimp
- **Utilities**: 7zip, kitty, keepassxc, obsidian, autofirma, config_fnmt,
rustdesk, raspberry_pi_imager
- **VPNs**: wireguard, openvpnv3
- **Drivers**: displaylink
- **Videogames**: steam, lutris, minecraft, battle.net, curseforge

#### Server

- **System**: htop, tree, nfs, rename, rsync, lshw, wget, curl, vim, neovim,
fastfetch
- **Development**: git, java_jdk, docker, lazydocker, python, nodejs

## Update

Update all system packages:

```bash
./linux/linux.sh update <distro>
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
- Add second keyboard distibution (scripted)
- Startup apps: Firefox, Obsidian, Thunderbird (scripted)
- Other setup configurations (scripted)
  - `.bashrc` aliases and customization
- Graphics Drivers (TODO: scripted)

## For developers

### Project Structure

```text
Genesis/linux/
├── linux.sh               # Main script
├── packages/              # Software definitions (JSON)
├── configs/               # Predefined configurations
│   ├── default_desktop.txt
│   └── default_server.txt
├── commands/              # Command managers
│   ├── install_manager.sh
│   ├── setup_manager.sh
│   └── update_manager.sh
├── utilities/             # Utilities and constants
│   ├── utils.sh
│   ├── constants.sh
│   └── help.sh
├── functions/             # Distribution-specific scripts
│   ├── install/
│   ├── setup/
│   └── update/
└── statics/               # Static configurations (dotfiles)
    ├── arch_hyprland/
    ├── debian_gnome/
    └── ubuntu_gnome/
```

### Adding Software

Create a file in `linux/packages/software_name.json`:

```json
{
  "description": "Software description",
  "arch": ["sudo pacman -Syu --noconfirm package"],
  "ubuntu": ["sudo apt install -y package"],
  "debian": ["sudo apt install -y package"]
}
```

For complex installations, use multiple commands:

```json
{
  "description": "Docker",
  "ubuntu": [
    "sudo apt update",
    "sudo apt install -y ca-certificates curl",
    "sudo curl -fsSL https://download.docker.com/.../docker.asc -o /etc/apt/keyrings/docker.asc",
    "sudo apt install -y docker-ce docker-ce-cli containerd.io"
  ]
}
```

## Available software installations

- sudo, htop, tree, NFS, rename, rsync, lshw, wget, curl, vim, nvim, Fastfetch,
NVtop, Git, GitHub CLI, Java Development Kit, Java Runtime Environment, Docker,
lazydocker, Python, NodeJS, Visual Studio Code, JetBrains Toolbox, Postman,
Raspberry Pi Imager, kitty, DisplayLink Driver, Firefox, Google Chrome,
Thunderbird, KeePass XC, Autofirma, Config FNMT, Obsidian, VLC, Spotify,
Telegram, Discord, Rust Desk, GIMP, Wireguard, 7zip, OpenVPNv3, Steam,
Minecraft Launcher
