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
    ignores = [ "*.swp" ];
    userName = variables.git.username;
    userEmail = variables.git.email;

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
