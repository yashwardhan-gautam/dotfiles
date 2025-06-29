{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./starship.nix
    ./neovim
    ./git.nix
    ./fish.nix
  ];
}
