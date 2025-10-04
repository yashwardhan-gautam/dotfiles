{config, ...}: {
  programs.git = {
    enable = true;
    userName = config.dotfiles.full_name;
    userEmail = config.dotfiles.email_address;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
