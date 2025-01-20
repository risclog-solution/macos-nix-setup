# Based on https://github.com/nix-community/home-manager#nix-flakes
{
  description = "Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nix-darwin, home-manager, ... } @ inputs: {
    darwinConfigurations."HOSTNAME" = nix-darwin.lib.darwinSystem {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      modules = [ ./darwin-configuration.nix ];
    };
    homeConfigurations = {
      rlmbp2025 = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [
          ./home-manager/modules/home-manager.nix
          ./home-manager/modules/common.nix
          ./home-manager/modules/git.nix
          ./home-manager/modules/ssh.nix
          ./home-manager/modules/zsh.nix
          ./home-manager/mac.nix
          {
            home = {
              username = "USERNAME";
              homeDirectory = "/Users/USERNAME";
              stateVersion = "24.11";
            };
          }
        ];
      };

    };
  };
}

