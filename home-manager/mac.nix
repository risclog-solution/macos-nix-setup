{ config, lib, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "20.09";

  # http://czyzykowski.com/posts/gnupg-nix-osx.html
  # adds file to `~/.nix-profile/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac`
  home.packages = with pkgs; [
    pinentry_mac

    nodejs

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/default.nix
    # nerdfonts
  ];

  # TODO
  # https://aregsar.com/blog/2020/turn-on-key-repeat-for-macos-text-editors/
  # automate `defaults write com.google.chrome ApplePressAndHoldEnabled -bool false`

  programs.git.signing.signByDefault = true;

  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs:
    {
      python312 = pkgs.python312.overrideAttrs (attrs:
        pkgs.lib.attrsets.recursiveUpdate attrs { meta.priority = 30; });
      python310 = pkgs.python310.overrideAttrs (attrs:
        pkgs.lib.attrsets.recursiveUpdate attrs { meta.priority = 50; });
      python39 = pkgs.python39.overrideAttrs (attrs:
        pkgs.lib.attrsets.recursiveUpdate attrs { meta.priority = 70; });
      python38 = pkgs.python38.overrideAttrs (attrs:
        pkgs.lib.attrsets.recursiveUpdate attrs { meta.priority = 100; });
    };

}
