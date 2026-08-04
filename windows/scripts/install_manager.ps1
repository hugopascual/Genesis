function ConvertTo-GenesisArray {
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

function Get-GenesisPackageNamesFromConfig {
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

function Get-GenesisPackageDefinition {
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

function Invoke-GenesisCommands {
    param (
        [Parameter(Mandatory = $true)]
        [array]$Commands,
        [Parameter(Mandatory = $true)]
        [string]$PackageName
    )

    foreach ($cmd in $Commands) {
        if ([string]::IsNullOrWhiteSpace($cmd)) {
            continue
        }

        Write-Host "[$PackageName] $cmd"
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

function Install-GenesisPackage {
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageName,
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Definition
    )

    $commands = ConvertTo-GenesisArray -Value $Definition.commands
    return Invoke-GenesisCommands -Commands $commands -PackageName $PackageName
}

function Invoke-GenesisInstall {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ScriptRoot,
        [string]$Profile = "base",
        [string]$ConfigPath
    )

    $packagesPath = Join-Path $ScriptRoot "packages"
    $installConfigsPath = Join-Path $ScriptRoot "install_configs"

    if ([string]::IsNullOrWhiteSpace($ConfigPath)) {
        $ConfigPath = Join-Path $installConfigsPath "$Profile.txt"
    }

    Write-Host "Using install config: $ConfigPath"
    [array]$packageNames = ConvertTo-GenesisArray -Value (Get-GenesisPackageNamesFromConfig -Path $ConfigPath)

    if (@($packageNames).Count -eq 0) {
        throw "No packages found in install config: $ConfigPath"
    }

    $installedCount = 0
    $failedPackages = @()
    $manualPackages = @()

    foreach ($packageName in $packageNames) {
        Write-Host "`n==> Installing package: $packageName"
        $definition = Get-GenesisPackageDefinition -PackageName $packageName -PackagesPath $packagesPath

        if ($null -eq $definition) {
            $failedPackages += $packageName
            continue
        }

        $commands = ConvertTo-GenesisArray -Value $definition.commands
        if (@($commands).Count -eq 0) {
            Write-Warning "Package '$packageName' has no install commands, skipping"

            $manualInfo = ""
            if ($definition.PSObject.Properties.Name -contains "info") {
                $manualInfo = [string]$definition.info
            }

            if ([string]::IsNullOrWhiteSpace($manualInfo)) {
                $manualInfo = "(no info URL provided)"
            }

            $manualPackages += [pscustomobject]@{
                name = $packageName
                info = $manualInfo
            }

            continue
        }

        if (Install-GenesisPackage -PackageName $packageName -Definition $definition) {
            $installedCount++
        }
        else {
            $failedPackages += $packageName
        }
    }

    Write-Host "`nInstallation summary"
    Write-Host "- Total packages: $(@($packageNames).Count)"
    Write-Host "- Installed successfully: $installedCount"
    Write-Host "- Failed: $(@($failedPackages).Count)"
    Write-Host "- Skipped (manual): $(@($manualPackages).Count)"

    if (@($manualPackages).Count -gt 0) {
        Write-Host "`nPackages skipped (manual install required):"
        foreach ($manualPackage in $manualPackages) {
            Write-Host "- $($manualPackage.name): $($manualPackage.info)"
        }
    }

    if (@($failedPackages).Count -gt 0) {
        Write-Host "- Failed packages: $($failedPackages -join ', ')"
        exit 1
    }

    Write-Host "All packages installed successfully."
}
