{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.adb;
in {
  config = lib.mkIf cfg.enable {
    programs.adb.enable = true;
    services.udev.packages = [
      pkgs.android-udev-rules
    ];
  };
}
