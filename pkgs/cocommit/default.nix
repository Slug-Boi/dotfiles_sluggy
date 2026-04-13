{lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {


  pname = "cocommit";
  version = "2.0.2";

  src = fetchFromGitHub {
    owner = "Slug-Boi";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-7sL6snUMlvd1cZbeYHeNs7AhqgJbKsaiPLzOQWtvT6g=";
  };

  vendorHash = "sha256-OzQjFohYO5hGDmFke5raJvJ5qB9byHIHSPy1WKYYQPc=";

  buildPhase = ''
    export Coco_Version="v${version}"
    make
  '';
  
  doCheck = false;

  installPhase = ''
    mkdir -p $out/bin
    cp "src/${pname}" "$out/bin/${pname}"
    chmod +x $out/bin/${pname}
  '';

  makefile = "makefile";

  meta = with lib; {
    description = "Cocommit is a CLI that makes it easier to co-author users on git commits";
    homepage = "https://github.com/Slug-Boi/${pname}";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
