{pkgs, ...}: {
  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.systemd-boot.editor = false; # Security: disable editor
  
  # Latest kernel for better hardware support
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Enhanced kernel parameters for AMD and performance
  boot.kernelParams = [
    # AMD optimizations
    "amd_pstate=active"
    "amd_iommu=on"
    
    # Performance and security
    "transparent_hugepage=madvise"
    
    # Boot improvements
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    
    # LUKS optimization
    "rd.luks.options=discard"
  ];
  
  # Improved boot settings
  boot.consoleLogLevel = 3;
  
  # Enable microcode updates
  hardware.enableRedistributableFirmware = true;
  
  # Plymouth for better boot experience
  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };
  
  # Faster boot
  boot.loader.timeout = 3;
  systemd.services.NetworkManager-wait-online.enable = false;
}