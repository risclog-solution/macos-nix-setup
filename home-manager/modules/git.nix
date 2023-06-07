{ config, pkgs, lib, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "USERFULLNAME";
    userEmail = "USEREMAIL";

    signing.key = "SIGNINGKEY";

    delta = {
      enable = false;
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
      push.autoSetupRemote = true;

      tag.forceSignAnnotated = true;

      changelog.filename = "CHANGES.rst";
      changelog.preprocess = "lambda x: ' '.join([l.strip() for l in x.splitlines() if l.strip()]).replace('https://redmine.risclog.de/issues/', '#').split(': ', 1)[1]"

      init.defaultBranch = "master";
      init.templatedir = "~/.git-templates";

      github.user = "${config.home.username}";

      core.editor = "mvim -f";
      core.fileMode = false;
      core.ignorecase = false;
      core.excludesfile = "~/.gitignore";

      alias.st = "status";
      alias.ci = "commit";
      alias.co = "checkout";
      alias.pullsrb = "!git stash save && git pull --rebase && git stash pop && echo 'Success!'";
      alias.b = "branch";
      alias.ba = "branch -a";
      alias.d = "diff";
      alias.dc = "diff --cached";
      alias.fp = "format-patch";
      alias.g = "!git gui &";
      alias.gr = "log --graph";
      alias.go = "log --graph --pretty=oneline --abbrev-commit";
      alias.k = "!gitk &";
      alias.ka = "!gitk --all &";
      alias.lc = "log ORIG_HEAD.. --stat --no-merges";
      alias.lp = "log --patch-with-stat";
      alias.mnf = "merge --no-ff";
      alias.mnff = "merge --no-ff";
      alias.mt = "mergetool";
      alias.p = "format-patch -1";
      alias.serve = "!git daemon --reuseaddr --verbose  --base-path=. --export-all ./.git";
      alias.sra = "svn rebase --all";
      alias.sh = "!git-sh";
      alias.stm = "status --untracked=no";
      alias.stfu = "status --untracked=no";
      alias.runs = "!f() { watch_gha_runs \"$(git remote get-url origin)\" \"$(git rev-parse --abbrev-ref HEAD)\"; }; f";

      oh-my-zsh.hide-info = 0;

      filter.lfs.required = true;
      filter.lfs.smudge = "git-lfs smudge -- %f";
      filter.lfs.process = "git-lfs filter-process";
      filter.lfs.clean = "git-lfs clean -- %f";
    };
  };
}
