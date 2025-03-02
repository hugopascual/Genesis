#!/bin/bashlink_driver
    ubuntu_install_flatpak
    ubuntu_install_terminator
    ubuntu_install_fastfetch
    ubuntu_install_nvtop
    ubuntu_install_firefox
    ubuntu_install_thunderbird
    ubuntu_install_keepassxc
    ubuntu_install_autofirma
    ubuntu_install_config_fnmt
    ubuntu_install_obsidian
    ubuntu_install_vlc

    # Development
    ubuntu_install_docker

export INSTALL_COMMAND_TYPES=(
    "desktop" 
    "server"
)

export AVAILABLE_DISTROS=(
    "ubuntu" 
    "debian"
)