{
  config,
  pkgs,
  lib,
  ...
}: let
  # Default to tokyo-night wallpaper if no wallpaper selector is available
  selected_wallpaper_path = "~/.config/hypr/wallpapers/tokyo-night.jpg";
  
  # Default color scheme (can be overridden by colorScheme if available)
  backgroundRgb = "rgba(26, 27, 38, 0.8)";
  surfaceRgb = "rgb(40, 42, 54)";  
  foregroundRgb = "rgb(248, 248, 242)";
  foregroundMutedRgb = "rgb(98, 114, 164)";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        no_fade_in = false;
      };
      auth = {
        fingerprint.enabled = true;
      };
      background = {
        monitor = "";
        path = selected_wallpaper_path;
        # blur_passes = 3;
        # brightness = 0.5;
      };

      input-field = {
        monitor = "";
        size = "600, 100";
        position = "0, 0";
        halign = "center";
        valign = "center";

        inner_color = surfaceRgb;
        outer_color = foregroundRgb;
        outline_thickness = 4;

        font_family = "CaskaydiaMono Nerd Font";
        font_size = 32;
        font_color = foregroundRgb;

        placeholder_color = foregroundMutedRgb;
        placeholder_text = "  Enter Password 󰈷 ";
        check_color = "rgba(131, 192, 146, 1.0)";
        fail_text = "Wrong";

        rounding = 0;
        shadow_passes = 0;
        fade_on_empty = false;
      };

      label = {
        monitor = "";
        text = "\$FPRINTPROMPT";
        text_align = "center";
        color = "rgb(211, 198, 170)";
        font_size = 24;
        font_family = "CaskaydiaMono Nerd Font";
        position = "0, -100";
        halign = "center";
        valign = "center";
      };
    };
  };
} 