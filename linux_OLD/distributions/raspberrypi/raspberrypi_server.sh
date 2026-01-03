#!/bin/bash

server_setup() {
    echo "Starting server setup"

    #------------------------------- Customization

    #------------------------------- Software installations
    # Minimum
    raspberrypi_install_basics
    raspberrypi_install_basics_network
    raspberrypi_install_fastfetch

    # Development
    raspberrypi_install_basics_development
    raspberrypi_install_docker
    raspberrypi_install_lazydocker
    raspberrypi_install_python

    #------------------------------- Update and clean
    update

    #------------------------------- Finish
    echo_success "Restart the computer now"
}
