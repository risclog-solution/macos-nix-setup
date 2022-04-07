{ config, pkgs, lib, libs, ... }:
{
  programs.mercurial = {
    enable = true;
    userName = "Sebastian Wehrmann";
    userEmail = "sebastian@risclog.com";

    iniContent.extensions.fetch= "";
    ignores = [ "*~" "*.swp" ];
    extraConfig = {
        auth."risclog.prefix" = "https://repos.risclog.de/";
        auth."risclog.username" = "${config.home.username}";
        auth."risclog.password" = "XXXXXXX";
        changelog.filename = "CHANGES.rst";
        ui.merge = "internal:merge3";
    };
  };
}
