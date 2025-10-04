{pkgs, ...}: {
  # Define user account
  users.users.unalome = {
    isNormalUser = true;
    description = "unalome";
    extraGroups = ["networkmanager" "wheel" "audio" "video" "input"];
    shell = pkgs.fish;
  };
  
  # Enable fish shell system-wide
  programs.fish.enable = true;
}