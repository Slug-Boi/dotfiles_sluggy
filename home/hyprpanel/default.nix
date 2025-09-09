{pkgs, config, variables, ...}: {
  programs.hyprpanel = {
    enable = true;
    
    #Note: Switched to using configfile symlinking since the settings bound on nix are incomplete. Something as basic as showing workspaces as numbers was in fact not possible.

  };

  xdg.configFile.hyprpanel = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/hyprpanel/config");
  };
}
