{lib, ...}: {
  options.dotfiles = {
    # User Information
    full_name = lib.mkOption {
      type = lib.types.str;
      default = "unalome";
      description = "Full name for git and other applications";
    };

    email_address = lib.mkOption {
      type = lib.types.str;
      default = "user@example.com";
      description = "Email address for git and other applications";
    };
  };

  # User Configuration - Edit these values to customize your dotfiles
  config.dotfiles = {
    full_name = "yashwardhan-gautam";
    email_address = "gautamyashwardhan@gmail.com";
  };
}
