######################
#--Logging Functions--#
######################

$script:GenesisLogStarted = $false

function Start-GenesisLog {
    # Record the whole session output (messages and command output) in the log file
    if (-not $GenesisLogEnabled) {
        return
    }

    New-Item -ItemType Directory -Path $LogsPath -Force | Out-Null
    Start-Transcript -Path $LogFile -Append | Out-Null
    $script:GenesisLogStarted = $true

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host @"
========================================
Genesis Windows - Log Session Started
Timestamp: $timestamp
========================================
"@
}

function Stop-GenesisLog {
    if (-not $script:GenesisLogStarted) {
        return
    }

    Write-Host "Execution completed!"
    Write-Host "Log file saved at: $LogFile"
    Stop-Transcript | Out-Null
    $script:GenesisLogStarted = $false
}
