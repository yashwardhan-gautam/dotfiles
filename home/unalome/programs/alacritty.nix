{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.9;
        decorations = "buttonless";
      };
      font = {
        size = 12;
        family = "JetBrains Mono";
      };
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
      };
    };
  };
}
