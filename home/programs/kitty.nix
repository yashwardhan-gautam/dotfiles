# Kitty terminal configuration with Catppuccin Frappe theme
# Catppuccin theme: https://github.com/catppuccin/catppuccin
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
  programs.kitty = {
    enable = true;
    font = {
      name = fontFamily;
      size = 11;
    };

    settings = {
      # Window settings
      hide_window_decorations = "yes";
      remember_window_size = "no";
      initial_window_width = "100c";
      initial_window_height = "30c";
      window_padding_width = 0;

      # Theme - Catppuccin Frappe
      background = "#303446";
      foreground = "#c6d0f5";
      cursor = "#f2d5cf";
      cursor_text_color = "#303446";
      selection_background = "#626880";
      selection_foreground = "#c6d0f5";

      # Black
      color0 = "#51576d";
      color8 = "#626880";

      # Red
      color1 = "#e78284";
      color9 = "#e78284";

      # Green
      color2 = "#a6d189";
      color10 = "#a6d189";

      # Yellow
      color3 = "#e5c890";
      color11 = "#e5c890";

      # Blue
      color4 = "#8caaee";
      color12 = "#8caaee";

      # Magenta
      color5 = "#f4b8e4";
      color13 = "#f4b8e4";

      # Cyan
      color6 = "#81c8be";
      color14 = "#81c8be";

      # White
      color7 = "#b5bfe2";
      color15 = "#a5adce";

      # Other settings
      confirm_os_window_close = 0;
    };

    keybindings = {
      # Application/Window Management
      "ctrl+shift+q" = "quit";
      "alt+f4" = "close_window";
      "ctrl+shift+n" = "new_os_window";

      # Config
      "ctrl+comma" = "edit_config_file";
      "ctrl+shift+comma" = "load_config_file";

      # Clipboard
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+insert" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "shift+insert" = "paste_from_selection";

      # Tabs
      "ctrl+shift+t" = "new_tab";
      "ctrl+w" = "close_tab";
      "ctrl+tab" = "next_tab";
      "ctrl+page_down" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";
      "ctrl+page_up" = "previous_tab";
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "alt+5" = "goto_tab 5";
      "alt+6" = "goto_tab 6";
      "alt+7" = "goto_tab 7";
      "alt+8" = "goto_tab 8";
      "alt+9" = "goto_tab 9";

      # Splits/Windows (Kitty uses windows instead of splits)
      "alt+e" = "launch --location=hsplit --cwd=current";
      "alt+v" = "launch --location=vsplit --cwd=current";
      "alt+w" = "close_window";
      "alt+k" = "neighboring_window up";
      "alt+j" = "neighboring_window down";
      "alt+h" = "neighboring_window left";
      "alt+l" = "neighboring_window right";
      "ctrl+shift+up" = "resize_window taller 3";
      "ctrl+shift+down" = "resize_window shorter 3";
      "ctrl+shift+left" = "resize_window narrower 3";
      "ctrl+shift+right" = "resize_window wider 3";
      "ctrl+shift+plus" = "resize_window reset";

      # Font Size
      "ctrl+equal" = "change_font_size all +1.0";
      "ctrl+plus" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
      "ctrl+0" = "change_font_size all 0";

      # Scrolling
      "shift+page_up" = "scroll_page_up";
      "shift+page_down" = "scroll_page_down";
      "shift+home" = "scroll_home";
      "shift+end" = "scroll_end";

      # Selection
      "ctrl+shift+a" = "select_all";

      # Other - Kitty specific features
      "ctrl+shift+page_down" = "scroll_to_prompt 1";
      "ctrl+shift+page_up" = "scroll_to_prompt -1";
      "ctrl+shift+i" = "show_kitty_env_vars";
    };
  };
}
