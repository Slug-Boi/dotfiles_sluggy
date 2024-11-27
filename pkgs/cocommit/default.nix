{lib, buildGoModule, fetchFromGitHub }:
buildGoModule rec {

  pname = "cocommit";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "Slug-Boi";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-TaKr7/IlWdKBZNpmoo4HxMSPAVXET0zCxKHlKqc5PdE=";
  };

  vendorHash = "sha256-WLbsH/T99Mdk9IzSTUaXGT2vhIKcjSMbQaXQtt3K040=";
  

  #TODO: Make this not use a makefile instead just use a gobuild cmd
  buildPhase = ''
    go build -C src -o cocommit 
  '';
  
  doCheck = false;

  installPhase = ''
    mkdir -p $out/bin
    cp "src/${pname}" "$out/bin/${pname}"
    chmod +x $out/bin/${pname}
  '';

  meta = with lib; {
    description = "Cocommit is a CLI that makes it easier to co-author users on git commits";
    homepage = "https://github.com/Slug-Boi/${pname}";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
