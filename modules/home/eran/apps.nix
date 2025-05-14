{pkgs, ...}: {
  home.packages = with pkgs; [
    ytmdesktop
    # vesktop
    legcord
    devenv
    vdhcoapp
    nmap
    cargo-generate
    google-chrome
    pcmanfm
    bitwarden-desktop
    stremio
    prusa-slicer
    #kicad
    #rustdesk
  ];
}
