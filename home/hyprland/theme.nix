{pkgs, variables, config, ...}: {
wayland.windowManager.hyprland.settings = {
    # General Deco

    general = {
      gaps_in = 3;
      gaps_out = 8;
      border_size = 2;
      "col.active_border" = "rgba(b16286cc) rgba(eebd35cc) 45deg";
      "col.inactive_border" = "rgba(689d6acc) rgba(458588cc) 45deg";
      layout = "dwindle";
      resize_on_border = true;
    };

    # TODO: Change to citrustzest colors and maybe base of theme root file instead
    group = {
      "col.border_active" = "rgba(b16286cc) rgba(eebd35cc) 45deg";
      "col.border_inactive" = "rgba(689d6acc) rgba(458588cc) 45deg";
      "col.border_locked_active" = "rgba(b16286cc) rgba(eebd35cc) 45deg";
      "col.border_locked_inactive" = "rgba(689d6acc) rgba(458588cc) 45deg";
    };

    decoration = {
      rounding = 10;
      #drop_shadow = false;
      
      inactive_opacity = 0.85;
      active_opacity = 0.95;
      fullscreen_opacity = 1.0;


      blur = {
        enabled = true;
        size = 6;
        passes = 3;
        new_optimizations = true;
        ignore_opacity = true;
        xray = false;
      };
    };

    #layout

    dwindle = {
      pseudotile = true; # master switch for pseudotiling, enable with mainMod + P
      preserve_split = true;
    };

    master = {
      new_status = "slave";    
    };

    # Misc

    misc = {
      vrr = 0;
    };

    #  █▀▀█ █▀▀▄ ▀█▀ █▀▄▀█ █▀▀█ ▀▀█▀▀ ▀█▀ █▀▀█ █▀▀▄ 
    #  █▄▄█ █  █  █  █ ▀ █ █▄▄█   █    █  █  █ █  █ 
    #  █  █ ▀  ▀ ▄█▄ ▀   ▀ ▀  ▀   ▀   ▄█▄ ▀▀▀▀ ▀  ▀
    
    animations = {
      enabled = true;
      
      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.1"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
      ];

      animation = [
        "windows, 1, 6, wind, slide"
        "windowsIn, 1, 6, winIn, slide"
        "windowsOut, 1, 5, winOut, slide"
        "windowsMove, 1, 5, wind, slide"
        "border, 1, 1, liner"
        "borderangle, 1, 30, liner, loop"
        "fade, 1, 10, default"
        "workspaces, 1, 5, wind"
      ];
    };

    #  █▀▀▀█  █▀▀█  █▀▀█  █▀▀█ ▀█▀ ▀▀█▀▀  █   █ 
    #  █   █  █▄▄█  █▄▄█  █     █    █    █▄▄▄█
    #  █▄▄▄█  █     █  █  █▄▄█ ▄█▄   █      █  

   windowrulev2 = [
      # Syntax: "rule, condition"
      # Set base opacity for all windows
      "opacity 0.98, class:^(rio)$"
      
      # Keep focused windows fully opaque
    ];
  };
}
