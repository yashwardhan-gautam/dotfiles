{ config, lib, pkgs, ... }:

{
  home.file.".local/bin/cleanup" = {
    source = ./cleanup.sh;
    executable = true;
  };
  
  home.file.".local/bin/update-system" = {
    source = ./update-system.sh;
    executable = true;
  };
} 