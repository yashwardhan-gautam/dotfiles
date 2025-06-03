{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./config/nvim.nix
  ];
  
  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Font configuration
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    # Individual Nerd Font packages
    (nerdfonts.override { fonts = [
      "JetBrainsMono"
      "FiraCode"
      "Hack"
      "DroidSansMono"
      "Iosevka"
    ]; })
  ];

  # Configure nvf
  programs.neovim.enable = true;
}
