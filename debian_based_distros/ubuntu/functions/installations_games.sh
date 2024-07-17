#!/bin/bash

##################
#--Wine related--#
##################

##
# @Description
# Install Lutris
# This software is used to install windows games on Linux
# https://www.addictivetips.com/ubuntu-linux-tips/hearthstone-linux/
##
install_lutris() {
    echo_installing "Lutris"
    sudo add-apt-repository -y ppa:lutris-team/lutris
    sudo apt-get update
    sudo apt-get -y install lutris
	echo_installed "Lutris"
}

##
# @Description
# Uninstall Lutris
#  
##
uninstall_lutris() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}

###############
#--Platforms--#
###############

# @Description
# Install Steam
#  
##
install_steam() {
    NAME="Steam"
    URL="https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
    deb_download_and_install "$NAME" "$URL"
}

##
# @Description
# Uninstall
#  
##
uninstall_steam() {
    NAME="Steam"
    echo_uninstalling "$NAME"
    echo_uninstalled "$NAME"
}

