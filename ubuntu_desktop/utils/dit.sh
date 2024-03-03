#!/bin/bash

#------------------------------- Imports
DIRECTORY=$(dirname "$0")

AUXILIAR_FILEPATH="$DIRECTORY/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$AUXILIAR_FILEPATH"

##################################
#--Software used to work in DIT--#
##################################
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