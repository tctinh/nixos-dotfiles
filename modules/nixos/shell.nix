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
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };

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
      teams-for-linux = "teams-for-linux --ozone-platform=x11";
      discord = "discord --ozone-platform=x11";
      mongodb-compass = "mongodb-compass --ozone-platform=x11";
    };
    interactiveShellInit = ''
      export OSH=${oh-my-bash-src}
      export OSH_THEME="agnoster"
      source "$OSH/oh-my-bash.sh"
    '';
  };
}
