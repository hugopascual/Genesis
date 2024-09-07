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

**Extra**

## Customization

## Accounts sync
- Firefox
    - Github login
    - Web browser syncronization
    - Google accounts on web browser
        - Google personal account 
        - Google profesional account
        - Google games account
   - FNMT Certificate
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
- Google Drive
	- 
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

## Remote git repositories list
- Personal repositories
    -
```
cd "$HOME/dev/$USER" || exit
git clone https://github.com/hugopascual/AdventCode
git clone https://github.com/hugopascual/BetAPI
git clone https://github.com/hugopascual/TGBotDuplicator
git clone https://github.com/hugopascual/WindowsOS
git clone https://github.com/hugopascual/BetWatchdog
git clone https://github.com/hugopascual/BetWatchdog-tgSupervisor
git clone https://github.com/hugopascual/BetWatchdog-API
git clone https://github.com/hugopascual/OS_setup
```

- Work repositories
    -
```
cd "$HOME/dev/STRAST" || exit
git clone https://github.com/hugopascual/iGreedy3.0
git clone https://github.com/hugopascual/Hunter
git clone https://github.com/hugopascual/HunterCache
git clone https://github.com/STRAST-UPM/cluster-documentation
git clone https://github.com/STRAST-UPM/hunter_experiment_anycast_europe
git clone https://github.com/SARA-MSRA-UPM/PG0_intro_python
git clone https://github.com/SARA-MSRA-UPM/PG1_concurrencia
git clone https://github.com/SARA-MSRA-UPM/PE1_concurrencia
git clone https://github.com/SARA-MSRA-UPM/PG2_tiempo_real
git clone https://github.com/SARA-MSRA-UPM/PE2_tiempo_real
git clone https://github.com/SARA-MSRA-UPM/PG3_programacion_web
git clone https://github.com/SARA-MSRA-UPM/PE3_programacion_web
```

- Obsidian vaults
    -
```
cd "$HOME/obsidian" || exit
git clone https://github.com/hugopascual/template_vault
git clone https://github.com/hugopascual/family_vault
git clone https://github.com/hugopascual/personal_vault
git clone https://github.com/hugopascual/work_vault
```


## Things that are not automatized
### Uninstall preinstalled software
Desintalar mierda y quetar que cosas como Cortana puedan ir en segundo plano


### Personalization
Quitar inconos escritorio

- Modo Oscuro de Windows en tono azul
> Fondo
- Cambiar fondo de escritorio
> Pantalla de bloqueo
- Cambiar imagen de bloqueo
- Deseleccionar los datos curiosos y consejos
> Inicio
- Seleccionar: Mas elementos anclados
	> Carpetas
	- Añadir Configuración y Explorador de archivos
> Barra de tareas
- Deseleccionar: Widgets y Chat
	> Comportamiento de la barra de tareas
	- Activar Ocultar automaticamente la barra de tareas

### Updates and drivers
Drivers
- Dirvers tarjeta inalámbrica usando el disco para ello

### Manual installations
Descargar exe:
https://www.blizzard.com/es-es/apps/battle.net/desktop
https://www.razer.com/synapse-3
https://rkgamingstore.com/es/pages/software
https://www.sede.fnmt.gob.es/descargas/descarga-software/instalacion-software-generacion-de-claves
https://firmaelectronica.gob.es/Home/Descargas.htm
https://www.epilogue.co/downloads

Microsoft Store: 
Minecraft
Microsoft Office


## Synchronize accounts
- One drive:
    - Cuenta personal [hugo.pasadan@hotmail.com]
    - Cuenta UPM [hugo.pascual.adan@upm.es]

# Detalles sobre cada software
Google Drive
- choco install -y googledrive
- Iniciar sesión [hugopascual998@gmail.com]

Mozilla Firefox
- choco install -y firefox
- Establecer como predeterminado
- Sincronizar cuenta [hugopascual998@gmail.com]
- Mostrar siempre la barra de marcadores
- Colocar el botón de inicio
- Iniciar sesión en Google 
[hugopascual998@gmail.com; turfusplays@gmail.com; hugo.pascual.adan@gmail.com]

