#!/bin/bash

################################################################################
# Configure system locales

################################################################################
# Create basics folders structure 
base_folder_structure_creation

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
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark'

# Background and screensaver
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/.config/theme/background.jpg"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/.config/theme/background.jpg"
gsettings set org.gnome.desktop.screensaver picture-uri "file://$HOME/.config/theme/screensaver.jpg"

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
## Crtl+Alt+T for terminal
terminal="kitty"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ name "Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ command "$terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ binding "<Ctrl><Alt>T"
## SUPER+E for file manager
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ name "Files"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ command "nautilus"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ binding "<Super>e"

#-------------------------------------------------------------------------------

################################################################
# Add second keyboard distribution

# Define the 2 keyboard distributions
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'es')]"

################################################################
# Startup applications

mkdir -p "$HOME/autostart"
# Obsidian
cp /usr/share/applications/obsidian.desktop "$HOME/autostart/"
cp /usr/share/applications/org.mozilla.Thunderbird.desktop "$HOME/autostart/"
cp /usr/share/applications/firefox.desktop "$HOME/autostart/"


################################################################################
# Other setup configurations

## Add aliases to .bashrc
aliases_setup

# .bashrc configuration and customization
sed -iE 's/\\w/\\W/' "$HOME/.bashrc"

################################################################################
# Graphics drivers
