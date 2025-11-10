{...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Core services
      "hypridle"
      "mako"
      "systemctl --user start hyprpolkitagent"
      "wl-clipboard --clipboard regular"
      "wl-clip-persist --clipboard regular"
      "clipse -listen"

      # Screen shaders
      "hyprshade on vibrance"

      # Authentication
      "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"

      # Clipboard history
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"

      # Ensure audio is unmuted on startup
      "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"
    ];

    exec = [
      # Restart waybar on config changes
      "pkill -SIGUSR2 waybar || waybar"
    ];
  };
}
