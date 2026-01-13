{ pkgs, ... }: 

let
  oh-my-bash-src = pkgs.fetchFromGitHub {
    owner = "ohmybash";
    repo = "oh-my-bash";
    rev = "b88b2244f15a0e0f65f1588a3de2db6d1c55169b";
    sha256 = "sha256-yl2ZK+lCHfTwB2mRfZT7egFWUa40p3Z0O4SdqiOpGR8=";
  };
in
{
  # Set default shell
  users.defaultUserShell = pkgs.bash;
  environment.shells = with pkgs; [ bash ];

  # Bash configuration with oh-my-bash
  programs.bash = {
    completion.enable = true;
    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
      update = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
      dots = "cd ~/nixos-dotfiles";
      # VSCode aliases
      code = "code-insiders";
      code-stable = "/run/current-system/sw/bin/code";
    };
    interactiveShellInit = ''
      export OSH=${oh-my-bash-src}
      source "$OSH/oh-my-bash.sh"
    '';
  };
}
