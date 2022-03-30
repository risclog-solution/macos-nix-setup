{ config, pkgs, lib, libs, ... }:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "mercurial" "macos" "thefuck" ];
      theme = "robbyrussell";
      extraConfig = ''
        # Load seperated config files
        for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
          source "''${conf}"
        done
        unset conf
      '';
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
  };
}

