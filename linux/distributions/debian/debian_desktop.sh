#!/bin/bash

desktop_setup() {
    #------------------------------- Start with the setup
    echo "Starting Setup"

    #------------------------------- Customization
    execute_customization

    #------------------------------- Software installations
    
    #------------------------------- Update and clean
    update

    #------------------------------- Finish
    echo_success "Restart the computer now"
}
