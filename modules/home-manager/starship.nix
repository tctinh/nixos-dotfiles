{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = "$directory$git_branch$git_status$nix_shell\n$character";

      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        style = "bold cyan";
      };

      git_branch = {
        symbol = "";
        style = "bold purple";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "bold yellow";
      };

      nix_shell = {
        format = "[nix]($style) ";
        style = "bold blue";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold green)";
        format = "$symbol ";
      };

      aws.disabled = true;
      azure.disabled = true;
      bun.disabled = true;
      c.disabled = true;
      cmake.disabled = true;
      cobol.disabled = true;
      conda.disabled = true;
      crystal.disabled = true;
      daml.disabled = true;
      dart.disabled = true;
      deno.disabled = true;
      dotnet.disabled = true;
      elixir.disabled = true;
      elm.disabled = true;
      erlang.disabled = true;
      fennel.disabled = true;
      golang.disabled = true;
      guix_shell.disabled = true;
      gradle.disabled = true;
      haskell.disabled = true;
      helm.disabled = true;
      java.disabled = true;
      julia.disabled = true;
      kotlin.disabled = true;
      lua.disabled = true;
      meson.disabled = true;
      nim.disabled = true;
      nodejs.disabled = true;
      ocaml.disabled = true;
      opa.disabled = true;
      perl.disabled = true;
      php.disabled = true;
      pulumi.disabled = true;
      purescript.disabled = true;
      python.disabled = true;
      rlang.disabled = true;
      ruby.disabled = true;
      rust.disabled = true;
      scala.disabled = true;
      swift.disabled = true;
      terraform.disabled = true;
      typst.disabled = true;
      vagrant.disabled = true;
      vlang.disabled = true;
      zig.disabled = true;
    };
  };
}
