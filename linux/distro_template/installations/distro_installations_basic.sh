#!/bin/bash

###############
#--Templates--#
###############

##
# @Description
# Install ZZZ
##
linux_install_zzz() {
    NAME="ZZZ"
	echo_installing "$NAME"
    install_zzz
    echo_installed "$NAME"
}

##
# @Description
# Install ZZZ
##
install_zzz() {
    echo
}

##
# @Description
# Uninstall ZZZ
##
linux_uninstall_zzz() {
    NAME="ZZZ"
	echo_uninstalling "$NAME"
    uninstall_zzz
    echo_uninstalled "$NAME"
}

##
# @Description
# Uninstall ZZZ
##
uninstall_zzz() {
    echo
}
