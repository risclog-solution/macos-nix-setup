{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
        pkgs.vim
        pkgs.nginx
        pkgs.postgresql_14
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  launchd.daemons.nginx = {
    command = "${pkgs.nginx}/bin/nginx -p /etc/nginx/tmp -c /etc/nginx/nginx.conf";
    path = [pkgs.nginx];
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
      UserName = "root";
    };
  };

  launchd.user.agents.postgresql_14 = {
    command = "${pkgs.postgresql_14}/bin/postgres -D /etc/postgres/data";
    path = [pkgs.postgresql_14];
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
    };
  };

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
