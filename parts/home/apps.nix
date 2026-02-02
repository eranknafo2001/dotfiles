# User applications
{...}: {
  homeModules = [
    ({pkgs, ...}: {
      home.packages = with pkgs; [
        ytmdesktop
        legcord
        devenv
        vdhcoapp
        nmap
        cargo-generate
        google-chrome
        pcmanfm
        bitwarden-desktop
        prusa-slicer
      ];
    })
  ];
}
