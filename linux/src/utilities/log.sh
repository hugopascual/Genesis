#!/bin/bash

######################
#--Logging Functions--#
######################
##
# @Description
# Initialize the log file and create logs directory if it doesn't exist
##
init_log() {
    if [[ "${GENESIS_LOG_ENABLED}" != "true" ]]; then
        return 0
    fi
    
    # Create logs directory if it doesn't exist
    mkdir -p "$LOGS_PATH"
    
    # Initialize log file with header
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "========================================
Genesis Linux - Log Session Started
Timestamp: $timestamp
========================================
" >> "$LOG_FILE"
}

##
# @Description
# Write a message to the log file with standard format
# @Params
# $1 Log level (INFO, SUCCESS, WARNING, ERROR, etc.)
# $2 Message to log
##
log() {
    if [[ "${GENESIS_LOG_ENABLED}" != "true" ]]; then
        return 0
    fi
    
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_text="[$level: $timestamp] $message"

    echo "$log_text"
    echo "$log_text" >> "$LOG_FILE"
}

log_severe() {
    log "$LOG_LEVEL_SEVERE" "$1"
}

log_warning() {
    log "$LOG_LEVEL_WARNING" "$1"
}

log_info() {
    log "$LOG_LEVEL_INFO" "$1"
}

log_config() {
    log "$LOG_LEVEL_CONFIG" "$1"
}

log_fine() {
    log "$LOG_LEVEL_FINE" "$1"
}

log_finer() {
    log "$LOG_LEVEL_FINER" "$1"
}

log_finest() {
    log "$LOG_LEVEL_FINEST" "$1"
}
