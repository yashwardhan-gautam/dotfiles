# Hardware configuration for AMD Ryzen 7 PRO 6850U with Radeon 680M
# Enhanced with optimizations and proper driver support
{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Boot modules and kernel configuration
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usbhid" "amdgpu"];
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = ["kvm-amd" "amdgpu"];
  boot.extraModulePackages = [];

  # AMD-specific kernel parameters for better performance
  boot.kernelParams = [
    "amd_pstate=active"
    "amdgpu.deep_color=1"
    "amdgpu.dc=1"
    "amdgpu.ppfeaturemask=0xffffffff"
  ];

  # File systems (LUKS encrypted)
  fileSystems."/" = {
    device = "/dev/mapper/luks-6b75d2b7-0738-4e88-bffe-71ee997cbc8d";
    fsType = "ext4";
    options = ["noatime"];
  };

  boot.initrd.luks.devices."luks-6b75d2b7-0738-4e88-bffe-71ee997cbc8d" = {
    device = "/dev/disk/by-uuid/6b75d2b7-0738-4e88-bffe-71ee997cbc8d";
    allowDiscards = true;
    bypassWorkqueues = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6397-7C0F";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  # No swap devices - using zram instead
  swapDevices = [];
  
  # Enable zram for better memory management
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  # Hardware platform and firmware
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;

  # Power management optimizations for laptop
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  
  # Enable hardware acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # RADV is enabled by default (replaces amdvlk)
      rocmPackages.clr.icd
    ];
  };
}