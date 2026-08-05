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

function Get-GenesisAvailableProfiles {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ScriptRoot
    )

    $installConfigsPath = Join-Path $ScriptRoot "install_configs"
    if (-not (Test-Path $installConfigsPath)) {
        throw "Install configs folder not found: $installConfigsPath"
    }

    return Get-ChildItem -Path $installConfigsPath -Filter "*.txt" -File |
        Sort-Object BaseName |
        Select-Object -ExpandProperty BaseName
}

function Resolve-GenesisInstallConfigPath {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ScriptRoot,
        [string]$Profile = "base",
        [string]$ConfigPath
    )

    $installConfigsPath = Join-Path $ScriptRoot "install_configs"

    if (-not [string]::IsNullOrWhiteSpace($ConfigPath)) {
        return $ConfigPath
    }

    $availableProfiles = ConvertTo-GenesisArray -Value (Get-GenesisAvailableProfiles -ScriptRoot $ScriptRoot)
    if (@($availableProfiles).Count -eq 0) {
        throw "No install profiles found in: $installConfigsPath"
    }

    if ([string]::IsNullOrWhiteSpace($Profile) -or -not ($availableProfiles -contains $Profile)) {
        $availableProfilesText = $availableProfiles -join ", "
        throw "Invalid profile '$Profile'. Available profiles: $availableProfilesText"
    }

    return Join-Path $installConfigsPath "$Profile.txt"
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
            # Stream all command output (stdout/stderr/information) directly to the current console.
            $global:LASTEXITCODE = 0
            & ([ScriptBlock]::Create($cmd)) *>&1 | ForEach-Object { $_ | Out-Host }

            if ($global:LASTEXITCODE -ne 0) {
                Write-Warning "Command exited with code $global:LASTEXITCODE for '$PackageName': $cmd"
                return $false
            }
        }
        catch {
            Write-Warning "Command failed for '$PackageName': $cmd"
            Write-Warning $_.Exception.Message
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
    $ConfigPath = Resolve-GenesisInstallConfigPath -ScriptRoot $ScriptRoot -Profile $Profile -ConfigPath $ConfigPath

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
