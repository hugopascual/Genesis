#!/bin/bash

# Available command types
export INSTALL_COMMAND='install'
export UPDATE_COMMAND='update'
export SETUP_COMMAND='setup'

export COMMAND_TYPES=(
    "$INSTALL_COMMAND" 
    "$UPDATE_COMMAND" 
    "$SETUP_COMMAND"
)

# Available installation types
export INSTALL_TYPE_PERSONAL='personal'
export INSTALL_TYPE_SERVER='server'

export INSTALL_COMMAND_TYPES=(
    "$INSTALL_TYPE_PERSONAL" 
    "$INSTALL_TYPE_SERVER"
)

# Available distros
export UBUNTU='ubuntu'
export DEBIAN='debian'
export ARCH='arch'

export AVAILABLE_DISTROS=(
    "$UBUNTU" 
    "$DEBIAN"
    "$ARCH"
)

# Available setup types
export GNOME='gnome'
export HYPRLAND='hyprland'

export SETUP_TYPES=(
    "$GNOME"
    "$HYPRLAND"
)

# Messages
export COMMAND_NOT_VALID_MESSAGE="Command selected not valid"
export INSTALLATION_TYPE_NOT_VALID_MESSAGE="Installation type selected not valid"
export DISTRIBUTION_NOT_VALID_MESSAGE="Distribution selected not valid"
export SETUT_NOT_VALID_MESSAGE="Setup selected not valid"
