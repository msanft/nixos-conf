{
  autoPatchelfHook,
  cairo,
  copyDesktopItems,
  dbus,
  fetchurl,
  fontconfig,
  freetype,
  glib,
  gtk3,
  lib,
  libdrm,
  libGL,
  libkrb5,
  libsecret,
  libsForQt5,
  libunwind,
  libxkbcommon,
  makeDesktopItem,
  makeWrapper,
  openssl,
  stdenv,
  xorg,
  zlib,
  curl,
}:
stdenv.mkDerivation rec {
  pname = "ida-pro";
  version = "8.4.240527";

  src = /nix/store/czhysj0vmgwf0b3dfif9iybq7nv2cwaf-idapro_240527.run;

  installPasswordFile = /nix/store/3znlc550j5kv6125fyp3hdrw7p011amg-ida_installpw.txt;

  icon = fetchurl {
    urls = [
      "https://hex-rays.com/products/ida/news/8_1/images/icon_pro.png"
    ];
    sha256 = "sha256-Botgf/o3W1CBF4Zvr1Ae5X0ma7CCBRdp82/QQqzNfiY=";
  };

  desktopItem = makeDesktopItem {
    name = "ida-pro";
    exec = "ida64";
    icon = icon;
    comment = meta.description;
    desktopName = "IDA Pro";
    genericName = "Interactive Disassembler";
    categories = [ "Development" ];
    startupWMClass = "IDA";
  };
  desktopItems = [ desktopItem ];

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
    autoPatchelfHook
    libsForQt5.wrapQtAppsHook
  ];

  # We just get a runfile in $src, so no need to unpack it.
  dontUnpack = true;

  # Add everything to the RPATH, in case IDA decides to dlopen things.
  runtimeDependencies = [
    cairo
    dbus
    fontconfig
    freetype
    glib
    gtk3
    libdrm
    libGL
    libkrb5
    libsecret
    libsForQt5.qtbase
    libunwind
    libxkbcommon
    openssl
    stdenv.cc.cc
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXau
    xorg.libxcb
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    zlib
    curl
  ];
  buildInputs = runtimeDependencies;

  dontWrapQtApps = true;

  # until we can have python3.6 in the environment, or IDA allows us to use a
  # more recent version, we need to ignore this dependency.
  autoPatchelfIgnoreMissingDeps = [ "libpython3.6m.so.1.0" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib $out/opt

    # IDA depends on quite some things extracted by the runfile, so first extract everything
    # into $out/opt, then remove the unnecessary files and directories.
    IDADIR=$out/opt

    # Invoke the installer with the dynamic loader directly, avoiding the need
    # to copy it to fix permissions and patch the executable.
    $(cat $NIX_CC/nix-support/dynamic-linker) $src \
      --mode unattended --prefix $IDADIR --installpassword "$(cat $installPasswordFile)"

    # Copy the exported libraries to the output.
    cp $IDADIR/libida64.so $out/lib

    # Some libraries come with the installer.
    addAutoPatchelfSearchPath $IDADIR
    for bb in ida64 assistant; do
      wrapProgram $IDADIR/$bb \
        --prefix QT_PLUGIN_PATH : $IDADIR/plugins/platforms
      ln -s $IDADIR/$bb $out/bin/$bb
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "The world's smartest and most feature-full disassembler";
    homepage = "https://hex-rays.com/ida-pro/";
    license = licenses.unfree;
    mainProgram = "ida64";
    maintainers = with maintainers; [ msanft ];
    platforms = [ "x86_64-linux" ]; # Right now, the installation script only supports Linux.
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
