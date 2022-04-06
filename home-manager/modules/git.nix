{ config, pkgs, lib, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Sebastian Wehrmann";
    userEmail = "sebastian@risclog.com";

    signing.key = "416EF9DA22BA2C40";

    delta = {
      enable = true;
      options = {
        side-by-side = false;
        hyperlinks = true;
        commit-decoration-style = "none";
        dark = true;
        file-added-label = "[+]";
        file-copied-label = "[C]";
        file-decoration-style = "none";
        file-modified-label = "[M]";
        file-removed-label = "[-]";
        file-renamed-label = "[R]";
        file-style = "232 bold 184";
        hunk-header-decoration-style = "none";
        hunk-header-file-style = "\"#999999\"";
        hunk-header-line-number-style = "bold \"#03a4ff\"";
        hunk-header-style = "none";
        line-numbers = true;
        line-numbers-left-style = "black";
        line-numbers-minus-style = "\"#B10036\"";
        line-numbers-plus-style = "\"#03a4ff\"";
        line-numbers-right-style = "black";
        line-numbers-zero-style = "\"#999999\"";
        minus-emph-style = "syntax bold \"#780000\"";
        minus-style = "syntax \"#400000\"";
        plus-emph-style = "syntax bold \"#007800\"";
        plus-style = "syntax \"#004000\"";
        whitespace-error-style = "\"#280050\" reverse";
        zero-style = "syntax";
        syntax-theme = "Nord";
      };
    };

    extraConfig = {
      pull.rebase = true;
      push.default = "current";

      tag.forceSignAnnotated = true;

      changelog.filename = "CHANGES.rst";
      changelog.preprocess = "lambda x: re.sub('(^.*) ?\\(([A-Z]+-[0-9]+)\\)\\.?$', r'Re \\2: \\1', x)";

      init.defaultBranch = "master";
      init.templatedir = "~/.git-templates";

      github.user = "${config.home.username}";

      core.editor = "mvim -f";
      core.fileMode = false;
      core.ignorecase = false;
      core.excludesfile = "~/.gitignore";

      alias.st = "status";
      alias.ci = "commit";
      alias.pullsrb = "!git stash save && git pull --rebase && git stash pop && echo 'Success!'";

      oh-my-zsh.hide-info = 0;

      filter.lfs.required = true;
      filter.lfs.smudge = "git-lfs smudge -- %f";
      filter.lfs.process = "git-lfs filter-process";
      filter.lfs.clean = "git-lfs clean -- %f";
    };
  };
}
