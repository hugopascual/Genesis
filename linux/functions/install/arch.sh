#!/bin/bash

##
# @Description
# Basic installs that are proper from the distro only
##
base_install() {
    echo_installing 'Basic installs for this distribution'
    
    # yay
    pacman_install 'git'
    pacman_install 'base-devel'
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si
    cd .. && rm -rf yay

    echo_installing 'Basic installs for this distribution completed'
}

# Minimum ######################################################################

sudo_install() {
    # TODO: Install sudo
    echo_installing 'Installing sudo'
    echo_installing 'sudo installed'
}

htop_install() {
    echo_installing 'Installing htop'
    pacman_install 'htop'
    echo_installing 'htop installed'
}

tree_install() {
    echo_installing 'Installing tree'
    pacman_install 'tree'
    echo_installing 'tree installed'
}

nfs_install() {
    # https://wiki.archlinux.org/title/NFS
    echo_installing 'Installing NFS utilities'
    pacman_install 'nfs-utils'
    echo_installing 'NFS utilities installed'
}

rename_install() {
    echo_installing 'Installing rename'
    pacman_install 'perl-rename'
    echo_installing 'rename installed'
}

rsync_install() {
    echo_installing 'Installing rsync'
    pacman_install 'rsync'
    echo_installing 'rsync installed'
}

lshw_install() {
    echo_installing 'Installing lshw'
    pacman_install 'lshw'
    echo_installing 'lshw installed'
}

wget_install() {
    echo_installing 'Installing wget'
    pacman_install 'wget'
    echo_installing 'wget installed'
}

curl_install() {
    echo_installing 'Installing curl'
    pacman_install 'curl'
    echo_installing 'curl installed'
}

vim_install() {
    echo_installing 'Installing vim'
    pacman_install 'vim'
    echo_installing 'vim installed'
}

nvim_install() {
    echo_installing 'Installing nvim'
    pacman_install 'neovim'
    echo_installing 'nvim installed'
}

fastfetch_install() {
    echo_installing 'Installing Fastfetch'
    pacman_install 'fastfetch'
    echo_installing 'Fastfetch installed'
}

nvtop_install() {
    echo_installing 'Installing NVTop'
    pacman_install 'nvtop'
    echo_installing 'NVTOP installed'
}

# Development ##################################################################

git_install() {
    echo_installing 'Installing Git'
    pacman_install 'git'
    echo_installing 'Git installed'
}

github_cli_install() {
    echo_installing 'Installing GitHub CLI'
    pacman_install 'github-cli'
    echo_installing 'GitHub CLI installed'
}

jdk_install() {
    # https://wiki.archlinux.org/title/Java#OpenJDK
    echo_installing 'Installing Java Development Kit'
    pacman_install 'jdk-openjdk'
    echo_installing 'Java Development Kit installed'
}

jre_install() {
    # https://wiki.archlinux.org/title/Java#OpenJDK
    echo_installing 'Installing Java Runtime Environment'
    pacman_install 'jre-openjdk'
    echo_installing 'Java Runtime Environment installed'
}

docker_install() {
    echo_installing 'Installing Docker'
    pacman_install 'docker'
    pacman_install 'docker-compose'
    sudo systemctl enable docker.service
    echo_installing 'Docker installed'
}

lazydocker_install() {
    echo_installing 'Installing lazydocker'
    yay_install 'lazydocker'
    echo_installing 'lazydocker installed'
}

python_install() {
    echo_installing 'Installing Python'
    pacman_install 'python'
    echo_installing 'Python installed'
}

nodejs_install() {
    # https://nodejs.org/es/download
    echo_installing 'Installing NodeJS'
    ## Download and install nvm:
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    ## in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"
    ## Download and install Node.js:
    nvm install 24
    echo_installing 'NodeJS installed'
}

vscode_install() {
    # In this case we install Code - OSS version
    echo_installing 'Installing Visual Studio Code'
    pacman_install 'code'
    echo_installing 'Visual Studio Code installed'
}

jetbrains_toolbox_install() {
    # https://aur.archlinux.org/packages/jetbrains-toolbox
    echo_installing 'Installing JetBrains Toolbox'
    yay_install 'jetbrains-toolbox'
    echo_installing 'JetBrains Toolbox installed'
}

