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
              IgnoreUnknown = "UseKeyChain,AddKeysToAgent,IdentityFile";
              UseKeychain = "yes";
              AddKeysToAgent = "yes";
              IdentityFile = "~/.ssh/id_rsa";
              PubkeyAcceptedKeyTypes = "+ssh-rsa";
            };
        };
        "flyingcircus-jump-host" = {
            hostname = "rldev.fcio.net";
            user = "${config.home.username}";
        };
        "*.fcio.net" = {
            proxyJump = "flyingcircus-jump-host";
        };
        "*.gocept.net" = {
            proxyJump = "flyingcircus-jump-host";
        };
        "kravag* clx* claimx* mci* risclog* rlservices* rliam*" = {
            proxyJump = "flyingcircus-jump-host";
        };
        "rldev.fcio.net" = {
            proxyJump = "none";
        };
    };
  };
}
