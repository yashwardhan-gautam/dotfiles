{...}: {
  programs.git = {
    enable = true;
    userName = "yashwardhna-gautam";
    userEmail = "gautamyashwardhan@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
