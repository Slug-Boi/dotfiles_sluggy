{pkgs, ...}: {
  home.packages = with pkgs; [
    #dotnet-sdk_7
    # dotnetCorePackages.sdk_8_0_3xx
    # dotnetCorePackages.sdk_8_0-bin
    dotnetCorePackages.sdk_9_0-bin
    fsautocomplete

    yarn

    #llvm_18
    #darwin.libresolv
    #darwin.libresolvHeaders

    # Go
    go
    golangci-lint

    # Nim
    nim-unwrapped-2_0
    # Nim package manager required for lsp
    nimble
    nimlsp

    # Rust
    cargo
    rustc
    #rustup
    clippy
    openssl # openssl-sys
    pkg-config # openssl-sys

    # Java, also required by Scala metals
    #jdk11
    jdk
    scala-cli
    coursier

    # Scripting
    #lua

    # Latex
    texliveFull
    
    # Python
    # python3  
    # python311Packages.virtualenv # globally install virtualenv
    # python311Packages.pip

    # C compiler
    #libgcc
    gsl
  ];
}
