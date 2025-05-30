{
  lib,
  stdenv,
  fetchurl,
  unzip,
	pkgs,	
}:
stdenv.mkDerivation {
  pname = "rec-mono";
  version = "06-20-2022";

  src = fetchurl {
    url = "https://github.com/arrowtype/recursive/releases/download/v1.085/ArrowType-Recursive-1.085.zip";
		sha256 = "sha256-y8vfeg4YHShKkjXgntXzhz5Se8XdHZd99xzcH/k32gI";
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
