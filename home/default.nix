{ config, pkgs, inputs, ... }:

{
    imports = [
  ];
  
  home.file = {
    ".config/nvim".source = ./config/nvim;
  };

  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Font configuration
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    # Nerd Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka

    # Build tools for native extensions
    gcc15
    gnumake
    cmake
    pkg-config
    openssl.dev

    # CLI tools 
    bat
    btop
    eza
    fzf
    git
    neofetch
    ripgrep
    tldr
    unzip
    openssl
    wget
    zip
    zoxide

    # GUI
    xfce.thunar
  ];

  programs.neovim.enable = true;
}
