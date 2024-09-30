# Naming this file was one of the hardest things to do apparently. Both config, options, setting and args were already taken.
# So yes, it's a stupid name, but i can't be arsed anymore
let
  username = "karpe";
  homeDirectory = builtins.toPath "/home/${username}";
in {
  inherit username;

  homeDirectory = {
    path = homeDirectory;
    directories = ["Applications" "Documents" "Downloads" "Music" "Movies" "Pictures" "Sites"];
  };

  git = {
    username = "Slug-Boi";
    email = "theis.p.holm@gmail.com";
  };

  dotfilesLocation = homeDirectory + (builtins.toPath "/Documents/dotfiles");

  #initialPassword = "changeme";

  #stateVersion = "23.11";
}
