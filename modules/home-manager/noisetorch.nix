{ pkgs, ... }: {
  systemd.user.services.noisetorch = {
    Unit = {
      Description = "NoiseTorch Noise Suppression";
      After = [ "pipewire.service" ];
      Requires = [ "pipewire.service" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.noisetorch}/bin/noisetorch -i";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
