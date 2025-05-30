{ config, pkgs, ... }:

{
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    hardware = {
      opengl.enable = true;
      nvidia.modesetting.enable = true;
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      kitty # switch to alacritty later 
      libnotify
      mako
      qt5.qtwayland
      qt6.qtwayland
      swayidle
      swaylock-effects
      wlogout
      wl-clipboard
      wofi
      waybar
    ];
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
}