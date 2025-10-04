{pkgs, inputs, ...}: {
  gtk = {
    enable = true;
    
    iconTheme = {
      name = "Tela";
      package = pkgs.callPackage ./tela-icons.nix {
        src = inputs.tela-icon-theme;
      };
    };
    
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    
    font = {
      name = "Noto Sans";
      size = 10;
    };
  };

  # QT theming
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };
}