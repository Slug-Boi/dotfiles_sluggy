{...}: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g mouse on
      set -s escape-time 0
    '';
  };
}
