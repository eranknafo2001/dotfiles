{...}: {
  flake.nixosModules.hibernation = {
    lib,
    config,
    ...
  }: let
    cfg = config.my.hibernation;
  in {
    options.my.hibernation = {
      resumeDevice = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "The swap device to resume from (e.g., /dev/nvme0n1p3)";
      };
      laptop = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable laptop-specific settings (lid switch, power button)";
      };
    };

    config = {
      boot.resumeDevice = lib.mkIf (cfg.resumeDevice != null) cfg.resumeDevice;
      powerManagement.enable = true;

      systemd.sleep.settings.Sleep.HibernateDelaySec = "30m";

      services.logind.settings.Login = lib.mkIf cfg.laptop {
        HandleLidSwitch = "hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        HandlePowerKey = "hibernate";
        HandlePowerKeyLongPress = "poweroff";
      };
    };
  };
}
