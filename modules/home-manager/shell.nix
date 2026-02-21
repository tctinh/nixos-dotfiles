{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      cleanup = "sudo nix-collect-garbage -d";
      bloat = "nix path-info -Sh /run/current-system";
      cat = "bat";
      l = "eza --group-directories-first --icons";
      ll = "eza -l --group-directories-first --icons";
      tree = "eza --tree --group-directories-first --icons";
    };
    interactiveShellInit = ''
      set -g fish_greeting

      bind \e\eOA history-prefix-search-backward
      bind \e\eOB history-prefix-search-forward

      bind --erase \es
      bind --erase \ev
      bind --erase \ez

      function fcd
        set -l target (fd --type d . --hidden --exclude .git | fzf)
        if test -n "$target"
          cd "$target"
        end
      end

      function fm
        set -l file (fd --type f . --hidden --exclude .git | fzf)
        if test -n "$file"
          kate "$file" &
        end
      end

      function installed
        nix profile list
      end
    '';
  };
}
