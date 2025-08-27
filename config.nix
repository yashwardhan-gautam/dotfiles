{lib, ...}: {
  options.dotfiles = {
    # Display & UI Settings
    primary_font = lib.mkOption {
      type = lib.types.str;
      default = "JetBrainsMono Nerd Font 11";
      description = "Primary font used across applications";
    };

    scale = lib.mkOption {
      type = lib.types.int;
      default = 1;
      description = "Display scale factor (1 for 1x displays, 2 for 2x displays)";
    };

    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [",preferred,auto,1.0"];
      description = "Monitor configuration strings for Hyprland";
      example = ["DP-1,2560x1440@144,0x0,1" "HDMI-A-1,1920x1080@60,2560x0,1"];
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
}