#!/bin/bash

# Install command
install_manager() {
    installation_type="$1"
    distribution_selected="$2"
    check_distribution "$distribution_selected"
    
    case $installation_type in
        "$INSTALL_TYPE_PERSONAL")
            # shellcheck disable=SC1090
            source "$COMMAND_INSTALL_PATH/${distribution_selected}_${INSTALL_TYPE_PERSONAL}.sh"
            ;;
        "$INSTALL_TYPE_SERVER")
            # shellcheck disable=SC1090
            source "$COMMAND_INSTALL_PATH/${distribution_selected}_${INSTALL_TYPE_SERVER}.sh"
            ;;
        *)
            echo "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"
            help
            ;;
    esac    
}
