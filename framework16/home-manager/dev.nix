{
  home = {
    file."gitconfig" = {
      source = ./configs/gitconfig;
      target = ".gitconfig";
    };

    file."gitignore" = {
      source = ./configs/global.gitignore;
      target = ".gitignore";
    };

    file."pdm config" = {
      source = ./configs/pdm.toml;
      target = ".config/pdm/config.toml";
    };
  };

  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        region = "us-east-1";
        output = "json";
      };
      "archive" = {
        region = "eu-north-1";
        output = "json";
      };
    };
  };

  programs.go.enable = true;
  programs.java.enable = true;

  programs.k9s.enable = true;

  programs.pyenv.enable = true;
  programs.git.enable = true;
}
