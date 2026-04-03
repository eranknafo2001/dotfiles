{...}: {
  flake.nixosModules.adb =
    {...}: {
      programs.adb.enable = true;
    }
;
}
