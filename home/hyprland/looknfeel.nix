{...}: let
  # Default Tokyo Night colors
  inactiveBorder = "rgba(414868b3)"; # 0.7 alpha = b3 in hex
  activeBorder = "rgba(7aa2f7b3)"; # 0.7 alpha = b3 in hex
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 0;
      gaps_out = 0;

      border_size = 1;

      "col.active_border" = activeBorder;
      "col.inactive_border" = inactiveBorder;

      resize_on_border = true;

      allow_tearing = false;

      layout = "master";
    };

    decoration = {
      rounding = 4;

      shadow = {
        enabled = false;
        range = 30;
        render_power = 3;
        ignore_window = true;
        color = "rgba(00000045)";
      };

      blur = {
        enabled = true;
        size = 5;
        passes = 2;

        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];

      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 0, 0, ease"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
      force_split = 2;
    };

    master = {
      new_status = "master";
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };
  };
}
