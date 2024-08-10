#!/bin/bash

########################################
#--Open the ssh server to be accessed--#
########################################
ssh_server_activate() {
    echo_info "Activating SSH Server"
    sudo apt install -y ssh
    sudo systemctl enable ssh && sudo systemctl start ssh
    echo_info "SSH Server activated"
}
