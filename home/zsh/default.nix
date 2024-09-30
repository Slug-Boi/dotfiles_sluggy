 {
  variables,
  ...
}: {
  zsh = {
    enable = true;
    # plugins = [
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    #   {
    #     name = "powerlevel10k-config";
    #     src = lib.cleanSource ./config;
    #     file = "p10k.zsh";
    #   }
    # ];
    #

  };

  home.file = {
    ".zshrc" = {
      text = ''
        source ${variables.dotfilesLocation}/home/zsh/config/.zshrc
      '';
    };
  };
}

 
