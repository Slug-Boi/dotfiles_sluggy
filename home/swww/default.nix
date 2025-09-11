{pkgs, config, variables, ...}: {
home.packages = with pkgs; [
  swww
];

systemd.timers."change_wallpaper" = {
  wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "45m";
      OnUnitActiveSec = "45m";
      Unit = "change_wallpaper.service";
    };
};

systemd.user.services."change_wallpaper" = {
  serviceConfig = {
    Type = "oneshot";
    # Use ExecStart instead of script for user services
    ExecStart = ''
      ${pkgs.bash}/bin/bash -c "
        set -eu
        WALLPAPERS_DIR=\$HOME/.config/wallpapers/current
        WALLPAPER=\$(find \"\$WALLPAPERS_DIR\" -type f | ${pkgs.coreutils}/bin/shuf -n 1)
        ${pkgs.swww}/bin/swww img \"\$WALLPAPER\"
      "
    '';
  };
  
  unitConfig = {
    # Start after graphical session is ready
    After = ["graphical-session.target"];
    PartOf = ["graphical-session.target"];
  };
};


  # Possibly use DVC as a exec command somewhere in login sequence to check if wallpapers are present if not then fetch from external source using DVC
  xdg.configFile.wallpapers = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/swww/wallpapers");   
  };
}
