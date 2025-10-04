{pkgs, ...}: {
  # Nix Helper (nh) - Better nix command experience
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 7d --keep 3";
    };
    flake = "/home/unalome/dotfiles";
  };
  
  # Install nh for better nix experience
  environment.systemPackages = with pkgs; [
    nh
    nix-output-monitor
    nvd # Nix package version diff tool
  ];
}