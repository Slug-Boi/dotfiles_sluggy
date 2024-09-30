{ config, pkgs, ... }:

#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#  Incomplete list of macOS `defaults` commands :
#    https://github.com/yannbertrand/macos-defaults

let user = "karpe"; in

{
  imports = [
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
    
  ];

  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 1; Hour = 0; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.checks.verifyNixPath = false;

  environment.systemPackages = [
    #emacs-unstable
  ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  # launchd.user.agents.emacs.path = [ config.environment.systemPath ];
  # launchd.user.agents.emacs.serviceConfig = {
  #   KeepAlive = true;
  #   ProgramArguments = [
  #     "/bin/sh"
  #     "-c"
  #     "/bin/wait4path ${pkgs.emacs}/bin/emacs && exec ${pkgs.emacs}/bin/emacs --fg-daemon"
  #   ];
  #   StandardErrorPath = "/tmp/emacs.err.log";
  #   StandardOutPath = "/tmp/emacs.out.log";
  # };
  
  security.pam.enableSudoTouchIdAuth = true;

  time.timeZone = "Europe/Copenhagen";

  system = {

  keyboard = {
      enableKeyMapping = true; # enable key mapping so that we can use `option` as `control`

      remapCapsLockToControl = false; # remap caps lock to control, useful for emac users
      remapCapsLockToEscape = true; # remap caps lock to escape, useful for vim users
      
    };

    stateVersion = 4;

     # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock

      NSGlobalDomain = {

        AppleShowAllExtensions = true;

        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;

        # Appearance
        AppleInterfaceStyle = "Dark"; # dark mode

        AppleKeyboardUIMode = 3; # Mode 3 enables full keyboard control.
        ApplePressAndHoldEnabled = true; # enable press and hold

        #NSAutomaticCapitalizationEnabled = false; # disable auto capitalization        
        #NSAutomaticDashSubstitutionEnabled = false; # disable auto dash substitution 
        NSAutomaticPeriodSubstitutionEnabled = false; # disable auto period substitution
        #NSAutomaticQuoteSubstitutionEnabled = false; # disable auto quote substitution 
        #NSAutomaticSpellingCorrectionEnabled = false; # disable auto spelling correction 
        #NSNavPanelExpandedStateForSaveMode = true; # expand save panel by default
        #NSNavPanelExpandedStateForSaveMode2 = true;
      };

      dock = {
        autohide = true;
        show-recents = false;
        # do not automatically rearrange spaces based on most recent use.
        mru-spaces = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
        AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extensions
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true; 
        TrackpadThreeFingerDrag = true;
      };

       # customize settings that not supported by nix-darwin directly
      # Incomplete list of macOS `defaults` commands :
      #   https://github.com/yannbertrand/macos-defaults
      CustomUserPreferences = {
        "com.apple.finder" = {
          AppleShowAllFiles = false;
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };

        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0; # Click wallpaper to reveal desktop
          StandardHideDesktopIcons = true; # Hide items on desktop
          HideDesktop = true; # Do hide items on desktop & stage manager
          StageManagerHideWidgets = 0;
          StandardHideWidgets = 0;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 10;
        };
        "com.apple.screencapture" = {
          location = "~/Screenshots";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        loginwindow = {
        GuestEnabled = false; # disable guest user
        };          
      };
      # keyboard settings is not very useful on macOS
    # the most important thing is to remap option key to alt key globally,
    # but it's not supported by macOS yet.

    };
  };
}
