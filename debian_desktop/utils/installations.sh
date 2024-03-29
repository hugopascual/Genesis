#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
UTILS_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$UTILS_DIR/auxiliar.sh"

##################################
#--Generic Installing Functions--#
##################################
##
# @Description
# Install a software package using apt-get
# @Params
# $1 Name of the software, just to print
# $2 Name of the apt package software wanted to be installed
##
apt_get_install() {
    echo_installing "$1 via apt-get"
    sudo apt-get install -y "$2"
    echo_installed "$1"
}

##
# @Description
# Install a software package from flathub via flatpak
# @Params
# $1 Name of the software, just to print
# $2 Name of the apt package software wanted to be installed
##
flathub_install() {
    echo_installing "$1 via flatpak"
    flatpak install -y flathub $2
    echo_installed "$1"
}

##
# @Description
# Install a software package via snap
# @Params
# $1 Name of the software, just to print
# $2 Name of the apt package software wanted to be installed
# $3 Option used in snap intallations
##
snap_install() {
    echo_installing "$1 via snap"
    sudo snap install $2 $3
    echo_installed "$1"
}

####################################
#--Especific Installing Functions--#
####################################
##
# @Description
# Install 
#  
##
install_template() {
	echo_info ""
}

##
# @Description
# Install flatpak package manager
# https://flatpak.org/setup/Ubuntu
##
install_flatpak() {
    echo_info "Installing Flatpak (only command line)"
    sudo apt install -y flatpak
    sudo apt install gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo_success "Flatpak installed"
}

##
# @Description
# Install Visual Studio Code
# https://code.visualstudio.com/docs/setup/linux
##
install_VScode() {
    echo_info "Installing Visual Studio Code"
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    sudo apt install apt-transport-https
    sudo apt update -y
    sudo apt install -y code
    echo_success "Visual Studio Code installed"
}

##
# @Description
# Install Docker
# https://docs.docker.com/engine/install/debian/
##
install_docker() {
    echo_installing "Docker"
    # Remove previous docker installs
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd

    # Install using the apt repo
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    # Add the repository to Apt sources:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Verify with
    # sudo docker run hello-world
    echo_installed "Docker"
}

##
# @Description
# Install jetbrains-toolbox
# https://www.jetbrains.com/help/idea/installation-guide.html#toolbox
# https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
##
install_jetbrains_toolbox() {
    tar_file="jetbrains-toolbox-2.2.3.20090.tar.gz"
    # Descargar el tar.gz
    curl -OL https://download.jetbrains.com/toolbox/$tar_file
    # Descomprimir el tar.gz
    sudo tar -xzf "$tar_file"
    # Mover el directorio descomprimido a /opt
    descompressed_dir="${tar_file: : -7}"
    sudo mv "$descompressed_dir" /opt/
    # Ejecutar el binario de dentro
    /opt/"$descompressed_dir"/jetbrains-toolbox
    # Borrar los restos
    sudo rm -rf /opt/"$descompressed_dir"
    sudo rm -f "$tar_file"
}

##
# @Description
# Install Autofirma from FNMT
# https://firmaelectronica.gob.es/Home/Descargas.html
##
install_auto_firma_fnmt() {
	echo_info "Installing AutoFirma"
	curl -OL https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma_Linux_Debian.zip
	unzip AutoFirma_Linux_Debian.zip
	sudo apt install ./"$(ls | grep .deb)"
	echo_installed "AutoFirma installed"
}

##
# @Description
# Install Lutris
# This software is used to install windows games on Linux
# https://www.addictivetips.com/ubuntu-linux-tips/hearthstone-linux/
##
install_lutris() {
    echo_info "Installing Lutris"
    echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
    wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null
    sudo apt update
    sudo apt install lutris
	echo_installed "Lutris installed"
}

##
# @Description
# Install GitHub CLI
# Github client to make login via terminal
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
##
install_github_cli() {
    echo_info "Installing GitHub CLI"
    sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
    echo_installed "GitHub CLI installed"
}