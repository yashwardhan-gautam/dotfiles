{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    
    extraPackages = with pkgs; [
      tree-sitter
      ripgrep
      fd
    ];
  };
}
