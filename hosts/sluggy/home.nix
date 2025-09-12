{...}: {
  imports = [
    ../../home/common.nix
    ../../home/betterlockscreen
    #../../home/dunst
    ../../home/fish
    ../../home/git
    ../../home/i3
    ../../home/kitty
    ../../home/lazygit
    ../../home/nvim
    ../../home/rio
    ../../home/zsh
    ../../home/yazi
    #(import ../../home/picom {nvidiaDrivers = true;})
    ../../home/polybar
    ../../home/rofi
    ../../home/wallpapers
    ../../home/easyeffects
    #../../home/zathura
    ../../home/nixos/nixprograms.nix
    ../../home/nixos/nixos_langs.nix


    #../../home/k8.nix
    ../../home/katty
    ../../home/langs.nix
    ../../home/python3.nix
    ../../home/hyprpanel
    ../../home/hyprland
    ../../home/hyprlock
    ../../home/swww

    #../../home/anytype.nix
    #../../home/todo.nix
    ../../home/obs.nix
    ../../home/programs.nix
    ../../home/tmux.nix
    ../../home/utils.nix
    ../../home/vscode.nix
  ];
}
