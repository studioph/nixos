{ username, ... }:
{
  imports = [
    ./pkgs.nix
    ./codium.nix
    ./plasma.nix
    ./firefox.nix
    ./terminal.nix
    ./dev.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  programs.htop.enable = true;
  programs.yt-dlp.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "coreos" = {
        hostname = "coreos.studiop";
        user = "core";
        identityFile = "~/.ssh/coreos";
        extraOptions = { StrictHostKeyChecking = "no"; };
      };
      "truenas" = {
        hostname = "truenas.studiop";
        user = "admin";
        identityFile = "~/.ssh/truenas";
      };
    };
  };

  programs.thunderbird = {
    enable = true;
    profiles.studiop = {
      isDefault = true;
    };
  };
}
