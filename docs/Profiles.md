# Profiles

A profile is a list of logical package names (one per line, matching `packages/<name>.json`). Profiles are split by operating system:

- Linux: `profiles/linux/*.txt`
- Windows: `profiles/windows/*.txt`

The profile name is the file name without `.txt`, and new files are detected automatically by both entrypoints.

## Levels

Profiles are organised by levels, each one including the previous one:

```text
base ──┬── server          (Linux only)
       └── desktop ──┬── work
                     └── personal
```

| Profile | Includes | Contents |
| --- | --- | --- |
| `base` | — | CLI and development essentials common to every machine |
| `server` | `base` | Nothing else (Linux only) |
| `desktop` | `base` | Graphical applications, drivers and VPN clients |
| `work` | `desktop` | Work extras, if any |
| `personal` | `desktop` | Videogames and, on Windows, 3D printing |

Check the profile files for the exact list of packages.

## Syntax

```txt
@include desktop

# Videogames
steam
heroic
```

- Lines starting with `#` are comments; blank lines are ignored.
- `@include <profile>` inserts that profile of the same OS at that point. Includes can be nested.
- `base` must not include any other profile.
- Each package is installed once, at its first occurrence after expanding includes.
- An include cycle or an include of a missing profile stops the installation with an error.

## Custom package lists

Any file with the same syntax can be installed instead of a profile, and it can include profiles of its OS:

```bash
./linux/linux.sh install arch my_packages.txt
```

```powershell
.\windows\windows.ps1 install -ConfigPath my_packages.txt
```

## Packages not available on a platform

A profile can list a package without an entry for every distro: it is skipped and listed as not available in the installation summary. A package with a `manual` entry is listed with its URL to be installed by hand.
