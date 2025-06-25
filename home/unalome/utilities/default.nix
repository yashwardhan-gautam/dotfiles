{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./xdg.nix
    ./waybar.nix
    #./rofi.nix
  ];
}
