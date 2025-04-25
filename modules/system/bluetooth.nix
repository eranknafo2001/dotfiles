{
  lib,
  config,
  ...
}: let
  cfg = config.my.bluetooth;
in {
  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
