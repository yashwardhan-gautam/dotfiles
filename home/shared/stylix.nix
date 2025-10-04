{
  config,
  inputs,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    opacity = {
      popups = 1.0;
      terminal = 1.0;
    };

    fonts = {
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    # Use gruvbox-dark-hard by default (will add gruvbox-light later)
    base16Scheme = ./colors/gruvbox-dark-hard.yml;

    targets = {
      bat.enable = true;
      nixos-icons.enable = true;
      starship.enable = true;
      vesktop.enable = true;
      yazi.enable = true;
      fish.enable = true;
      ghostty.enable = true;
    };
  };
}