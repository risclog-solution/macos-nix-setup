{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
        pkgs.vim
        pkgs.nginx
        pkgs.postgresql_14
        pkgs.redis
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  launchd.daemons.nginx = {
    command = "${pkgs.nginx}/bin/nginx -p /etc/local/nginx/tmp -c /etc/local/nginx/nginx.conf";
    path = [pkgs.nginx];
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
      UserName = "root";
    };
  };

  launchd.user.agents.postgresql_14 = {
    command = "${pkgs.postgresql_14}/bin/postgres -D /etc/local/postgres/data";
    path = [pkgs.postgresql_14];
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
    };
  };

  launchd.user.agents.redis = {
    command = "${pkgs.redis}/bin/redis-server /etc/local/redis/redis.conf";
    path = [pkgs.redis];
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
