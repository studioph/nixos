{ pkgs, ... }:
{
  home = {
    persistence."/persist" = {
      hideMounts = true;
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "dev"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        ".MakeMKV"
        ".mozilla"
        ".nuget"
        ".thunderbird"
        ".vscode-oss"
        ".var/app"
        "Templates"
        ".icons"
        ".local/share/containers"
      ];
      files = [
        ".kube/config"
        ".talos/config"
        ".config/helm/repositories.yaml"
      ];
    };
  };
}
