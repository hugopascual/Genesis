#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$DIRECTORY/auxiliar.sh"

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
