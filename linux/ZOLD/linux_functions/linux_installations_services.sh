#!/bin/bash

#########################
#--Commercial Services--#
#########################

##
# @Description
# Install Spotify
##
linux_install_spotify() {
    NAME="Spotify"
	echo_installing "$NAME"
    install_spotify
    echo_installed "$NAME"
}

##
# @Description
# Install Telegram
##
linux_install_telegram() {
    NAME="Telegram"
	echo_installing "$NAME"
    install_telegram
    echo_installed "$NAME"
}

##
# @Description
# Install Discord
##
linux_install_discord() {
    NAME="Discord"
	echo_installing "$NAME"
    install_discord
    echo_installed "$NAME"
}
