{
  description = "StudioP";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, hardware, ... }:
    let
      username = "paul";
    in
    {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      nixosConfigurations.studiop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username; }; # allows access to flake inputs in nixos modules
        modules = [
          ./configuration.nix
        ];
      };
    };
}
