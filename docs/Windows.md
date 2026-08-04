# Windows Software

## Installation

The first step is to install Chocolatey, on an administrative powershell, run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Then, run the software installation script:

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 -Profile base
```

### Installation profiles

The script now uses profile files (similar to Linux) and package JSON definitions:

- Profiles: `windows/install_configs/*.txt`
- Package definitions: `windows/packages/*.json`

Active profile currently included:

- `base`

The script logic remains profile-based, so adding `development`, `desktop`, or `games` again only requires creating new `.txt` files in `windows/install_configs/`.

Examples:

```powershell
# Use a custom list file
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 -ConfigPath .\windows\install_configs\base.txt
```

### Package JSON format

Each package file can define one or more providers:

```json
{
  "description": "Software description",
  "chocolatey": [
    "choco install -y package"
  ],
  "winget": [
    "winget install --id Vendor.Package --silent --accept-package-agreements --accept-source-agreements"
  ],
  "urls": [
    {
      "url": "https://example.org/installer.exe",
      "arguments": "/S"
    }
  ]
}
```

If a provider array is empty, it is skipped.

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
    - Taskbar corner icons
      - Disable `Pen menu`
      - Disable `Touch keyboard`
      - Disable `Virtual touchpad`
    - Taskbar corner overflow
      - Disable all
    - Taskbar behaviours
      - Enable `Automatically hide the taskbar`
- Time & language
  - Language & region
    - Language
      - Windows display language: English (United Kingdom)
      - Preferred languages: English (United Kingdom), Spanish (Spain)
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
