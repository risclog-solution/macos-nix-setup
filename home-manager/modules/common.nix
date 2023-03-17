{ config, pkgs, libs, ... }:
{

  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    ack
    gdb
    act
    xz
    mkcert
    gettext
    nss.tools
    zlib.dev
    zlib.out
    libjpeg.dev
    libjpeg.out
    openssl.dev
    openssl.out
    libxslt
    libffi.dev
    libffi.out
    # mailsend  # currently not supported under M1
    haskellPackages.cryptohash-sha256
    libxml2
    readline
    postgresql_14
    file
    pre-commit
    ruby
    binutils
    openjdk11
    coreutils
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
    python38Packages.flake8
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
    python27
    virtualenv
    python37
    python38
    python39
    python310
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

  home.file.".local/bin/b".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/b";
  home.file.".local/bin/drop_testdb".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/drop_testdb.sh";
  home.file.".local/bin/clean_repo".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/clean_repo.sh";
  home.file.".local/bin/restart_nginx".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/restart_nginx.sh";
  home.file.".local/bin/mvim".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/mvim";
  home.file.".local/bin/t".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/t";
  home.file.".local/bin/tf".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/tf";
}
