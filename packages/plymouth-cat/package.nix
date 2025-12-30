{
  stdenv,
  lib,
  fetchFromGitHub,
}:
let
  pname = "plymouth-cat";
in
stdenv.mkDerivation {
  inherit pname;
  version = "0-unstable-2025-11-29";

  dontBuild = true;
  src = fetchFromGitHub {
    owner = "derVedro";
    repo = "PlymouthTheme-Cat";
    rev = "4b5dc0cb73598e71af48993bf07b6ecb7ed7270a";
    hash = "sha256-iCePHALHusBn7Tnd695tE9EguKf9yqU2530tIjunqnc=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plymouth/themes
    cp -r cat/ $out/share/plymouth/themes
    find $out/share/plymouth/themes/cat -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;

    runHook postInstall
  '';

  meta = {
    description = "a lovely sleepy cat plymouth theme";
    homepage = "https://github.com/derVedro/PlymouthTheme-Cat";
    platforms = lib.platforms.linux;
    license = lib.licenses.gpl3;
  };
}
