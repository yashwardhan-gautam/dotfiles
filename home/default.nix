{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../config.nix
    ./programs/default.nix
    inputs.zen-browser.homeModules.twilight
  ];

  # Home Manager basic settings
  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "26.05";

  # Basic packages
  home.packages = with pkgs; [
    # Programming Languages & Build Tools
    rustc
    cargo
    go
    gotools
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

    # Python
    (python312.withPackages (ps:
      with ps; [
        pip
        black
        isort
        ruff
        pygobject3
      ]))

    # CLI Tools
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
    wget
    curl
    fastfetch
    zoxide
    chafa
    ueberzugpp

    # Version Control
    git
    lazygit

    # Applications
    brave
    qbittorrent
    discord
    gnome-boxes
    yt-dlp

    # Shell & Terminal
    kitty
    fish
    starship

    # Services
    redis
    docker
    docker-compose
    xdg-desktop-portal-gtk # GTK portal for XDG desktop (related to home/programs/neovim/default.nix, home/programs/xdg.nix)
  ];

  programs.home-manager.enable = true;

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
