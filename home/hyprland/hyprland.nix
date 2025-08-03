{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [./configuration.nix];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  services.hyprpolkitagent.enable = true;
} 