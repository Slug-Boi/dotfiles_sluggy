{pkgs, ...}: {
  imports = [
    ./insomnia.nix
  ];

  home.packages = with pkgs; [
    discord
    spotify
    easyeffects
  ];

  programs.firefox = {
    enable = true;
    # TODO: Add extensions
  };
}
