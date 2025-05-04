{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Colorscheme
    colorschemes.tokyonight = {
      enable = true;
    };
    
    # Basic options
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      mouse = "a";
      clipboard = "unnamedplus";
      cursorline = true;
      termguicolors = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      wrap = false;
      splitbelow = true;
      splitright = true;
    };
    
    # Set space as leader key
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    
    # Keymaps
    keymaps = [
      # File Operations
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.silent = true;
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.silent = true;
      }
      {
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.silent = true;
      }
      {
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options.silent = true;
      }
      
      # Buffer Management
      {
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options.silent = true;
      }
      {
        key = "<leader>bn";
        action = "<cmd>bnext<CR>";
        options.silent = true;
      }
      {
        key = "<leader>bp";
        action = "<cmd>bprevious<CR>";
        options.silent = true;
      }
      
      # Window Management
      {
        key = "<leader>ww";
        action = "<C-w>w";
        options.silent = true;
      }
      {
        key = "<leader>wd";
        action = "<C-w>c";
        options.silent = true;
      }
      {
        key = "<leader>wv";
        action = "<C-w>v";
        options.silent = true;
      }
      {
        key = "<leader>ws";
        action = "<C-w>s";
        options.silent = true;
      }
      
      # File Explorer
      {
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<CR>";
        options.silent = true;
      }
      {
        key = "<leader>o";
        action = "<cmd>NvimTreeFocus<CR>";
        options.silent = true;
      }
      
      # LSP
      {
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.silent = true;
      }
      {
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.silent = true;
      }
      {
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.silent = true;
      }
      {
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.silent = true;
      }
      
      # Basic Operations
      {
        key = "<leader>w";
        action = ":w<CR>";
        options.silent = true;
        options.desc = "Save file";
      }
      {
        key = "<leader>q";
        action = ":q<CR>";
        options.silent = true;
        options.desc = "Quit";
      }
    ];
    
    # Plugins
    plugins = {
      # LSP Configuration
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          rust-analyzer.enable = true;
          tsserver.enable = true;
          lua-ls.enable = true;
          pyright.enable = true;
        };
      };
      
      # File Explorer
      nvim-tree = {
        enable = true;
        diagnostics = {
          enable = true;
          showOnDirs = true;
          showOnOpenDirs = true;
          debounceDelay = 50;
        };
        view = {
          width = 30;
          side = "left";
        };
        renderer = {
          highlightGit = true;
          icons = {
            show = {
              git = true;
              folder = true;
              file = true;
              folderArrow = true;
            };
          };
        };
        actions = {
          openFile = {
            quitOnOpen = true;
          };
        };
      };
      
      # Fuzzy Finder
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
        };
      };
      
      # Status Line
      lualine = {
        enable = true;
      };
      
      # Git Integration
      gitsigns = {
        enable = true;
      };
      
      # Treesitter
      treesitter = {
        enable = true;
        indent = true;
        ensureInstalled = [
          "bash"
          "c"
          "cpp"
          "json"
          "markdown"
          "python"
          "rust"
          "toml"
          "vim"
          "yaml"
        ];
      };
      
      # Autopairs
      nvim-autopairs = {
        enable = true;
      };
      
      # Comments
      comment = {
        enable = true;
      };
      
      # Which Key
      which-key = {
        enable = true;
      };
      
      # Buffer Line
      bufferline = {
        enable = true;
      };
      
      # Web Dev Icons
      web-devicons = {
        enable = true;
      };
      
      # Trouble
      trouble = {
        enable = true;
      };
      
      # Todo Comments
      todo-comments = {
        enable = true;
      };
      
      # Indent Blankline
      indent-blankline = {
        enable = true;
      };
    };
    
    # Additional Lua configuration
    extraConfigLua = ''
      -- Additional Lua configuration
      vim.opt.scrolloff = 8
      vim.opt.sidescrolloff = 8
      
      -- LazyVim-like configuration
      vim.g.autoformat = true
      vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
      
      -- Additional custom configuration can go here
    '';
  };
}