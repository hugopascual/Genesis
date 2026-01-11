#!/bin/bash

##
# @Description
# 
##
install_command() {
    check_option_supported "$OPTION_SELECTED" \
        "${INSTALL_COMMAND_TYPES[@]}" \
        "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"

    # Import the distro specific installation functions
    # shellcheck disable=SC1090
    source "$INSTALL_FUNCTIONS_PATH/$DISTRO_SELECTED.sh"

    case $OPTION_SELECTED in
        "$INSTALL_TYPE_PERSONAL")
            echo_info "Starting $INSTALL_TYPE_PERSONAL installation"
            personal_installation
            ;;
        "$INSTALL_TYPE_SERVER")
            echo_info "Starting $INSTALL_TYPE_SERVER installation"
            server_installation
            ;;
        *)
            echo "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"
            ;;
    esac
}

personal_installation() {
    echo_info "Starting $INSTALL_TYPE_PERSONAL installation"
    
    # Base
    base_install
    
    # Minimum
    sudo_install
    htop_install
    tree_install
    nfs_install
    rename_install
    rsync_install
    lshw_install
    wget_install
    curl_install
    vim_install
    nvim_install
    fastfetch_install
    nvtop_install
    
    # Development
    git_install
    github_cli_install
    jdk_install
    docker_install
    lazydocker_install
    python_install
    nodejs_install
    vscode_install
    jetbrains_toolbox_install
    postman_install
    raspberry_pi_imager_install
    
    # DIT Software
    openvpn3_install
    
    # Desktop
    kitty_install
    displaylink_driver_install
    firefox_install
    google_chrome_install
    thunderbird_install
    keepassxc_install
    autofirma_install
    config_fnmt_install
    obsidian_install
    vlc_install
    spotify_install
    telegram_install
    discord_install
    teamviewer_install
    gimp_install
    wireguard_install
    7zip_install
    
    # Hobbys
    steam_install
    minecraft_launcher_install
    
    echo_success "$INSTALL_TYPE_PERSONAL installation completed"
}

server_installation() {
    echo_info "Starting $INSTALL_TYPE_SERVER installation"
    
    # Base
    base_install
    
    # Minimum
    sudo_install
    htop_install
    tree_install
    nfs_install
    rename_install
    rsync_install
    lshw_install
    wget_install
    curl_install
    vim_install
    nvim_install
    fastfetch_install
    nvtop_install
    
    # Development
    git_install
    jre_install
    docker_install
    lazydocker_install
    python_install
    
    echo_success "$INSTALL_TYPE_SERVER installation completed"
}
