{lib, config, ...}: {
  imports = [
    ./autostart.nix
    ./bindings.nix
    ./envs.nix
    ./input.nix
    ./looknfeel.nix
    ./windows.nix
  ];
  wayland.windowManager.hyprland.settings = {
    # Default applications
    "$terminal" = lib.mkDefault "ghostty";
    "$fileManager" = lib.mkDefault "$terminal -e yazi";
    "$browser" = lib.mkDefault "brave";
    "$music" = lib.mkDefault "spotify";
    "$passwordManager" = lib.mkDefault "1password";
    "$messenger" = lib.mkDefault "signal-desktop";
    "$webapp" = lib.mkDefault "$browser --app";

    # Monitor configuration using dotfiles.monitors option
    monitor = config.dotfiles.monitors;
  };
}
