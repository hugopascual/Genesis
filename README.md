# Genesis

Automated installation and configuration system for Linux distributions.

## Supported Systems

| Distribution | Status | Environments |
|--------------|--------|--------------|
| Ubuntu | Working | GNOME |
| Debian | Working | GNOME |
| Arch Linux | Working | Hyprland |

## Installation

### Basic Usage

```bash
# Desktop installation
./linux/linux.sh install <distro> desktop

# Server installation
./linux/linux.sh install <distro> server

# Custom configuration
./linux/linux.sh install <distro> <path/to/my_config.txt>
```

**Available distributions**: `ubuntu`, `debian`, `arch`

### Examples

```bash
# Ubuntu Desktop
./linux/linux.sh install ubuntu desktop

# Debian Server
./linux/linux.sh install debian server

# Custom configuration
./linux/linux.sh install arch configs/my_setup.txt
```

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

**Available environments**: `gnome` (Ubuntu/Debian), `hyprland` (Arch)

## Adding Software

### 1. Create JSON definition

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

### 2. Add to configuration

Add the software name (without .json) to one of these files:

- `linux/configs/default_desktop.txt` - Desktop installation
- `linux/configs/default_server.txt` - Server installation
- Your own custom configuration file

Configuration file example:

```txt
# System
htop
neofetch

# Development
git
docker
vscode
```

## Included Software

### Desktop
- **System**: htop, tree, rsync, wget, curl, fastfetch
- **Development**: git, docker, vscode, jetbrains-toolbox, postman
- **Browsers**: firefox, google-chrome
- **Communication**: thunderbird, telegram, discord
- **Media**: vlc, spotify
- **Utilities**: keepassxc, obsidian

### Server
- **System**: htop, tree, rsync, wget, curl
- **Development**: git, docker, vim
- **Utilities**: tmux, screen

## Project Structure

```
Genesis/
├── linux/
│   ├── linux.sh               # Main script
│   ├── packages/              # Software definitions (JSON)
│   ├── configs/               # Predefined configurations
│   │   ├── default_desktop.txt
│   │   └── default_server.txt
│   ├── commands/              # Command managers
│   │   ├── install_manager.sh
│   │   ├── setup_manager.sh
│   │   └── update_manager.sh
│   ├── utilities/             # Utilities and constants
│   │   ├── utils.sh
│   │   ├── constants.sh
│   │   └── help.sh
│   ├── functions/             # Distribution-specific scripts
│   │   ├── install/
│   │   ├── setup/
│   │   └── update/
│   └── statics/               # Static configurations (dotfiles)
│       ├── arch_hyprland/
│       ├── debian_gnome/
│       └── ubuntu_gnome/
├── docs/                      # Documentation
└── README.md
```

## Documentation

- [Linux](docs/Linux.md) - Detailed usage guide
- [Ubuntu](docs/linux_distributions/Ubuntu.md)
- [Debian](docs/linux_distributions/Debian.md)
- [Arch](docs/linux_distributions/Arch.md)

## License

See [LICENSE](LICENSE) file

