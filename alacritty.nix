{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        live_config_reload = true;
      };
      env = {
        TERM = "xterm-256color";
      };
      window = {
        dimensions = {
          columns = 133;
          lines = 40;
        };
        decorations = "buttonless";
        dynamic_padding = true;
        padding = {
          x = 1;
          y = 3;
        };
      };
      font = {
        size = 12.5;
      };
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        cursor = {
          text = "#1e1e2e";
          cursor = "#f5e0dc";
        };
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        bright = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#a6adc8";
        };
      };
    };
  };
} 