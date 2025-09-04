{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    # Input configuration
    input = lib.mkDefault {
      kb_layout = "us";
      kb_options = "compose:caps";

      follow_mouse = 1;

      sensitivity = 0.25; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        clickfinger_behavior = false;
        middle_button_emulation = false;
        tap-to-click = true;
        drag_lock = false;
        tap-and-drag = true;
      };
    };

    # Gestures are configured in gestures.nix using Hyprland's native gesture system
  };
}
