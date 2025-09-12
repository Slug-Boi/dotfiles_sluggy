{ lib
, fetchFromGitHub
, rustPlatform
, libiconv
, pkg-config
, openssl
# , docker
}: 

rustPlatform.buildRustPackage rec {
  pname = "kitty";
  version = "v0.9.0";

  src = fetchFromGitHub {
    owner = "avborup";
    repo = pname;
    rev = "master";
    sha256 = "sha256-6/ednV6hpTObID8VgSxu0xw23DI9Njvz1UuGVWrQH0g=";
  };

  cargoHash = "sha256-e0RLFtfr0iZTFxIIS5ExWOgc9YlLstitj7Im9AQFtlo=";

  postInstall = ''
    mv $out/bin/kitty $out/bin/katty 2>/dev/null || true
  '';

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libiconv openssl ];
  # checkInputs = [ libiconv openssl docker ];

  # checkPhase = ''
  #   export HOME=$(pwd)
  #   make test
  # '';

  doCheck = false;

  doInstallCheck = true;
  installCheckPhase = ''
    $out/bin/katty --help
  '';

  meta = with lib; {
    description = "Kitty is a CLI for interacting with Kattis that allows you to test and submit problems straight from your terminal.";
    homepage = "https://github.com/avborup/kitty";
    license = with licenses; [ mit ];
    maintainers = ["Adrian Borup" "Albert Rise Nielsen"];
    mainProgram = "katty";
  };
}

