param (
    [string]$Profile = "base",
    [string]$ConfigPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$script:checkedChocolatey = $false
$script:checkedWinget = $false

function install_from_url {
    param (
        [Parameter(Mandatory = $true)]
        [array]$Installers
    )

    $destFolder = Join-Path ([Environment]::GetFolderPath("UserProfile")) "Downloads"

    foreach ($installer in $Installers) {
        $url = $null
        $arguments = $null

        if ($installer -is [string]) {
            $url = $installer
        }
        else {
            $url = $installer.url
            $arguments = $installer.arguments
        }

        if ([string]::IsNullOrWhiteSpace($url)) {
            Write-Warning "Skipping URL installer because url is empty."
            continue
        }

        $dest = Join-Path $destFolder (Split-Path $url -Leaf)

        Write-Host "Downloading $url"
        Invoke-WebRequest -Uri $url -OutFile $dest

        Write-Host "Running installer: $dest"
        if ([string]::IsNullOrWhiteSpace($arguments)) {
            Start-Process -FilePath $dest -Wait
        }
        else {
            Start-Process -FilePath $dest -ArgumentList $arguments -Wait
        }

        Write-Host "Installer completed. File kept at: $dest"
    }
}

function Test-Dependency {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required tool '$Name' was not found in PATH."
    }
}

function ConvertTo-Array {
    param (
        $Value
    )

    if ($null -eq $Value) {
        return @()
    }

    if ($Value -is [System.Array]) {
        return $Value
    }

    return @($Value)
}

function Get-ItemCount {
    param (
        $Value
    )

    return @(ConvertTo-Array -Value $Value).Count
}

function Get-PackageNamesFromConfig {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        throw "Install config not found: $Path"
    }

    return Get-Content -Path $Path |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ -and -not $_.StartsWith("#") }
}

function Get-PackageDefinition {
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageName,
        [Parameter(Mandatory = $true)]
        [string]$PackagesPath
    )

    $definitionPath = Join-Path $PackagesPath "$PackageName.json"
    if (-not (Test-Path $definitionPath)) {
        Write-Warning "Package definition not found: $definitionPath"
        return $null
    }

    try {
        return Get-Content -Path $definitionPath -Raw | ConvertFrom-Json
    }
    catch {
        Write-Warning "Invalid JSON for package '$PackageName' in $definitionPath"
        return $null
    }
}

function Invoke-InstallCommands {
    param (
        [Parameter(Mandatory = $true)]
        [array]$Commands,
        [Parameter(Mandatory = $true)]
        [string]$Provider,
        [Parameter(Mandatory = $true)]
        [string]$PackageName
    )

    foreach ($cmd in $Commands) {
        if ([string]::IsNullOrWhiteSpace($cmd)) {
            continue
        }

        Write-Host "[$PackageName][$Provider] $cmd"
        try {
            Invoke-Expression $cmd
        }
        catch {
            Write-Warning "Command failed for '$PackageName': $cmd"
            return $false
        }
    }

    return $true
}

function Install-Package {
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageName,
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Definition
    )

    $success = $true
    $hasChocolatey = $Definition.PSObject.Properties.Name -contains "chocolatey"
    $hasWinget = $Definition.PSObject.Properties.Name -contains "winget"
    $hasUrls = $Definition.PSObject.Properties.Name -contains "urls"

    [array]$chocoCommands = if ($hasChocolatey) { ConvertTo-Array -Value $Definition.chocolatey } else { @() }
    [array]$wingetCommands = if ($hasWinget) { ConvertTo-Array -Value $Definition.winget } else { @() }
    [array]$urlInstallers = if ($hasUrls) { ConvertTo-Array -Value $Definition.urls } else { @() }

    if ((Get-ItemCount -Value $chocoCommands) -gt 0 -and -not $script:checkedChocolatey) {
        Test-Dependency -Name "choco"
        $script:checkedChocolatey = $true
    }

    if ((Get-ItemCount -Value $wingetCommands) -gt 0 -and -not $script:checkedWinget) {
        Test-Dependency -Name "winget"
        $script:checkedWinget = $true
    }

    if ((Get-ItemCount -Value $chocoCommands) -gt 0) {
        $success = $success -and (Invoke-InstallCommands -Commands $chocoCommands -Provider "choco" -PackageName $PackageName)
    }

    if ((Get-ItemCount -Value $wingetCommands) -gt 0) {
        $success = $success -and (Invoke-InstallCommands -Commands $wingetCommands -Provider "winget" -PackageName $PackageName)
    }

    if ((Get-ItemCount -Value $urlInstallers) -gt 0) {
        try {
            install_from_url -Installers $urlInstallers
        }
        catch {
            Write-Warning "URL installer failed for '$PackageName': $($_.Exception.Message)"
            $success = $false
        }
    }

    return $success
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$packagesPath = Join-Path $scriptRoot "packages"
$installConfigsPath = Join-Path $scriptRoot "install_configs"

if ([string]::IsNullOrWhiteSpace($ConfigPath)) {
    $ConfigPath = Join-Path $installConfigsPath "$Profile.txt"
}

Write-Host "Using install config: $ConfigPath"
[array]$packageNames = ConvertTo-Array -Value (Get-PackageNamesFromConfig -Path $ConfigPath)

if ((Get-ItemCount -Value $packageNames) -eq 0) {
    throw "No packages found in install config: $ConfigPath"
}

$installedCount = 0
$failedPackages = @()

foreach ($packageName in $packageNames) {
    Write-Host "`n==> Installing package: $packageName"
    $definition = Get-PackageDefinition -PackageName $packageName -PackagesPath $packagesPath

    if ($null -eq $definition) {
        $failedPackages += $packageName
        continue
    }

    if (Install-Package -PackageName $packageName -Definition $definition) {
        $installedCount++
    }
    else {
        $failedPackages += $packageName
    }
}

Write-Host "`nInstallation summary"
$totalPackages = Get-ItemCount -Value $packageNames
$failedCount = Get-ItemCount -Value $failedPackages
Write-Host "- Total packages: $totalPackages"
Write-Host "- Installed successfully: $installedCount"
Write-Host "- Failed: $failedCount"

if ($failedCount -gt 0) {
    Write-Host "- Failed packages: $($failedPackages -join ', ')"
    exit 1
}

Write-Host "All packages installed successfully."
