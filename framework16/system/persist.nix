{ ... }:
{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/var/lib/flatpak"
    ];
    files = [
      "/etc/machine-id"
      "/etc/passwd"
      "/etc/shadow"
      "/etc/setuid"
      "/etc/setgid"
      "/etc/group"
    ];
    users.paul = {
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
        ".config/mozilla"
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
