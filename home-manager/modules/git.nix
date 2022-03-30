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
        syntax-theme = "Solarized (dark)";
        minus-style = "#fdf6e3 #dc322f";
        plus-style = "#fdf6e3 #859900";
        side-by-side = false;
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

      github.user = "sweh";
      github.token = "57bf71b45b03c1ee9347e7caf894a8ce";

      core.editor = "mvim -f";
      core.fileMode = false;
      core.ignorecase = false;
      core.excludesfile = "~/.gitignore";

      alias.st = "status";
      alias.ci = "commit";

      commit.gpgsign = true;
    };
  };
}
