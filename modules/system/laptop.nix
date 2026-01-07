{
  lib,
  config,
  ...
}: let
  cfg = config.my.laptop;
in {
  config = lib.mkIf cfg.enable {
    # Thermald for thermal management
    services.thermald.enable = true;

    # TLP for battery optimization
    services.tlp = {
      enable = true;
      settings = {
        # CPU scaling governor
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # CPU energy/performance policy
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        # Platform profile (for modern Intel/AMD)
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";
      };
    };

    # Disable power-profiles-daemon (conflicts with TLP)
    services.power-profiles-daemon.enable = false;

    # Disable USB (XHCI) as a wakeup source to prevent spurious wakes from sleep
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", DRIVER=="xhci_hcd", ATTR{power/wakeup}="disabled"
    '';
  };
}
