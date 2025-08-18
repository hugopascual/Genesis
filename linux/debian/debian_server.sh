#!/bin/bash

server_setup() {
    echo "Starting server setup"

    #------------------------------- Customization
    execute_server_customization
    
    #------------------------------- Software installations
    # Minimum
    debian_install_basics
    debian_install_basics_network
    debian_install_fastfetch

    # Development
    debian_install_basics_development
    debian_install_docker
    debian_install_lazydocker
    debian_install_python

    #------------------------------- Update and clean
    update

    #------------------------------- Finish
    echo_success "Restart the computer now"
}
