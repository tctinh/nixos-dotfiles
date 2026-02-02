{ pkgs, ... }:
{
  users.users.tctinh = {
    isNormalUser = true;
    description = "tctinh";
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" "input" ];
    shell = pkgs.fish;
  };
}
