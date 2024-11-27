{
  pkgs,
  config,
  variables,
  ...
}: {
  home.packages = with pkgs; [
    yazi
    ueberzugpp

    # req plugins
    ffmpegthumbnailer
    mediainfo
  ];
  
  xdg.configFile.yazi = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/yazi/config");
    
  };

 }
