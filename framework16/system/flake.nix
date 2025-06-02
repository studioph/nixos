{
  description = "StudioP";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs@{ self, nixpkgs, hardware, ... }:
    let
      username = "paul";
    in
    {
      nixosConfigurations.studiop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username; }; # allows access to flake inputs in nixos modules
        modules = [
          ./configuration.nix
          hardware.nixosModules.framework-16-7040-amd
        ];
      };
    };
}
