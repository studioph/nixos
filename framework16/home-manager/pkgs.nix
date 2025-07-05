{ pkgs, ... }:
{
  home = {
    packages = (with pkgs; [
      android-tools
      bitwarden
      dbgate
      devpod
      dino
      dive
      drawio
      ffmpeg
      fluent-icon-theme
      freecad
      go-task
      gomplate
      gtkterm
      helmfile
      hunspell
      hunspellDicts.en_US
      kdePackages.akonadi
      kdePackages.filelight
      kdePackages.isoimagewriter
      kdePackages.k3b
      kdePackages.kate
      kdePackages.kcalc
      kdePackages.kdeconnect-kde
      kdePackages.kdenlive
      kdePackages.kdepim-runtime
      kdePackages.kolourpaint
      kdePackages.krdc
      kdePackages.ksshaskpass
      kdePackages.kweather
      kdePackages.merkuro
      kdePackages.plasma-browser-integration
      kdePackages.plasma-workspace-wallpapers
      kdePackages.skanpage
      kdePackages.xdg-desktop-portal-kde
      kid3
      kubectl
      (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-diff
          helm-git
        ];
      })
      libreoffice-qt
      libsForQt5.kamoso
      logseq
      nerd-fonts.agave
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.droid-sans-mono
      nerd-fonts.hack
      nerd-fonts.noto
      nerd-fonts.roboto-mono
      nerd-fonts.ubuntu-sans
      nextcloud-client
      nil
      nixpkgs-fmt
      nodejs_20
      opentofu
      p7zip # TODO: Remove once Ark works without it
      papirus-icon-theme
      pdm
      podman-compose
      podman-tui
      protonmail-bridge
      protonmail-bridge-gui
      pyenv
      python3
      rclone
      rustup
      talosctl
      tela-icon-theme
      ungoogled-chromium
      vimix-cursors
      virt-manager
      vlc
      webcord
      xdg-desktop-portal
      xournalpp
    ]);
  };

  services.flatpak.packages = [
    "com.usebottles.bottles"
  ];
}
