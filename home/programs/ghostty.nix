{...}: {
  # Ghostty terminal configuration with Catppuccin Frappe theme
  # Note: No home-manager module yet, using xdg.configFile directly
  xdg.configFile."ghostty/config".text = ''
    # Font Configuration
    font-family = JetBrainsMono Nerd Font
    font-size = 11.2

    # Window Settings
    window-decoration = false
    window-padding-x = 0
    window-padding-y = 0
    confirm-close-surface = false

    # Theme - Catppuccin Frappe
    background = 303446
    foreground = c6d0f5
    cursor-color = f2d5cf
    cursor-text = 303446
    selection-background = 626880
    selection-foreground = c6d0f5

    # Black
    palette = 0=#51576d
    palette = 8=#626880

    # Red
    palette = 1=#e78284
    palette = 9=#e78284

    # Green
    palette = 2=#a6d189
    palette = 10=#a6d189

    # Yellow
    palette = 3=#e5c890
    palette = 11=#e5c890

    # Blue
    palette = 4=#8caaee
    palette = 12=#8caaee

    # Magenta
    palette = 5=#f4b8e4
    palette = 13=#f4b8e4

    # Cyan
    palette = 6=#81c8be
    palette = 14=#81c8be

    # White
    palette = 7=#b5bfe2
    palette = 15=#a5adce

    # ===== Keybindings =====

    # Application/Window Management
    keybind = ctrl+shift+q=quit
    keybind = alt+f4=close_surface
    keybind = ctrl+shift+n=new_window

    # Clipboard
    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+insert=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard
    keybind = shift+insert=paste_from_clipboard

    # Tabs
    keybind = ctrl+shift+t=new_tab
    keybind = ctrl+w=close_surface
    keybind = ctrl+tab=next_tab
    keybind = ctrl+page_down=next_tab
    keybind = ctrl+shift+tab=previous_tab
    keybind = ctrl+page_up=previous_tab
    keybind = alt+one=goto_tab:1
    keybind = alt+two=goto_tab:2
    keybind = alt+three=goto_tab:3
    keybind = alt+four=goto_tab:4
    keybind = alt+five=goto_tab:5
    keybind = alt+six=goto_tab:6
    keybind = alt+seven=goto_tab:7
    keybind = alt+eight=goto_tab:8
    keybind = alt+nine=goto_tab:9

    # Splits
    keybind = alt+e=new_split:right
    keybind = alt+v=new_split:down
    keybind = alt+w=close_surface
    keybind = alt+k=goto_split:top
    keybind = alt+j=goto_split:bottom
    keybind = alt+h=goto_split:left
    keybind = alt+l=goto_split:right
    keybind = ctrl+shift+up=resize_split:up,30
    keybind = ctrl+shift+down=resize_split:down,30
    keybind = ctrl+shift+left=resize_split:left,30
    keybind = ctrl+shift+right=resize_split:right,30
    keybind = ctrl+shift+plus=equalize_splits

    # Font Size
    keybind = ctrl+equal=increase_font_size:1
    keybind = ctrl+plus=increase_font_size:1
    keybind = ctrl+minus=decrease_font_size:1
    keybind = ctrl+zero=reset_font_size

    # Scrolling
    keybind = shift+page_up=scroll_page_up
    keybind = shift+page_down=scroll_page_down
    keybind = shift+home=scroll_to_top
    keybind = shift+end=scroll_to_bottom

    # Selection
    keybind = ctrl+shift+a=select_all
  '';
}

