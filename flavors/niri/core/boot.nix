{ inputs, pkgs, ... }:
{
  boot = {
    kernelPackages = inputs.chaotic.packages.${pkgs.system}.linuxPackages_cachyos;
    kernelParams = [ "quiet" "splash" "loglevel=3" "rd.systemd.show_status=false" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}
