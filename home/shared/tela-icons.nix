{
  stdenv,
  src,
  gtk3,
  hicolor-icon-theme,
  jdupes,
}: stdenv.mkDerivation {
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
    
    # Install all variants
    ./install.sh -a -d $out/share/icons
    
    # Remove broken symlinks
    find $out/share/icons -xtype l -delete
    
    # Deduplicate
    jdupes --recurse --link-soft --exclude-hidden $out/share/icons
    
    runHook postInstall
  '';

  meta = {
    description = "A flat colorful Design icon theme";
    homepage = "https://github.com/vinceliuice/Tela-icon-theme";
    platforms = ["x86_64-linux" "aarch64-linux"];
  };
}