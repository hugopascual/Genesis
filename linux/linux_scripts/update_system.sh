#!/bin/bash

# shellcheck disable=SC1091
source "$PARENT_DISTRO_SCRIPTS_DIR/package_manager_update.sh"

echo_info "Flatpak updates started"
sudo flatpak update -y
echo_info "Flatpak updates finished"

echo_info "Snap updates started"
sudo snap refresh
echo_info "Snap updates finished"
