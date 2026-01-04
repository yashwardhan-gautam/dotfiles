# GTK 3/4 Configuration with Catppuccin Frappe theme
# Catppuccin theme: https://github.com/catppuccin/gtk
# Font managed by DankMaterialShell - matches fontFamily in DMS settings.json
{pkgs, ...}: {
  # GTK Configuration
  gtk = {
    enable = true;

    # Theme
    theme = {
      name = "catppuccin-frappe-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        variant = "frappe";
      };
    };

    # Icon Theme
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # Cursor Theme (macOS-style)
    cursorTheme = {
      name = "macOS-BigSur";
      package = pkgs.apple-cursor;
      size = 24;
    };

    # Font Configuration - matches DMS fontFamily
    font = {
      name = "Inter Variable"; # Matches DMS fontFamily
      size = 11;
    };

    # GTK3 specific settings
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    # GTK4 specific settings
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };

  # Qt Configuration (for Qt apps to follow GTK theme)
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
      package = pkgs.catppuccin-kvantum.override {
        accent = "blue";
        variant = "frappe";
      };
    };
  };

  # Kvantum theme configuration
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=catppuccin-frappe-blue
  '';

  # Set cursor theme for Wayland (macOS-style)
  home.pointerCursor = {
    name = "macOS-BigSur";
    package = pkgs.apple-cursor;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}

