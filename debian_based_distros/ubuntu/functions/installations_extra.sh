#!/bin/bash

###############
#--Something--#
###############

# @Description
# Install Obsidian
# https://obsidian.md/download
##
install_obsidian() {
    NAME="Obsidian"
	echo_installing "$NAME"
    URL_DEB="https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.7/obsidian_1.6.7_amd64.deb"
    deb_download_and_install "Obsidian" "$URL_DEB"
    echo_installed "$NAME"
}

##
# @Description
# Uninstall Obsidian
# 
##  
uninstall_obsidian() {
    NAME="Obsidian"
    echo_uninstalling "$NAME"
    echo_uninstalled "$NAME"
}