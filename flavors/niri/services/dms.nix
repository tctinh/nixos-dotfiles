{ inputs, pkgs, ... }:
{
  imports = [
    inputs.dank-material-shell.nixosModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    package = inputs.dank-material-shell.packages.${pkgs.system}.default;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableClipboardPaste = true;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
  };
}
