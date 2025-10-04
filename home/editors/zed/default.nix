{pkgs, ...}: {
  home.packages = with pkgs; [
    zed-editor
  ];

  # Zed configuration
  xdg.configFile."zed/settings.json".text = ''
    {
      "theme": "Gruvbox Dark Hard",
      "buffer_font_family": "JetBrainsMono Nerd Font",
      "buffer_font_size": 14,
      "ui_font_family": "Noto Sans",
      "ui_font_size": 12,
      "autosave": "on_focus_change",
      "format_on_save": "on",
      "show_whitespaces": "selection",
      "vim_mode": true,
      "soft_wrap": "editor_width",
      "tab_size": 2,
      "hard_tabs": false,
      "remove_trailing_whitespace_on_save": true,
      "ensure_final_newline_on_save": true,
      "preferred_line_length": 100,
      "git": {
        "inline_blame": {
          "enabled": true
        }
      },
      "terminal": {
        "shell": {
          "program": "fish"
        }
      },
      "lsp": {
        "rust-analyzer": {
          "initialization_options": {
            "checkOnSave": {
              "command": "clippy"
            }
          }
        }
      }
    }
  '';
}