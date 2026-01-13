{ pkgs, ... }: {
  # System fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-nerdfont
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}
