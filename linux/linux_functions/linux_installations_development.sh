#!/bin/bash

########################
#--Execution software--#
########################

##
# @Description
# Install Python
##
linux_install_python() {
    NAME="Python"
	echo_installing "$NAME"
    install_python
    echo_installed "$NAME"
}

##
# @Description
# Install Docker
##
linux_install_docker() {
    NAME="Docker"
	echo_installing "$NAME"
    install_docker
    echo_installed "$NAME"
}

##
# @Description
# Uninstall Docker
##
linux_uninstall_docker() {
    NAME="Docker"
	echo_uninstalling "$NAME"
    uninstall_docker
    echo_uninstalled "$NAME"
}

##
# @Description
# Install NodeJS and npm
##
linux_install_nodejs() {
    NAME="NodeJS and npm"
	echo_installing "$NAME"
    install_nodejs
    echo_installed "$NAME"
}

##
# @Description
# Uninstall NodeJS and npm
##
linux_uninstall_nodejs() {
    NAME="NodeJS adn npm"
	echo_uninstalling "$NAME"
    uninstall_nodejs
    echo_uninstalled "$NAME"
}


##############################
#--Code editors/enviroments--#
##############################

##
# @Description
# Install VSCode
##
linux_install_vscode() {
    NAME="VSCode"
	echo_installing "$NAME"
    install_vscode
    echo_installed "$NAME"
}

##
# @Description
# Install JetBrains ToolBox
##
linux_install_jetbrains_toolbox() {
    NAME="JetBrains ToolBox"
	echo_installing "$NAME"
    install_jetbrains_toolbox
    echo_installed "$NAME"
}


###############################
#--Other development related--#
###############################

##
# @Description
# Install GitHub CLI
# Github client to make login via terminal
##
linux_install_github_cli() {
    NAME="GitHub CLI"
	echo_installing "$NAME"
    install_github_cli
    echo_installed "$NAME"
}
