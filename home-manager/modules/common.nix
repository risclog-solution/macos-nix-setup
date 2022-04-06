{ config, pkgs, libs, ... }:
{

  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    ack
    zlib.dev
    zlib.out
    libjpeg.dev
    libjpeg.out
    openssl.dev
    openssl.out
    libxslt
    libffi
    libxml2
    readline
    postgresql
    file
    pre-commit
    geckodriver
    poppler_utils
    rustc
    nodePackages.grunt-cli
    mercurial
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-history-substring-search
    thefuck
    imagemagick
    gnupg
    tmux
    wget
    bat
    bottom
    fzf
    magic-wormhole
    twine
    cookiecutter
    black
    python38Packages.flake8
    sphinx

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
    virtualenv
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

  home.file.".local/bin/b".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/binaries/b";
  home.file.".local/bin/drop_testdb".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/binaries/drop_testdb.sh";
  home.file.".local/bin/clean_repo".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/binaries/clean_repo.sh";
  home.file.".local/bin/mvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/binaries/mvim";
  home.file.".local/bin/t".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/binaries/t";
  home.file.".local/bin/tf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/binaries/tf";
}
