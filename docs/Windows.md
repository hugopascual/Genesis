# Windows Software

## Software escritorio

1. **Minimum**

   - 7zip

2. **Development**

   - Basics development
     - git
   - Docker desktop
   - Python
   - GitHub Desktop
   - VScode
   - JetBrains Toolbox
   - Postman
   - RPI Imager

3. **DIT Software**

   - OpenVPNv3

4. **Desktop**

   - DisplayLink Driver
   - GeForce Experience
   - Firefox
   - Google Chrome
   - Thunderbird
   - KeePass
   - Autofirma
   - Config FNMT
   - Obsidian
   - VLC
   - Spotify
   - Telegram
   - Discord
   - Rust Desk
   - Wireguard
   - Google Drive
   - Adobe Reader

5. **Hobbys**

   - Steam
   - Epic Games Launcher
   - Battle.net
   - EA App
   - Minecraft Launcher
   - Heroic
   - Amazon Games
   - Chitubox Software: Chitubox Free y Chitubox Manager
   - Lychee Slicer

## Installation steps

### Chocolatey install

On an administrative powershell, run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### Software installation script

```powershell
powershell -ExecutionPolicy Bypass -File .\windows.ps1
```

## Final setup steps

- Add second keyboard distibution
- Graphic drivers
  - [GeForce Experience](https://www.nvidia.com/es-es/geforce/drivers/)
- Startup apps: Firefox, Obsidian, Thunderbird
  - Apps folder: `Win+R` -> `shell:appsfolder`
  - Startup folder: `Win+R` -> `shell:startup`
  - Drag and drop the ones
- Clonar repositorios
- Configurar VPNs
  - Wireguard
  - OpenVPN3
- Iniciar sesión en los distintos servicios

### Customization

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
