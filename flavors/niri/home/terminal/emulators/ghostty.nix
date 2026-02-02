{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      command = "fish";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 11;
      theme = "Nord";
      window-padding-x = 8;
      window-padding-y = 8;
      window-decoration = true;
      cursor-style = "block";
      cursor-style-blink = true;
      copy-on-select = "clipboard";
      confirm-close-surface = false;
    };
  };
}
