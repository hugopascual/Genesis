# Windows Software

## Installation

The first step is to install Chocolatey, on an administrative powershell, run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Then, run the software installation script:

```powershell
powershell -ExecutionPolicy Bypass -File .\windows.ps1
```

### Default installs

- **System**: htop, tree, rsync, wget, curl, fastfetch
- **Development**: git, docker, vscode, jetbrains-toolbox, postman
- **Browsers**: firefox, google-chrome
- **Communication**: thunderbird, telegram, discord
- **Media**: vlc, spotify
- **Utilities**: keepassxc, obsidian

## Environment Setup

- Configure locales
- Customize desktop
  - Desktop icons
    - In screen, right button -> `View -> Disable Show Desktop Icons`
  - Black Mode in blue
  - Background
    - Select Photo
  - Lock Screen
    - Select Photo
    - Disble fun facts, tips and tricks
    - App on screen -> None
  - Start
    - More pins
    - Disble recomendations
    - Disbale related notifications
    - Folders
      - Settings
      - File Explorer
      - Personal folder
  - Taskbar
    - Search icon only
    - Disble Widgets
    - Taskbar Behaviours
      - Automatically hide the taskbar
- Create basic folders structure
- Add second keyboard distribution
- Startup apps: Firefox, Obsidian, Thunderbird
  - Apps folder: `Win+R` -> `shell:appsfolder`
  - Startup folder: `Win+R` -> `shell:startup`
  - Drag and drop the ones
- Other setup configurations
  - Remove Windows Slop -> `Apps -> Installed apps`
- Graphic drivers
  - [GeForce Experience](https://www.nvidia.com/es-es/geforce/drivers/)
