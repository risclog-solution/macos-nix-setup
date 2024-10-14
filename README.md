Setup development environment for Mac using Nix
===============================================

First install and update
------------------------

Just run this install script from your terminal:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/risclog-solution/macos-nix-setup/HEAD/install.sh)"
```

Restore from Time Machine backup
--------------------------------

When you restore you MacOS from a backup, the Nix Setup is broken because not
everything is backed up. You then should first uninstall everything that was
left over with this guide:

https://nixos.org/manual/nix/unstable/installation/uninstall.html#macos

```
rm /Users/<USER>/.local/state/nix/profiles/home-manager*
rm /Users/<USER>/.local/state/home-manager/gcroots/current-home
```

Then, after a reboot, you can install everything from scatch.


Problems with Nix Users after Update to MacOS 15 Sequoia
--------------------------------------------------------

If you get errors after updating to MacOS 15 Sequoia like `error: the user '_nixbld1' in the group 'nixbld' does not exist`, you can fix this by running the following commands:

```
curl --proto '=https' --tlsv1.2 -sSf -L https://github.com/NixOS/nix/raw/master/scripts/sequoia-nixbld-user-migration.sh | bash -
```
