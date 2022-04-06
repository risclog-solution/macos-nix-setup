Setup development environment for Mac using Nix
===============================================

Clone this repository into your home directory under `~/.nixpkgs`.

Open `flake.nix` and change `homeDirectory` and `username` to your needs.

Open `home-manager/modules/git.nix` and change `userName`, `userEmail` and
`signing.key` to your needs.

Run the following commands inside `~/.nixpkgs`::

    sh <(curl -L https://nixos.org/nix/install)
    nix-env -iA nixpkgs.nixFlakes
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager
    nix-channel --update
    NIX_PATH="~/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels" nix-shell '<home-manager>' -A install
    home-manager switch --flake .#rlmbp2022
    darwin-rebuild switch --show-trace
