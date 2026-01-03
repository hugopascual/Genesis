#!/bin/bash

desktop_setup() {
    #------------------------------- Start with the setup
    echo_info "Starting setup"

    #------------------------------- Software installations
    # Minimum
    ubuntu_install_basics
    ubuntu_install_basics_network
    ubuntu_install_fastfetch

    # Development
    ubuntu_install_docker
    ubuntu_install_lazydocker
    ubuntu_install_python
    ubuntu_install_vscode
    ubuntu_install_jetbrains_toolbox
    ubuntu_install_github_cli
    ubuntu_install_postman
    ubuntu_install_rpi_imager

    # DIT Software
    ubuntu_install_openvpn

    # Desktop
    ubuntu_install_displaylink_driver
    ubuntu_install_nvtop
    ubuntu_install_flatpak
    ubuntu_install_terminator
    ubuntu_install_firefox
    ubuntu_install_thunderbird
    ubuntu_install_keepassxc
    ubuntu_install_autofirma
    ubuntu_install_config_fnmt
    ubuntu_install_obsidian
    ubuntu_install_vlc
    ubuntu_install_spotify
    ubuntu_install_telegram
    ubuntu_install_discord
    ubuntu_install_teamviewer
    ubuntu_install_gimp
    ubuntu_install_wireguard

    # Hobbys
    ubuntu_install_lutris
    ubuntu_install_steam
    ubuntu_install_minecraft
    ubuntu_install_chitubox_software
    ubuntu_install_lychee_slicer

    #------------------------------- Update and clean
    update

    #------------------------------- Finish
    echo_success "Restart the computer now"
}
