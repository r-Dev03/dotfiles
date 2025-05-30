{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:
stdenv.mkDerivation {
  pname = "rec-mono";
  version = "06-20-2022";

  src = fetchurl {
    url = "https://github.com/arrowtype/recursive/releases/download/v1.085/ArrowType-Recursive-1.085.zip";
    sha256 = "5f4be025122d72d4710267e959128e8986ebe435";
  };

  nativeBuildInputs = [unzip];

  dontInstall = true;

  unpackPhase = ''
    mkdir -p $out/share/fonts
    unzip -d $out/share/fonts/truetype $src
  '';

  meta = {
    description = "Recursive Sans & Mono Font";
    homepage = "https://github.com/arrowtype/recursive";
    license = lib.licenses.ofl;
  };
}
