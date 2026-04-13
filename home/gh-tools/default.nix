{
  pkgs,
  config,
  variables,
  ...
}: {
  home.packages = with pkgs; [
    gh-dash
    diffnav
  ];
  
  xdg.configFile.gh-dash = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/gh-tools/config-dash");   
  };

  xdg.configFile.diffnav = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/gh-tools/config-diff");   
  };

 }
