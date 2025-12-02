#!/bin/bash

desktop_setup() {
    #------------------------------- Start with the setup
    echo "Starting Setup"

    #------------------------------- Software installations
    
    #------------------------------- Update and clean
    update

    #------------------------------- Finish
    echo_success "Restart the computer now"
}
