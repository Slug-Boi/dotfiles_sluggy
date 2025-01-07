{...}: 
{
  imports = [
    # Darwin specific imports probably move

    ../../home/common.nix
    ../../home/darwin/aerospace
    ../../home/darwin/sketchybar


    ../../home/alacritty
    ../../home/git
    #../../home/kitty
    ../../home/zsh
    ../../home/yazi
    ../../home/cocommit
    ../../home/lazygit
    ../../home/nvim 

    ../../home/programs.nix
    ../../home/langs.nix
    ../../home/python3.nix
      
    ../../home/tmux.nix
    #TODO: unsupported platform darwin x86_64 look at later
    #../../home/vscode.nix
  ];
}
