{ config, pkgs, pkgs-unstable, lib, home-manager, specialArgs, ... }:

let
  user = "karpe";
in
{
  imports = [
   ./dock
  ];
  
  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;

    # Custom taps 
    taps = [
       # "nikitabobko/tap"
       # "FelixKratz/formulae"
    ];
    casks = pkgs.callPackage ./casks.nix {};
    
    # onActivation.cleanup = "uninstall";


    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
  };

  # Enable home-manager
  home-manager = {
    
    useGlobalPkgs = true;

    extraSpecialArgs = specialArgs;
    
    users.${user} = { pkgs, config, lib, ... }:
    {
    imports = [
        ../shared/home.nix 
      ];
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
        ];
        stateVersion = "23.11";
      };
      programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };


      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    { path = "/System/Library/CoreServices/Finder.app"; }
    { path = "/Applications/Firefox Nightly.app"; }
    { path = "/Applications/Spotify.app/"; }
    { path = "/System/Applications/App Store.app"; }
    { path = "/System/Applications/System Settings.app"; }
    { path = "/Applications/Discord.app/"; }
    { path = "/Applications/Notion.app/"; }
    { path = "/Applications/Visual Studio Code.app"; }
    { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
    { path = "/Applications/Microsoft Outlook.app"; }
    { path = "/System/Applications/Calendar.app"; }
    ];

}
