# NixOS configuration for eranlaptop (laptop)
{
  inputs,
  mkNixosConfiguration,
  ...
}: {
  flake.nixosConfigurations.eranlaptop = mkNixosConfiguration {
    hostname = "eranlaptop";
    hardwareConfig = ../../systems/eranlaptop/hardware-configuration.nix;
    myConf = ../../systems/eranlaptop/my-conf.nix;
    extraModules = [
      ../../systems/eranlaptop/hardware-fixes.nix
      ({pkgs, ...}: {
        boot = {
          loader = {
            systemd-boot.enable = false;
            grub = {
              enable = true;
              device = "nodev";
              useOSProber = false;
              efiSupport = true;
            };
            efi = {
              canTouchEfiVariables = true;
              efiSysMountPoint = "/boot";
            };
          };
          kernelModules = ["i2c_hid" "i2c_hid_acpi"];
          kernelPackages = pkgs.linuxPackages_latest;
        };

        time.timeZone = "Asia/Jerusalem";

        system.stateVersion = "24.05";
      })
    ];
  };
}
