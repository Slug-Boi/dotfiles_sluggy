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
    userName = variables.git.username;
    userEmail = variables.git.email;
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

    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = false;
      # rebase.autoStash = true;
      credential.helper = "store";
      core = {
        editor = "vim";
        autocrlf = "input";
      };
    };

    lfs = {
      enable = true;
    };
  };
}
