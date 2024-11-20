{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI stuff
    # General packages for development and system management
    alacritty
    bat
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
    slack
    pdfgrep

    # Encryption and security tools
    #age
    #age-plugin-yubikey
    openssl
    libfido2

    # Development tools
    protobuf
    tesseract
    sqlite

    # Cloud-related tools and SDKs
    docker
    docker-compose

    # Media-related packages
    ffmpeg
    fd
    pandoc
    poppler
    asciinema

    # Darwin 
    dockutil

    # Text and terminal utilities
    jq
    ripgrep
    tree
    tmux
    unrar
    unzip
    zsh-powerlevel10k
    fzf
    yazi

  ];
}
