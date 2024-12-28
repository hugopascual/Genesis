#!/bin/bash

echo_info "Activating SSH Server"
"$PARENT_DISTRO_SCRIPTS_DIR/enable_ssh_service.sh"
echo_info "SSH Server activated"
