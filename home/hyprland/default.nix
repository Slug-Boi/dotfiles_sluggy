{pkgs,variables,config,inputs,...}: {

imports = [ ./theme.nix ];

home.sessionVariables = {
    # Force electron apps to use Wayland
    NIXOS_OZONE_WL = "1";

    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
};

home.packages = with pkgs; [
    rose-pine-hyprcursor
];

wayland.windowManager.hyprland = {
enable = true;
  settings = {
    env = [
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"
    ];
    exec-once = [
      "hyprpanel"
      "swww-daemon"
    ];
    "$mod" = "SUPER";
    "$terminal" = "rio";
    "$browser" = "firefox";
    bind = [
      "$mod, q, exec, $terminal"

      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      # Start terminal
      "$mod, RETURN, exec, $terminal"

      # Kill focused window
      "$mod SHIFT, Q, killactive"

      # Rofi launchers
      "$mod, D, exec, rofi -show drun"
      "$mod SHIFT, D, exec, rofi -show p -modi p:~/.config/rofi/rofi-power-menu -width 20 -lines 6"

      # Focus movement (vim style)
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"

      # Focus movement (arrow keys)
      "$mod, Left, movefocus, l"
      "$mod, Down, movefocus, d"
      "$mod, Up, movefocus, u"
      "$mod, Right, movefocus, r"

      # Move windows (vim style)
      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, J, movewindow, d"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, L, movewindow, r"

      # Move windows (arrow keys)
      "$mod SHIFT, Left, movewindow, l"
      "$mod SHIFT, Down, movewindow, d"
      "$mod SHIFT, Up, movewindow, u"
      "$mod SHIFT, Right, movewindow, r"

      # Splitting
      # "$mod, B, split, h" # horizontal split
      # "$mod, V, split, v" # vertical split

      # Fullscreen
      "$mod, F, fullscreen, 1"
      "$mod SHIFT, F, fullscreen, 0"

      # Layout toggling
      "$mod, S, togglesplit" # toggle split layout

      # Floating/Session Actions
      "$mod, W, togglefloating"
      "$mod, SPACE, cyclenext" # similar to focus mode toggle

      # Grouping windows
      "$mod, G, togglegroup"
      "$mod SHIFT, G, moveintogroup"
      "$mod SHIFT, Tab, changegroupactive, f"
      "$mod CTRL, Tab, changegroupactive, b"
      

      # Workspace switching (1-9)
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"
      
      # Mouse Workspace Scrolling
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # Special workspaces
      "$mod SHIFT, Z, movetoworkspacesilent, special"
      "$mod, Z, togglespecialworkspace"

      # Move windows to workspaces (1-10)
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      # Move workspaces between monitors
      "$mod CTRL, Right, movecurrentworkspacetomonitor, +1"
      "$mod CTRL, Left, movecurrentworkspacetomonitor, -1"
      "$mod CTRL, L, movecurrentworkspacetomonitor, +1"
      "$mod CTRL, H, movecurrentworkspacetomonitor, -1"

      # Keyboard layout switching
      "$mod CONTROL, D, exec, setxkbmap dk"
      "$mod CONTROL, U, exec, setxkbmap us"

      # Lock
      "$mod+SHIFT+CTRL, L, exec, hyprlock"
    ];

    windowrule = [
    "workspace 1, class:^(firefox)$"
    "workspace 2, class:^(discord)$"
    "workspace 2, class:^(Spotify)$"
    # "workspace 9, class:^(easyeffects)$"
    ];

    workspace = [
    "1, monitor:DP-2"
    "2, monitor:DP-1"
    "9, monitor:DP-1"
    ];
    
    bindm = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
    ];
    input = {
      kb_options = "caps:escape";
    };

    monitor = [
      # Main monitor (left) - 1920x1080@144
      "DP-2,1920x1080@144,0x0,1"
    
      # Second monitor (right) - 2560x1440@60  
      "DP-1,2560x1440@60,1920x0,1"

    ];
  };
};

}
