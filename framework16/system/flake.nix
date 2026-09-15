{
  description = "StudioP";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    hardware.url = "github:nixos/nixos-hardware";

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs@{ self, nixpkgs, hardware, impermanence, ... }:
    let
      username = "paul";
    in
    {
      nixosConfigurations.studiop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username; }; # allows access to flake inputs in nixos modules
        modules = [
          ./configuration.nix
          hardware.nixosModules.framework-16-7040-amd
          impermanence.nixosModules.impermanence
        ];
      };
    };
}
