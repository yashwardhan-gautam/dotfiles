{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../config.nix
    ../user-config.nix
    ./programs/default.nix
    ./hyprland
    inputs.zen-browser.homeModules.twilight
  ];

  # Home Manager basic settings
  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "25.11";

  # Basic packages
  home.packages = with pkgs; [
    # --- Programming Languages & Runtimes ---
    nodejs # JavaScript runtime
    rustc # Rust compiler
    go # Go programming language
    lua5_1 # Lua programming language

    # --- Package Managers & Build Tools ---
    cargo # Rust package manager
    luajitPackages.luarocks # LuaRocks package manager for LuaJIT
    gnumake # GNU Make utility

    # --- C/C++ Development Tools ---
    cmake # Cross-platform build system
    ninja # Small build system
    gcc15 # GNU C/C++ compiler
    # clang # C/C++/Objective-C compiler
    clang-tools # Clang development tools (e.g., clang-format, clang-tidy)
    cmake-lint
    pkg-config # Helper for compiling against installed libraries
    gtest # Google Test framework for C++
    gbenchmark # Google Benchmark library for C++
    codespell # Check for common misspellings in code
    cppcheck # Static analysis tool for C/C++ code
    doxygen # Documentation system for C++, C, Java, Objective-C, Python, IDL, Fortran, VHDL, PHP, C#, and D
    gdb # GNU Debugger for C/C++
    gotools # Go tools (e.g., gofmt, govet)

    # --- Python Development Tools ---
    (python312.withPackages (ps:
      with ps; [
        pip # Python package installer
        black # Python code formatter
        isort # Python import sorter
        ruff # An extremely fast Python linter and formatter
        pygobject3 # Python bindings for GObject
      ]))

    # --- Lua Specific Tools ---
    lua-language-server # Language server for Lua (related to home/programs/neovim/lazyvim/lua/plugins/lsp.lua)
    stylua # Lua code formatter (related to home/programs/neovim/lazyvim/lua/plugins/none-ls.lua)

    # --- System Utilities & CLI Tools ---
    tree # List contents of directories in a tree-like format
    eza # Modern replacement for `ls`
    bat # `cat` clone with syntax highlighting and Git integration
    fd # A simple, fast and user-friendly alternative to 'find'
    ripgrep # A line-oriented search tool that recursively searches the current directory for a regex pattern
    fzf # A command-line fuzzy finder
    file # Required by Yazi for file type detection
    jq # JSON preview
    poppler # PDF preview utilities
    resvg # SVG preview
    imagemagick # Font, HEIC, JPEG XL preview
    p7zip # Archive extraction and preview
    xclip # Command line interface to X selections (clipboard)
    wl-clipboard # Clipboard support on Wayland
    wl-color-picker
    wget # Non-interactive network downloader
    curl # Tool for transferring data with URL syntax
    fastfetch # Fast system information tool
    zoxide # A smarter cd command
    chafa # ASCII image fallback (optional)
    ueberzugpp # Image preview helper (optional)

    # --- Version Control ---
    git # Distributed version control system
    lazygit # A simple terminal UI for git commands

    # --- Browsers ---
    brave # Alternative browser
    chromium # Alternative browser for web apps

    # --- Bluetooth Management (alternatives) ---
    blueberry # Alternative Bluetooth configuration tool
    qbittorrent
    discord
    gnome-boxes
    yt-dlp

    # --- Media Tools ---
    vlc
    ffmpeg # Complete, cross-platform solution to record, convert and stream audio and video

    # --- Other Applications ---
    qalculate-gtk # Powerful and versatile desktop calculator
    gimp # GNU Image Manipulation Program
    code-cursor # (Assuming this is a specific application, if not, it might need clarification)
    telegram-desktop # Official Telegram Desktop client
    opencode

    # --- Shells & Terminal Utilities ---
    ghostty # A GPU-accelerated terminal emulator (related to home/programs/ghostty.nix)
    fish # User-friendly command line shell (related to home/programs/fish.nix)
    starship # The minimal, blazing-fast, and infinitely customizable prompt for any shell (related to home/programs/starship.nix)

    # --- Language Servers & Linters (General/Misc) ---
    tree-sitter # Parser generator tool and an incremental parsing library (related to home/programs/neovim/lazyvim/lua/plugins/treesitter.lua)
    alejandra # Nix code formatter (related to home/programs/neovim/lazyvim/lua/plugins/none-ls.lua)
    nodePackages.prettier # Opinionated code formatter for various languages (related to home/programs/neovim/lazyvim/lua/plugins/none-ls.lua)
    shfmt # Shell script formatter (related to home/programs/neovim/lazyvim/lua/plugins/none-ls.lua)
    golangci-lint # Fast Go linters runner (related to home/programs/neovim/lazyvim/lua/plugins/none-ls.lua)
    hadolint # Dockerfile linter (related to home/programs/neovim/lazyvim/lua/plugins/none-ls.lua)
    shellcheck # Shell script static analysis tool
    tflint # Terraform linter (related to home/programs/neovim/lazyvim/lua/plugins/lsp.lua, home/programs/neovim/lazyvim/lua/plugins/none-ls.lua)
    gopls # Go language server (related to home/programs/neovim/lazyvim/lua/plugins/lsp.lua)
    nixd # Nix language server (related to home/programs/neovim/lazyvim/lua/plugins/lsp.lua)
    pyright # Pyright language server for Python (related to home/programs/neovim/lazyvim/lua/plugins/lsp.lua)
    terraform-ls # Terraform language server (related to home/programs/neovim/lazyvim/lua/plugins/lsp.lua, home/programs/neovim/lazyvim/lua/plugins/none-ls.lua)
    yaml-language-server # YAML language server (related to home/programs/neovim/lazyvim/lua/plugins/lsp.lua)
    cmake-language-server # CMake language server (related to home/programs/neovim/lazyvim/lua/plugins/lsp.lua)

    # --- System Services/Daemons ---
    redis # In-memory data structure store

    # --- Fonts ---
    nerd-fonts.jetbrains-mono # JetBrains Mono Nerd Font

    # --- Desktop Integration ---
    xdg-desktop-portal-gtk # GTK portal for XDG desktop (related to home/programs/neovim/default.nix, home/programs/xdg.nix)
  ];

  programs.home-manager.enable = true;

  # Desktop entries
  xdg.desktopEntries.zen-browser = {
    name = "Zen Browser";
    comment = "A privacy-focused web browser";
    exec = "zen-browser %U";
    icon = "zen-browser";
    terminal = false;
    categories = ["Network" "WebBrowser"];
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "application/xml"
      "application/rss+xml"
      "application/rdf+xml"
      "image/gif"
      "image/jpeg"
      "image/png"
      "image/webp"
      "video/webm"
      "video/ogg"
      "audio/ogg"
      "audio/mpeg"
      "audio/x-mpegurl"
      "video/mp4"
      "video/x-m4v"
      "audio/mp4"
      "application/ogg"
      "application/x-ogg"
    ];
  };

  # Zen Browser configuration
  programs.zen-browser = {
    enable = true;
    profiles."default" = {
      # Basic configuration without complex theme for now
      spaces = {
        "Default" = {
          id = "00000000-0000-0000-0000-000000000000";
          position = 1000;
        };
      };
    };
  };
}
