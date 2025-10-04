{config, pkgs, lib, ...}: {
  # Application-specific theming configurations
  
  # Zed Editor theming
  xdg.configFile."zed/settings.json" = let
    zedTheme = if config.stylix.polarity == "light" 
      then "Gruvbox Light" 
      else "Gruvbox Dark Hard";
  in {
    text = lib.generators.toJSON {} {
      theme = zedTheme;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 14;
      ui_font_family = "Noto Sans";
      ui_font_size = 12;
    };
  };
  
  # Cursor Editor theming
  xdg.configFile."Cursor/User/settings.json" = let
    cursorTheme = if config.stylix.polarity == "light"
      then "Gruvbox Light"
      else "Gruvbox Dark Hard";
  in {
    text = lib.generators.toJSON {} {
      "workbench.colorTheme" = cursorTheme;
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
      "editor.fontSize" = 14;
      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
      "workbench.iconTheme" = "material-icon-theme";
    };
  };
  
  # Chromium theming
  programs.chromium = lib.mkIf config.programs.chromium.enable {
    commandLineArgs = [
      # Force dark mode based on theme
      (if config.stylix.polarity == "dark" 
       then "--force-dark-mode" 
       else "--disable-dark-mode")
      
      # Use system theme
      "--use-system-theme"
      
      # GTK theme integration
      "--gtk-version=4"
    ];
  };
  
  # Waybar theming (disabled to avoid conflicts - let existing waybar config handle styling)
  # programs.waybar = lib.mkIf (config.programs.waybar.enable or false) {
  #   style = ''
  #     * {
  #       font-family: "${config.stylix.fonts.sansSerif.name}";
  #       font-size: ${toString config.stylix.fonts.sizes.applications}px;
  #     }
  #   '';
  # };
  
  # Mako notification styling (disabled to avoid conflicts with existing config)
  # services.mako = lib.mkIf (config.services.mako.enable or false) {
  #   # Let existing mako configuration handle styling
  # };
  
  # Hyprland theming integration (disabled to avoid conflicts - Stylix handles this)
  # wayland.windowManager.hyprland = lib.mkIf (config.wayland.windowManager.hyprland.enable or false) {
  #   settings = {
  #     # Let existing Hyprland configuration and Stylix handle theming
  #   };
  # };
}