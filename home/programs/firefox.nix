{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    
    profiles.default = {
      id = 0;
      name = "Default";
      
      settings = {
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.search.defaultEngine" = "DuckDuckGo";
        "privacy.trackingprotection.enabled" = true;
        "browser.ctrlTab.recentlyUsedOrder" = false;
      };
      
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        privacy-badger
      ];
    };
  };
}
