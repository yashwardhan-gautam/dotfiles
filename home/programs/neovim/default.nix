# Neovim configuration with Catppuccin Frappe theme
# Catppuccin theme: https://github.com/catppuccin/nvim
{...}: {
  xdg.desktopEntries.nvim = {
    name = "Neovim";
    comment = "Edit text files";
    exec = "kitty -e nvim %F";
    icon = "nvim";
    terminal = false;
    categories = ["Utility" "TextEditor"];
    mimeType = ["text/plain" "text/x-python" "text/x-tex"];
  };

  # Neovim text editor configuration
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    withNodeJs = true;
    withPython3 = true;
  };

  # Lua config
  xdg.configFile = {
    "nvim" = {
      source = ./lazyvim;
      recursive = true;
    };
  };
}
