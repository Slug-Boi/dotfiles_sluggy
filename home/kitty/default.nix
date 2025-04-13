{
  pkgs,
  config,
  variables,
  ...
}: {
  home.packages = with pkgs; [
    kitty
  ];
  
  xdg.configFile.kitty = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/kitty/config");
    
  };

 }
