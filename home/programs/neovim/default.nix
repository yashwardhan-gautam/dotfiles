{pkgs, ...}: {
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
    package = pkgs.neovim-unwrapped;
    defaultEditor = false;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      # Formatters
      alejandra # Nix code formatter
      black # Python code formatter
      isort # Python import sorter
      nodePackages.prettier # Formatter for web languages
      shfmt # Shell script formatter
      stylua # Lua code formatter

      # Linters
      golangci-lint # Go linter
      hadolint # Dockerfile linter
      ruff # Fast Python linter
      shellcheck # Shell script linter
      tflint # Terraform linter

      # Language Servers
      gopls # Go language server
      lua-language-server # Lua language server
      nixd # Nix language server
      # nodePackages.bash-language-server # Bash language server
      pyright # Python language server and type checker
      terraform-ls # Terraform language server
      yaml-language-server # YAML language server
      cmake-language-server # CMake language server

      gdb
      gtest
      gbenchmark

      # Other
      cmake # build tools
      gotools # Go tools
      nerd-fonts.jetbrains-mono # Font with icons for symbols
    ];
  };

  # lua config
  xdg.configFile = {
    "nvim" = {
      source = ./lazyvim;
      recursive = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk # GTK portal
    ];
  };
}
