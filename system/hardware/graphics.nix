{pkgs, ...}: {
  # Graphics drivers for AMD Radeon 680M
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  # AMD-specific configuration
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];
  
  # Enable Wayland support
  programs.xwayland.enable = true;
}