{pkgs, ...}: {
  programs = {
    zsh.enable = true;
    fish.enable = true;
  };

  environment.shells = with pkgs; [
    bash
    fish
    zsh
  ];

  users.defaultUserShell = pkgs.zsh;
}
