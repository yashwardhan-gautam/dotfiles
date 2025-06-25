{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Fred";
    userEmail = "fred@example.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
