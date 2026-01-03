# Neovim configuration with Catppuccin Frappe theme
# Catppuccin theme: https://github.com/catppuccin/nvim
{pkgs, ...}: {
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

  # Neovim-related packages: LSPs, formatters, linters, tree-sitter
  home.packages = with pkgs; [
    # Lua (for neovim config)
    lua5_1
    luajitPackages.luarocks
    lua-language-server
    stylua

    # Tree-sitter
    tree-sitter

    # Formatters
    alejandra # Nix
    nodePackages.prettier # JS/TS/JSON/etc
    shfmt # Shell

    # Linters
    golangci-lint # Go
    hadolint # Dockerfile
    shellcheck # Shell
    tflint # Terraform

    # Language Servers
    gopls # Go
    nixd # Nix
    pyright # Python
    terraform-ls # Terraform
    yaml-language-server # YAML
    cmake-language-server # CMake
  ];

  # Lua config
  xdg.configFile = {
    "nvim" = {
      source = ./lazyvim;
      recursive = true;
    };
  };
}
