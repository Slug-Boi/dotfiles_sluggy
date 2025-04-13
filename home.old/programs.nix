{pkgs, ...}: {
  imports = [
    ./insomnia.nix
  ];

  home.packages = with pkgs; [
    discord
    spotify
    pulseeffects-legacy
    prismlauncher
  ];

  programs.firefox = {
    enable = true;
    # TODO: Add extensions
  };
}
