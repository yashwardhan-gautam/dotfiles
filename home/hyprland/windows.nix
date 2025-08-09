{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      "suppressevent maximize, class:.*"

      # Force chromium into a tile to deal with --app bug
      "tile, class:^(chromium)$"

      # Settings management
      "float, class:^(org.pulseaudio.pavucontrol|blueberry.py)$"

      # Fullscreen RetroArch
      "fullscreen, class:^(com.libretro.RetroArch)$"

      # All windows fully opaque (no transparency)
      "opacity 1 1, class:.*"

      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      # Float in the middle for clipse clipboard manager
      "float, class:^(clipse)$"
      "size 622 652, class:^(clipse)$"
      "stayfocused, class:^(clipse)$"
      # Fallback on window title when class is not set
      "float, title:^(clipse)$"
      "size 622 652, title:^(clipse)$"
      "stayfocused, title:^(clipse)$"
    ];

    layerrule = [
      # Proper background blur for wofi
      "blur,wofi"
      "blur,waybar"
    ];
  };
} 
