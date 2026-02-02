{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.helix;
    defaultEditor = true;

    settings = {
      theme = "catppuccin-mocha";

      editor = {
        line-number = "relative";
        inline-diagnostics = {
          cursor-line = "hint";
        };
      };

      keys = {
        normal = {
          tab = "buffer_next";
          "S-tab" = "buffer_previous";
          "A-h" = "move_char_left";
          "A-j" = "move_line_down";
          "A-k" = "move_line_up";
          "A-l" = "move_char_right";
          "C-h" = "jump_view_left";
          "C-j" = "jump_view_down";
          "C-k" = "jump_view_up";
          "C-l" = "jump_view_right";
        };
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.alejandra}/bin/alejandra";
          };
          language-server = {
            command = "${pkgs.nil}/bin/nil";
          };
        }
        {
          name = "javascript";
          auto-format = true;
          formatter = {
            command = "${pkgs.biome}/bin/biome";
            args = [ "format" "--write" "--stdin-file-path" "%{buffer_name}" ];
          };
          language-server = {
            command = "${pkgs.biome}/bin/biome";
            args = [ "lsp" "--stdio" ];
          };
        }
        {
          name = "typescript";
          auto-format = true;
          formatter = {
            command = "${pkgs.biome}/bin/biome";
            args = [ "format" "--write" "--stdin-file-path" "%{buffer_name}" ];
          };
          language-server = {
            command = "${pkgs.biome}/bin/biome";
            args = [ "lsp" "--stdio" ];
          };
        }
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = "${pkgs.shfmt}/bin/shfmt";
          };
          language-server = {
            command = "${pkgs.shfmt}/bin/shfmt";
          };
        }
        {
          name = "markdown";
          language-server = {
            command = "${pkgs.marksman}/bin/marksman";
          };
        }
      ];
    };
  };

  home.packages = with pkgs; [
    nil
    biome
    marksman
    shfmt
  ];
}
