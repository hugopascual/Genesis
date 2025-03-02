#!/bin/bash

##
# @Description
# 
##
execute_customization() {
    config_locale
    config_bash
    desktop_customization
    development_config
    add_alias
}

##
# @Description
# 
##
config_locale() {
    sudo locale-gen es_ES.UTF-8
    localectl set-locale LANG=en_US.UTF-8
    localectl set-locale LANGUAGE=en_US.UTF-8
    localectl set-locale LC_CTYPE=es_ES.UTF-8
    localectl set-locale LC_NUMERIC=es_ES.UTF-8
    localectl set-locale LC_TIME=es_ES.UTF-8
    localectl set-locale LC_COLLATE=es_ES.UTF-8
    localectl set-locale LC_MONETARY=es_ES.UTF-8
    localectl set-locale LC_MESSAGES=es_ES.UTF-8
    localectl set-locale LC_PAPER=es_ES.UTF-8
    localectl set-locale LC_NAME=es_ES.UTF-8
    localectl set-locale LC_ADDRESS=es_ES.UTF-8
    localectl set-locale LC_TELEPHONE=es_ES.UTF-8
    localectl set-locale LC_MEASUREMENT=es_ES.UTF-8
    localectl set-locale LC_IDENTIFICATION=es_ES.UTF-8
}

##
# @Description
# 
##
config_bash(){
    # Modify file .bashrc changing \w with \W
    sed -iE 's/\\w/\\W/' ~/.bashrc
}

##
# @Description
# 
##
desktop_customization() {
    #------------------------------- Initialization
    echo_info "Starting configuration"

    #------------------------------- Appearance
    # Style
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark'

    # Desktop icons
    gsettings set org.gnome.shell.extensions.ding show-home false

    # Dock
    gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize
    gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
    gsettings set org.gnome.shell.extensions.dash-to-dock autohide true

    #------------------------------- Multitasking 
    gsettings set org.gnome.mutter workspaces-only-on-primary false
    gsettings set org.gnome.shell.app-switcher current-workspace-only true


    #------------------------------- Mouse and Touchpad
    gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

    #------------------------------- Notifications
    gsettings set org.gnome.desktop.notifications show-in-lock-screen false

    #------------------------------- END
    echo_success "Configuration Finished"
}

##
# @Description
#
##
development_config() {
    mkdir "$HOME/repositories"
    script_folder="$(dirname "$0")"
    cp "$script_folder/../statics/scripts/clone.sh" "$HOME/repositories"
}

##
# @Description
#
##
add_alias() {
    echo "
    # Custom alias
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grep='grep --color=auto'
    alias l='ls -CF'
    alias la='ls -A'
    alias ll='ls -alF'
    alias ls='ls --color=auto'

    alias mountdrive='sudo mount -t nfs archaedas.home:/mnt/main/drive /mnt/drive'
    alias umountdrive='sudo umount -f /mnt/drive'
    alias homevpnin='sudo wg-quick up vpn_mad-ly129'
    alias homevpnout='sudo wg-quick down vpn_mad-ly129'

    alias inhome='homevpnin && mountdrive'
    alias outhome='umountdrive && homevpnout'

    alias ditvpnconnect='sudo vpnc-connect --enable-weak-encryption --enable-weak-authentication vpn_dit'
    alias ditvpndisconnect='sudo vpnc-disconnect'
    " >> "$HOME/.bashrc"
}

##
# @Description
#
##
dit_vpn_config() {
    echo "
IPSec gateway
IPSec ID
IPSec secret
Xauth username
Xauth password " | sudo tee -a /etc/vpnc/vpn_dit.conf
}
