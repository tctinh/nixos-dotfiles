{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  programs.fish = {
    enable = true;
    vendor = {
      config.enable = true;
      completions.enable = true;
      functions.enable = true;
    };
  };
}
