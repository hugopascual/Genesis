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
   - Team Viewer
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

## Chocolatey install

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

```powershell
powershell -ExecutionPolicy Bypass -File .\windows.ps1
```
