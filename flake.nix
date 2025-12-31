{
  description = "starlight";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      home-manager,
      nixos-hardware,
      nixpkgs,
      ragenix,
      nix-darwin,
      ...
    }:
    {
      nixosConfigurations = {
        starlight = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/starlight
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-gpu-amd
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-cpu-amd-zenpower
            ragenix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.ivan = import ./home/_home.nix;
                extraSpecialArgs = inputs;
              };
            }
          ];
        };
      };

      darwinConfigurations = {
        work = nix-darwin.lib.darwinSystem {
          modules = [
            ./machines/work
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                users."ivan.ostric" = import ./home/_work.nix;
                backupFileExtension = ".before-nix-darwin";
                extraSpecialArgs = inputs;
              };
            }
          ];
        };
      };
    };
}
