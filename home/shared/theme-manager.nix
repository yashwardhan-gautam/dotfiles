{pkgs, lib, config, ...}: {
  # Advanced theme management tools
  home.packages = with pkgs; [
    # Theme switching script (enhanced)
    (writeShellScriptBin "theme-switch" ''
      #!/usr/bin/env bash
      
      DOTFILES_DIR="$HOME/dotfiles"
      STYLIX_FILE="$DOTFILES_DIR/home/shared/stylix.nix"
      
      show_help() {
        echo "Theme Switcher for NixOS Dotfiles"
        echo ""
        echo "Usage: theme-switch [COMMAND] [OPTIONS]"
        echo ""
        echo "Commands:"
        echo "  dark, d          Switch to Gruvbox Dark Hard theme"
        echo "  light, l         Switch to Gruvbox Light theme"
        echo "  status, s        Show current theme"
        echo "  list             List available themes"
        echo "  help, h          Show this help message"
        echo ""
        echo "Options:"
        echo "  --dry-run        Show what would be changed without applying"
        echo "  --no-rebuild     Only update config, don't rebuild"
        echo ""
      }
      
      get_current_theme() {
        grep 'selectedTheme = ' "$STYLIX_FILE" | sed 's/.*selectedTheme = "\([^"]*\)".*/\1/'
      }
      
      switch_theme() {
        local theme="$1"
        local dry_run="$2"
        local no_rebuild="$3"
        
        if [ "$dry_run" = "true" ]; then
          echo "Would switch to theme: $theme"
          echo "Would update file: $STYLIX_FILE"
          return 0
        fi
        
        echo "Switching to $theme theme..."
        
        # Create backup
        cp "$STYLIX_FILE" "$STYLIX_FILE.backup.$(date +%s)"
        
        # Update theme
        sed -i "s/selectedTheme = \"[^\"]*\"/selectedTheme = \"$theme\"/" "$STYLIX_FILE"
        
        if [ "$no_rebuild" != "true" ]; then
          echo "Rebuilding home-manager configuration..."
          cd "$DOTFILES_DIR" || exit 1
          
          if home-manager switch --flake .#unalome; then
            echo "✅ Theme switched successfully to $theme"
            echo "🔄 Please restart applications to see full theme changes"
          else
            echo "❌ Failed to rebuild configuration"
            echo "🔄 Restoring backup..."
            mv "$STYLIX_FILE.backup."* "$STYLIX_FILE"
            exit 1
          fi
        else
          echo "✅ Theme configuration updated to $theme"
          echo "🔄 Run 'home-manager switch --flake .#unalome' to apply changes"
        fi
      }
      
      # Parse arguments
      dry_run="false"
      no_rebuild="false"
      
      while [[ $# -gt 0 ]]; do
        case $1 in
          --dry-run)
            dry_run="true"
            shift
            ;;
          --no-rebuild)
            no_rebuild="true"
            shift
            ;;
          dark|d)
            switch_theme "gruvbox-dark-hard" "$dry_run" "$no_rebuild"
            exit 0
            ;;
          light|l)
            switch_theme "gruvbox-light" "$dry_run" "$no_rebuild"
            exit 0
            ;;
          status|s)
            current=$(get_current_theme)
            echo "Current theme: $current"
            case $current in
              gruvbox-dark-hard)
                echo "🌙 Dark theme (Gruvbox Dark Hard)"
                ;;
              gruvbox-light)
                echo "☀️  Light theme (Gruvbox Light)"
                ;;
              *)
                echo "❓ Unknown theme"
                ;;
            esac
            exit 0
            ;;
          list)
            echo "Available themes:"
            echo "  gruvbox-dark-hard  🌙 Dark theme with high contrast"
            echo "  gruvbox-light      ☀️  Light theme for daylight use"
            exit 0
            ;;
          help|h|--help)
            show_help
            exit 0
            ;;
          *)
            echo "Unknown option: $1"
            echo "Use 'theme-switch help' for usage information"
            exit 1
            ;;
        esac
      done
      
      # No arguments provided
      current=$(get_current_theme)
      echo "Current theme: $current"
      echo "Use 'theme-switch help' for usage information"
    '')
    
    # Icon theme browser
    (writeShellScriptBin "icon-browser" ''
      #!/usr/bin/env bash
      
      echo "🎨 Tela Icon Theme Browser"
      echo "=========================="
      
      ICON_DIR="$HOME/.nix-profile/share/icons"
      
      if [ ! -d "$ICON_DIR" ]; then
        echo "❌ Icon directory not found: $ICON_DIR"
        exit 1
      fi
      
      echo "Available Tela icon themes:"
      find "$ICON_DIR" -maxdepth 1 -name "Tela*" -type d | sort | while read -r theme_dir; do
        theme_name=$(basename "$theme_dir")
        echo "  📁 $theme_name"
        
        # Show some sample icons if they exist
        if [ -d "$theme_dir/48x48/apps" ]; then
          icon_count=$(find "$theme_dir/48x48/apps" -name "*.svg" | wc -l)
          echo "     └─ Apps: $icon_count icons"
        fi
      done
      
      echo ""
      echo "Current icon theme: $(gsettings get org.gnome.desktop.interface icon-theme 2>/dev/null || echo 'Unknown')"
      echo ""
      echo "To preview icons, try: gtk-launch icon-browser (if available)"
    '')
    
    # Theme status widget
    (writeShellScriptBin "theme-status" ''
      #!/usr/bin/env bash
      
      # Get current theme
      current_theme=$(grep 'selectedTheme = ' "$HOME/dotfiles/home/shared/stylix.nix" | sed 's/.*selectedTheme = "\([^"]*\)".*/\1/')
      
      case "$current_theme" in
        gruvbox-dark-hard)
          echo "🌙"
          ;;
        gruvbox-light)
          echo "☀️"
          ;;
        *)
          echo "❓"
          ;;
      esac
    '')
  ];
  
  # Desktop entry for theme switcher
  xdg.desktopEntries.theme-switcher = {
    name = "Theme Switcher";
    comment = "Switch between light and dark themes";
    exec = "theme-switch";
    icon = "preferences-desktop-theme";
    terminal = true;
    categories = ["Settings" "DesktopSettings"];
  };
}