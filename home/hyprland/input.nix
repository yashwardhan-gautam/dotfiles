{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    # Input configuration
    input = lib.mkDefault {
      kb_layout = "us";
      kb_options = "compose:caps";

      follow_mouse = 1;

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
        natural_scroll = true;
      };
    };

    # Gestures configuration
    gestures = lib.mkDefault {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
    };
  };
}
