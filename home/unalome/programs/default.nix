{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./alacritty.nix
    ./neovim.nix
    #./firefox.nix
    ./git.nix
    ./zsh.nix
  ];
}
