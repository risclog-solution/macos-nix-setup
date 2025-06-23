{ config, pkgs, libs, lib, nixpkgs, ... }:
{

  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [

  ];
  nixpkgs.config.allowUnsupportedSystem = true;

  home.packages = with pkgs; [
    gnused.out
    zopfli.dev
    gitleaks
    tmate
    ack
    act
    xz
    mkcert
    gettext
    lazygit
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
    libxcrypt
    libargon2
    tesseract
    # mailsend  # currently not supported under M1
    haskellPackages.cryptohash-sha256
    libxml2
    readline
    postgresql_14.dev
    file
    ruby
    binutils
    jdk17.out
    coreutils
    ghostscript
    geckodriver
    poppler_utils
    qpdf
    texlive.combined.scheme-full
    swig
    zoxide
    imagemagick
    liberation_ttf
    rustc
    inetutils.out
    nodePackages.grunt-cli
    # mercurial
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
    python310Packages.pipx
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

    watchman

    yarn
    neovim
    python39
    python310
    python311
    python312Full
    jq
    cloc
    docker
    docker-compose
    # Nix VSC
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
  home.file.".local/bin/update_nix".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/update_nix";
  home.file.".local/bin/pdftk".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/pdftk";
  home.file.".git-templates/hooks/prepare-commit-msg".source = config.lib.file.mkOutOfStoreSymlink "/opt/nixpkgs/binaries/prepare-commit-msg";
  home.file.".local/bin/wkhtmltopdf".source = config.lib.file.mkOutOfStoreSymlink "/nix/store/f6si5zpzfz9rba23j2pz8jg0pzj5zjxa-wkhtmltopdf-0.12.6-2/bin/wkhtmltopdf";
}
