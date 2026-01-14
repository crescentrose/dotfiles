{
  description = "starlight";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
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
      dms,
      ...
    }:
    let
      linuxPkgs = import nixpkgs { system = "x86_64-linux"; };
      darwinPkgs = import nixpkgs { system = "aarch64-darwin"; };
      devShellHook = ''
        export PATH="$PWD/scripts/bin:$PATH"
        printf "\n❄️ Quick reference:\n\n"
        printf "  • \`manage-system update\`   – update the flake\n"
        printf "  • \`manage-system rebuild\`  – rebuild and switch\n"
        printf "  • \`manage-system clean-up\` – collect garbage\n"
        printf "\n💡 Once installed, these commands are available system-wide.\n\n"
      '';
    in
    {
      devShells = {
        "x86_64-linux".default = linuxPkgs.mkShellNoCC {
          name = "dotfiles-linux";
          buildPackages = [ linuxPkgs.nushell ];
          shellHook = devShellHook;
        };

        "aarch64-darwin".default = darwinPkgs.mkShellNoCC {
          name = "dotfiles-mac";
          buildPackages = [ darwinPkgs.nushell ];
          shellHook = devShellHook;
        };
      };

      nixosConfigurations = {
        starlight = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [
            ./machines/starlight
            dms.nixosModules.greeter
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
