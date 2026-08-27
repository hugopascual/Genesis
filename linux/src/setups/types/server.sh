#!/bin/bash

server_folder_structure_creation
copy_config_statics "$TYPES_STATICS_PATH/$OPTION_SELECTED"
setup_install_bundle "server" || return 1

setup_finalize_type
