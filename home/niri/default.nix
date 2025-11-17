{pkgs, ...}: {
  imports = [
    ./config.nix
  ];

  # Install Niri-specific packages
  home.packages = with pkgs; [
    # Wayland utilities
    wl-clipboard
    cliphist
    wf-recorder
    slurp
    grim
    swappy
    
    # System utilities
    brightnessctl
    pamixer
    playerctl
    pavucontrol
    
    # Application launcher
    wofi
    fuzzel
    
    # Portals
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    
    # Cursor themes
    adwaita-icon-theme
    
    # Qt Wayland support
    qt5.qtwayland
    qt6.qtwayland
    
    # Network and system tray
    networkmanagerapplet
    
    # File manager
    xfce.thunar
    
    # Additional utilities
    wireplumber
  ];
}

