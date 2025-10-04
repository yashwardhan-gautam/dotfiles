{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./editors
    ./terminal
    ./software
    ./services
    ./shared
    ../config.nix
    ../user-config.nix
    inputs.nix-index-db.homeModules.nix-index
    inputs.stylix.homeModules.stylix
  ];

  home = {
    username = "unalome";
    homeDirectory = "/home/unalome";
    stateVersion = "25.11";
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;

  programs.nix-index = {
    enable = true;
  };

  # Basic packages (preserved from original with some additions)
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
    clang-tools # Clang development tools
    cmake-lint
    pkg-config # Helper for compiling against installed libraries
    gtest # Google Test framework for C++
    gbenchmark # Google Benchmark library for C++
    codespell # Check for common misspellings in code
    cppcheck # Static analysis tool for C/C++ code
    doxygen # Documentation system
    gdb # GNU Debugger for C/C++
    gotools # Go tools

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
    lua-language-server # Language server for Lua
    stylua # Lua code formatter

    # --- System Utilities & CLI Tools ---
    tree # List contents of directories in a tree-like format
    eza # Modern replacement for `ls`
    bat # `cat` clone with syntax highlighting
    fd # A simple, fast and user-friendly alternative to 'find'
    ripgrep # A line-oriented search tool
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

    # --- Browsers (Custom requirement: only Chromium) ---


    # --- Bluetooth Management ---
    blueberry # Alternative Bluetooth configuration tool
    qbittorrent
    discord
    gnome-boxes
    yt-dlp

    # --- Media Tools ---
    vlc
    ffmpeg # Complete, cross-platform solution

    # --- Other Applications ---
    qalculate-gtk # Powerful and versatile desktop calculator
    gimp # GNU Image Manipulation Program
    code-cursor # Cursor editor
    telegram-desktop # Official Telegram Desktop client
    opencode
    bitwarden # Open-source password manager

    # --- Shells & Terminal Utilities ---
    ghostty # A GPU-accelerated terminal emulator
    fish # User-friendly command line shell
    starship # The minimal, blazing-fast, and infinitely customizable prompt

    # --- Language Servers & Linters ---
    tree-sitter # Parser generator tool
    alejandra # Nix code formatter
    nodePackages.prettier # Opinionated code formatter
    shfmt # Shell script formatter
    golangci-lint # Fast Go linters runner
    hadolint # Dockerfile linter
    shellcheck # Shell script static analysis tool
    tflint # Terraform linter
    gopls # Go language server
    nixd # Nix language server
    pyright # Pyright language server for Python
    terraform-ls # Terraform language server
    yaml-language-server # YAML language server
    cmake-language-server # CMake language server

    # --- System Services/Daemons ---
    redis # In-memory data structure store

    # --- Fonts ---
    nerd-fonts.jetbrains-mono # JetBrains Mono Nerd Font

    # --- Desktop Integration ---
    xdg-desktop-portal-gtk # GTK portal for XDG desktop

    # --- Additional from @kaku/ pattern ---
    # GNOME Applications
    amberol # Music player
    celluloid # Video player with YouTube support
    nautilus # File manager
    gnome-text-editor # Text editor
    loupe # Image viewer
    resources # System resource monitor

    # Development Tools
    bottom # System resource monitor
    skim # Fuzzy finder alternative to fzf

    # Communication
    vesktop # Discord client with Vencord integration
    telegram-desktop

    # Additional tools from @kaku/
    inkscape # Vector graphics editor
  ];


}