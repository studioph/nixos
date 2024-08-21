{
  description = "StudioP";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nurpkgs = {
      url = "github:nix-community/NUR";
#       inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nurpkgs, hardware, plasma-manager, nix-flatpak, ... }:
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        nurpkgs.overlay
      ];
    };
    username = "paul";
  in {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    nixosConfigurations.studiop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs username; }; # allows access to flake inputs in nixos modules
      modules = [
        ./configuration.nix
      ];
    };

    # homeConfigurations."${username}" =
    #   home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     modules = [
    #       ./home.nix
    #       plasma-manager.homeManagerModules.plasma-manager
    #       nix-flatpak.homeManagerModules.nix-flatpak
    #     ];
    #     extraSpecialArgs = { inherit inputs username; };
    #   };
    };
}
