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
        Write-Host "Usage:"
        Write-Host "  .\\windows\\windows.ps1 install [-Profile base] [-ConfigPath .\\windows\\install_configs\\base.txt]"
        Write-Host "  .\\windows\\windows.ps1 help"
    }
    default {
        throw "Invalid command '$Command'. Use 'install' or 'help'."
    }
}
