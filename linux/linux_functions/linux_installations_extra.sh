#!/bin/bash

###############
#--Something--#
###############

##
# @Description
# Install Obsidian
##
linux_install_obsidian() {
    NAME="Obsidian"
	echo_installing "$NAME"
    install_obsidian
    echo_installed "$NAME"
}

##
# @Description
# Install VLC
##
linux_install_vlc() {
    NAME="VLC"
	echo_installing "$NAME"
    install_vlc
    echo_installed "$NAME"
}

##
# @Description
# Install GNU Image Manipulation Program
##
linux_install_gimp() {
    NAME="GNU Image Manipulation Program"
	echo_installing "$NAME"
    install_gimp
    echo_installed "$NAME"
}

##
# @Description
# Install Google Chrome
##
linux_install_google_chrome() {
    NAME="Google Chrome"
	echo_installing "$NAME"
    install_google_chrome
    echo_installed "$NAME"
}

##
# @Description
# Install Raspberry Pi OS Imager
##
linux_install_rpi_imager() {
    NAME="Raspberry Pi OS Imager"
	echo_installing "$NAME"
    install_rpi_imager
    echo_installed "$NAME"
}

