{ config, pkgs, pkgs-unstable, lib, inputs, ... }:

{
  imports = [
    ./user
  ];

  # home.backupFileExtension = "backup";
  home.username = "unalome";
  home.homeDirectory = "/home/unalome";
  home.stateVersion = "23.11";
}

