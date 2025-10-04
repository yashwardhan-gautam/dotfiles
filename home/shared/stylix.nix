{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  # Theme selection - change this to switch themes
  selectedTheme = "gruvbox-dark-hard"; # or "gruvbox-light"
  
  themeConfig = {
    gruvbox-dark-hard = {
      scheme = ./colors/gruvbox-dark-hard.yml;
      polarity = "dark";
    };
    gruvbox-light = {
      scheme = ./colors/gruvbox-light.yml;
      polarity = "light";
    };
  };
  
  currentTheme = themeConfig.${selectedTheme};
in {
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = currentTheme.polarity;
    
    # Enhanced opacity settings
    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 0.95;
    };

    # Enhanced font configuration
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      
      # Font sizes
      sizes = {
        applications = 11;
        terminal = 13;
        desktop = 10;
        popups = 10;
      };
    };

    # Dynamic theme selection
    base16Scheme = currentTheme.scheme;

    # Enhanced application targets (only supported ones)
    targets = {
      # Terminal applications
      bat.enable = true;
      fish.enable = true;
      starship.enable = true;
      yazi.enable = true;
      
      # Desktop applications
      ghostty.enable = true;
      nixos-icons.enable = true;
      
      # Communication
      vesktop.enable = true;
      
      # Desktop environment
      gtk.enable = true;
      gnome.enable = true;
      
      # Window manager (disabled to avoid conflicts with existing config)
      # hyprland.enable = true;
      hyprpaper.enable = true;
      
      # Media
      mpv.enable = true;
    };

    # Cursor configuration
    cursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };
  };
  
  # Create a theme switcher script
  home.packages = with pkgs; [
    (writeShellScriptBin "theme-switch" ''
      #!/usr/bin/env bash
      
      DOTFILES_DIR="$HOME/dotfiles"
      STYLIX_FILE="$DOTFILES_DIR/home/shared/stylix.nix"
      
      case "$1" in
        "dark"|"gruvbox-dark-hard")
          echo "Switching to Gruvbox Dark Hard theme..."
          sed -i 's/selectedTheme = "[^"]*"/selectedTheme = "gruvbox-dark-hard"/' "$STYLIX_FILE"
          ;;
        "light"|"gruvbox-light")
          echo "Switching to Gruvbox Light theme..."
          sed -i 's/selectedTheme = "[^"]*"/selectedTheme = "gruvbox-light"/' "$STYLIX_FILE"
          ;;
        *)
          echo "Usage: theme-switch [dark|light]"
          echo "Current theme: ${selectedTheme}"
          exit 1
          ;;
      esac
      
      echo "Theme switched. Rebuilding home-manager configuration..."
      cd "$DOTFILES_DIR" && home-manager switch --flake .#unalome
    '')
  ];
}