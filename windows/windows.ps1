param (
    [string]$Command = "install",
    [string]$Profile,
    [string]$ConfigPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

################################################################################
# Get the path to the main directory.
$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$SrcPath = Join-Path $BasePath "src"

################################################################################
### Imports (dot-sourced at script level so functions and constants stay visible)
foreach ($importDirectory in @("utilities", "commands")) {
    foreach ($scriptFile in Get-ChildItem -Path (Join-Path $SrcPath $importDirectory) -Filter "*.ps1" -File -Recurse | Sort-Object FullName) {
        . $scriptFile.FullName
    }
}

################################################################################
### Initialize logging system (finally also runs on "exit", closing the log)
Start-GenesisLog
try {
    $Command = $Command.ToLowerInvariant()
    if ([string]::IsNullOrWhiteSpace($Profile)) {
        $Profile = $DefaultProfile
    }

    Test-GenesisOptionSupported -Option $Command `
        -ErrorMessage $CommandNotValidMessage `
        -SupportedOptions $CommandTypes

    if ($Command -eq $HelpCommand) {
        Show-GenesisHelp
        exit 0
    }

    Write-Host "Command selected: $Command"
    if ($Command -eq $InstallCommand) {
        if ([string]::IsNullOrWhiteSpace($ConfigPath)) {
            Write-Host "Profile selected: $Profile"
        }
        else {
            Write-Host "Package list selected: $ConfigPath"
        }
    }

    # Display options selected and ask for confirmation
    $answer = Read-Host "Are you sure you want to continue? (Y/n)"
    if (-not [string]::IsNullOrWhiteSpace($answer) -and $answer -notmatch '^(y|yes)$') {
        Write-Host "Operation cancelled by user"
        exit 1
    }

    # Execute routine depending on command
    switch ($Command) {
        $InstallCommand {
            Write-Host "Starting installation"
            Invoke-GenesisInstall -Profile $Profile -ConfigPath $ConfigPath
        }
        $UpdateCommand {
            Write-Host "Starting update"
            Invoke-GenesisUpdate
        }
    }
}
finally {
    ### Display log file location
    Stop-GenesisLog
}
