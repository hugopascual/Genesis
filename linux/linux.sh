#!/bin/bash

################################################################################
# Get the path to the main directory.
full_path_to_script="$(realpath "${BASH_SOURCE[0]}")"
BASE_PATH="$(dirname "$full_path_to_script")"
export BASE_PATH

# Paths constants
export COMMANDS_PATH="$BASE_PATH/commands"
export COMMAND_INSTALL_FUNCTIONS_PATH="$COMMANDS_PATH/install"
export COMMAND_UPDATE_FUNCTIONS_PATH="$COMMANDS_PATH/update"
export COMMAND_SETUP_FUNCTIONS_PATH="$COMMANDS_PATH/setup"

export UTILITIES_PATH="$BASE_PATH/utilities"

export STATICS_PATH="$BASE_PATH/statics"
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
### Imports needed
import_from_dir "$UTILITIES_PATH"
import_from_dir "$COMMANDS_PATH"
1
export DISTRO_SELECTED="$2"
check_option_supported "$DISTRO_SELECTED" "$AVAILABLE_DISTROS" "$DISTRIBUTION_NOT_VALID_MESSAGE"

# Execute rutine depending on command
case $1 in
    "$INSTALL_COMMAND")
        import_from_dir "$COMMAND_INSTALL_FUNCTIONS_PATH"
        install_command "$DISTRO_SELECTED" "$3"
        ;;
    "$UPDATE_COMMAND")
        update_command "$DISTRO_SELECTED"
        ;;
    "$SETUP_COMMAND")
        setup_command "$DISTRO_SELECTED" "$3"
        ;;
    *)
        echo "$COMMAND_NOT_VALID_MESSAGE"
        help
        ;;
esac
