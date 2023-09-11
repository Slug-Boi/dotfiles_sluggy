{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dotnet-sdk_7
    go
    nodejs-16_x

    # Rust
    cargo
    rustc
    openssl # openssl-sys
    pkg-config # openssl-sys

    # Scala
    scala
    scala-cli
    scalafmt
    scalafix
    coursier
  ];
}
