{
  # Firmware updater
  services.fwupd = {
    enable = true;
    extraRemotes = ["lvfs-testing"];
  };
}