# Windows 11 software installations

## Installations commands

### Package manager
```
# On an administrative powershell
# Run 
Get-ExecutionPolicy
# If it returns Restricted, then run 
Set-ExecutionPolicy AllSigned 
# or 
Set-ExecutionPolicy Bypass -Scope Process.

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Restart the powershell
```

### Command Software Installs
Restart after the complete execution
```
# On an administrative powershell

# Basic
choco install -y git
choco install -y firefox
choco install -y thunderbird
choco install -y geforce-experience
choco install -y keepass.install
# Autofirma (Manual)
# Config FMNT (Manual)
choco install -y 7zip
choco install -y googledrive
choco install -y adobereader

# Development
# Docker (Manual)
choco install -y vscode
choco install -y jetbrainstoolbox

# DIT
# VPN (Manual)

# Services
choco install -y spotify
choco install -y telegram.install
choco install -y discord.install

# Games
choco install -y steam --ignore-checksums
choco install -y epicgameslauncher
choco install -y amazongames --ignore-checksums
# Battle.net (Manual)
# Minecraft (Manual)

# Extra
choco install -y obsidian
choco install -y vlc
```

### Manual Software Installs
**Basic**
- [Autofirma](https://autofirma.net/descargar/)
- [Config FNMT](https://www.sede.fnmt.gob.es/descargas/descarga-software/instalacion-software-generacion-de-claves)

**Development**
- [Docker](https://www.docker.com/)

**DIT**
- TODO [DIT VPN]()

**Services**

**Games**
- [Battle.net](https://eu.shop.battle.net/es-es)
- [Minecraft](https://www.minecraft.net/es-es/download)
- [Epilogue](https://www.epilogue.co/downloads)

**Extra**
- [Razer synapse](https://www.razer.com/synapse-3)
- [RK Royal Gaming Keyboard](https://rkgamingstore.com/products/rk84-75-percent-keyboard)
    - [Other link](https://www.techpowerup.com/review/royal-kludge-rk84-keyboard/5.html)
- [Aura Creator]()
- [Armor Crate]()
- [MyAsus]()
- [Dolby Access]()

### Special Drivers
Drivers of PCIe cards

## Customization
The first step is to remove software not useful. Go to `Apps -> Installed apps` remove and disable.

Now is the time to customize the desktop
- In screen `View -> Disable Show Desktop Icons`
Inside Settings
- Personalisation
    - Black Mode in blue
    - Background
        - Select Photo
    - Lock Screen
        - Select Photo
        - Disble fun facts, tips and tricks
        - App on screen -> None
    - Taskbar
        - Pinned apps: Firefox - File explorer - Thunderbird - Obsidian - Spotify - VSCode - Pycharm - IntelliJ - Android Studio
        - Search icon only
        - Disble Widgets
        - Taskbar Behaviours
            - Automatically hide the taskbar
    - Start
        - More pins
        - Disble recomendations
        - Disbale related notifications
        - Folders
            - Settings
            - File Explorer
            - Personal folder

## Accounts sync
- Firefox
    - Github login
    - Web browser syncronization
    - Google accounts on web browser
        - Google personal account 
        - Google profesional account
        - Google games account
   - FNMT Certificate
- Google Drive
	- Google personal account
    - Google profesional account
    - Google games account
    - Keep a copy of files locally for all accounts
- One Drive
    - Microsoft personal account
    - UPM professional account
    - Keep a copy of files locally for all accounts
- Thunderbird
    - UPM worker account
        - Incoming server: 
            - `correo.upm.es` / `SSL/TLS` / `hugo.pascual.adan`
        - Outgoing server: 
            - `smtp.upm.es` / `STARTTLS` / `hugo.pascual.adan@upm.es`
    - UPM student account
        - Incoming server: 
            - `correo.alumnos.upm.es` / `SSL/TLS` 
        / `hugo.pascual.adan`
        - Outgoing server: 
            - `smtp.upm.es` / `STARTTLS` / `hugo.pascual.adan@alumnos.upm.es`
    - Google personal account
    - Google profesional account
    - Google games account
    - Microsoft personal account
    - Projects accounts if work laptop
    - Config:
        - Disable show lost reminders 
- GeForce Experience
	- NVIDIA account sync
- Keepassxc
    - Download credentials database and check if works
    - Config:
        - Title / User / Password / URL / Notes
        - Fit to Window
- Adobe Reader
	- Adobe account sync
- VSCode
    - Sync settings with Github account
- Jetbrains Toolbox
    - Syncronize with licensed account
    - Config:
        - Not open on startup
- VPNs
	- TODO DIT one
- Spotify
    - Spotify login
- Telegram
    - Telegram login personal
    - Telegram login profesional
- Discord
    - Discord login
    - Config:
        - Linux ajustements -> NOT Open Discord on Startup
        - Linux ajustements -> NOT Minimize on close
- Steam
    - Steam login
    - Config:
        - Disable open on startup
- Epic Games
	- Epic Games login
- Amazon Games 
	- Amazon Games login
- Battle.net
    - Battle.net login
    - Config:
        - Disable open on startup
- Minecraft
    - Microsoft login
- Obsidian
    - Clone obsidian vaults from git
- Office 365
    - UPM professional account
- Razer Synapse
    - Account login
