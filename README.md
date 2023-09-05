# Go Version Manager
A simple command-line utility for quick installation and switching of Golang versions within the current user.

## Supported Operating Systems
| Operating System | Command Line |
| ---------------- | ------------ |
| Windows 10/11    | Powershell   |

## Available Commands
#### `Go-VerMan list`
Lists all installed versions of Golang

---
#### `Go-VerMan install <version>`
Downloads and installs a new version of Golang from the official Google website.

Example:
`Go-VerMan install go1.21.0`

---
#### `Go-VerMan uninstall <version>`
Deletes the specified version from the installation directory.

Example:
`Go-VerMan uninstall go1.21.0`

---
#### `Go-VerMan use <version>`
Switch the currently active version, available for use within the system path.

Example:
`Go-VerMan use go1.21.0`