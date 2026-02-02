# ADB - Android Debug Bridge
{...}: {
  nixosModules = [
    ({lib, config, ...}: let
      cfg = config.my.adb;
    in {
      config = lib.mkIf cfg.enable {
        programs.adb.enable = true;
      };
    })
  ];
}
