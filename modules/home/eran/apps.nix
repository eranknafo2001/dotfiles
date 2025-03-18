{ pkgs, ... }: {
  home.packages = with pkgs; [
    ytmdesktop
    vesktop
    nixfmt-classic
    devenv
    vdhcoapp
    nmap
    cargo-generate
    google-chrome
    pcmanfm
    kicad
    rustdesk
  ];
}
