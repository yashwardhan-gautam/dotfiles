{lib, ...}: {
  imports = [
    ./boot.nix
    ./security.nix
    ./users.nix
  ];

  # Enable flakes and new command-line tool
  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  # Default locale settings (timezone is set per-host)
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}