{pkgs, ...}: {
  # Graphics drivers for AMD Radeon 680M (enhanced)
  services.xserver.videoDrivers = ["amdgpu"];
  
  # Enable Wayland support
  programs.xwayland.enable = true;
  
  # Additional graphics optimizations
  environment.variables = {
    # Force Wayland for all apps
    NIXOS_OZONE_WL = "1";
    # AMD GPU optimizations
    AMD_VULKAN_ICD = "RADV";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  };
  
  # OpenGL and Vulkan support
  hardware.graphics.extraPackages = with pkgs; [
    # VAAPI for hardware video acceleration
    libva
    vaapiVdpau
    libvdpau-va-gl
  ];
}