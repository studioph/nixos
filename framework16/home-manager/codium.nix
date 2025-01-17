{ pkgs, extensions, ... }:

let
  compatibleExtensions = extensions.forVSCodeVersion (pkgs.vscodium.version);

in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # Disabled otherwise it causes file conflict since home-manager tries to generate a separate settings.json
    # These are set in the symlinked settings.json from the configs folder
    #         enableUpdateCheck = false;
    #         enableExtensionUpdateCheck = false;
    mutableExtensionsDir = true; # Required for stupid .NET extensions
    extensions = (with compatibleExtensions.open-vsx; [
      adguard.adblock
      antfu.icons-carbon
      csharpier.csharpier-vscode
      detachhead.basedpyright
      devsense.phptools-vscode
      ecmel.vscode-html-css
      equinusocio.vsc-material-theme
      fernandoescolar.vscode-solution-explorer
      golang.go
      hangxingliu.vscode-systemd-support
      hashicorp.terraform
      jnoortheen.nix-ide
      mechatroner.rainbow-csv
      mkhl.direnv
      ms-azuretools.vscode-docker
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-python.black-formatter
      ms-python.isort
      ms-python.pylint
      ms-python.python
      ms-vscode.hexeditor
      pkief.material-icon-theme
      redhat.java
      redhat.vscode-xml
      redhat.vscode-yaml
      ritwickdey.liveserver
      tamasfe.even-better-toml
      timonwong.shellcheck
      tomoyukim.vscode-mermaid-editor
      tyriar.sort-lines
      yzhang.markdown-all-in-one
      "3timeslazy".vscodium-devpodcontainers
      #             muhammad-sammy.csharp # Have to install manually cause it also dynamically downloads Omnisharp into it's folder
    ])
    ++ (with compatibleExtensions.open-vsx-release; [
      eamodio.gitlens
      rust-lang.rust-analyzer
    ])
    ++ (with compatibleExtensions.vscode-marketplace; [
      ms-dotnettools.vscode-dotnet-runtime
    ]);
  };

  home.file."VSCodium settings" = {
    source = ./configs/vscodium-settings.json;
    target = ".config/VSCodium/User/settings.json";
  };
}
