#!/bin/bash

##
# @Description
# Install ProtonVPN
# https://protonvpn.com/support/linux-ubuntu-vpn-setup/
# https://protonvpn.com/support/linux-vpn-tool/
##
install_proton_vpn() {
    echo_installing "ProtonVPN"
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
    echo_installed "ProtonVPN"
}

##
# @Description
# Uninstall ProtonVPN
#  
##
uninstall_proton_vpn() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}