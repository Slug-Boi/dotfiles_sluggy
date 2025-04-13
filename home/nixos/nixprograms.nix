{pkgs, ...}: {
  programs = {
    firefox = {
      enable = true;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    rio
  ];
}
