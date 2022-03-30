sh <(curl -L https://nixos.org/nix/install)
nix-env -iA nixpkgs.nixFlakes
nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager
nix-channel --update
NIX_PATH="/Users/sweh/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels" nix-shell '<home-manager>' -A install
home-manager switch --flake .#swehmbp2021


darwin-rebuild switch --show-trace
