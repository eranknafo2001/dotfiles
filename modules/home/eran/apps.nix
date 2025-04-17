{pkgs, ...}: {
  home.packages = with pkgs; [
    ytmdesktop
    vesktop
    devenv
    vdhcoapp
    nmap
    cargo-generate
    google-chrome
    pcmanfm
    bitwarden-desktop
    stremio
    #kicad
    #rustdesk
  ];
}
