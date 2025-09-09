{pkgs,variables,config, ...}: {
  home.packages = with pkgs; [
    easyeffects
  ];


  xdg.configFile.easyeffects = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/easyeffects/config");   
  };
}
