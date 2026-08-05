# Windows Software

## Installation

The first step is to install Chocolatey, on an administrative powershell, run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Then, run the software installation script:

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -Profile base
```

### Installation profiles

The script now uses profile files (similar to Linux) and package JSON definitions:

- Profiles: `windows/install_configs/*.txt`
- Package definitions: `windows/packages/*.json`

Available profiles are discovered automatically from `windows/install_configs/*.txt`.

- `base`
- `games`
- `3dprinting`

Profile name is the filename without `.txt`.
Example: `windows/install_configs/base.txt` -> `-Profile base`.

Examples:

```powershell
# Use a custom list file
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -ConfigPath .\windows\install_configs\base.txt

# Use a detected profile name (from install_configs filename)
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -Profile games

# Show command help
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 help
```

### Package JSON format

Each package file now uses a single command list and optional info URL:

```json
{
  "description": "Software name",
  "info": "https://example.org/software",
  "commands": [
    "choco install -y package --ignore-checksums",
    "winget install --id Vendor.Package --silent --accept-package-agreements --accept-source-agreements"
  ]
}
```

Notes:

- `description` is metadata only and is not used by the installer logic.
- `commands` is the only field executed by the installer.
- Command output is streamed to terminal while each command runs.
- If a command exits with non-zero code, the package is marked as failed.
- URL downloads are expressed directly as commands.
- If `commands` is empty, the package is skipped and shown at the end in a manual-install list with the `info` link.

### Default installs

- **Development**: git, vscode, python, docker-desktop, jetbrains-toolbox, postman
- **Browsers**: firefox, google-chrome
- **Communication**: thunderbird, telegram, discord
- **Media**: vlc, spotify
- **Utilities**: keepass, obsidian, wireguard
- **Games**: steam, epic-games-launcher, ea-app, heroic-games-launcher

## Environment Setup

### Settings configuration

- Personalisation
  - Background
    - Picture: Select Photo
  - Themes
    - Dark Mode
    - Custom accent color: Blue
  - Lock Screen
    - Picture: Select Photo
    - Disable `Get fun facts, tips, tricks and more on your lock screen`
    - Lock screen status: None
  - Start
    - Recommended
      - Disable `Show recently added apps`
      - Disable `Show recommended files in Start, recentfiles in File Explorer and on Jump Lists`
      - Disable `Show recommendations for tips, shortcuts, new apps and more`
  - Taskbar
    - Taskbar items
      - Search: `Search icon only`
      - Task view: `On`
      - Widgets: `Off`
    - System Tray icons
      - Emoji and more: `Never`
      - Pen Menu: `Off`
      - Touch keyboard: `Never`
    - Taskbar behaviours
      - Enable `Automatically hide the taskbar`
- Time & language
  - Language & region
    - Language
      - Windows display language: English (United Kingdom)
      - Preferred languages
        - English (United Kingdom). Add `US` as keyboard layout.
        - Spanish (Spain)
    - Region
      - Country or region: Spain
      - Regional format: Spanish (Spain, Internacional Sort)

### Desktop configuration

Making right click aand selecting `Show more options` to get the old menu:

- View
  - Disable `Show desktop icons`

## WIP

- Startup apps: Firefox, Obsidian, Thunderbird
  - Apps folder: `Win+R` -> `shell:appsfolder`
  - Startup folder: `Win+R` -> `shell:startup`
  - Drag and drop the ones
- Other setup configurations
  - Remove Windows Slop -> `Apps -> Installed apps`
- Graphic drivers
  - [GeForce Experience](https://www.nvidia.com/es-es/geforce/drivers/)
