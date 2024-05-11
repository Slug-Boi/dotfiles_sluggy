{pkgs, ...}: {
  imports = [
    ./insomnia.nix
  ];

  home.packages = with pkgs; [
    discord
    spotify
    pulseeffects-legacy
  ];

  programs.firefox = {
    enable = true;
    # TODO: Add extensions
  };
}
