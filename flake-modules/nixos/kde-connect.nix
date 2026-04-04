{...}: {
  flake.nixosModules.kde-connect = {...}: {
    programs.kdeconnect.enable = true;
  };
}
