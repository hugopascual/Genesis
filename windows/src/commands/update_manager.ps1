function Invoke-GenesisUpdate {
    # General update function
    Write-Host "Starting update os system..."

    $failed = $false

    # Chocolatey
    if (Test-GenesisCommandInstalled -Name "choco") {
        if (-not (Update-GenesisChoco)) {
            $failed = $true
        }
    }

    if ($failed) {
        exit 1
    }
}

######################
#--Update Functions--#
######################

function Update-GenesisChoco {
    # Chocolatey packages update
    Write-Host "Chocolatey update started"

    $global:LASTEXITCODE = 0
    choco upgrade all -y
    if ($global:LASTEXITCODE -ne 0) {
        Write-Warning "Chocolatey update exited with code $global:LASTEXITCODE"
        return $false
    }

    Write-Host "Chocolatey update finished"
    return $true
}
