{
  pkgs,
  variables,
  ...
}: {
  home.packages = with pkgs; [
    bfg-repo-cleaner
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
      name = variables.git.username;
      email = variables.git.email;
      };
      init.defaultBranch = "master";
      pull.rebase = false;
      # rebase.autoStash = true;
      credential.helper = "store";
      core = {
        editor = "vim";
        autocrlf = "input";
      };
    };
    ignores = [
      "*.swp"
      "*.swo"
      "*.DS_Store"
      ".DS_Store"
      ".idea/"
      ".vscode/"
      "logs/"
      "tmp/"
    ];


    lfs = {
      enable = true;
    };
  };
}
