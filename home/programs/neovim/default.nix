{...}: {
  xdg.desktopEntries.nvim = {
    name = "Neovim";
    comment = "Edit text files";
    exec = "ghostty -e nvim %F";
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

    # add extra packages if required, but make sure they don't conflict with any other declaration
    # extraPackages = with pkgs; [
    # ];
  };

  # lua config
  xdg.configFile = {
    "nvim" = {
      source = ./lazyvim;
      recursive = true;
    };
  };
}
