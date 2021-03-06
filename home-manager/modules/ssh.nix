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

