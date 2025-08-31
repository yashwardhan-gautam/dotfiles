# Ghostty terminal configuration with Gruvbox Light theme
# Gruvbox theme: https://github.com/morhetz/gruvbox
{
  config,
  lib,
  ...
}: let
  # Extract font size from primary_font (e.g., "JetBrainsMono Nerd Font 11" -> 11)
  fontSize = lib.toInt (lib.last (lib.splitString " " config.dotfiles.primary_font));
  # Extract font family from primary_font (e.g., "JetBrainsMono Nerd Font 11" -> "JetBrainsMono Nerd Font")
  fontFamily = lib.removeSuffix " ${toString fontSize}" config.dotfiles.primary_font;
in {
  programs.ghostty = {
    enable = true;
    package = null; # ghostty is not in nixpkgs yet
    clearDefaultKeybinds = true;
    settings = {
      font-family = fontFamily;
      font-size = 13.5;
      window-decoration = "none";
      theme = "gruvbox-light";
      maximize = true;
      keybind = [
        # Application/Window Management
        "ctrl+shift+q=quit"
        "alt+f4=close_window"
        "ctrl+shift+n=new_window"

        # Config
        "ctrl+comma=open_config"
        "ctrl+shift+comma=reload_config"

        # Clipboard
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+insert=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "shift+insert=paste_from_selection"

        # Tabs
        "ctrl+shift+t=new_tab"
        "ctrl+w=close_tab"
        "ctrl+tab=next_tab"
        "ctrl+page_down=next_tab"
        "ctrl+shift+right=next_tab"
        "ctrl+shift+tab=previous_tab"
        "ctrl+page_up=previous_tab"
        "ctrl+shift+left=previous_tab"
        "alt+one=goto_tab:1"
        "alt+two=goto_tab:2"
        "alt+three=goto_tab:3"
        "alt+four=goto_tab:4"
        "alt+five=goto_tab:5"
        "alt+six=goto_tab:6"
        "alt+seven=goto_tab:7"
        "alt+eight=goto_tab:8"
        "alt+nine=last_tab"

        # Splits
        "alt+e=new_split:down"
        "alt+v=new_split:right"
        "alt+w=close_surface"
        "alt+k=goto_split:up"
        "alt+j=goto_split:down"
        "alt+h=goto_split:left"
        "alt+l=goto_split:right"
        "ctrl+shift+up=resize_split:up,10"
        "ctrl+shift+down=resize_split:down,10"
        "ctrl+shift+left=resize_split:left,10"
        "ctrl+shift+right=resize_split:right,10"
        "ctrl+shift+plus=equalize_splits"

        # Font Size
        "ctrl+equal=increase_font_size:1"
        "ctrl+plus=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+zero=reset_font_size"

        # Scrolling
        "shift+page_up=scroll_page_up"
        "shift+page_down=scroll_page_down"
        "shift+home=scroll_to_top"
        "shift+end=scroll_to_bottom"

        # Selection
        "ctrl+shift+a=select_all"
        # "shift+up=adjust_selection:up"
        # "shift+down=adjust_selection:down"
        # "shift+left=adjust_selection:left"
        # "shift+right=adjust_selection:right"

        # Other
        "ctrl+shift+page_down=jump_to_prompt:1"
        "ctrl+shift+page_up=jump_to_prompt:-1"
        "ctrl+alt+shift+j=write_screen_file:open"
        "ctrl+shift+j=write_screen_file:paste"
        "ctrl+shift+i=inspector:toggle"
      ];
    };
    themes = {
      # Gruvbox Light theme - Retro groove color scheme
      # https://github.com/morhetz/gruvbox
      "gruvbox-light" = {
        background = "fbf1c7";
        cursor-color = "d65d0e";
        foreground = "3c3836";
        palette = [
          "0=#fbf1c7"
          "1=#cc241d"
          "2=#98971a"
          "3=#d79921"
          "4=#458588"
          "5=#b16286"
          "6=#689d6a"
          "7=#3c3836"
          "8=#7c6f64"
          "9=#9d0006"
          "10=#79740e"
          "11=#b57614"
          "12=#076678"
          "13=#8f3f71"
          "14=#427b58"
          "15=#3c3836"
        ];
        selection-background = "7c6f64";
        selection-foreground = "fbf1c7";
      };
      kanagawa = {
        background = "1f1f28";
        cursor-color = "ff9e3b";
        foreground = "dcd7ba";
        palette = [
          "0=#16161d"
          "1=#e82424"
          "2=#76946a"
          "3=#ff9e3b"
          "4=#7e9cd8"
          "5=#957fb8"
          "6=#6a9589"
          "7=#dcd7ba"
          "8=#727169"
          "9=#ff5d62"
          "10=#98bb6c"
          "11=#e6c384"
          "12=#7fb4ca"
          "13=#d27e99"
          "14=#7aa89f"
          "15=#c8c093"
        ];
        selection-background = "223249";
        selection-foreground = "dcd7ba";
      };
      catppuccin-mocha = {
        background = "1e1e2e";
        cursor-color = "f5e0dc";
        foreground = "cdd6f4";
        palette = [
          "0=#45475a"
          "1=#f38ba8"
          "2=#a6e3a1"
          "3=#f9e2af"
          "4=#89b4fa"
          "5=#f5c2e7"
          "6=#94e2d5"
          "7=#bac2de"
          "8=#585b70"
          "9=#f38ba8"
          "10=#a6e3a1"
          "11=#f9e2af"
          "12=#89b4fa"
          "13=#f5c2e7"
          "14=#94e2d5"
          "15=#a6adc8"
        ];
        selection-background = "353749";
        selection-foreground = "cdd6f4";
      };
      catppuccin-latte = {
        background = "eff1f5";
        cursor-color = "dc8a78";
        foreground = "4c4f69";
        palette = [
          "0=#5c5f77"
          "1=#d20f39"
          "2=#40a02b"
          "3=#df8e1d"
          "4=#1e66f5"
          "5=#ea76cb"
          "6=#179299"
          "7=#bcc0cc"
          "8=#6c6f85"
          "9=#d20f39"
          "10=#40a02b"
          "11=#df8e1d"
          "12=#1e66f5"
          "13=#ea76cb"
          "14=#179299"
          "15=#acb0be"
        ];
        selection-background = "acb0be";
        selection-foreground = "4c4f69";
      };
      tokyonight-moon = {
        background = "222436";
        cursor-color = "7fd9ea";
        foreground = "c8d3f5";
        palette = [
          "0=#444b6a"
          "1=#ff7a93"
          "2=#b9f27c"
          "3=#ffda7b"
          "4=#7fd9ea"
          "5=#ea9a97"
          "6=#7fd9ea"
          "7=#c8d3f5"
          "8=#545c7e"
          "9=#ff7a93"
          "10=#b9f27c"
          "11=#ffda7b"
          "12=#7fd9ea"
          "13=#ea9a97"
          "14=#7fd9ea"
          "15=#c8d3f5"
        ];
        selection-background = "3b4261";
        selection-foreground = "c8d3f5";
      };
    };
  };
}
