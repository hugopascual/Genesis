#!/bin/bash

##################################
#--Software used to work in DIT--#
##################################

##
# @Description
# Install OpenVPNC
##
linux_install_openvpnc() {
    NAME="OpenVPNC"
	echo_installing "$NAME"
    install_openvpnc
    echo_installed "$NAME"
}