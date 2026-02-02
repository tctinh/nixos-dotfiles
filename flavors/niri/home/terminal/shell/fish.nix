{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
      set -gx EDITOR "hx"
      set -gx VISUAL "hx"
      set -gx PAGER "less -R"
    '';

    shellAliases = {
      ll = "ls -lah";
      la = "ls -a";
      l = "ls -lh";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
      dots = "cd ~/nixos-dotfiles";
    };

    shellAbbrs = {
      gco = "git checkout";
      gcb = "git checkout -b";
      gl = "git log --oneline --graph --decorate";
    };
  };
}
