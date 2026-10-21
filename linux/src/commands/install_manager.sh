#!/bin/bash

# install_software return codes
export INSTALL_STATUS_OK=0
export INSTALL_STATUS_FAILED=1
export INSTALL_STATUS_NOT_AVAILABLE=2
export INSTALL_STATUS_MANUAL=3

##
# @Description
# Main installation command handler
#
# Environment Variables:
#   DISTRO_SELECTED: Distribution name (ubuntu/debian/arch)
#   OPTION_SELECTED: Profile name (profiles/linux/<name>.txt) or custom package list path
##
install_command() {
    local config_file=""

    if [[ -f "$OPTION_SELECTED" ]]; then
        config_file="$OPTION_SELECTED"
    else
        check_option_supported "$OPTION_SELECTED" \
            "$INSTALLATION_TYPE_NOT_VALID_MESSAGE" \
            "${INSTALL_COMMAND_TYPES[@]}"
        config_file="$PROFILES_PATH/$OPTION_SELECTED.txt"
    fi

    # Execute installation with determined config file
    run_installation "$config_file"
}


#####################################
#--Auxiliar Installation Functions--#
#####################################

##
# @Description
# Run installation from a configuration file
# @Params
# $1 Path to config file
##
run_installation() {
    local config_file="$1"

    log_info "Using configuration file: $config_file"

    ensure_jq_installed || return 1
    if ! install_from_config_file "$config_file" "$DISTRO_SELECTED"; then
        log_severe "Installation finished with errors"
        return 1
    fi

    log_info "Installation completed"
}

##
# @Description
# Install jq with the distro package manager if it is missing
##
ensure_jq_installed() {
    if command -v jq &> /dev/null; then
        return 0
    fi

    log_info "Installing jq (required for JSON-based installation)"
    if command -v pacman &> /dev/null; then
        sudo pacman -Syu --noconfirm jq
    elif command -v apt &> /dev/null; then
        sudo apt install -y jq
    else
        log_severe "jq is not installed and no supported package manager was found"
        return 1
    fi
}

##
# @Description
# Print the package names of a profile, expanding "@include <profile>" lines recursively.
# Included profiles are resolved from PROFILES_PATH. Output may contain duplicates.
# @Params
# $1 Profile file path
# $2 Profiles already being expanded (space separated), used to detect include cycles
##
expand_profile() {
    local profile_file="$1"
    local include_stack="${2:-$(basename "$profile_file" .txt)}"
    local line
    local included_profile

    if [[ ! -f "$profile_file" ]]; then
        log_severe "Profile not found: $profile_file" >&2
        return 1
    fi

    while IFS= read -r line || [[ -n "$line" ]]; do
        line="$(echo "$line" | xargs)"
        [[ -z "$line" || "$line" == \#* ]] && continue

        if [[ "$line" == "@include "* ]]; then
            included_profile="$(echo "${line#@include }" | xargs)"
            if [[ " $include_stack " == *" $included_profile "* ]]; then
                log_severe "Include cycle detected: $include_stack $included_profile" >&2
                return 1
            fi
            expand_profile "$PROFILES_PATH/$included_profile.txt" "$include_stack $included_profile" || return 1
        else
            echo "$line"
        fi
    done < "$profile_file"
}

##
# @Description
# Install every package of a profile or package list (e.g., profiles/linux/work.txt)
# Each line is a package name or an "@include <profile>" directive.
# Packages repeated through includes are installed only once.
# @Params
# $1 Config file path (e.g., "profiles/linux/server.txt" or absolute path)
# $2 Distribution name (e.g., "ubuntu", "arch", "debian")
##
install_from_config_file() {
    local config_file="$1"
    local distro="$2"
    local expanded
    local packages=()
    local software

    expanded="$(expand_profile "$config_file")" || return 1
    mapfile -t packages < <(printf '%s\n' "$expanded" | awk 'NF && !seen[$0]++')

    log_info "Installing packages from: $config_file"
    log_info "Distribution: $distro"

    local installed_count=0
    local failed_packages=()
    local not_available_packages=()
    local manual_packages=()

    for software in "${packages[@]}"; do
        install_software "$software" "$distro"
        case $? in
            "$INSTALL_STATUS_OK") ((installed_count++)) ;;
            "$INSTALL_STATUS_NOT_AVAILABLE") not_available_packages+=("$software") ;;
            "$INSTALL_STATUS_MANUAL") manual_packages+=("$software: $(get_manual_url "$software" "$distro")") ;;
            *) failed_packages+=("$software") ;;
        esac
    done

    log_info "Installation summary:"
    log_info "  Total packages: ${#packages[@]}"
    log_info "  Successfully installed: $installed_count"
    log_info "  Not available on $distro: ${#not_available_packages[@]}"
    for software in "${not_available_packages[@]}"; do
        log_info "    - $software"
    done
    log_info "  Manual install required: ${#manual_packages[@]}"
    for software in "${manual_packages[@]}"; do
        log_info "    - $software"
    done
    log_info "  Failed: ${#failed_packages[@]}"
    for software in "${failed_packages[@]}"; do
        log_info "    - $software"
    done

    [[ ${#failed_packages[@]} -eq 0 ]]
}

##
# @Description
# Print the manual installation URL of a package for a distro
# @Params
# $1 Software name
# $2 Distribution name
##
get_manual_url() {
    jq -r --arg distro "$2" '.install[$distro].manual' "$PACKAGES_PATH/$1.json"
}

##
# @Description
# Print the command for a typed installer entry (pacman, yay, apt, flatpak)
# @Params
# $1 Installer name
# $2 Packages, space separated
##
build_typed_install_command() {
    local installer="$1"
    local packages="$2"

    case $installer in
        pacman) echo "sudo pacman -Syu --noconfirm $packages" ;;
        yay) echo "yay -Syu --noconfirm $packages" ;;
        apt) echo "sudo apt install -y $packages" ;;
        flatpak) echo "sudo flatpak install -y flathub $packages" ;;
        *) return 1 ;;
    esac
}

