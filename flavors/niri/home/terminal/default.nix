{ ... }: {
  imports = [
    ./shell/fish.nix
    ./shell/starship.nix
    ./emulators/ghostty.nix
    ./software/yazi.nix
    ./software/zoxide.nix
    ./software/atuin.nix
    ./software/bat.nix
    ./software/eza.nix
    ./software/git.nix
  ];
}
