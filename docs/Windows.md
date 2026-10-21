# Windows Genesis Guide

## Requirements

Install [Chocolatey](https://chocolatey.org/install) from an administrative PowerShell:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## Commands

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install [-Profile <profile>] [-ConfigPath <package_list_file>]
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 update
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 help
```

- `install` is the default command, and `desktop` the default profile: running the script without arguments installs the `desktop` profile.
- Every command except `help` shows the selected options and asks for confirmation before running.

## Install

```powershell
# Profile (profiles/windows/<profile>.txt)
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -Profile personal

# Custom package list, it can contain "@include <profile>"
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -ConfigPath .\my_packages.txt
```

Profiles and the `@include` syntax are described in [Profiles](Profiles.md). If both `-Profile` and `-ConfigPath` are given, `-ConfigPath` is used.

Each package is installed with its `windows` entry (see [Packages](../README.md#packages)):

- `choco`: installed with Chocolatey.
- `commands`: PowerShell commands run in order. Their output is shown while they run, and a non-zero exit code marks the package as failed.
- `manual`: skipped and listed at the end with its URL to install it by hand.
- No `windows` entry: skipped and listed as not available.

At the end, a summary lists the packages installed, not available, requiring a manual install and failed. The command exits with an error only if some package failed.

## Update

Update all Chocolatey packages:

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 update
```

## Logs

The whole session output, including the output of the installation commands, is saved in `windows\logs\` with the format `genesis_YYYYMMDD_HHMMSS.log`. Logs are enabled by default; set `GENESIS_LOG_ENABLED` to `false` to disable them:

```powershell
$env:GENESIS_LOG_ENABLED = "false"
powershell -ExecutionPolicy Bypass -File .\windows\windows.ps1 install -Profile desktop
```

## Manual configuration

There is no automated setup on Windows yet. These are the settings applied by hand.

### Settings

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
      - Disable `Show recommended files in Start, recent files in File Explorer and on Jump Lists`
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
      - Regional format: Spanish (Spain, International Sort)

### Desktop

Right click on the desktop and select `Show more options` to get the old menu:

- View
  - Disable `Show desktop icons`

### Pending

- Startup apps: Firefox, Obsidian, Thunderbird
  - Apps folder: `Win+R` -> `shell:appsfolder`
  - Startup folder: `Win+R` -> `shell:startup`
  - Drag and drop the apps from the apps folder to the startup folder
- Remove preinstalled apps: `Apps -> Installed apps`
- Graphics drivers: installed manually through the `amd_drivers`, `intel_drivers` and `nvidia_app` packages of the `desktop` profile

## For developers

### Project Structure

The Windows code follows the same layout as the Linux one:

```text
Genesis/
├── packages/              # Software definitions shared with Linux (JSON)
├── profiles/windows/      # Installation profiles
└── windows/
    ├── windows.ps1        # Main entrypoint
    ├── logs/              # Session logs
    └── src/
        ├── commands/      # Command managers (install, update)
        └── utilities/     # Constants, help, logging and utilities
```

Scripts in `src/utilities` and `src/commands` are loaded automatically by `windows.ps1`, in that order.

### Adding software

See [Packages](../README.md#packages).
