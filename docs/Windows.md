# Windows Software

## Installation

The first step is to install Chocolatey, on an administrative powershell, run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Then, run the software installation script:

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -Profile desktop
```

### Installation profiles

Profiles are defined in `profiles/windows/*.txt` and packages in the shared `packages/*.json` catalog (see the Packages section of the main `README.md`).

Profiles are organised by levels: `base` is included by `desktop`, and `desktop` is included by `work` and `personal`. See `profiles/README.md` for the `@include` syntax.

The profile name is the filename without `.txt`. If `-Profile` is not given, `desktop` is used.

Examples:

```powershell
# Use a profile
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -Profile personal

# Use a custom package list (it can contain "@include <profile>")
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -ConfigPath .\my_packages.txt

# Show command help
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 help
```

### Installation behaviour

- Before installing, the selected options are shown and a confirmation is requested.
- Each package uses its `windows` entry: `choco`, `commands` (PowerShell) or `manual`.
- Command output is streamed to terminal while each command runs.
- If a command exits with non-zero code, the package is marked as failed.
- Packages without a `windows` entry are skipped and listed as not available.
- Packages with a `manual` entry are skipped and listed at the end with their URL.

## Update

Update all Chocolatey packages:

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 update
```

## Logs

The whole session output, including the output of the installation commands, is saved in `windows/logs` with the format `genesis_YYYYMMDD_HHMMSS.log`. It is enabled by default; to disable it set the `GENESIS_LOG_ENABLED` environment variable to `false`:

```powershell
$env:GENESIS_LOG_ENABLED = "false"
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -Profile desktop
```

### Project Structure

The Windows code follows the same layout as the Linux one:

```text
windows/
├── windows.ps1            # Main entrypoint
├── logs/                  # Session logs
└── src/
    ├── commands/          # Command managers (install, update)
    └── utilities/         # Constants, help, logging and utilities
```

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
