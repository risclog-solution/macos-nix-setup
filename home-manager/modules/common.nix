{ config, pkgs, libs, ... }:
{

  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    ack
    geckodriver
    #imagemagick
    #nginx
    #postgresql_14
    #redis
    gnupg
    tmux
    wget
    bat
    bottom
    fzf

    # Requires a patched font
    # https://github.com/ryanoasis/nerd-fonts/blob/master/readme.md#patched-fonts
    lsd
    tree
    # better du alternative
    du-dust
    awscli
    graphviz
    git-crypt

    youtube-dl

    yarn
    neovim
    python27
    python37
    python38
    python39
    jq
    go
    cloc
    docker
    # docker-compose
    # Nix VSC
    rnix-lsp
    nixpkgs-fmt
    # github cli
    gitAndTools.gh
    # needed for headless chrome
    # chromium
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  programs.dircolors = {
    enable = true;
  };

}
