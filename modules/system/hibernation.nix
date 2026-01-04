{
  lib,
  config,
  ...
}: let
  cfg = config.my.hibernation;
in {
  config = lib.mkIf cfg.enable {
    # Resume device for hibernation (optional)
    boot.resumeDevice = lib.mkIf (cfg.resumeDevice != null) cfg.resumeDevice;

    # Enable power management
    powerManagement.enable = true;

    # Suspend-then-hibernate timing (30 minutes)
    systemd.sleep.extraConfig = ''
      HibernateDelaySec=30m
    '';

    # Laptop-specific settings (lid switch, power button)
    services.logind.settings.Login = lib.mkIf cfg.laptop {
      # Lid switch behavior
      HandleLidSwitch = "hibernate"; # On battery: hibernate
      HandleLidSwitchExternalPower = "suspend-then-hibernate"; # On AC: suspend -> hibernate after 30m

      # Power button behavior
      HandlePowerKey = "hibernate"; # Short press: hibernate
      HandlePowerKeyLongPress = "poweroff"; # Long press: power off
    };
  };
}
