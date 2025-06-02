{ pkgs, extensions, unstable, ... }:

let
  compatibleExtensions = extensions.forVSCodeVersion (unstable.vscodium.version);

in
{
  programs.vscode = {
    enable = true;
    package = unstable.vscodium;
    # Disabled otherwise it causes file conflict since home-manager tries to generate a separate settings.json
    # These are set in the symlinked settings.json from the configs folder
    #         enableUpdateCheck = false;
    #         enableExtensionUpdateCheck = false;
    profiles.default.extensions = (with compatibleExtensions.open-vsx; [
      adguard.adblock
      antfu.icons-carbon
      detachhead.basedpyright
      ecmel.vscode-html-css
      t3dotgg.vsc-material-theme-but-i-wont-sue-you
      golang.go
      hangxingliu.vscode-systemd-support
      hashicorp.terraform
      jnoortheen.nix-ide
      mechatroner.rainbow-csv
      ms-azuretools.vscode-docker
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-python.black-formatter
      ms-python.isort
      ms-python.pylint
      ms-python.python
      ms-vscode.hexeditor
      pkief.material-icon-theme
      redhat.vscode-xml
      redhat.vscode-yaml
      ritwickdey.liveserver
      tamasfe.even-better-toml
      timonwong.shellcheck
      tomoyukim.vscode-mermaid-editor
      tyriar.sort-lines
      yzhang.markdown-all-in-one
      jeanp413.open-remote-ssh
    ])
    ++ (with compatibleExtensions; [
      # Specify separately otherwise the quoting doesn't work properly
      open-vsx."3timeslazy".vscodium-devpodcontainers
    ])
    ++ (with compatibleExtensions.open-vsx-release; [
      eamodio.gitlens
      rust-lang.rust-analyzer
    ]);
  };

  home.file."VSCodium settings" = {
    source = ./configs/vscodium-settings.json;
    target = ".config/VSCodium/User/settings.json";
  };
}
