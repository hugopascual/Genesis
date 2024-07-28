#!/bin/bash

##################
#--Wine related--#
##################

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

###########
#--Games--#
###########

# @Description
# Install Minecraft
# https://www.minecraft.net/en-us/download/alternative
##
install_minecraft() {
    NAME="Minecraft"
    URL="https://launcher.mojang.com/download/Minecraft.deb"
    deb_download_and_install "$NAME" "$URL"
}

##
# @Description
# Uninstall Minecraft
#  
##
uninstall_template() {
    NAME="Minecraft"
    echo_uninstalling "$NAME"
    echo_uninstalled "$NAME"
}