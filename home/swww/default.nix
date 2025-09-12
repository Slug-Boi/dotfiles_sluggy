{pkgs, config, variables, ...}: {
home.packages = with pkgs; [
  swww
];

systemd.user.timers.change_wallpaper = {
    Timer = {
    OnBootSec = "45m";
    OnUnitActiveSec = "45m";
    Unit = "change_wallpaper.service";
    };
    Install.WantedBy = [ "timers.target" ];
};

systemd.user.services.change_wallpaper = {
  Service = {
    Type = "oneshot";
    ExecStart = let
      wallpaperScript = pkgs.writeShellScript "change-wallpaper" ''
        set -eu
        WALLPAPERS_DIR="$HOME/.config/wallpapers"
        LAST_WALLPAPER_FILE="$HOME/.cache/last_wallpaper"
        
        # Get all wallpapers
        ALL_WALLPAPERS=$(find -L "$WALLPAPERS_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | sort)
        
        if [ -z "$ALL_WALLPAPERS" ]; then
          echo "No wallpapers found!"
          exit 1
        fi
        
        # Read last wallpaper
        if [ -f "$LAST_WALLPAPER_FILE" ]; then
          LAST_WALLPAPER=$(cat "$LAST_WALLPAPER_FILE")
          # Exclude last wallpaper and shuffle
          SELECTED=$(echo "$ALL_WALLPAPERS" | grep -v "^$LAST_WALLPAPER$" | shuf -n 1)
          # If exclusion left nothing, use any
          if [ -z "$SELECTED" ]; then
            SELECTED=$(echo "$ALL_WALLPAPERS" | shuf -n 1)
          fi
        else
          SELECTED=$(echo "$ALL_WALLPAPERS" | shuf -n 1)
        fi
        
        # Save current selection
        echo "$SELECTED" > "$LAST_WALLPAPER_FILE"
        
        echo "Changing to: $SELECTED"
        ${pkgs.swww}/bin/swww img "$SELECTED"
      '';
    in "${wallpaperScript}";  };
  };


  # Possibly use DVC as a exec command somewhere in login sequence to check if wallpapers are present if not then fetch from external source using DVC
  xdg.configFile.wallpapers = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/swww/wallpapers");   
  };
}
