{
  inputs,
  pkgs,
  ...
}: {
  # Install libinput-gestures for touchpad gesture support
  home.packages = with pkgs; [
    libinput-gestures
  ];

  # Create libinput-gestures config
  xdg.configFile."libinput-gestures.conf".text = ''
    # Touchpad gestures for Hyprland
    gesture swipe left 3 hyprctl dispatch workspace +1
    gesture swipe right 3 hyprctl dispatch workspace -1
    gesture swipe up 3 hyprctl dispatch fullscreen
    gesture swipe down 3 hyprctl dispatch killactive
    
    # 4-finger gestures
    gesture swipe up 4 hyprctl dispatch movewindow u
    gesture swipe down 4 hyprctl dispatch movewindow d
    gesture swipe left 4 hyprctl dispatch togglefloating
    gesture swipe right 4 hyprctl dispatch togglespecialworkspace magic
  '';

  # Enable libinput-gestures service
  systemd.user.services.libinput-gestures = {
    Unit = {
      Description = "Libinput Gestures";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.default
    ];

    settings = {
      plugin = {
        touch_gestures = {
          # The default sensitivity is probably too low on tablet screens,
          # I recommend turning it up to 4.0
          sensitivity = 1.0;

          # must be >= 3
          workspace_swipe_fingers = 3;

          # switching workspaces by swiping from an edge, this is separate from workspace_swipe_fingers
          # and can be used at the same time
          # possible values: l, r, u, or d
          # to disable it set it to anything else
          workspace_swipe_edge = "d";

          # in milliseconds
          long_press_delay = 400;

          # resize windows by long-pressing on window borders and gaps.
          # If general:resize_on_border is enabled, general:extend_border_grab_area is used for floating
          # windows
          resize_on_border_long_press = true;

          # in pixels, the distance from the edge that is considered an edge
          edge_margin = 10;

          # emulates touchpad swipes when swiping in a direction that does not trigger workspace swipe.
          # ONLY triggers when finger count is equal to workspace_swipe_fingers
          #
          # might be removed in the future in favor of event hooks
          emulate_touchpad_swipe = false;

          experimental = {
            # send proper cancel events to windows instead of hacky touch_up events,
            # NOT recommended as it crashed a few times, once it's stabilized I'll make it the default
            send_cancel = 0;
          };

          # Custom gesture bindings using hyprgrass-bind (inside plugin section)
          hyprgrass-bind = [
            # 3-finger swipe gestures for workspace management
            ", swipe:3:l, workspace, +1"
            ", swipe:3:r, workspace, -1"
            ", swipe:3:u, fullscreen"
            ", swipe:3:d, killactive"

            # 4-finger gestures for advanced window management
            ", swipe:4:u, movewindow, u"
            ", swipe:4:d, movewindow, d"
            ", swipe:4:l, togglefloating"
            ", swipe:4:r, togglespecialworkspace, magic"

            # Edge swipes
            ", edge:r:l, workspace, +1"
            ", edge:l:r, workspace, -1"
            ", edge:d:u, exec, wofi --show drun --sort-order=alphabetical"
            ", edge:u:d, exec, hyprlock"

            # Tap gestures
            ", tap:3, exec, hyprpicker -a"
            ", tap:4, exec, hyprshot -m region"
          ];

          # Mouse bindings for long press gestures
          hyprgrass-bindm = [
            ", longpress:2, movewindow"
            ", longpress:3, resizewindow"
          ];
        };
      };
    };
  };
}
