{pkgs, inputs, lib, config, ...}: let
  # Using Adwaita icon theme instead of Tela
  iconVariant = if config.stylix.polarity == "light" then "Adwaita" else "Adwaita-dark";
  
  # Dynamic GTK theme based on Stylix polarity  
  gtkThemeName = if config.stylix.polarity == "light" then "Adwaita" else "Adwaita-dark";
  
in {
  # GTK Configuration
  gtk = {
    enable = true;
    
    # Tela Icon Theme with dynamic variant selection
    iconTheme = {
      name = iconVariant;
      package = pkgs.adwaita-icon-theme;
    };
    
    # Dynamic GTK theme selection (let Stylix handle this)
    # theme = {
    #   name = gtkThemeName;
    #   package = pkgs.gnome-themes-extra;
    # };
    
    # Cursor theme
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
    
    # Font configuration (will be overridden by Stylix)
    font = {
      name = "Noto Sans";
      size = 11;
    };
    
    # GTK3 settings
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = config.stylix.polarity == "dark";
      gtk-recent-files-limit = 20;
      gtk-enable-animations = true;
    };
    
    # GTK4 settings
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = config.stylix.polarity == "dark";
      gtk-recent-files-limit = 20;
      gtk-enable-animations = true;
    };
  };

  # Qt theming with dynamic selection
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = if config.stylix.polarity == "light" then "adwaita" else "adwaita-dark";
  };
  
  # XDG configuration for icon theme
  xdg.configFile = {
    # Ensure proper icon theme configuration
    "gtk-3.0/settings.ini".text = lib.generators.toINI {} {
      Settings = {
        gtk-icon-theme-name = iconVariant;
        gtk-theme-name = gtkThemeName;
        gtk-cursor-theme-name = "Adwaita";
        gtk-cursor-theme-size = 24;
        gtk-font-name = "Noto Sans 11";
        gtk-application-prefer-dark-theme = config.stylix.polarity == "dark";
        gtk-enable-animations = true;
      };
    };
    
    "gtk-4.0/settings.ini".text = lib.generators.toINI {} {
      Settings = {
        gtk-icon-theme-name = iconVariant;
        gtk-theme-name = gtkThemeName;
        gtk-cursor-theme-name = "Adwaita";
        gtk-cursor-theme-size = 24;
        gtk-font-name = "Noto Sans 11";
        gtk-application-prefer-dark-theme = config.stylix.polarity == "dark";
        gtk-enable-animations = true;
      };
    };
  };

  # Ensure icon themes are available
  home.packages = [
    pkgs.adwaita-icon-theme
    pkgs.gnome-themes-extra
  ];
  
  # Environment variables for proper theming
  home.sessionVariables = {
    # GTK theme variables
    GTK_THEME = gtkThemeName;
    
    # Icon theme
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}