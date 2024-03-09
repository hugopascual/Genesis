#!/bin/bash

#------------------------------- Imports
DIRECTORY=$(dirname "$0")

AUXILIAR_FILEPATH="$DIRECTORY/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$AUXILIAR_FILEPATH"

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
    sudo apt-get install -y $2
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
# Install nodejs and npm
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04
##
install_nodejs() {
    echo_info "Installing nodejs via apt-get"
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    
    # NODE_MAJOR could be changed depending on the version you need
    NODE_MAJOR=20
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    
    sudo apt-get update
    sudo apt-get install nodejs -y
    echo_success "nodejs installed"
}

##
# @Description
# Uninstall nodejs and npm
# https://github.com/nodesource/distributions#installation-instructions
##
uninstall_nodejs() {
    apt-get purge nodejs &&\
    rm -r /etc/apt/sources.list.d/nodesource.list &&\
    rm -r /etc/apt/keyrings/nodesource.gpg
}


##
# @Description
# Install Docker
# 
##
install_docker() {
    echo_info "Installing Docker via apt-get"
    # Uninstall old versions
    sudo apt-get remove docker docker-engine docker.io containerd runc
    # Necessary installs to do
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    # Add Docker's official GPG key 
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    # Set up the repository
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    #Install Docker Engine
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    echo_success "Docker installed"
}   

##
# @Description
# Install jetbrains-toolbox
# https://www.jetbrains.com/help/idea/installation-guide.html#toolbox
# https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
##
install_jetbrains_toolbox() {
    tar_file="jetbrains-toolbox-1.27.3.14493.tar.gz"
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
# Install ProtonVPN
# https://protonvpn.com/support/linux-ubuntu-vpn-setup/
# https://protonvpn.com/support/linux-vpn-tool/
##
install_proton_vpn() {
    proton_package_name="protonvpn-stable-release_1.0.3_all.deb"
    # Descargar el .deb
    curl -OL https://repo.protonvpn.com/debian/dists/stable/main/binary-all/$proton_package_name
    # Install the package
    sudo apt-get install -y ./$proton_package_name
    sudo rm $proton_package_name
    sudo apt-get update
    # Install the grafic interface
    sudo apt-get -y install protonvpn
    # Install top pin
    sudo apt install -y gnome-shell-extension-appindicator gir1.2-appindicator3-0.1
    # Install command client
    sudo apt-get -y install protonvpn-cli
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
# Install Lutris.
# This software is used to install windows games on Linux
# https://www.addictivetips.com/ubuntu-linux-tips/hearthstone-linux/
##
install_lutris() {
    echo_info "Installing Lutris"
    sudo add-apt-repository ppa:lutris-team/lutris
    sudo apt-get update
    sudo apt-get -y install lutris
	echo_installed "Lutris installed"
}

##
# @Description
# Install OpenVPNC
# VPN to connect to the DIT net
# https://web.dit.upm.es/.cdc/index.php/Configuracion_manual_vpnc_en_ubuntu
##
install_openvpnc() {
    echo_info "Installing OpenVPNC"
    sudo apt-get update
    sudo apt-get -y install vpnc
    echo_installed "OpenVPNC installed"
}

###########
#--Other--#
###########
