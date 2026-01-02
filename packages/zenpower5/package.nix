{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation rec {
  pname = "zenpower5-${version}-module-${kernel.modDirVersion}";
  version = "0.5.0-patched";

  # Use the branch that supports Granite Ridge
  # see: https://github.com/mattkeenan/zenpower5/pull/3
  src = fetchFromGitHub {
    owner = "SamG05Z";
    repo = "zenpower5";
    rev = "feature/zen5-granite-ridge-support";
    hash = "sha256-T+Dh6jAcF/7zbVGTo9ucmm4gVrNTP2vB7giTup7JdMI=";
  };
  #
  # TODO: use the main branch once merged
  # src = fetchFromGitHub {
  #   owner = "mattkeenan";
  #   repo = "zenpower5";
  #   rev = "v${version}";
  #   hash = lib.fakeHash; # TODO: hash
  # };

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
