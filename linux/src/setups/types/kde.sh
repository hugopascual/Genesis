#!/bin/bash

kde_apply_look_and_feel() {
	lookandfeeltool -a org.kde.breezedark.desktop
	plasma-apply-wallpaperimage "$BACKGROUND_DESTINATION_PATH"
}

kde_install_dynamic_workspaces() {
	local temp_dir
	temp_dir="$(mktemp -d)" || return 1

	git clone https://github.com/maurges/dynamic_workspaces.git "$temp_dir/dynamic_workspaces"
	pushd "$temp_dir/dynamic_workspaces" >/dev/null || return 1
	kpackagetool6 --type KWin/Script --install .
	popd >/dev/null || return 1

	kwriteconfig6 --file kwinrc --group Plugins --key dynamic_workspacesEnabled true
	qdbus6 org.kde.KWin /KWin reconfigure

	rm -rf "$temp_dir"
}

kde_apply_desktop_preferences() {
	# Disable natural scrolling
	kwriteconfig6 --file kcminputrc --group Touchpad --key NaturalScroll false
	# Taskbar on top
	qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'panels()[0].location = "top"'
	# No restore of apps from previouse session
	kwriteconfig6 --file ksmserverrc --group General --key loginMode emptySession
	# Switch desktops independently for each screen
	kwriteconfig6 --file ~/.config/kwinrc --group Windows --key PerOutputVirtualDesktops true
	# Plugins - Virtual Desktops Only on Primary
	kwriteconfig6 --file ~/.config/kwinrc --group Plugins --key virtualdesktopsonlyonprimaryEnabled true
}

kde_apply_shortcuts() {
	kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Left" "Ctrl+Alt+Left,none,Switch One Desktop to the Left"
	kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Right" "Ctrl+Alt+Right,none,Switch One Desktop to the Right"
	kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Overview" "Meta,none,Toggle Overview"
	kwriteconfig6 --file kglobalshortcutsrc --group plasmashell --key "activate application launcher" "Ctrl+Space,none,Activate Application Launcher"
	kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window Maximize" "Meta+F,none,Maximise Window"
}

kde_apply_input_sources() {
	kwriteconfig6 --file kxkbrc --group Layout --key Use true
	kwriteconfig6 --file kxkbrc --group Layout --key LayoutList "us,es"
	kwriteconfig6 --file kxkbrc --group Layout --key Options "grp:win_space_toggle"
}

kde_configure_startup_apps() {
	setup_copy_autostart_entry_if_exists "/usr/share/applications/obsidian.desktop"
	setup_copy_autostart_entry_if_exists "/usr/share/applications/org.mozilla.Thunderbird.desktop"
	setup_copy_autostart_entry_if_exists "/usr/share/applications/firefox.desktop"
}

###############################################################################

desktop_folder_structure_creation
copy_config_statics "$TYPES_STATICS_PATH/$OPTION_SELECTED"
setup_install_bundle "kde" || return 1

kde_apply_look_and_feel
kde_install_dynamic_workspaces || return 1
kde_apply_desktop_preferences
kde_apply_shortcuts
kde_apply_input_sources
kde_configure_startup_apps

setup_finalize_type
