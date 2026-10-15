function Test-GenesisOptionSupported {
    # Show the error message and the help, and exit, if the option is not supported
    param (
        [string]$Option,
        [Parameter(Mandatory = $true)]
        [string]$ErrorMessage,
        [Parameter(Mandatory = $true)]
        [string[]]$SupportedOptions
    )

    if ([string]::IsNullOrWhiteSpace($Option) -or -not ($SupportedOptions -contains $Option)) {
        Write-Host $ErrorMessage
        Show-GenesisHelp
        exit 1
    }
}

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

function Test-GenesisCommandInstalled {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        Write-Host "Command $Name not installed"
        return $false
    }

    return $true
}
