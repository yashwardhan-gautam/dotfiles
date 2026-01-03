{lib, ...}: {
  options.dotfiles = {
    # Font Settings
    primary_font = lib.mkOption {
      type = lib.types.str;
      default = "JetBrainsMono Nerd Font 11";
      description = "Primary font used across applications (e.g., kitty terminal)";
    };

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
    primary_font = "JetBrainsMono Nerd Font 14";
    full_name = "yashwardhan-gautam";
    email_address = "gautamyashwardhan@gmail.com";
  };
}
