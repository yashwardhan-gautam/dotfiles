{pkgs, ...}: {
  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  
  # Latest kernel for better hardware support
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Kernel parameters for AMD
  boot.kernelParams = [
    "amd_pstate=active"
    "quiet"
    "splash"
  ];
}