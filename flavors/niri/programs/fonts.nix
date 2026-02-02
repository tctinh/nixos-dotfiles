{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
    inter
    roboto
    noto-fonts
    noto-fonts-cjk-sans
    source-han-sans
    noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Noto Serif" "Noto Serif CJK SC" ];
      sansSerif = [ "Inter" "Noto Sans" "Noto Sans CJK SC" ];
      monospace = [ "JetBrainsMono Nerd Font" "Fira Code" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
