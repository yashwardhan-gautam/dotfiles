{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
      {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
    ];
    
    commandLineArgs = [
      "--enable-features=VaapiVideoDecoder"
      "--use-gl=egl"
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
    ];
  };
}