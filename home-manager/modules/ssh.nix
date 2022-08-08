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
              identityAgent = "\"${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
              strictHostKeyChecking = "no";
              IgnoreUnknown = "UseKeyChain,AddKeysToAgent,IdentityFile";
              UseKeychain = "yes";
              AddKeysToAgent = "yes";
              IdentityFile = "~/.ssh/id_rsa";
            };
        };
        "flyingcircus-jump-host" = {
            hostname = "clxstagc00.fe.rzob.fcio.net";
            user = "${config.home.username}";
        };
        "*.fcio.net" = {
            proxyJump = "flyingcircus-jump-host";
        };
        "*.gocept.net" = {
            proxyJump = "flyingcircus-jump-host";
        };
        "kravag* clx* claimx* risclog* rlservices*" = {
            proxyJump = "flyingcircus-jump-host";
        };
        "rldev.fcio.net" = {
            proxyJump = "none";
        };
    };
  };
}

