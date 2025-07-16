{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # Import Hyprland home-manager module
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./waybar.nix
  ];

  # Install user-specific packages
  home.packages = with pkgs; [
    # Core Hyprland ecosystem
    hypridle
    hyprlock
    hyprpicker

    # Wayland utilities
    wl-clipboard
    wf-recorder
    slurp
    grim
    swappy
    wlr-randr

    # System utilities
    brightnessctl
    pamixer
    playerctl
    pavucontrol

    # Launchers and menus
    rofi-wayland
    wofi

    # Wallpaper and theming
    swww
    qt5.qtwayland
    qt6.qtwayland

    # Notifications
    dunst
    libnotify

    # File manager
    nautilus

    # Network and system tray
    networkmanagerapplet
    blueman

    # Authentication
    polkit_gnome

    # Clipboard tools
    cliphist

    # Development tools (user-specific)
    lazygit
    fzf
    ripgrep
    fd
    btop
    htop
    zoxide
    tree-sitter

    # Applications
    firefox
    obsidian
    code-cursor
    telegram-desktop
    gemini-cli

    # Terminal utilities
    ghostty
    tmux
    fish
    starship

    # Waybar and dependencies
    waybar
    gobject-introspection
    (python3.withPackages (ps: with ps; [ pygobject3 ]))
    lm_sensors
  ];

  # Configure Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };



  # Copy configuration files
  home.file = {
    ".config/hypr/keybindings.conf".source = ./keybindings.conf;
    ".config/hypr/monitors.conf".source = ./monitors.conf;
    ".config/hypr/userprefs.conf".source = ./userprefs.conf;
    ".config/hypr/animations.conf".source = ./animations.conf;
    ".config/hypr/windowrules.conf".source = ./windowrules.conf;
    ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;

    # Scripts directory
    ".config/hypr/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };

    # Wallpapers
    ".config/hypr/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
  };

  # Services
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 380;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  # XDG user directories
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
    };
  };
}
