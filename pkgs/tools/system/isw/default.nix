{ lib
, stdenv
, fetchFromGitHub
, cmake
, yaml-cpp
, pkg-config
, procps
, coreutils
, smartSupport ? false, libatasmart
}:

stdenv.mkDerivation rec {
  pname = "isw";
  version = "1.10";

  src = fetchzip {
    url = "https://github.com/YoyPa/isw/archive/${version}.tar.gz";
    hash = "sha256-ZRHLhf0C3b5GhqlkZPBGooHL/UFfyfbp7XtPy9flz0k=";
  };


  buildInputs = [ 
    pkgs.python3
    pkgs.coreutils
  ];


  buildPhase = ''
    runHook preBuild
    runHook postBuild
  '';

  installPhase = ''
    install -Dm 644 etc/isw.conf $out/etc/isw.conf
    install -Dm 644 etc/modprobe.d/isw-ec_sys.conf $out/etc/modprobe.d/isw-ec_sys.conf
    install -Dm 644 etc/modules-load.d/isw-ec_sys.conf $out/etc/modules-load.d/isw-ec_sys.conf
    install -Dm 644 usr/lib/systemd/system/isw@.service $out/usr/lib/systemd/system/isw@.service
    install -Dm 755 isw $out/usr/bin/isw

    sed -i "s|CFG_FILE = '/etc/isw.conf'|CFG_FILE = '$out/etc/isw.conf'|" $out/usr/bin/isw
  '';


  meta = {
    description = "Fan control tool for MSI gaming series laptops";
    homepage = "https://github.com/YoyPa/isw";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
    mainProgram = "isw";
  };
}
