#!/bin/bash

server_setup() {
    echo "Starting server setup"

    #------------------------------- Customization

    #------------------------------- Software installations

    #------------------------------- Update and clean
    update

    #------------------------------- Finish
    echo_success "Restart the computer now"
}
