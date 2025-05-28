{ pkgs, pkgs-unstable, ... }:

{
  

  home.packages = [

    # Dev stuff
    pkgs.jetbrains.clion
    pkgs.gcc14
    pkgs.go
    pkgs.lua
    pkgs.nodejs_24
    pkgs.nodePackages.pnpm
    (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pip
        python-pkgs.requests
    ]))
    pkgs.rustup
    pkgs.pkgsCross.mingwW64.stdenv.cc 
    pkgs.pkgsCross.mingwW64.windows.pthreads
    pkgs.zig
    pkgs.neovim
    pkgs.code-cursor
    pkgs.lazygit
    
    # CLI tools
    pkgs.tmux
    pkgs.fish
    pkgs.wget
    pkgs.starship
    pkgs.git
    pkgs.btop
    pkgs.htop
    pkgs.zoxide
    pkgs.nix-index
    pkgs.tinyxxd
    
    # Work stuff
    pkgs.obsidian
    pkgs.thunderbird
    pkgs.hunspell
 
    # Browsers
    pkgs.brave
    
    # Terminal
    pkgs.ghostty

    # Bluetooth
    pkgs.blueberry

    # Social
    pkgs.telegram-desktop
    pkgs-unstable.vesktop

    # # Gaming
    # pkgs.steam
    # pkgs.steam-run
    # pkgs.yuzu-mainline
    # (pkgs.lutris.override {
    #   extraPkgs = pkgs: [
    #     pkgs.wineWowPackages.stable
    #     pkgs.winetricks
    #   ];
    # })

    # Downloads
    pkgs.qbittorrent

    # Utils
    pkgs.viewnior # image view
    pkgs-unstable.hyprshot # screenshot tool
    pkgs.catppuccin-cursors.macchiatoBlue # cursor theme
    pkgs.catppuccin-gtk # gtk theme
    pkgs.papirus-folders # folder icons
  ];
}
