{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Core KDE apps
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.kate
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.okular

    # Utilities
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kcolorchooser
    kdePackages.kfind
    kdePackages.kmag
    kdePackages.ksystemlog
    kdePackages.ksystemstats
    kdePackages.filelight
  ];
}
