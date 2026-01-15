{ pkgs, ... }: {
  # System fonts
  fonts.packages = with pkgs; [
    # Programming fonts with ligatures (=> || != <= -> etc.)
    jetbrains-mono                # Best overall programming font
    fira-code                     # Classic with most ligatures
    nerd-fonts.jetbrains-mono     # JetBrains Mono + icons
    nerd-fonts.fira-code          # FiraCode + icons
    nerd-fonts.caskaydia-cove     # Cascadia Code Nerd Font (correct nerd-fonts name)

    # System/UI fonts
    inter                         # Modern UI font (GitHub, Figma style)
    roboto                        # Clean, versatile UI font

    # Vietnamese + Unicode support
    noto-fonts                    # Base Noto fonts
    noto-fonts-cjk-sans           # CJK + Vietnamese
    source-han-sans               # Alternative CJK/Vietnamese

    # Emoji
    noto-fonts-color-emoji        # Color emoji support
  ];

  # Font configuration for better rendering
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
