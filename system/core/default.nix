{
  imports = [
    ./boot.nix
    ./security.nix
    ./users.nix
  ];

  # Enable flakes and new command-line tool
  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  # Set your time zone
  time.timeZone = "America/New_York"; # Adjust as needed
  
  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}