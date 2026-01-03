{ pkgs, ... }: {
  # Enable XDG base directories
  xdg.enable = true;

  # Configure XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config.common = {
      default = ["gtk"];
    };
  };

  # Enable dconf for GTK applications
  dconf.enable = true;
}
