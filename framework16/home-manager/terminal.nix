{...}:
{
  home = {
    file."starship config" = {
            source = ./configs/starship.toml;
            target = ".config/starship.toml";
        };

        file."konsole profile" = {
            source = ./configs/studiop.profile;
            target = ".local/share/konsole/studiop.profile";
        };
  };
  programs.starship.enable = true;
  programs.bash = {
        enable = true;
        shellAliases = {
            docker = "podman";
            terraform = "tofu";
        };
    };
  programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
}