{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../config.nix
    ./programs/default.nix
    inputs.zen-browser.homeModules.twilight
    inputs.dms.homeModules.dankMaterialShell.default
  ];

  # DankMaterialShell configuration
  programs.dankMaterialShell = {
    enable = true;

    # Auto-start DMS via systemd
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    # Core features
    enableSystemMonitoring = true; # dgop
    enableClipboard = true;
    enableVPN = true;
    enableDynamicTheming = true; # matugen
    enableAudioWavelength = true; # cava
    enableCalendarEvents = true; # khal
  };

  # Home Manager basic settings
  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "26.05";

  # Basic packages
  home.packages = with pkgs; [
    # Programming Languages & Build Tools
    nodejs
    rustc
    cargo
    go
    gotools
    lua5_1
    luajitPackages.luarocks
    gnumake
    cmake
    ninja
    gcc15
    clang-tools
    cmake-lint
    pkg-config

    # C/C++ Development
    gtest
    gbenchmark
    codespell
    cppcheck
    doxygen
    gdb

    # Profiling Tools
    perf # CPU profiling, cache analysis
    heaptrack # Heap memory profiler
    valgrind # Memory debugging (includes cachegrind, callgrind)
    coz # Causal profiler
    cargo-flamegraph # Generate flamegraph SVGs for Rust

    # Python
    (python312.withPackages (ps:
      with ps; [
        pip
        black
        isort
        ruff
        pygobject3
      ]))

    # Language Servers
    lua-language-server
    gopls
    nixd
    pyright
    rust-analyzer
    terraform-ls
    yaml-language-server
    cmake-language-server

    # Formatters
    stylua
    alejandra
    nodePackages.prettier
    shfmt

    # Linters
    tree-sitter
    golangci-lint
    hadolint
    shellcheck
    tflint
    clippy
    cargo-nextest
    bacon
    vscode-extensions.vadimcn.vscode-lldb.adapter # Rust debugger

    # CLI Tools
    yazi
    tree
    eza
    bat
    fd
    ripgrep
    fzf
    jq
    poppler
    resvg
    imagemagick
    p7zip
    xclip
    wl-clipboard
    wl-color-picker
    wget
    curl
    fastfetch
    zoxide

    # Version Control
    git
    lazygit

    # Applications
    cosmic-files
    brave
    chromium
    qbittorrent
    discord
    gnome-boxes
    yt-dlp
    code-cursor
    cursor-cli
    opencode
    qalculate-gtk
    telegram-desktop
    bitwarden-desktop

    # Media
    vlc
    ffmpeg

    # Shell & Terminal
    ghostty
    fish
    starship

    # Services
    redis
    docker
    docker-compose
    fprintd
    xdg-desktop-portal-gtk

    # Fonts
    nerd-fonts.jetbrains-mono

    # System fonts for browsers and apps
    noto-fonts # Google Noto fonts (good Unicode coverage)
    noto-fonts-color-emoji # Emoji support
    liberation_ttf # Metric-compatible with Arial, Times, Courier
    inter # Modern UI font (like SF Pro)
    roboto # Android/Material Design font
    source-sans-pro # Adobe Source Sans
    font-awesome # Icon font
  ];

  # Font configuration
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
    };
  };

  # Better font rendering (hinting & antialiasing)
  xdg.configFile."fontconfig/conf.d/99-custom.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <match target="font">
        <edit name="antialias" mode="assign"><bool>true</bool></edit>
        <edit name="hinting" mode="assign"><bool>true</bool></edit>
        <edit name="hintstyle" mode="assign"><const>hintslight</const></edit>
        <edit name="rgba" mode="assign"><const>rgb</const></edit>
        <edit name="lcdfilter" mode="assign"><const>lcddefault</const></edit>
      </match>
    </fontconfig>
  '';

  # Ensure Screenshots directory exists
  home.activation.createScreenshotsDir = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/Pictures/Screenshots
  '';

  programs.home-manager.enable = true;

  # Zen Browser configuration
  programs.zen-browser = {
    enable = true;
    profiles."default" = {
      spaces = {
        "Default" = {
          id = "00000000-0000-0000-0000-000000000000";
          position = 1000;
        };
      };
      # Theme settings - follow system light/dark mode
      settings = {
        # Follow system theme (light/dark)
        "layout.css.prefers-color-scheme.content-override" = 2; # 2 = system
        "browser.theme.toolbar-theme" = 2; # 2 = system
        "browser.theme.content-theme" = 2; # 2 = system

        # GTK integration for proper theme detection
        "widget.content.allow-gtk-dark-theme" = true;
        "widget.gtk.ignore-theme-variant" = false;
        "widget.gtk.alt-theme.dark" = true;

        # Use system colors
        "browser.display.use_system_colors" = true;
      };
    };
  };
}
