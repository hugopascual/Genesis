#!/bin/bash

###############
#--Something--#
###############

##
# @Description
# Install Obsidian
# https://obsidian.md/download
##
install_obsidian() {
    URL_DEB="https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.7/obsidian_1.6.7_amd64.deb"
    deb_download_and_install "$URL_DEB"
}

##
# @Description
# Install VLC
##
install_vlc() {
    apt_get_install "vlc"
}

##
# @Description
# Install GNU Image Manipulation Program
##
install_gimp() {
    apt_get_install "gimp"
}

##
# @Description
# Install Google Chrome
##
install_google_chrome() {
    flathub_install "com.google.Chrome"
}

##
# @Description
# Install Raspberry Pi OS Imager
##
install_rpi_imager() {
    apt_get_install "rpi-imager"
}