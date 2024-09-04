# Linux desktop

## Instructions
Execute `desktop_setup.sh` and follow the instructions. If your distro is not 
supported I am very sorry (okay, maybe not that much).

### Update system
Using the `desktop_setup.sh` script the system will be updated and upgraded. If 
you want to execute another standard upgrade use the `update.sh` script.

## Not Automatic Steps
Although I have tried to automatize the whole process there are some aspects I 
do not know how to make it. 

### Config
- Put on startup the apps:
    - `firefox`
    - `flatpak run org.mozilla.Thunderbird`
    - `obsidian`
- Config second keyboard distribution
- Add to bookmark in files: `dev`, `obsidian`, `nfs`

### Not automatic installations
- Lutris
    - Battle.net (https://lutris.net/games/battlenet/)
- Jetbrains Toolbox
    - Install Pycharm Professional
    - Install IntelliJ IDEA Ultimate
    - Install Android Studio
    

### Accounts Initializations
- Firefox
    - Github login
    - Web browser syncronization
    - Google accounts on web browser
        - Google personal account 
        - Google profesional account
        - Google games account
- Github CLI (terminal)
    - Github account via browser 
    - `gh auth login`
    - Clone personal and work repositories from list
- Obsidian
    - Clone obsidian vaults from git
- VSCode
    - Sync settings with Github account
- GNOME Desktop
    - Google personal account
    - Google profesional account
    - Google games account
- Keepassxc
    - Download credentials database and check if works
    - Config:
        - Titulo / Usuario /Contraseña / URL / Notas
        - Ajustar a la ventana
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
- Jetbrains Toolbox
    - Syncronize with licensed account
    - Config:
        - Not open on startup
- VPNs
    - Get VPN DIT configuration file (`dit.conf`) and test
    - Move the file: `sudo mv dit.conf /etc/vpnc/`
    - Connect: `sudo vpnc-connect dit`
    - Connect if new system: `sudo vpnc-connect --enable-weak-encryption 
        --enable-weak-authentication dit`
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
- Battle.net
    - Battle.net login
    - Config:
        - Disable open on startup
- Steam
    - Steam login
    - Config:
        - Disable open on startup
- Minecraft
    - Microsoft login

### Personal NAS syncro
Not ready for production yet

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