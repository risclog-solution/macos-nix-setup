Setup development environment for Mac using Nix
===============================================


Run install script:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/risclog-solution/macos-nix-setup/HEAD/install.sh)"
```

Restore Mac from Time Machine backup
------------------------------------

When using Time Machine, the “Nix Store” volume will be backed-up just as the Recovery volume, but it *won’t be restored* when restoring a Time Machine Backup in macOS Recovery. However, we can still manually restore the Nix Store volume from a Time Machine backup in macOS by using `rsync` or `tmutil restore`.

First of all, you’ll need to create the Nix Store volume and mount it to `/nix` if it isn’t ready. On the commands below, we’re using the `create-darwin-volume.sh` script taken from an PR to let nix installation support macOS 10.15, you can use whatever method suitable under the current era that does the same thing. Just note that it’s not needed to do a multi-user Nix installation, if you’ve done it before in the system, again:

```
# Create a volume for the nix store and configure it to mount at /nix.
wget https://raw.githubusercontent.com/LnL7/nix/darwin-10.15-install/scripts/create-darwin-volume.sh
bash create-darwin-volume.sh
# The following options can be enabled to disable spotlight indexing of the volume, which might be desirable.
sudo mdutil -i off /nix
# Hides the "Nix Store" disk on Desktop, need to relaunch Finder to see effect.
sudo SetFile -a V /nix
```

Then, we can use `rsync` to restore the Nix Store from our Time Machine backup. We’re not using `tmutil restore` here because `tmutil restore` can’t only restore the content within a directory to a specific destination, and will not show the progress while restoring. Note the trailing slash (`/`) after `Latest/Nix\ Store `, and we’re using `-p` (`--perms`) which restore the file permissions, and `-H` (`--hard-links`) which respect the hard link structure. You can use `--dry-run -vP` first to see what will be transferred:

```
sudo rsync -azpHt '/Volumes/[YourDriveHere]/Backups.backupdb/[YourComputerNameHere]/Latest/Nix Store/' '/nix'
```

To verify the restore, start a new terminal session and type `which nix`, you should see the correct output.

Then, start the nix-daemon manually:

```
sudo nix-daemon
```

Open another terminal session, then type:

```
nix-shell -p nix-info --run "nix-info -m" --show-trace
```

You should see the correct output:

```
$ nix-shell -p nix-info --run "nix-info -m" --show-trace
- system:
'"×86_64-darwin"
- host os: 'Darwin 19.3.0, macOS 10.15.3*
- multi-user?•
" no
- sandbox: 'no
- version:
nix-env (Nix) 2.3.3*
- channels (root) :
'"nixpkgs-20.09pre215033.ddc2f887f5f'*
- nixpkgs:
/nix/var/nix/profiles/per-user/ root/channels/nixpkgs
```

`nix-daemon` should be started correctly with `launchctl` on the next reboot, or you can start it directly by using `sudo launchctl kickstart -k system/org.nixos.nix-daemon`.

> 💡 You might want to start a fresh new Time Machine backup, by moving the original backup directory in Backups.backupdb to another place, after recovering.
