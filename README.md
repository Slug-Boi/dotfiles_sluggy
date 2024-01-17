# THIS IS A FORK FROM ALBE's Dotfiles. These have been modifed to be used with my own PC use them at your own risk.
## The install guide files have been left untouched as these were fairly good to get going for me but it does require a bit of troubleshooting. 

# .files

## Requirements
*Note: I aim to auto install these at some point*
### Tools
- [oh-my-posh](https://ohmyposh.dev)
- [neovim](https://github.com/neovim/neovim/releases/latest)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [fd](https://github.com/sharkdp/fd/releases/latest)
  - You will need PCRE2 support for telekazten, so install with `cargo install ripgrep --features 'pcre2'`
- [rg](https://github.com/BurntSushi/ripgrep)
- [fisher](https://github.com/jorgebucaran/fisher)

### Font
- [fira code patched](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode/Regular/complete)
  - [Refer to this superuser answer regarding gnome terminal issues](https://superuser.com/questions/1335155/patched-fonts-not-showing-up-on-gnome-terminal)

### Language specific tools
  - ``npm install -g typescript typescript-language-server vscode-langservers-extracted prettier``
  - Install [lua language server](https://github.com/sumneko/lua-language-server/releases)
  - Install [clangd](https://clangd.llvm.org/installation.html)
    - Be sure to install version 14 or higher 

## TODO
- Add windows terminal profiles and settings
- Add [bufferline](https://github.com/akinsho/bufferline.nvim) or cokeline
- Setup PolyBar
- Setup screenshotting tool
- Install guide

## Shell
```bash
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Plugins
fisher install FabioAntunes/fish-nvm edc/bass
```

## Slack
### Horizon theme
```
#1D1F27,#121016,#22252E,#E0E2E3,#22252E,#7F8086,#27D796,#D18274,#1D1F27,#B173D3
```

### Everforest
```
#2B3339,#3B4252,#4C555B,#D3C6AA,#3A454A,#D3C6AA,#A7C080,#E67E80,#2B3339,#D3C6AA
```