Google Chrome
- choco install -y googlechrome

Steam
- choco install -y steam-client
- Iniciar sesión [turfus98]
- Quitar que se inicie con el ordenador

Thunderbird
- choco install -y thunderbird
- Configurar correos con calendarios 
[hugopascual998@gmail.com; turfusplays@gmail.com; hugo.pascual.adan@gmail.com; hugo.pasadan@hotmail.com]

GeForce Experience
- choco install -y geforce-experience
- Iniciar sesión

Nvidia Control Panel
- Revisar que esta instalado

Spotify
- choco install -y spotify
- Iniciar sesión [hugopascual998@gmail.com]
- Quitar que se inicie con el ordenador y hacer que al cerrar no se minimice
- Modo oscuro

Visual Studio Code
- choco install -y vscode
- Iniciar sesión con GitHub

7zip
- choco install -y 7zip

KeePass2
- choco install -y keepass.install
- Hacer que se vea el campo custom de email

Adobe Acrobat Reader
- choco install -y adobereader

Epic games
- choco install -y epicgameslauncher
- Iniciar sesión
- Quitar que se inicie con el ordenador y hacer que al cerrar no se minimice

Amazon Games
- choco install -y amazongames
- Iniciar sesión
- Quitar que se inicie con el ordenador
- Modo oscuro

Discord
- choco install -y discord.install
- Iniciar sesión
- Quitar que se inicie con el ordenador y hacer que al cerrar no se minimice
- Modo oscuro

Battle.net
- Descargar exe (https://www.blizzard.com/es-es/apps/battle.net/desktop)
- Iniciar sesión [hugopascual998@gmail.com]
- Quitar que se inicie con el ordenador y hacer que al cerrar no se minimice

Razer Synapse
- Descargar exe (https://www.razer.com/synapse-3)
- Iniciar cuenta [hugopascual998@gmail.com]

RK RGB Keyboard
- Dedscargar exe (https://www.techpowerup.com/review/royal-kludge-rk84-keyboard/5.html)

Configurador FNMT
- Descargar de (https://www.sede.fnmt.gob.es/descargas/descarga-software/instalacion-software-generacion-de-claves)

Autofirma (se instala a la vez que el configurador)
- Descargar de (https://firmaelectronica.gob.es/Home/Descargas.htm)

Epilogue
- Descargar de (https://www.epilogue.co/downloads)

Hearthstone Tracker
- Descargar de (https://hsreplay.net/downloads/)
- Iniciar cuenta
- Restaurar última copia de seguridad

Hearth Arena
- Descargar de (https://www.heartharena.com/app)
- Iniciar cuenta

Overwolf
- Instalado con Heartharena
- Quitar el inicio con Windows

Minecraft
- Instalar desde Microft Store
- Iniciar sesión con Microsoft [hugo.pasadan@hotmail.com]

Microsoft Office con la cuenta de la UPM / En su defecto Libre Office
- Instalar desde Microft Store

Instalar certificado en Firefox

------------------------------------------- Anclados a Inicio Windows
Navegadores Web:
- Mozilla Firefox

Launchers:
- Los distintos Launchers

Juegos 
- Minecraft
- Hearthstone

Extra Juegos
- Hearthstone Deck Tracker
- Heartharena
- Epilogue
- Overwolf

Uso diario:
- Thunderbird
- Spotify
- Discord

PC:
- Panel de control
- GeForce Experience

Desarrollo:
- Visual Studio Code

Hardware (aquello de hardware especifico)
- Armoury Crate (solo el Zephyrus G14)
- Razer Synapse
- RK RGB Keyboard

-------------------------------------------

Al usar el portatil Zephyrus G14 añadir los programas:

Periféricos
- Armor Create
- Dolby Access
- Aura Creator
- MyASUS