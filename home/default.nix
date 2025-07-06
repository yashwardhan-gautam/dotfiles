{pkgs, ...}: {
  imports = [
    ./programs/default.nix
    ./utilities/default.nix
  ];

  # Home Manager basic settings
  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "25.11";

  # Basic packages
  home.packages = with pkgs; [
    # Development tools
    nodejs
    python3
    rustc
    cargo

    # C++ Development tools (for flox project)
    cmake
    ninja
    gcc
    pkg-config
    gtest
    gbenchmark
    doxygen
    clang-tools

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
  ];

  # Environment variables
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.gtest}/lib/pkgconfig:${pkgs.gbenchmark}/lib/pkgconfig:$PKG_CONFIG_PATH";
    CMAKE_PREFIX_PATH = "${pkgs.gtest}:${pkgs.gbenchmark}:$CMAKE_PREFIX_PATH";
  };

  programs.home-manager.enable = true;
}
