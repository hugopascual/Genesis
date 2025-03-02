#!/bin/bash

desktop_setup() {
    #------------------------------- Start with the setup
    echo_info "Starting setup"
    
    #------------------------------- Customization
    execute_customization

    #------------------------------- Software installations
    # Basic
    ubuntu_install_net_basic
    ubuntu_install_common_funcionalities
    ubuntu_install_displaylink_driver
    ubuntu_install_flatpak
    ubuntu_install_terminator
    ubuntu_install_fastfetch
    ubuntu_install_nvtop
    ubuntu_install_firefox
    ubuntu_install_thunderbird
    ubuntu_install_keepassxc
    ubuntu_install_autofirma
    ubuntu_install_config_fnmt

    # Development
    ubuntu_install_docker
    ubuntu_install_vscode
    ubuntu_install_jetbrains_toolbox
    ubuntu_install_github_cli

    # DIT Installs and config
    ubuntu_install_openvpnc

    # Services
    ubuntu_install_spotify
    ubuntu_install_telegram
    ubuntu_install_discord

    # Games
    ubuntu_install_lutris
    ubuntu_install_steam
    ubuntu_install_minecraft

    # Extra
    ubuntu_install_obsidian
    ubuntu_install_vlc
    ubuntu_install_gimp
    ubuntu_install_rpi_imager

    #------------------------------- Update and clean
    update

    #------------------------------- Finish
    echo_success "Restart the computer now"
}
