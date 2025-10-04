{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.geist-mono
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      source-han-sans
      source-han-serif
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Sans Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}