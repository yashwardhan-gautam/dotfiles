{pkgs, ...}: {
  imports = [
    ./programs/default.nix
  ];

  # Home Manager basic settings
  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "25.11";

  # Basic packages
  home.packages = with pkgs; [
    # Development tools
    nodejs
    rustc

    # C++ Development tools
    cmake
    ninja
    gcc15
    pkg-config
    gtest
    gbenchmark

    # System utilities
    tree
    eza
    bat
    fd
    ripgrep
    fzf

    # Media
    mpv
    ffmpeg

    # Other
    qalculate-gtk
    gimp
    lazygit
    tree-sitter
    curl
    firefox
    ghostty
    tmux
    xclip
    fish
    wget
    starship
    git
    btop
    brave
    zoxide
    gnumake
    lua5_1
    luajitPackages.luarocks
    lua-language-server
    stylua
    (python312.withPackages (ps: with ps; [pip black isort ruff pygobject3]))
    go
    cargo
    clang-tools
    codespell
    cppcheck
    doxygen
    code-cursor
    telegram-desktop
    gemini-cli

    # System services and daemons
    redis

    # Essential system utilities
    loupe

    # Packages from neovim
    alejandra
    nodePackages.prettier
    shfmt
    golangci-lint
    hadolint
    shellcheck
    tflint
    gopls
    nixd
    pyright
    terraform-ls
    yaml-language-server
    cmake-language-server
    gdb
    gotools
    nerd-fonts.jetbrains-mono
    xdg-desktop-portal-gtk
  ];

  # Environment variables
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.gtest}/lib/pkgconfig:${pkgs.gbenchmark}/lib/pkgconfig:$PKG_CONFIG_PATH";
    CMAKE_PREFIX_PATH = "${pkgs.gtest}:${pkgs.gbenchmark}:$CMAKE_PREFIX_PATH";
  };

  programs.home-manager.enable = true;
}
