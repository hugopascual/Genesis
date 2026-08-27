#!/bin/bash

gnome_install_packages() {
	setup_install_bundle "gnome"
}

gnome_enable_display_manager() {
	sudo systemctl enable gdm.service
}

gnome_apply_theme() {
	local gnome_theme="Adwaita-dark"

	if [[ "$DISTRO_SELECTED" == "$UBUNTU" ]]; then
		gnome_theme="Yaru-blue-dark"
	fi

	gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme"
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
}

gnome_apply_backgrounds() {
	gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND_DESTINATION_PATH"
	gsettings set org.gnome.desktop.background picture-uri-dark "file://$BACKGROUND_DESTINATION_PATH"
	gsettings set org.gnome.desktop.screensaver picture-uri "file://$SCREENSAVER_DESTINATION_PATH"
}

gnome_apply_desktop_preferences() {
	gsettings set org.gnome.mutter workspaces-only-on-primary true
	gsettings set org.gnome.shell.app-switcher current-workspace-only true

	gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
	gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

	gsettings set org.gnome.desktop.notifications show-in-lock-screen false
	gsettings set org.gnome.desktop.interface show-battery-percentage true
}

gnome_apply_optional_dock_preferences() {
	if gsettings writable org.gnome.shell.extensions.dash-to-dock click-action >/dev/null 2>&1; then
		gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize
		gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
		gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
		gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
		gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
	fi
}

gnome_apply_keyboard_shortcuts() {
	gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"

	local terminal_shortcut_id="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
	local terminal_command="terminator"
	local file_manager_id="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/"
	local file_manager_command="nautilus"

	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$terminal_shortcut_id', '$file_manager_id']"

	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ name "Terminal"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ command "$terminal_command"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ binding "<Ctrl><Alt>T"

	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ name "Files"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ command "$file_manager_command"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ binding "<Super>e"
}

gnome_apply_input_sources() {
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'es')]"
}

gnome_configure_startup_apps() {
	setup_copy_autostart_entry_if_exists "/usr/share/applications/obsidian.desktop"
	setup_copy_autostart_entry_if_exists "/usr/share/applications/org.mozilla.Thunderbird.desktop"
	setup_copy_autostart_entry_if_exists "/usr/share/applications/firefox.desktop"
}

###############################################################################

log_info "Starting GNOME setup"

# TODO: test in other distros 
if [[ "$DISTRO_SELECTED" == "$UBUNTU" || "$DISTRO_SELECTED" == "$DEBIAN" ]]; then
	setup_configure_locales
fi

desktop_folder_structure_creation
copy_config_statics "$TYPES_STATICS_PATH/$OPTION_SELECTED"

gnome_install_packages || return 1
gnome_enable_display_manager || return 1

gnome_apply_theme
gnome_apply_backgrounds
gnome_apply_desktop_preferences
gnome_apply_optional_dock_preferences
gnome_apply_keyboard_shortcuts
gnome_apply_input_sources
gnome_configure_startup_apps

setup_finalize_type
