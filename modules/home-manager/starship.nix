{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      palette = "gruvbox_dark";
      format = "$directory$git_branch$nodejs$python\n$character";

      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        format = "[](fg:orange)[ $path]($style)[](fg:orange bg:yellow)";
        style = "bold fg:dark_bg bg:orange";
      };

      git_branch = {
        symbol = " ";
        format = "[$symbol$branch]($style)[](fg:yellow bg:green)";
        style = "bold fg:dark_bg bg:yellow";
      };

      nodejs = {
        format = "[ $version]($style)[](fg:green bg:aqua)";
        style = "bold fg:dark_bg bg:green";
      };

      python = {
        format = "[ $version]($style)[](fg:aqua bg:blue)";
        style = "bold fg:dark_bg bg:aqua";
      };

      character = {
        success_symbol = "[❯](bold fg:blue)";
        error_symbol = "[❯](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:blue)";
        format = "[](fg:blue)$symbol ";
      };

      palettes = {
        gruvbox_dark = {
          dark_bg = "#282828";
          red = "#cc241d";
          orange = "#d65d0e";
          yellow = "#d79921";
          green = "#98971a";
          aqua = "#689d6a";
          blue = "#458588";
        };
      };
    };
  };
}
