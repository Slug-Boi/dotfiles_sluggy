{pkgs, pkgs-unstable, ...}: {
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
    #dvc-with-remotes

    # Encryption and security tools
    #age
    #age-plugin-yubikey
    openssl
    libfido2
    nmap

    # Development tools
    protobuf
    tesseract
    sqlite
    nix-prefetch
    gh
    openapi-generator-cli
    opentofu
    cloc

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
    audacity
    yt-dlp

    # Text and terminal utilities
    jq
    ripgrep
    tree
    tmux
    unrar
    unzip
    zsh-powerlevel10k
    fzf
    cook-cli
  ];
  
}
