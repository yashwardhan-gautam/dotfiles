{
  config,
  lib,
  ...
}: let
  # Extract font family from primary_font (e.g., "JetBrainsMono Nerd Font 11" -> "JetBrainsMono Nerd Font")
  fontFamily = lib.head (lib.splitString " " (lib.removeSuffix " ${toString (lib.last (lib.splitString " " config.dotfiles.primary_font))}" config.dotfiles.primary_font));
in {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["Noto Serif"];
      sansSerif = [fontFamily "Noto Sans"];
      monospace = [fontFamily "Caskaydia Mono Nerd Font"];
    };
  };
}