##
# @Description
# Install a single software package using its definition in packages/<software>.json
# @Params
# $1 Software name (e.g., "htop", "docker")
# $2 Distribution name (e.g., "ubuntu", "arch", "debian")
# @Returns
# INSTALL_STATUS_OK, INSTALL_STATUS_FAILED, INSTALL_STATUS_NOT_AVAILABLE or INSTALL_STATUS_MANUAL
##
install_software() {
    local software="$1"
    local distro="$2"
    local package_file="$PACKAGES_PATH/$software.json"
    local installer
    local commands=()

    log_info "$software"

    if [[ ! -f "$package_file" ]]; then
        log_warning "Package definition not found for '$software' in $package_file"
        return "$INSTALL_STATUS_FAILED"
    fi

    installer="$(jq -r --arg distro "$distro" '.install[$distro] // {} | keys[0] // ""' "$package_file")" \
        || return "$INSTALL_STATUS_FAILED"

    case $installer in
        "")
            log_info "  Not available on '$distro', skipping"
            return "$INSTALL_STATUS_NOT_AVAILABLE"
            ;;
        manual)
            log_info "  Manual install required: $(get_manual_url "$software" "$distro")"
            return "$INSTALL_STATUS_MANUAL"
            ;;
        commands)
            # Read one command at a time: a command may contain newlines
            local cmd_count index
            cmd_count="$(jq -r --arg distro "$distro" '.install[$distro].commands | length' "$package_file")"
            for ((index = 0; index < cmd_count; index++)); do
                commands+=("$(jq -r --arg distro "$distro" --argjson i "$index" \
                    '.install[$distro].commands[$i]' "$package_file")")
            done
            ;;
        *)
            local package_names typed_command
            package_names="$(jq -r --arg distro "$distro" --arg installer "$installer" \
                '.install[$distro][$installer] | if type == "array" then join(" ") else . end' "$package_file")"
            if ! typed_command="$(build_typed_install_command "$installer" "$package_names")"; then
                log_severe "Installer '$installer' is not supported on Linux ('$software' on '$distro')"
                return "$INSTALL_STATUS_FAILED"
            fi
            commands+=("$typed_command")
            ;;
    esac

    local cmd
    for cmd in "${commands[@]}"; do
        log_info "  Executing: $cmd"
        if ! eval "$cmd"; then
            log_severe "Failed to execute command for '$software': $cmd"
            return "$INSTALL_STATUS_FAILED"
        fi
    done

    return "$INSTALL_STATUS_OK"
}
