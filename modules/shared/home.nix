{...}: 
let 
variables = import ../../variables.nix;
in
{
  imports = [
    # Darwin specific imports probably move

    ../../home/common.nix {inherit variables;}
    # ../../home/darwin/raycast
    # ../../home/darwin/aerospace
    # ../../home/darwin/sketchybar


    #../../home/alacritty
    # ../../home/git
    # ../../home/kitty
    #../../home/zsh
    # ../../home/cocommit
    #../../home/lazygit
    #../../home/nvim 

    ../../home/programs.nix
    ../../home/langs.nix
    ../../home/python3.nix
      
    ../../home/tmux.nix
    #../../home/vscode.nix
  ];
}
