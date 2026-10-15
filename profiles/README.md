# Profiles

Lists of logical package names (one per line, matching `packages/<name>.json`), split by operating system.

```text
base ──┬── server
       └── desktop ──┬── work
                     └── personal
```

| Level | Linux | Windows |
|---|---|---|
| `base` | CLI and development essentials | Development essentials |
| `server` | `base` | — |
| `desktop` | `base` + graphical applications | `base` + graphical applications |
| `work` | `desktop` | `desktop` + work extras |
| `personal` | `desktop` | `desktop` + personal extras |

## Syntax

- Lines starting with `#` are comments; blank lines are ignored.
- `@include <profile>` inserts that profile of the same OS at that point. Includes can be nested.
- `base` must not include any other profile.
- Each package is installed once, at its first occurrence after expanding includes.
- An include cycle is an error.
