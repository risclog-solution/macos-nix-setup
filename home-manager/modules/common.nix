{ config, pkgs, libs, ... }:
{

  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    age
    pwgen
    glib
    gnused.out
    zopfli.dev
    tmate
    ack
    act
    xz
    dogdns
    step-cli
    mkcert
    gettext
    lazygit
    nss.tools
    cocoapods
    zlib.dev
    zlib.out
    libjpeg.dev
    libjpeg.out
    openssl.dev
    openssl.out
    libxslt
    libffi.dev
    libffi.out
    libxcrypt
    libargon2
    # mailsend  # currently not supported under M1
    haskellPackages.cryptohash-sha256
    libxml2
    readline
    postgresql_14
    file
    pre-commit
    ruby
    binutils
    jdk17.out
    coreutils
    ghostscript
    geckodriver
    poppler_utils
    qpdf
    pdftk
    texlive.combined.scheme-full
    swig
    zoxide
    imagemagick7
    liberation_ttf
    rustc
    inetutils.out
    nodePackages.grunt-cli
    mercurial
    zsh
    ctags
    oh-my-zsh
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-history-substring-search
    thefuck
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
    python39Packages.flake8
    python39Packages.pipx
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
    watchman

    yarn
    neovim
    virtualenv
    python38
    python39
    python310
    python311
        # python312
    jq
    go
    cloc
    docker
    docker-compose
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

  home.file.".local/bin/b".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/b";
  home.file.".local/bin/drop_testdb".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/drop_testdb.sh";
  home.file.".local/bin/clean_repo".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/clean_repo.sh";
  home.file.".local/bin/restart_nginx".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/restart_nginx.sh";
  home.file.".local/bin/mvim".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/mvim";
  home.file.".local/bin/t".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/t";
  home.file.".local/bin/tf".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/tf";
  home.file.".git-templates/hooks/prepare-commit-msg".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/prepare-commit-msg";
}
