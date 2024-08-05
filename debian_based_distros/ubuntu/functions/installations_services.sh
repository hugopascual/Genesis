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
    NAME="WIP"
    echo_uninstalling "$NAME"
    echo_uninstalled "$NAME"
}

# @Description
# Install Spotify
# https://www.spotify.com/us/download/linux/
##
install_spotify() {
    NAME="Spotify"
	echo_installing "$NAME"
    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update 
    sudo apt-get install spotify-client
    echo_installed "$NAME"
}

##
# @Description
# Uninstall Spotify
# https://www.spotify.com/us/download/linux/
##
uninstall_spotify() {
    NAME="Spotify"
    echo_uninstalling "$NAME"
    sudp apt remove spotify-client
    sudo apt autoremove
    sudo apt autoclean
    echo_uninstalled "$NAME"
}

# @Description
# Install Discrord
# https://discord.com/
##
install_discord() {
    NAME="Discord"
	echo_installing "$NAME"
    URL_DEB="https://discord.com/api/download?platform=linux&format=deb"
    deb_download_and_install "$NAME" "$URL"
    echo_installed "$NAME"
}

##
# @Description
# Uninstall Discord
# 
##
uninstall_discord() {
    NAME="WIP"
    echo_uninstalling "$NAME"
    sudo apt remove debian
    sudo apt autoremove
    sudo apt autoclean
    echo_uninstalled "$NAME"
}