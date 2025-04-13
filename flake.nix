{
  description = "A NixOS configuration made by a silly goose way over their head";

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
  };

  # These urls should coincide with the stateVersion variable in the variables.nix file
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Use stable for now
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixos-generators,
    home-manager,
    nix-index-database,
    ...
  }: let
    args =
      {
        variables = import ./variables.nix;
        theme = import ./theme.nix;
      }
      // inputs;

    hosts = import ./hosts args;
    installers = import ./hosts/installers.nix ({
        hosts = hosts.hosts;
        systems = hosts.allSystems;
      }
      // args);
  in {
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
