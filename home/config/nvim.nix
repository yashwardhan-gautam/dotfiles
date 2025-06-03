# Neovim configuration using nvf
{ config, lib, pkgs, ... }:

{
  vim = {
    # Enable the default theme
    theme.enable = true;

    # Enable treesitter with default parsers
    treesitter.enable = true;

    # Enable LSP support
    lsp = {
      enable = true;
      
      # Enable specific language servers
      servers = {
        nil.enable = true;  # Nix language server
        lua.enable = true;  # Lua language server
      };
    };

    # Enable basic plugins
    plugins = {
      lualine.enable = true;      # Status line
      telescope.enable = true;     # Fuzzy finder
      nvim-tree.enable = true;    # File explorer
      gitsigns.enable = true;     # Git integration
      which-key.enable = true;    # Key binding helper
      comment.enable = true;      # Easy commenting
      autopairs.enable = true;    # Auto close pairs
    };

    # Custom keymaps
    keymaps = [
      {
        key = "<leader>ff";
        mode = ["n"];
        action = "<cmd>Telescope find_files<CR>";
        silent = true;
        desc = "Find files";
      }
      {
        key = "<leader>fg";
        mode = ["n"];
        action = "<cmd>Telescope live_grep<CR>";
        silent = true;
        desc = "Live grep";
      }
    ];
  };
} 