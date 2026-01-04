{...}: {
  # Niri window manager configuration
  # DankMaterialShell handles: launcher, lock screen, notifications, 
  # brightness, media controls, clipboard, screenshots, etc.

  # Environment variables for Wayland compatibility
  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Niri config file (window management only - DMS handles desktop features)
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };
}
