{
  description = "A NixOS configuration made by a silly goose way over their head";

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
  };

  # These urls should coincide with the stateVersion variable in the variables.nix file
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Use stable for now
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-services = {
      url = "github:homebrew/homebrew-services";
      flake = false;
    };
    homebrew-aerospace = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };
    homebrew-felix = {
      url = "github:FelixKratz/homebrew-formulae";
      flake = false;
    };
    homebrew-jorgelbg = {
      url = "github:jorgelbg/homebrew-tap";
      flake = false;
    };
    cocommit = {
      url = "github:Slug-Boi/cocommit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sddm-astronaut-theme = {
      url = "./flakes/sddm-astronaut-theme";
    };

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = inputs @ {
    self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask,homebrew-services, home-manager, homebrew-aerospace, homebrew-felix, homebrew-jorgelbg, nixpkgs, nixpkgs-unstable, disko, nixos-generators,
    nix-index-database, cocommit,
    ...
  }: let
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs (darwinSystems) f;
      devShell = system: let pkgs = nixpkgs.legacyPackages.${system}; in {
        default = with pkgs; mkShell {
          nativeBuildInputs = with pkgs; [ bashInteractive git ];
          shellHook = with pkgs; ''
            export EDITOR=vim
          '';
        };
      };
      mkApp = scriptName: system: {
        type = "app";
        program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
          #!/usr/bin/env bash
          PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
          echo "Running ${scriptName} for ${system}"
          exec ${self}/apps/${system}/${scriptName}
        '')}/bin/${scriptName}";
      };
      mkLinuxApps = system: {
        "apply" = mkApp "apply" system;
        "build-switch" = mkApp "build-switch" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "install" = mkApp "install" system;
      };
      mkDarwinApps = system: {
        "apply" = mkApp "apply" system;
        "build" = mkApp "build" system;
        "build-switch" = mkApp "build-switch" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "rollback" = mkApp "rollback" system;
      };
      args =
        {
        inherit inputs;
        variables = import ./variables.nix;
        theme = import ./theme.nix;
      } // inputs;

      user = args.variables.username;
      hosts = import ./hosts args;
      installers = import ./hosts/installers.nix ({
          hosts = hosts.hosts;
          systems = hosts.allSystems;
      }
      // args);

  in {
    devShells = forAllSystems devShell;
      apps = nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;

      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system: let
        #user = "slugboi";  
        args = {
          variables = import ./variables.nix;
          theme = import ./theme.nix;
        }//inputs;
        in
        darwin.lib.darwinSystem {
        
          inherit system;
          specialArgs = args;
          modules = [
            home-manager.darwinModules.home-manager {
                home-manager.extraSpecialArgs = args;
            }
            nix-homebrew.darwinModules.nix-homebrew 
            {
              #inherit args;
              nix-homebrew = {
                inherit user;
                enable = true;
                enableRosetta = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                  "homebrew/homebrew-services" = homebrew-services;
                  "nikitabobko/homebrew-nikitabobko" = homebrew-aerospace;
                  "felix/homebrew-felix" = homebrew-felix;
                  "jorgelbg/homebrew-jorgelbg" = homebrew-jorgelbg;
                };

                mutableTaps = false;
                autoMigrate = true;
              };
            } 
            ./hosts/darwin 
          ]; 
        }
        );

    homeManagerConfigurations.sluggy = home-manager.lib.homeManagerConfiguration {
        inherit nixpkgs;

        modules = [
          nix-index-database.hmModules.nix-index
          # optional to also wrap and install comma
          # { programs.nix-index-database.comma.enable = true; }
        ];
      };

    hosts = hosts;
    nixosConfigurations = hosts.nixosConfigurations;
    packages = hosts.packages;
    installers = installers;

    formatter = nixpkgs.lib.genAttrs hosts.allSystems (
      system: nixpkgs.legacyPackages.${system}.alejandra
    );
  };
}
