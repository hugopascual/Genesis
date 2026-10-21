function Show-GenesisHelp {
    # Help command or with error usage
    Write-Host @"

Usage:  .\windows\windows.ps1 [$InstallCommand] [-Profile { PROFILE }] [-ConfigPath { PACKAGE_LIST_FILE }]
        .\windows\windows.ps1 $UpdateCommand
        .\windows\windows.ps1 $HelpCommand

where   $InstallCommand is the default command when none is given

        PROFILE := { $($InstallCommandTypes -join ' ') } (from profiles/windows/, default: $DefaultProfile)
        PACKAGE_LIST_FILE := Path to custom package list (supports @include <profile>)
            - Takes precedence over -Profile when both are given
            - Example: my_packages.txt

Environment:
        GENESIS_LOG_ENABLED := { true | false } Save the log in windows\logs\ (default: true)

Examples:
    .\windows\windows.ps1
    .\windows\windows.ps1 $InstallCommand -Profile personal
    .\windows\windows.ps1 $InstallCommand -ConfigPath my_packages.txt
    .\windows\windows.ps1 $UpdateCommand
    `$env:GENESIS_LOG_ENABLED = "false"; .\windows\windows.ps1 $InstallCommand -Profile work

"@
}
