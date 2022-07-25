{ config, pkgs, lib, libs, ... }:
{
  programs.mercurial = {
    enable = true;
    userName = "USERFULLNAME";
    userEmail = "USEREMAIL";

    iniContent.extensions.fetch= "";
    ignores = [ "*~" "*.swp" ];
    extraConfig = {
        auth."risclog.prefix" = "https://repos.risclog.de/";
        auth."risclog.username" = "USERREPOSUSERNAME";
        auth."risclog.password" = "USERREPOSPASSWORD";
        changelog.filename = "CHANGES.rst";
        ui.merge = "internal:merge3";
    };
  };
}
