# Genesis

Automated installation and configuration system for Linux and Windows operating systems.

## Overview

Genesis provides automated scripts to install and configure software packages across different operating systems and distributions. It simplifies the process of setting up new machines with predefined or custom software configurations.

## Supported Systems

- **Linux**: Ubuntu, Debian, Arch Linux
- **Windows**: PowerShell-based installation

## Quick Start

### Linux

```bash
./linux/linux.sh install <distro> <config>
./linux/linux.sh update <distro>
./linux/linux.sh setup <distro> <environment>
./linux/linux.sh add-distro <new_distro> "<base_command>"
```

### Windows

```powershell
powershell -ExecutionPolicy Bypass -File .\windows.ps1
```

## Project Structure

```text
Genesis/
├── linux/          # Linux entrypoint, source code and configurations
│   ├── linux.sh
│   ├── src/
│   ├── configs/
│   ├── packages/
│   └── statics/
├── windows/        # Windows installation scripts
└── docs/           # Detailed documentation
```

## Documentation

- **[Linux](docs/Linux.md)** - Linux installation and configuration guide
  - [Ubuntu](docs/linux_distributions/Ubuntu.md)
  - [Debian](docs/linux_distributions/Debian.md)
  - [Arch](docs/linux_distributions/Arch.md)
- **[Windows](docs/Windows.md)** - Windows installation and configuration guide

## License

See [LICENSE](LICENSE) file
