{
  description = "streaming-heart";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixos-hardware, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      streaming-heart = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system.nix
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-gpu-amd
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-cpu-amd-zenpower
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.ivan = import ./home.nix;
                extraSpecialArgs = inputs;
              };
            }
        ];
      };
    };
  };
}
/*
 */
