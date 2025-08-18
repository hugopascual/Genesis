#!/bin/bash

server_setup() {
    echo "Starting server setup"

    #------------------------------- Customization

    #------------------------------- Software installations
    # Minimum
    ubuntu_install_basics
    ubuntu_install_basics_network
    ubuntu_install_fastfetch

    # Development
    ubuntu_install_basics_development
    ubuntu_install_docker
    ubuntu_install_lazydocker
    ubuntu_install_python

    #------------------------------- Update and clean
    update

    #------------------------------- Finish
    echo_success "Restart the computer now"
}
