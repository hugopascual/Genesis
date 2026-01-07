#!/bin/bash

################################################################################
#-- Minimum --#
################################################################################

# sudo
# TODO: Install sudo
# htop
apt_get_install 'htop'
# tree
apt_get_install 'tree'
# NFS
apt_get_install 'nfs-common'
# rename
apt_get_install 'rename'
# rsync
apt_get_install 'rsync'
# lshw
apt_get_install 'lshw'
# wget
apt_get_install 'wget'
# curl
apt_get_install 'curl'
# vim
apt_get_install 'vim'
# nvim
apt_get_install 'nvim'
# Fastfetch
# https://github.com/fastfetch-cli/fastfetch
deb_download_and_install 'https://github.com/fastfetch-cli/fastfetch/releases/download/2.50.2/fastfetch-linux-amd64.de'
# NVTOP
apt_get_install "nvtop"

################################################################################
#-- Development --#
################################################################################

# Git
apt_get_install "git"
# GitHub Cli
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
# shellcheck disable=SC2174
mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install gh -y
# Java Runtime
apt_get_install "default-jre"
# Docker
# https://docs.docker.com/engine/install/ubuntu/
# Add Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce
apt-get install -y docker-ce-cli
apt-get install -y containerd.io
apt-get install -y docker-buildx-plugin
apt-get install -y docker-compose-plugin
# Lazydocker
# https://github.com/jesseduffield/lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
mv "$HOME/.local/bin/lazydocker" /usr/local/bin/
# Python3
apt_get_install "python3"
apt_get_install "python3-venv"
apt_get_install "python3-pip"
# NodeJS
# https://nodejs.org/es/download
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
# Download and install Node.js:
nvm install 22
# Visual Studio Code
# https://code.visualstudio.com/docs/setup/linux
deb_download_and_install 'https://go.microsoft.com/fwlink/?LinkID=760868'
# JetBrains Toolbox
# https://www.jetbrains.com/help/idea/installation-guide.html#toolbox
# https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
## TODO install for all users
## TODO: improve with the build variable
apt-get install -y libfuse2
jetbrains_toolbox_tar_file="jetbrains-toolbox-2.4.0.32175.tar.gz"
wget -c https://download.jetbrains.com/toolbox/$jetbrains_toolbox_tar_file
tar -xzf "$jetbrains_toolbox_tar_file" -C /opt
descompressed_dir="${jetbrains_toolbox_tar_file: : -7}"
/opt/"$descompressed_dir"/jetbrains-toolbox
rm -rf /opt/"$descompressed_dir"
rm -f "$jetbrains_toolbox_tar_file"
# Postman
snap_install "postman"
# Raspberry Pi Imager
apt_get_install "rpi-imager"
# 7zip
apt_get_install '7zip'

################################################################################
#-- DIT Software --#
################################################################################

# OpenVPNv3
# https://community.openvpn.net/Pages/OpenVPN3Linux
# https://openvpn.net/cloud-docs/tutorials/configuration-tutorials/connectors/operating-systems/linux/tutorial--learn-to-install-and-control-the-openvpn-3-client.html
## Install other necessary software
apt install -y apt-transport-https curl
## Repository keys
sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://packages.openvpn.net/packages-repo.gpg | sudo tee /etc/apt/keyrings/openvpn.asc
DISTRO=$(lsb_release -c -s)
echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian $DISTRO main" | sudo tee /etc/apt/sources.list.d/openvpn-packages.list
apt update
apt install -y openvpn3

################################################################################
#-- Desktop --#
################################################################################

# Flatpak
apt install -y flatpak
# add the Flathub repository
FLATHUB_REPO_URI=https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub "$FLATHUB_REPO_URI"
# Kitty
# TODO: install kitty
# DisplayLink Driver
# https://www.synaptics.com/products/displaylink-graphics/downloads
wget 'https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb'
apt install -y ./synaptics-repository-keyring.deb
apt update
apt install -y displaylink-driver
rm synaptics-repository-keyring.deb
# Firefox
apt_get_install "firefox"
# Google Chrome
flathub_install "com.google.Chrome"
# Thunderbird
flathub_install "org.mozilla.Thunderbird"
# KeePassXC
flathub_install "org.keepassxc.KeePassXC"
# Autofirma
# https://firmaelectronica.gob.es/Home/Descargas.html
echo_installing "AutoFirma"
curl -OL 'https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma19/Autofirma_Linux_Debian.zip'
unzip "Autofirma_Linux_Debian.zip"
apt install -y ./*.deb
rm Autofirma*
echo_installed "AutoFirma"
# Configurador FNMT
# https://www.sede.fnmt.gob.es/descargas/descarga-software/instalacion-software-generacion-de-claves
echo_installing "Configurador FNMT"
apt install -y default-jdk
wget https://descargas.cert.fnmt.es/Linux/configuradorfnmt_4.0.5_amd64.deb
apt install -y ./configuradorfnmt*
rm configuradorfnmt*
echo_installed "Configurador FNMT"
# Obsidian
deb_download_and_install 'https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.7/obsidian_1.6.7_amd64.deb'
# VLC
apt_get_install "vlc"
# Spotify
# https://www.spotify.com/us/download/linux/
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
apt-get update
apt-get install -y spotify-client
# Telegram Desktop
flathub_install "org.telegram.desktop"
# Discord
deb_download_and_install 'https://discord.com/api/download?platform=linux&format=deb'
# TeamViewer
deb_download_and_install 'https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'
# GIMP
apt_get_install "gimp"
# WireGuard
apt_get_install "wireguard"

################################################################################
#-- Hobbys --#
################################################################################

# Steam
deb_download_and_install 'https://cdn.akamai.steamstatic.com/client/installer/steam.deb'
# Minecraft
# https://www.minecraft.net/en-us/download/alternative
deb_download_and_install 'https://launcher.mojang.com/download/Minecraft.deb'

################################################################################
