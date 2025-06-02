{ config, pkgs, ... }:

{
  # imports = [
  #   ./config
  # ];
  
  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Font configuration
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    # Individual Nerd Font packages
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    # nerd-fonts.symbols
  ];

}
