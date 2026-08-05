param (
    [string]$Command = "install",
    [string]$Profile = "base",
    [string]$ConfigPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$scriptsPath = Join-Path $scriptRoot "scripts"

if (-not (Test-Path $scriptsPath)) {
    throw "Scripts folder not found: $scriptsPath"
}

Get-ChildItem -Path $scriptsPath -Filter "*.ps1" -File |
    Sort-Object Name |
    ForEach-Object { . $_.FullName }

switch ($Command.ToLowerInvariant()) {
    "install" {
        Invoke-GenesisInstall -ScriptRoot $scriptRoot -Profile $Profile -ConfigPath $ConfigPath
    }
    "help" {
        $availableProfiles = @()
        try {
            $availableProfiles = @(Get-GenesisAvailableProfiles -ScriptRoot $scriptRoot)
        }
        catch {
            $availableProfiles = @()
        }

        $profilesText = if ($availableProfiles.Count -gt 0) { $availableProfiles -join ", " } else { "(none found)" }

        Write-Host "Usage:"
        Write-Host "  .\\windows\\windows.ps1 install [-Profile <profile-name>] [-ConfigPath .\\windows\\install_configs\\<profile-name>.txt]"
        Write-Host "  .\\windows\\windows.ps1 help"
        Write-Host ""
        Write-Host "Available profiles (from windows/install_configs/*.txt): $profilesText"
    }
    default {
        throw "Invalid command '$Command'. Use 'install' or 'help'."
    }
}
