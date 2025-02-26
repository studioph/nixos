{ pkgs, unstable, ... }:
let
  dotnetSDK = pkgs.dotnet-sdk_8;
in
{
  home = {
    packages = (with pkgs; [
      kdePackages.kate
      python3
      rustup
      pdm
      virt-manager
      bitwarden
      gomplate
      marktext
      kdePackages.krdc
      ungoogled-chromium
      talosctl
      libreoffice-qt
      ffmpeg
      xdg-desktop-portal
      kdePackages.xdg-desktop-portal-kde
      kdePackages.kdeconnect-kde
      nodejs_20
      kdePackages.plasma-workspace-wallpapers
      kdePackages.plasma-browser-integration
      nerdfonts
      nextcloud-client
      kdePackages.kolourpaint
      vlc
      kdePackages.filelight
      kdePackages.skanpage
      protonmail-bridge-gui
      kdePackages.kweather
      vimix-cursors
      papirus-icon-theme
      tela-icon-theme
      fluent-icon-theme
      dotnetSDK # Defined as let var
      xournalpp
      kdePackages.kcalc
      protonmail-bridge
      qownnotes
      libsForQt5.kamoso
      nil
      dino
      kdePackages.merkuro
      kdePackages.akonadi
      kdePackages.kdepim-runtime
      kdePackages.k3b
      kdePackages.ksshaskpass
      kid3
      go-task
      gtkterm
      drawio
      android-tools
      opentofu
      kdePackages.kdenlive
      p7zip # TODO: Remove once Ark works without it
      go-task
      podman-tui
      dive
      podman-compose
      kdePackages.isoimagewriter
      kubernetes-helm
      helmfile
      kubernetes-helmPlugins.helm-diff
      kubernetes-helmPlugins.helm-git
      kubectl
      pyenv
      webcord
      netcoredbg
      hunspell
      hunspellDicts.en_US
      jetbrains.rider
      rclone
      nixpkgs-fmt
      freecad
      devpod
      dbgate
    ]);

    sessionVariables = {
      DOTNET_ROOT = "${dotnetSDK}";
    };
  };

  services.flatpak.packages = [
    "com.usebottles.bottles"
  ];
}
