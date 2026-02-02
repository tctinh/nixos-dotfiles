{ pkgs, ... }:
{
  boot = {
    # CachyOS kernel from chaotic-nyx overlay (enabled via nixosModules.default)
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [ "quiet" "splash" "loglevel=3" "rd.systemd.show_status=false" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}
