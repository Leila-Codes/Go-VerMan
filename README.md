# Go Version Manager
A simple command-line utility for quick installation and switching of Golang versions within the current user.

## Supported Operating Systems
| Operating System | Command Line |
| ---------------- | ------------ |
| Windows 10/11    | Powershell   |

## Available Commands
*List*
Lists all installed versions of Golang
`Go-VerMan list`

*Install*
Downloads and installs a new version of Golang from the official Google website.
`Go-VerMan install <version>`
Examples:
`Go-VerMan install go1.21.0`

*Uninstall*
Deletes the specified version from the installation directory.
`Go-VerMan uninstall <version>`
Examples:
`Go-VerMan uninstall go1.21.0`

*Use*
Switch the currently active version, available for use within the system path.
`Go-VerMan use <version>`
Example:
`Go-VerMan use go1.21.0`