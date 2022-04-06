# Based on https://github.com/nix-community/home-manager#nix-flakes
{
  description = "Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    homeConfigurations = {
      rlmbp2022 = inputs.home-manager.lib.homeManagerConfiguration {
        system = "aarch64-darwin";
        homeDirectory = "/Users/sweh";
        username = "sweh";
        configuration.imports = [
          ./home-manager/modules/home-manager.nix
          ./home-manager/modules/fish.nix
          ./home-manager/modules/common.nix
          ./home-manager/modules/git.nix
          ./home-manager/modules/zsh.nix
          ./home-manager/mac.nix
        ];
      };

    };
  };
}

