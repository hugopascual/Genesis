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
# choco install -y 7zip

################################################################################
# Development installations
################################################################################
choco install -y git
choco install -y vscode
choco install -y jetbrainstoolbox
choco install -y docker-desktop
choco install -y python
choco install -y github-desktop
choco install -y postman
# RPI Imager
# install_from_url -urls @("https://downloads.raspberrypi.com/imager/imager_latest.exe")

################################################################################
# DIT installations
################################################################################
# OpenVPNv3
choco install -y openvpn-connect

################################################################################
# Desktop installations
################################################################################
choco install -y geforce-experience
choco install -y firefox
choco install -y googlechrome
choco install -y thunderbird
choco install -y keepass.install
choco install -y googledrive
choco install -y adobereader
choco install -y spotify
choco install -y telegram.install
choco install -y discord.install
choco install -y obsidian
choco install -y vlc
# DisplayLink Driver
# https://www.synaptics.com/products/displaylink-graphics/downloads
# Autofirma
# https://firmaelectronica.gob.es/ciudadanos/descargas
# Config FNMT
# install_from_url -urls @(""https://descargas.cert.fnmt.es/Windows/Configurador_FNMT_5.0.3_64bits.exe")
# TODO: install rustdesk
choco install -y wireguard

################################################################################
# Hobbys installations
################################################################################
choco install -y steam --ignore-checksums
choco install -y epicgameslauncher
choco install -y amazongames --ignore-checksums
# Battle.net
# https://eu.shop.battle.net/
# EA App
choco install -y ea-app
# Minecraft Launcher
# https://www.minecraft.net/es-es/download
# Heroic
choco install -y heroic-games-launcher
# Chitubox Software: Chitubox Free
# https://www.chitubox.com/en/download/chitubox-free
# Lychee Slicer
# https://mango3d.io/download-lychee-slicer
