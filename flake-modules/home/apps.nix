{...}: {
  flake.homeModules.apps = {pkgs, ...}: {
    home.packages = with pkgs; [
      ytmdesktop
      # vesktop
      legcord
      devenv
      nmap
      cargo-generate
      google-chrome
      pcmanfm
      bitwarden-desktop
      # stremio
      prusa-slicer
      gh
      (writeShellScriptBin "playwright-cli" ''
        exec ${bun}/bin/bun x playwright-cli "$@"
      '')
      #kicad
      #rustdesk
    ];
  };
}
