# Private macOS Nix Setup

Declarative setup for a private Apple Silicon MacBook using Determinate Nix,
nix-darwin, and Home Manager.

## Scope

The configuration manages the macOS development environment, shell tools, Git,
SSH, and selected local services. It is intentionally independent of any work
environment.

## Prerequisites

- An Apple Silicon Mac running macOS
- An administrator account
- Xcode Command Line Tools
- A GitHub account with SSH access configured

## Installation

Clone the private repository and run the installer from the checkout:

```bash
git clone git@github.com:marcus-steinbach/macos-nix-setup.git
cd macos-nix-setup
./install.sh
```

The installer installs Determinate Nix when necessary and bootstraps the Nix
configuration. It may prompt for your private identity and signing settings.

## Restore

After restoring macOS from Time Machine, reinstall Determinate Nix before
running the installer again. Nix-managed profiles are not fully restored by
Time Machine.

## Status

The configuration is being migrated from an older setup. The remaining work is
tracked in [todo.md](todo.md).
