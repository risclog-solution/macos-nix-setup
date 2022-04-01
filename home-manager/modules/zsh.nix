{ config, pkgs, lib, libs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      v = "open -a MacVim $argv";
      gig = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(bold black)%s%C(reset) %C(black)- %an%C(reset)' --all";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "mercurial" "macos" "thefuck" ];
      theme = "robbyrussell";
      extraConfig = ''
        export LANG=de_DE.UTF-8
        export PATH=/Users/sweh/.local/bin:$PATH

        if [[ -n $SSH_CONNECTION ]]; then
          export EDITOR='vim'
        else
          export EDITOR='mvim -f'
        fi

        # Load seperated config files
        for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
          source "''${conf}"
        done
        unset conf

        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down
        bindkey '^[[A' history-substring-search-up

        export LDFLAGS="-L/Users/sweh/.nix-profile/lib"
        export CFLAGS="-I/Users/sweh/.nix-profile/include"
      '';
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };
}

