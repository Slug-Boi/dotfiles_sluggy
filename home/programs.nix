{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI stuff
    # General packages for development and system management
    bat
    eza
    act
    btop
    coreutils
    killall
    fastfetch
    openssh
    sqlite
    wget
    zip
    mosh
    zoxide
    devenv
    pop
    glow
    slack
    pdfgrep
    ripgrep
    gnupg
    lazydocker
    opentofu
    jless

    # Encryption and security tools
    #age
    #age-plugin-yubikey
    openssl
    libfido2

    # Development tools
    protobuf
    tesseract
    sqlite
    nix-prefetch
    gh
    jetbrains.phpstorm

    # Cloud-related tools and SDKs
    docker
    docker-compose

    # Media-related packages
    ffmpeg
    fd
    pandoc
    poppler
    asciinema
    imagemagick_light
    zotero
    lynx 

    # Text and terminal utilities
    jq
    ripgrep
    tree
    tmux
    unrar
    unzip
    zsh-powerlevel10k
    fzf

  ];
}
