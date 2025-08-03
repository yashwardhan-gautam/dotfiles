{pkgs, ...}: {
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./mako.nix
    ./wofi.nix
    ./waybar.nix
  ];

  # Install user-specific packages for hyprland ecosystem
  home.packages = with pkgs; [
    # Core Hyprland ecosystem
    hypridle
    hyprlock
    hyprpicker
    hyprshot

    # Wayland utilities
    wl-clipboard
    wf-recorder
    slurp
    grim
    swappy
    wlr-randr
    clipse

    # System utilities
    brightnessctl
    pamixer
    playerctl
    pavucontrol

    # Cursor themes
    adwaita-icon-theme

    # Launchers and menus
    wofi

    # Wallpaper and theming
    hyprpaper
    qt5.qtwayland
    qt6.qtwayland

    # File manager
    nautilus

    # Network and system tray
    networkmanagerapplet
    # Note: blueberry is installed in home/default.nix and used in waybar

    # Authentication
    polkit_gnome

    # Waybar and dependencies
    waybar
    gobject-introspection
    lm_sensors

    # Additional utilities for omarchy setup
    hyprsunset
    wireplumber
  ];
}
