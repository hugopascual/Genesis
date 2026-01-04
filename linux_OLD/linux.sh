#!/bin/bash

################################################################################
# Get the path to the main directory.
full_path_to_script="$(realpath "${BASH_SOURCE[0]}")"
BASE_PATH="$(dirname "$full_path_to_script")"
export BASE_PATH

# Paths constants
export UTILITIES_PATH="$BASE_PATH/utilities"

export STATICS_PATH="$BASE_PATH/statics"

export COMMANDS_PATH="$BASE_PATH/commands"
export COMMAND_INSTALL_PATH="$COMMANDS_PATH/install"
export COMMAND_UPDATE_PATH="$COMMANDS_PATH/update"
export COMMAND_SETUP_PATH="$COMMANDS_PATH/setup"
################################################################################
##
# @Description
# Import all the scripts from the objective folder
# @Parameters
# $1 Directory to import scripts from
##
import_from_dir() {
    directory="$1"
    # shellcheck disable=SC1090
    for file in $( find "$directory" -type f -name "*.sh" -print | sort ); 
    do
        source "$file"
    done
}
################################################################################
### Import utilities
import_from_dir "$UTILITIES_PATH"

### Check commands input
# Validate if command among available ones
if [[ ! " ${COMMAND_TYPES[*]} " =~ [[:space:]]$1[[:space:]] ]]; then
    echo "$COMMAND_NOT_VALID_MESSAGE"
    help
fi

# Execute rutine depending on command
import_from_dir "$COMMANDS_PATH"
case $1 in
    "$INSTALL_COMMAND")
        install_manager "$2" "$3"
        ;;
    "$UPDATE_COMMAND")
        update_manager "$2"
        ;;
    "$SETUP_COMMAND")
        setup_manager "$2"
        ;;
    *)
        echo "$COMMAND_NOT_VALID_MESSAGE"
        help
        ;;
esac
