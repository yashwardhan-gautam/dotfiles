{pkgs, ...}: {
  # Install libinput-gestures for reliable touchpad gesture support
  home.packages = with pkgs; [
    libinput-gestures
  ];

  # Create libinput-gestures config for instant, no-animation gestures
  xdg.configFile."libinput-gestures.conf".text = ''
    # 3-finger touchpad gestures - instant execution, no animations
    gesture swipe left 3 hyprctl dispatch workspace +1
    gesture swipe right 3 hyprctl dispatch workspace -1
    gesture swipe up 3 hyprctl dispatch fullscreen
    gesture swipe down 4 hyprctl dispatch killactive
  '';

  # Enable libinput-gestures service
  systemd.user.services.libinput-gestures = {
    Unit = {
      Description = "Libinput Gestures";
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  wayland.windowManager.hyprland.settings = {
    # Disable workspace animations for instant gesture response
    animation = [
      "workspaces, 0" # No workspace switch animations
      "specialWorkspace, 0" # No special workspace animations
    ];
  };
}
