#!/bin/bash

################################################################################
# Configure system locales

################################################################################
# Create basics folders structure 
desktop_folder_structure_creation

################################################################################
# Configure environment
selected_statics_path="$STATICS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED"
copy_config_statics

# Install GNOME and configure it
# GNOME
log_info "Starting GNOME setup"
#------------------------------- Installation
log_info 'Checking if GNOME is installed...'
if is_command_installed 'gnome'; then
    log_info "GNOME is installed"
else
    log_info "GNOME not installed"
    pacman_install 'gnome'
fi

# Activate GNOME desktop on start
sudo systemctl enable gdm.service
# GNOME network manager integration with openvpn
pacman_install 'networkmanager-openvpn'

#------------------------------- Appearance and general settings
# Style
pacman_install 'gtk3'
pacman_install 'gtk4'
pacman_install 'adwaita-icon-theme'
pacman_install 'gnome-themes-extra'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Background and screensaver
gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND_DESTINATION_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$BACKGROUND_DESTINATION_PATH"
gsettings set org.gnome.desktop.screensaver picture-uri "file://$SCREENSAVER_DESTINATION_PATH"

# Multitasking 
gsettings set org.gnome.mutter workspaces-only-on-primary true
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Mouse and Touchpad
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

# Notifications
gsettings set org.gnome.desktop.notifications show-in-lock-screen false

# Add the baterry percentage show
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Keyboard shortcuts
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
## Custom shortcuts
### Crtl+Alt+T for terminal
terminal_shortcut_id="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
terminal_command="terminator"
### SUPER+E for file manager
file_manager_id="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/"
file_manager_command="nautilus"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['$terminal_shortcut_id', '$file_manager_id']"
### Set terminal shortcut
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ name "Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ command "$terminal_command"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ binding "<Ctrl><Alt>T"
### Set file manager shortcut
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ name "Files"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ command "$file_manager_command"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ binding "<Super>e"

#-------------------------------------------------------------------------------

################################################################
# Add second keyboard distribution

# Define the 2 keyboard distributions
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'es')]"

################################################################
# Startup applications
autostart_folder="$HOME/.config/autostart"
mkdir -p "$autostart_folder"
# Obsidian
cp /usr/share/applications/obsidian.desktop "$autostart_folder"
cp /usr/share/applications/org.mozilla.Thunderbird.desktop "$autostart_folder"
cp /usr/share/applications/firefox.desktop "$autostart_folder"

################################################################################
# Other setup configurations

## Add aliases to .bashrc
aliases_setup

# .bashrc configuration and customization
sed -iE 's/\\w/\\W/' "$HOME/.bashrc"

################################################################################
# Graphics drivers
