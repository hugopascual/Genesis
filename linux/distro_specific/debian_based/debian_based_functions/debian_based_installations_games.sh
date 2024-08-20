#!/bin/bash

##################
#--Wine related--#
##################

##
# @Description
# Install Lutris
##
install_lutris() {
    apt_get_install "lutris"
}

###############
#--Platforms--#
###############

##
# @Description
# Install Steam
##
install_steam() {
    URL="https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
    deb_download_and_install "$URL"
}

###########
#--Games--#
###########

##
# @Description
# Install Minecraft
# https://www.minecraft.net/en-us/download/alternative
##
install_minecraft() {
    URL="https://launcher.mojang.com/download/Minecraft.deb"
    deb_download_and_install "$URL"
}