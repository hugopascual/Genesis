#!/bin/bash

##
# @Description
# Main installation command handler
# 
# Environment Variables:
#   DISTRO_SELECTED: Distribution name (ubuntu/debian/arch)
#   OPTION_SELECTED: Installation option or custom software list
##
install_command() {
    local config_file=""
    
    if [[ -f "$OPTION_SELECTED" ]]; then
        config_file="$OPTION_SELECTED"
    else
        check_option_supported "$OPTION_SELECTED" \
            "$INSTALLATION_TYPE_NOT_VALID_MESSAGE" \
            "${INSTALL_COMMAND_TYPES[@]}"
        
        case $OPTION_SELECTED in
            "$INSTALL_TYPE_DESKTOP")
                config_file="$DEFAULT_DEKSTOP_INSTALL_PATH"
                ;;
            "$INSTALL_TYPE_SERVER")
                config_file="$DEFAULT_SERVER_INSTALL_PATH"
                ;;
            *)
                echo "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"
                exit 1
                ;;
        esac
    fi
    
    # Execute installation with determined config file
    run_installation "$config_file"
}

##
# @Description
# Run installation from a configuration file
# @Params
# $1 Path to config file
##
run_installation() {
    local config_file="$1"
    
    echo_info "Using configuration file: $config_file"
    
    base_install

    if ! command -v jq &> /dev/null; then
        echo_info "Installing jq (required for JSON-based installation)"
        case $DISTRO_SELECTED in
            "$ARCH")
                sudo pacman -Syu --noconfirm jq
                ;;
            "$UBUNTU"|"$DEBIAN")
                sudo apt install -y jq
                ;;
        esac
    fi
    
    install_from_config_file "$config_file" "$DISTRO_SELECTED"
    
    echo_success "Installation completed"
}

##
# @Description
# Install base packages required for the distribution
# These are distribution-specific packages needed before other installations
##
base_install() {
    echo_info "Installing base packages for $DISTRO_SELECTED"
    
    case $DISTRO_SELECTED in
        "$ARCH")
            install_software "yay" "$DISTRO_SELECTED"
            ;;
        "$UBUNTU"|"$DEBIAN")
            install_software "flatpak" "$DISTRO_SELECTED"
            ;;
    esac
    
    echo_success "Base packages installation completed"
}

##
# @Description
# Install multiple software packages from a config file (e.g., configs/default_server.txt)
# Each line in the config file should be a software name
# @Params
# $1 Config file path (e.g., "configs/default_server.txt" or absolute path)
# $2 Distribution name (e.g., "ubuntu", "arch", "debian")
##
install_from_config_file() {
    local config_file="$1"
    local distro="$2"
    
    if [[ ! -f "$config_file" ]]; then
        echo_info "Error: Config file not found: $config_file"
        return 1
    fi
    
    echo_info "Installing packages from: $config_file"
    echo_info "Distribution: $distro"
    
    local failed_packages=()
    local installed_count=0
    local total_count=0
    
    # Read config file line by line
    while IFS= read -r software || [[ -n "$software" ]]; do
        # Skip empty lines and comments
        [[ -z "$software" || "$software" =~ ^[[:space:]]*# ]] && continue
        
        # Trim whitespace
        software=$(echo "$software" | xargs)
        
        ((total_count++))
        
        if install_software "$software" "$distro"; then
            ((installed_count++))
        else
            failed_packages+=("$software")
        fi
    done < "$config_file"
    
    echo_success "Installation summary:"
    echo_success "  Total packages: $total_count"
    echo_success "  Successfully installed: $installed_count"
    
    if [[ ${#failed_packages[@]} -gt 0 ]]; then
        echo_info "  Failed packages (${#failed_packages[@]}):"
        for pkg in "${failed_packages[@]}"; do
            echo_info "    - $pkg"
        done
        return 1
    fi
    
    return 0
}

##
# @Description
# Install a single software package using JSON configuration
# Uses modular packages/ directory structure (packages/software.json)
# @Params
# $1 Software name (e.g., "htop", "docker")
# $2 Distribution name (e.g., "ubuntu", "arch", "debian")
##
install_software() {
    local software="$1"
    local distro="$2"
    
    echo_installing "$software"
    
    # Check if jq is available
    if ! command -v jq &> /dev/null; then
        echo_info "Error: jq is not installed. Please install jq to use JSON-based installation."
        exit 1
    fi
    
    # Build package file path
    local package_file="$PACKAGES_PATH/$software.json"
    if [[ ! -f "$package_file" ]]; then
        echo_info "Warning: Package definition not found for '$software' in $package_file"
        return 1
    fi
    
    # Read commands for the specific distribution
    local commands
    commands=$(jq -r ".\"$distro\" // []" "$package_file")
    
    # Check if commands were found
    if [[ -z "$commands" || "$commands" == "null" || "$commands" == "[]" ]]; then
        echo_info "Warning: No installation commands found for '$software' on '$distro'"
        return 0
    fi
    
    # Parse and execute commands
    local cmd_count
    cmd_count=$(echo "$commands" | jq -r 'length')
    
    if [[ "$cmd_count" -eq 0 ]]; then
        echo_info "Info: No commands to execute for '$software' (empty array)"
        return 0
    fi
    
    # Execute each command
    local index=0
    while [[ $index -lt $cmd_count ]]; do
        local cmd
        cmd=$(echo "$commands" | jq -r ".[$index]")
        
        if [[ -n "$cmd" && "$cmd" != "null" ]]; then
            echo_info "  Executing: $cmd"
            if ! eval "$cmd"; then
                echo_info "Error: Failed to execute command for '$software': $cmd"
                return 1
            fi
        fi
        
        ((index++))
    done
    
    echo_installed "$software"
    return 0
}
