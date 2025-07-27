{pkgs, ...}: {
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.gtest}/lib/pkgconfig:${pkgs.gbenchmark}/lib/pkgconfig:$PKG_CONFIG_PATH";
    CMAKE_PREFIX_PATH = "${pkgs.gtest}:${pkgs.gbenchmark}:$CMAKE_PREFIX_PATH";
    # Wayland
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    # Qt
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";

    # GTK
    GDK_BACKEND = "wayland,x11";

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";

    # Electron
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
}