postman_install() {
    # https://aur.archlinux.org/packages/postman-bin
    echo_installing 'Installing Postman'
    yay_install 'postman-bin'
    echo_installing 'Postman installed'
}

raspberry_pi_imager_install() {
    # https://archlinux.org/packages/extra/x86_64/rpi-imager/
    # TODO: install to run with privilegies
    echo_installing 'Installing Raspberry Pi Imager'
    pacman_install 'rpi-imager'
    echo_installing 'Raspberry Pi Imager installed'
}

# DIT Software #################################################################

openvpn3_install() {
    echo_installing 'Installing OpenVPNv3'
    yay_install 'openvpn3'
    echo_installing 'OpenVPNv3 installed'
}

# Desktop ######################################################################

kitty_install() {
    echo_installing 'Installing kitty'
    pacman_install 'kitty'
    echo_installing 'kitty installed'
}

displaylink_driver_install() {
    # https://wiki.archlinux.org/title/DisplayLink
    echo_installing 'Installing DisplayLink Driver'
    pacman_install 'linux-headers'
    yay_install 'evdi-dkms'
    yay_install 'displaylink'
    sudo systemctl enable displaylink.service
    echo_installing 'DisplayLink Driver installed'
}

firefox_install() {
    echo_installing 'Installing Firefox'
    pacman_install 'firefox'
    echo_installing 'Firefox installed'
}

google_chrome_install() {
    echo_installing 'Installing Google Chrome'
    yay_install 'google-chrome'
    echo_installing 'Google Chrome installed'
}

thunderbird_install() {
    echo_installing 'Installing Thunderbird'
    pacman_install 'thunderbird'
    echo_installing 'Thunderbird installed'
}

keepassxc_install() {
    echo_installing 'Installing KeePass XC'
    pacman_install 'keepass'
    echo_installing 'KeePass XC installed'
}

autofirma_install() {
    # https://aur.archlinux.org/packages/autofirma-bin
    echo_installing 'Installing Autofirma'
    yay_install 'autofirma-bin'
    echo_installing 'Autofirma installed'
}

config_fnmt_install() {
    # https://aur.archlinux.org/packages/configuradorfnmt
    echo_installing 'Installing Config FNMT'
    yay_install 'configuradorfnmt'
    echo_installing 'Config FNMT installed'
}

obsidian_install() {
    echo_installing 'Installing Obsidian'
    pacman_install 'obsidian'
    echo_installing 'Obsidian installed'
}

vlc_install() {
    echo_installing 'Installing VLC'
    pacman_install 'vlc'
    echo_installing 'VLC installed'
}

spotify_install() {
    # https://wiki.archlinux.org/title/Spotify
    # https://archlinux.org/packages/?name=spotify-launcher
    echo_installing 'Installing Spotify'
    pacman_install 'spotify-launcher'
    echo_installing 'Spotify installed'
}

telegram_install() {
    # https://archlinux.org/packages/?name=telegram-desktop
    echo_installing 'Installing Telegram'
    pacman_install 'telegram-desktop'
    echo_installing 'Telegram installed'
}

discord_install() {
    # https://archlinux.org/packages/?name=discord
    echo_installing 'Installing Discord'
    pacman_install 'discord'
    echo_installing 'Discord installed'
}

rustdesk_install() {
    # TODO: Install Rust Desk
    echo_installing 'Installing Rust Desk'
    echo_installing 'Rust Desk installed'
}

gimp_install() {
    # https://archlinux.org/packages/?name=gimp
    echo_installing 'Installing GIMP'
    pacman_install 'gimp'
    echo_installing 'GIMP installed'
}

wireguard_install() {
    echo_installing 'Installing Wireguard'
    pacman_install 'wireguard-tools'
    echo_installing 'Wireguard installed'
}

7zip_install() {
    echo_installing 'Installing 7zip'
    pacman_install '7zip'
    echo_installing '7zip installed'
}

# Hobbys #######################################################################

steam_install() {
    # TODO: Install Steam
    echo_installing 'Installing Steam'
    echo_installing 'Steam installed'
}

minecraft_launcher_install() {
    # TODO: Install Minecraft Launcher
    echo_installing 'Installing Minecraft Launcher'
    echo_installing 'Minecraft Launcher installed'
}
