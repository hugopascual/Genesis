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
