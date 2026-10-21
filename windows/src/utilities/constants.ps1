################################################################################

# Configuration
$GenesisPlatform = "windows"
$DefaultProfile = "desktop"
## Logging (enabled unless GENESIS_LOG_ENABLED is "false")
$GenesisLogEnabled = $env:GENESIS_LOG_ENABLED -ne "false"

################################################################################

# Available command types
$InstallCommand = "install"
$UpdateCommand = "update"
$HelpCommand = "help"

$CommandTypes = @(
    $InstallCommand
    $UpdateCommand
    $HelpCommand
)

################################################################################

# Messages
$CommandNotValidMessage = "Command selected not valid"
$InstallationTypeNotValidMessage = "Installation type selected not valid"

################################################################################

# Paths constants
## Basic paths
$RepositoryPath = Split-Path -Parent $BasePath
$ProfilesPath = Join-Path (Join-Path $RepositoryPath "profiles") $GenesisPlatform
$PackagesPath = Join-Path $RepositoryPath "packages"
$LogsPath = Join-Path $BasePath "logs"

### Logs paths
$LogFile = Join-Path $LogsPath "genesis_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

################################################################################

# Load available installation types from profiles
function Get-GenesisInstallTypes {
    if (-not (Test-Path $ProfilesPath)) {
        throw "Profiles folder not found: $ProfilesPath"
    }

    $installTypes = @(Get-ChildItem -Path $ProfilesPath -Filter "*.txt" -File |
        Sort-Object BaseName |
        Select-Object -ExpandProperty BaseName)

    if ($installTypes.Count -eq 0) {
        throw "No profiles found in: $ProfilesPath"
    }

    return $installTypes
}

$InstallCommandTypes = @(Get-GenesisInstallTypes)

################################################################################
