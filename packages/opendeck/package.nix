{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  wrapGAppsHook3,
  gtk3,
  glib,
  gdk-pixbuf,
  webkitgtk_4_1,
  libsoup_3,
  libappindicator-gtk3,
  librsvg,
  openssl,
  systemd,
  dbus,
  hidapi,
  at-spi2-atk,
  cairo,
  pango,
  libX11,
  libXext,
  libXrandr,
  glib-networking,
  ...
}:

stdenv.mkDerivation rec {
  pname = "opendeck";
  version = "2.12.0";

  src = fetchurl {
    url = "https://github.com/nekename/OpenDeck/releases/download/v${version}/opendeck_${version}_amd64.deb";
    hash = "sha256-p+NCR3QzUXu8O/A4qdFXHGKxmrqOk+zLVVCoI7jhhKE=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    wrapGAppsHook3
  ];

  buildInputs = [
    gtk3
    glib
    gdk-pixbuf
    webkitgtk_4_1
    libsoup_3
    libappindicator-gtk3
    librsvg
    openssl
    systemd
    dbus
    hidapi
    at-spi2-atk
    cairo
    pango
    libX11
    libXext
    libXrandr
    glib-networking
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/lib
    mkdir -p $out/share

    # Install the binary
    cp -r usr/bin/* $out/bin/
    # Install libraries/resources bundled with the app
    cp -r usr/lib/* $out/lib/ 2>/dev/null || true
    # Install desktop file, icons, metainfo, etc.
    cp -r usr/share/* $out/share/

    # Install udev rules
    if [ -d etc/udev ]; then
      mkdir -p $out/etc/udev/rules.d
      cp etc/udev/rules.d/* $out/etc/udev/rules.d/
    fi

    runHook postInstall
  '';

  # The binary needs to find its bundled WebKit resources
  preFixup = ''
    gappsWrapperArgs+=(
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}"
    )
  '';

  meta = {
    description = "Linux software for your Elgato Stream Deck with support for original Stream Deck plugins";
    homepage = "https://github.com/nekename/OpenDeck";
    license = lib.licenses.gpl3Plus;
    platforms = [ "x86_64-linux" ];
    mainProgram = "opendeck";
  };
}
