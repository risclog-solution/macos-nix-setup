{ config, pkgs, lib, libs, ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {
        "*" = {
            forwardAgent = true;
            serverAliveInterval = 15;
            serverAliveCountMax = 3;
            extraOptions = {
              1PASSWORD_SSH_AGENT_CONFIG
              strictHostKeyChecking = "no";
              VisualHostKey = "yes";
              IgnoreUnknown = "UseKeyChain,AddKeysToAgent,IdentityFile";
              UseKeychain = "yes";
              AddKeysToAgent = "yes";
              IdentityFile = "~/.ssh/id_ed25519";
              PubkeyAcceptedKeyTypes = "+ssh-rsa";
            };
        };
        "flyingcircus-jump-host" = {
            hostname = "dev.risclog.net";
            user = "${config.home.username}";
        };
        "*.fcio.net" = {
            proxyJump = "flyingcircus-jump-host";
        };
        "*.gocept.net" = {
            proxyJump = "flyingcircus-jump-host";
        };
        "kravag* clx* claimx* mci* risclog* rlservices* gha*" = {
            proxyJump = "flyingcircus-jump-host";
        };
        "dev.risclog.net" = {
            proxyJump = "none";
        };
    };
  };
}
