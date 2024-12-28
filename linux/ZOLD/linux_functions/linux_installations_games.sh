#!/bin/bash

##################
#--Wine related--#
##################

##
# @Description
# Install Lutris
##
linux_install_lutris() {
    NAME="Lutris"
	echo_installing "$NAME"
    install_lutris
    echo_installed "$NAME"
}

###############
#--Platforms--#
###############

##
# @Description
# Install Steam
##
linux_install_steam() {
    NAME="Steam"
	echo_installing "$NAME"
    install_steam
    echo_installed "$NAME"
}

###########
#--Games--#
###########

##
# @Description
# Install Minecraft
##
linux_install_minecraft() {
    NAME="Minecraft"
	echo_installing "$NAME"
    install_minecraft
    echo_installed "$NAME"
}
