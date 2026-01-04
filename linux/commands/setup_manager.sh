#!/bin/bash

### Customize command
setup_manager() {
    desktop_environment="$1"
    check_desktop_environment "$desktop_environment"

    customization_script_path="$BASE_PATH/desktop_environments/$desktop_environment.sh"
    # shellcheck disable=SC1090
    source "$customization_script_path"
    customize_desktop_environment
}
