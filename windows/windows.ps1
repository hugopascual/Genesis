function install_from_url {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]$urls
    )

    $destFolder = [Environment]::GetFolderPath('UserProfile') + "\Downloads"

    foreach ($url in $urls) {
        $dest = Join-Path $destFolder (Split-Path $url -Leaf)

        Write-Host "Downloading $url..."
        Invoke-WebRequest -Uri $url -OutFile $dest

        Write-Host "Running installer..."
        Start-Process -FilePath $dest -Wait

        Write-Host "Installation completed. The installer remains at: $dest"
    }

    Write-Host "`nAll installations completed."
}

################################################################################
# Minimum installations
################################################################################
choco install -y 7zip

################################################################################
# Development installations
################################################################################
choco install -y git
choco install -y vscode
choco install -y jetbrainstoolbox
install_from_url -urls @(
    # Docker Desktop
    # Python
    # GitHub Desktop
    # Postman
    # RPI Imager
    "https://example.com/dit_installer.exe"
)

################################################################################
# DIT installations
################################################################################
install_from_url -urls @(
    # OpenVPN
    "https://example.com/dit_installer.exe"
)

################################################################################
# Desktop installations
################################################################################
choco install -y geforce-experience
choco install -y firefox
choco install -y thunderbird
choco install -y keepass.install
choco install -y googledrive
choco install -y adobereader
choco install -y spotify
choco install -y telegram.install
choco install -y discord.install
choco install -y obsidian
choco install -y vlc
install_from_url -urls @(
    # DisplayLink Driver
    # Autofirma
    # Config FNMT
    # Team Viewer
    # Wireguard
    "https://example.com/desktop_installer.exe"
)

################################################################################
# Hobbys installations
################################################################################
choco install -y steam --ignore-checksums
choco install -y epicgameslauncher
choco install -y amazongames --ignore-checksums
install_from_url -urls @(
    # Battle.net
    # EA App
    # Minecraft Launcher
    # Heroic
    # Chitubox Software: Chitubox Free y Chitubox Manager
    # Lychee Slicer
    "https://example.com/hobbys_installer.exe"
)
