#!/bin/bash

server_setup() {
    echo "server_setup"

    #------------------------------- Customization

    #------------------------------- Software installations
    # Basic
    ubuntu_install_net_basic
    ubuntu_install_common_funcionalities
    ubuntu_install_fastfetch
    ubuntu_install_nvtop

    # Development
    ubuntu_install_docker
    ubuntu_install_python

    #------------------------------- Update and clean
    update

    #------------------------------- Finish
    echo_success "Restart the computer now"
}
