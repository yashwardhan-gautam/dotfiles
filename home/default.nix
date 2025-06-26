{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./programs/default.nix
    ./utilities/default.nix
    ./themes/default.nix
    ./scripts/default.nix
  ];

  # Home Manager basic settings
  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "25.05";

  # Basic packages
  home.packages = with pkgs; [
    # Development tools
    nodejs
    python3
    rustc
    cargo
    
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

  programs.home-manager.enable = true;
} 