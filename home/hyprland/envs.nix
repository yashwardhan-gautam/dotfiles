{...}: {
  wayland.windowManager.hyprland.settings = {
    # Environment variables
    env = [
      # Cursor size
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"

      # Cursor theme
      "XCURSOR_THEME,Adwaita"
      "HYPRCURSOR_THEME,Adwaita"

      # Force all apps to use Wayland
      "GDK_BACKEND,wayland"
      "QT_QPA_PLATFORM,wayland"
      "QT_STYLE_OVERRIDE,kvantum"
      "SDL_VIDEODRIVER,wayland"
      "MOZ_ENABLE_WAYLAND,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      "OZONE_PLATFORM,wayland"

      # Make Chromium use all Wayland
      "CHROMIUM_FLAGS,\"--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4\""

      # Make .desktop files available for wofi
      "XDG_DATA_DIRS,$XDG_DATA_DIRS:$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share"

      # Use XCompose file
      "XCOMPOSEFILE,~/.XCompose"
      "EDITOR,nvim"

      # GTK theme - default to light
      "GTK_THEME,Adwaita"

      # Default apps
      "TERMINAL,kitty"
      "BROWSER,zen-twilight"

      # Hyprshot save directory
      "HYPRSHOT_DIR,~/Pictures/Screenshots"

      # Locale settings to fix UTF-8 issues for all applications including btop
      "LC_ALL,en_US.UTF-8"
      "LANG,en_US.UTF-8"
      "LC_CTYPE,en_US.UTF-8"
    ];

    xwayland = {
      force_zero_scaling = true;
    };

    # Don't show update on first launch
    ecosystem = {
      no_update_news = true;
    };
  };
}
