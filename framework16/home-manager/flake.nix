{
  description = "StudioP";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nurpkgs.url = "github:nix-community/NUR";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/001f9f541edd406ff00aab49d968f535658778fa";

  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nurpkgs, plasma-manager, nix-flatpak, nix-vscode-extensions, ... }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [
          nurpkgs.overlays.default
        ];
      };
      unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      username = "paul";
      extensions = nix-vscode-extensions.extensions.x86_64-linux;
    in
    {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      homeConfigurations."${username}" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            plasma-manager.homeManagerModules.plasma-manager
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
          extraSpecialArgs = { inherit inputs username extensions unstable; };
        };
    };
}
