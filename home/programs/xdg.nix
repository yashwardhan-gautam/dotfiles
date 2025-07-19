{ pkgs, lib, ... }:

{
  # Enable XDG base directories
  xdg.enable = true;

  # Configure XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland # Wayland portal
      xdg-desktop-portal-gtk # GTK portal
    ];
    
    config.common = {
      default = ["hyprland" "gtk"];
    };
  };

  # Enable dconf for GTK applications
  dconf.enable = true;
}