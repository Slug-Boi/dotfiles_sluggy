 {
  variables,
  ...
}: {

  home.file = {
    ".zshrc" = {
      text = ''
        source ${variables.dotfilesLocation}/home/zsh/config/.zshrc
      '';
    };
  };
}

 
