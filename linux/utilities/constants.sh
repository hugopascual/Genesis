#!/bin/bash

# Available command types
export COMMAND_TYPES=(
    "install" 
    "customize" 
    "update"
)

export INSTALL_COMMAND_TYPES=(
    "desktop" 
    "server"
)

export AVAILABLE_DISTROS=(
    "ubuntu" 
    "debian"
)

export CUSTOMIZATION_TYPES=(
    "gnome"
)

# Messages
export COMMAND_NOT_VALID_MESSAGE="Command selected not valid"
export INSTALLATION_TYPE_NOT_VALID_MESSAGE="Installation type selected not valid"
export DISTRIBUTION_NOT_VALID_MESSAGE="Distribution selected not valid"
export DESKTOP_ENVIRONMENT_TYPE_NOT_VALID_MESSAGE="Desktop environment type selected not valid"
