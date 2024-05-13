{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      vscodevim.vim
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
      #ms-dotnettools.vscode-dotnet-pack
      #Ionide.Ionide-fsharp
      ms-vsliveshare.vsliveshare
      ms-vscode.cpptools
      golang.go
      jebbs.plantuml
      ];
  };
}
