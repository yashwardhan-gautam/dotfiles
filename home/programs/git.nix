{config, ...}: {
  programs.git = {
    enable = true;
    
    settings = {
      user = {
        name = config.dotfiles.full_name;
        email = config.dotfiles.email_address;
      };
      
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
