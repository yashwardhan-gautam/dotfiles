{
  config,
  pkgs,
  ...
}: let
  # Default to tokyo-night wallpaper
  selected_wallpaper_path = "~/.config/hypr/wallpapers/tokyo-night.jpg";
in {
  # Copy wallpapers to the config directory
  home.file = {
    ".config/hypr/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
  };
  
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        selected_wallpaper_path
      ];
      wallpaper = [
        ",${selected_wallpaper_path}"
      ];
    };
  };
} 