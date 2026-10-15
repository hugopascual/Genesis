function Invoke-GenesisInstall {
    # Main installation command handler
    param (
        [string]$Profile = $DefaultProfile,
        [string]$ConfigPath
    )

    if ([string]::IsNullOrWhiteSpace($ConfigPath)) {
        Test-GenesisOptionSupported -Option $Profile `
            -ErrorMessage $InstallationTypeNotValidMessage `
            -SupportedOptions $InstallCommandTypes
        $ConfigPath = Join-Path $ProfilesPath "$Profile.txt"
    }

    Invoke-GenesisInstallFromConfigFile -ConfigPath $ConfigPath
}

#####################################
#--Auxiliar Installation Functions--#
#####################################

function Expand-GenesisProfile {
    # Returns the package names of a profile, expanding "@include <profile>" lines recursively.
    # Included profiles are resolved from ProfilesPath. The result may contain duplicates.
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [string[]]$IncludeStack = @()
    )

    if (-not (Test-Path $Path)) {
        throw "Profile not found: $Path"
    }

    if (@($IncludeStack).Count -eq 0) {
        $IncludeStack = @([System.IO.Path]::GetFileNameWithoutExtension($Path))
    }

    $packageNames = @()
    foreach ($rawLine in Get-Content -Path $Path) {
        $line = $rawLine.Trim()
        if (-not $line -or $line.StartsWith("#")) {
            continue
        }

        if ($line -match '^@include\s+(\S+)$') {
            $includedProfile = $Matches[1]
            if ($IncludeStack -contains $includedProfile) {
                throw "Include cycle detected: $((@($IncludeStack) + $includedProfile) -join ' -> ')"
            }

            $includedPath = Join-Path $ProfilesPath "$includedProfile.txt"
            $packageNames += @(Expand-GenesisProfile -Path $includedPath -IncludeStack (@($IncludeStack) + $includedProfile))
            continue
        }

        $packageNames += $line
    }

    return $packageNames
}

function Get-GenesisPackageDefinition {
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageName
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

function Get-GenesisPlatformEntry {
    # Returns the installation method of a package for this platform as @{ Installer; Value },
    # or $null when the package is not available on it.
    param (
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Definition
    )

    $installProperty = $Definition.PSObject.Properties["install"]
    if ($null -eq $installProperty) {
        return $null
    }

    $platformProperty = $installProperty.Value.PSObject.Properties[$GenesisPlatform]
    if ($null -eq $platformProperty) {
        return $null
    }

    $method = @($platformProperty.Value.PSObject.Properties)[0]
    return [pscustomobject]@{
        Installer = $method.Name
        Value     = $method.Value
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
        [pscustomobject]$Entry
    )

    switch ($Entry.Installer) {
        "choco" {
            $packages = (ConvertTo-GenesisArray -Value $Entry.Value) -join " "
            $commands = @("choco install -y $packages --ignore-checksums")
        }
        "commands" {
            $commands = ConvertTo-GenesisArray -Value $Entry.Value
        }
        default {
            Write-Warning "Installer '$($Entry.Installer)' is not supported on Windows ('$PackageName')"
            return $false
        }
    }

    return Invoke-GenesisCommands -Commands $commands -PackageName $PackageName
}

function Invoke-GenesisInstallFromConfigFile {
    # Install every package of a profile or package list.
    # Packages repeated through includes are installed only once.
    param (
        [Parameter(Mandatory = $true)]
        [string]$ConfigPath
    )

    Write-Host "Using install config: $ConfigPath"
    [array]$packageNames = @(Expand-GenesisProfile -Path $ConfigPath | Select-Object -Unique)

    if (@($packageNames).Count -eq 0) {
        throw "No packages found in install config: $ConfigPath"
    }

    $installedCount = 0
    $failedPackages = @()
    $notAvailablePackages = @()
    $manualPackages = @()

    foreach ($packageName in $packageNames) {
        Write-Host "`n==> Installing package: $packageName"
        $definition = Get-GenesisPackageDefinition -PackageName $packageName

        if ($null -eq $definition) {
            $failedPackages += $packageName
            continue
        }

        $entry = Get-GenesisPlatformEntry -Definition $definition
        if ($null -eq $entry) {
            Write-Warning "Package '$packageName' is not available on Windows, skipping"
            $notAvailablePackages += $packageName
            continue
        }

        if ($entry.Installer -eq "manual") {
            Write-Warning "Package '$packageName' requires manual install, skipping"
            $manualPackages += [pscustomobject]@{
                name = $packageName
                info = [string]$entry.Value
            }
            continue
        }

        if (Install-GenesisPackage -PackageName $packageName -Entry $entry) {
            $installedCount++
        }
        else {
            $failedPackages += $packageName
        }
    }

    Write-Host "`nInstallation summary"
    Write-Host "- Total packages: $(@($packageNames).Count)"
    Write-Host "- Installed successfully: $installedCount"
    Write-Host "- Not available on Windows: $(@($notAvailablePackages).Count)"
    Write-Host "- Skipped (manual): $(@($manualPackages).Count)"
    Write-Host "- Failed: $(@($failedPackages).Count)"

    if (@($notAvailablePackages).Count -gt 0) {
        Write-Host "`nPackages not available on Windows: $($notAvailablePackages -join ', ')"
    }

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
