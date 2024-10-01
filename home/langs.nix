{pkgs, ...}: {
  home.packages = with pkgs; [
    dotnet-sdk_7
    #nodejs-18_x
    nodePackages.npm # globally install npm
    nodePackages.prettier
    nodejs

    # Go
    go
    golangci-lint

    # Rust
    cargo
    rustc
    clippy
    openssl # openssl-sys
    pkg-config # openssl-sys

    # Java, also required by Scala metals
    jdk11

    # Scripting
    #lua

    # Python
    # python3  
    # python311Packages.virtualenv # globally install virtualenv
    # python311Packages.pip

    # C compiler
    #libgcc
  ];
}
