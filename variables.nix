# Naming this file was one of the hardest things to do apparently. Both config, options, setting and args were already taken.
# So yes, it's a stupid name, but i can't be arsed anymore
let
  username = "sluggy";
  homeDirectory = builtins.toPath "/home/${username}";
in {
  inherit username;

  homeDirectory = {
    path = homeDirectory;
    directories = ["Documents" "Downloads" "Music" "Pictures" "Videos"];
  };

  git = {
    username = "Slug-Boi";
    email = "theis.p.holm@gmail.com";
  };

  dotfilesLocation = homeDirectory + (builtins.toPath "/Documents/Coding/Other/dotfiles");

  initialPassword = "changeme";

  stateVersion = "23.11";
}
