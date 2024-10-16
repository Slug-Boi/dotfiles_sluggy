{lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {


  pname = "cocommit";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "Slug-Boi";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-oraadDCyek8qnXFZPj2yitXL3KPK+uW1/VZphrEa/MU=";
  };

  vendorHash = null;

  buildPhase = ''
    make build-nix
  '';
  
  doCheck = false;

  installPhase = ''
    mkdir -p $out/bin
    cp "src_code/go_src/${pname}" "$out/bin/${pname}"
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
