{...}: {
  flake.nixosModules.suwayomi =
    {...}: {
      services.suwayomi-server.enable = true;
    }
;
}
