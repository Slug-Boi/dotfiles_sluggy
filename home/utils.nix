{pkgs, ...}: {
  home.packages = with pkgs; [
    # Tools
    eza
    gnutar
    ripgrep
    unzip
    baobab

    # Programming
    gh
    gnumake

    # Convenience
    fd
    jump

    # System
    bandwhich
    bottom
    procs
    glxinfo
    brightnessctl

    # Networks
    networkmanagerapplet

    # Virtualization
    virtualbox
  ];
}
