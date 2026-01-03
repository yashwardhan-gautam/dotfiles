{ lib, config, ... }:
{
  xdg.configFile."niri/config.kdl".source = ./config/config.kdl;
}
