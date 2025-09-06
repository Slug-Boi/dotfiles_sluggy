# Naming this file was one of the hardest things to do apparently. Both config, options, setting and args were already taken.
# So yes, it's a stupid name, but i can't be arsed anymore
let
  username = "slugboi";
  homeDirectory = builtins.toPath "/Users/${username}";
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

  dotfilesLocation = homeDirectory + (builtins.toPath "/Documents/dotfiles_sluggy");

  initialPassword = "changeme";

  stateVersion = "25.11";
}
