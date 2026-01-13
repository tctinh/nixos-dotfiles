{ pkgs, ... }: {
  # System fonts
  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code  # renamed from fira-code-nerdfont in unstable
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji  # renamed from noto-fonts-emoji in unstable
  ];
}
