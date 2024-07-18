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

####################################
#--Especific Installing Functions--#
####################################
##
# @Description
# Install nodejs and npm
# 
##
install_nodejs() {
    echo_installing "NodeJS"
    echo_installed "NodeJS"
}

##
# @Description
# Uninstall nodejs and npm
# https://github.com/nodesource/distributions#installation-instructions
##
uninstall_nodejs() {
    echo_info "Uninstalling NodeJS"
    echo_success "NodeJS uninstalled"
}

##
# @Description
# Install Docker
# 
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
# Install ProtonVPN
# https://protonvpn.com/support/linux-ubuntu-vpn-setup/
# https://protonvpn.com/support/linux-vpn-tool/
##
install_proton_vpn() {
    echo_installing "ProtonVPN"
    echo_installed "ProtonVPN"
}
