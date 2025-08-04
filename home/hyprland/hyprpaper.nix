{...}: let
  selected_wallpaper_path = "~/.config/hypr/wallpapers/macos.jpg";
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
