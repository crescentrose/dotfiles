{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation rec {
  pname = "zenpower5-${version}-module-${kernel.modDirVersion}";
  version = "0.5.0-main";

  src = fetchFromGitHub {
    owner = "mattkeenan";
    repo = "zenpower5";
    rev = "66871d8"; # latest commit to `master`
    hash = "sha256-g0zVTDi5owa6XfQN8vlFwGX+gpRIg+5q1F4EuxAk9Sk=";
  };

  hardeningDisable = [
    "pic"
    "format"
  ];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M=$PWD \
      modules
  '';

  installPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M=$PWD \
      INSTALL_MOD_PATH=${placeholder "out"} \
      INSTALL_MOD_DIR=kernel/drivers/hwmon \
      modules_install
  '';

  meta = {
    description = "Linux kernel driver for AMD Zen CPU monitoring (Zen 1-5): temperature, voltage, current, and power via SVI2/RAPL. Multi-file architecture with Zen 5 (Strix Halo) support.";
    homepage = "https://github.com/mattkeenan/zenpower5";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
  };
}
