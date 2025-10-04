{
  stdenv,
  src,
  gtk3,
  hicolor-icon-theme,
  jdupes,
  lib,
}: stdenv.mkDerivation rec {
  pname = "tela-icon-theme";
  version = "2024-12-01";

  inherit src;

  nativeBuildInputs = [gtk3 jdupes];
  propagatedBuildInputs = [hicolor-icon-theme];

  dontDropIconThemeCache = true;

  installPhase = ''
    runHook preInstall
    
    patchShebangs install.sh
    mkdir -p $out/share/icons
    
    # Install all variants with specific color options
    # Standard variants
    ./install.sh -d $out/share/icons -n standard
    
    # Colored variants (blue, green, grey, orange, pink, purple, red, yellow)
    for color in blue green grey orange pink purple red yellow; do
      ./install.sh -d $out/share/icons -c "$color" -n "$color"
    done
    
    # Create symlinks for common names
    cd $out/share/icons
    
    # Default Tela (standard)
    ln -sf Tela Tela-standard
    
    # Dark variants
    if [ -d Tela-dark ]; then
      ln -sf Tela-dark Tela-dark-standard
    fi
    
    # Remove broken symlinks
    find $out/share/icons -xtype l -delete
    
    # Fix permissions
    find $out/share/icons -type f -exec chmod 644 {} \;
    find $out/share/icons -type d -exec chmod 755 {} \;
    
    # Deduplicate to save space
    jdupes --recurse --link-soft --exclude-hidden $out/share/icons
    
    runHook postInstall
  '';

  # Post-install script to update icon cache
  postInstall = ''
    for theme in $out/share/icons/*/; do
      if [ -d "$theme" ]; then
        ${gtk3}/bin/gtk-update-icon-cache -qtf "$theme" 2>/dev/null || true
      fi
    done
  '';

  meta = with lib; {
    description = "A flat colorful Design icon theme";
    longDescription = ''
      Tela is a flat colorful Design icon theme for linux desktops.
      It includes multiple color variants and both light and dark versions.
      Supports most common applications and provides a modern, clean look.
    '';
    homepage = "https://github.com/vinceliuice/Tela-icon-theme";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}