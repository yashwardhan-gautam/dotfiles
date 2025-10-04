{pkgs, ...}: {
  # Enhanced networking settings
  networking = {
    # Enable NetworkManager
    networkmanager = {
      enable = true;
      wifi.powersave = false; # Better performance
      dns = "systemd-resolved";
      
      # Additional plugins
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];
    };
    
    # Enable systemd-resolved for better DNS
    useNetworkd = false;
    useDHCP = false;
    
    # Network security
    enableIPv6 = true;
  };
  
  # Enable systemd-resolved
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = ["8.8.8.8" "8.8.4.4" "1.1.1.1"];
  };
  
  # Enhanced SSH daemon
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
      MaxAuthTries = 3;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
    };
    
    # Additional security
    openFirewall = false; # We'll control this via firewall
  };
  
  # Additional networking packages
  environment.systemPackages = with pkgs; [
    networkmanager-openvpn
    networkmanager-openconnect
    wireguard-tools
    traceroute
    dig
    whois
  ];
}