{...}: 
{
  imports = [
    # Darwin specific imports probably move

    ../../home/common.nix
    ../../home/darwin
    ../../home/darwin/aerospace
    ../../home/darwin/sketchybar

    #../../home/alacritty
    ../../home/git
    # ../../home/kitty
    ../../home/katty
    ../../home/rio
    ../../home/zsh
    ../../home/yazi
    ../../home/cocommit
    ../../home/lazygit
    ../../home/nvim 
    #../../home/php.nix
    ../../home/zellij
    ../../home/helix
    ../../home/gh-tools
    ../../home/ghostty

    ../../home/programs.nix
    ../../home/langs.nix
    ../../home/python3.nix
    ../../home/tmux.nix
    #TODO: unsupported platform darwin x86_64 look at later
    #../../home/vscode.nix
  ];
}
