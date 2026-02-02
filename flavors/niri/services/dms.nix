{ inputs, pkgs, ... }:
{
  imports = [
    inputs.dank-material-shell.nixosModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    # Feature toggles
    enableClipboardPaste = true;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableVPN = true;
    enableCalendarEvents = true;
  };
}
