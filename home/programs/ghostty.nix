{...}: {
  programs.ghostty = {
    enable = true;
    package = null; # ghostty is not in nixpkgs yet
    clearDefaultKeybinds = true;
    settings = {
      font-size = 14;
      window-decoration = "none";
      theme = "gruvbox-light";
      maximize = true;
      keybind = [
        # Application/Window Management
        "ctrl+shift+q=quit"
        "alt+f4=close_window"
        "ctrl+shift+n=new_window"
        "ctrl+enter=toggle_fullscreen"

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
        "ctrl+shift+enter=toggle_split_zoom"

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
      "gruvbox-dark" = {
        background = "282828";
        cursor-color = "ebdbb2";
        foreground = "ebdbb2";
        palette = [
          "0=#282828"
          "1=#cc241d"
          "2=#98971a"
          "3=#d79921"
          "4=#458588"
          "5=#b16286"
          "6=#689d6a"
          "7=#a89984"
          "8=#928374"
          "9=#fb4934"
          "10=#b8bb26"
          "11=#fabd2f"
          "12=#83a598"
          "13=#d3869b"
          "14=#8ec07c"
          "15=#ebdbb2"
        ];
        selection-background = "504945";
        selection-foreground = "ebdbb2";
      };
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
    };
  };
} 