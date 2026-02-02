# NixOS configuration for eranpc (desktop)
{
  inputs,
  mkNixosConfiguration,
  ...
}: {
  flake.nixosConfigurations.eranpc = mkNixosConfiguration {
    hostname = "eranpc";
    hardwareConfig = ../../systems/eranpc/hardware-configuration.nix;
    myConf = ../../systems/eranpc/my-conf.nix;
    extraModules = [
      ({config, ...}: {
        boot.loader.systemd-boot.enable = false;
        boot.loader.grub.enable = true;
        boot.loader.grub.device = "nodev";
        boot.loader.grub.useOSProber = false;
        boot.loader.grub.efiSupport = true;
        boot.loader.efi.canTouchEfiVariables = true;
        boot.loader.efi.efiSysMountPoint = "/boot";

        hardware.keyboard.zsa.enable = true;

        time.timeZone = "Asia/Jerusalem";

        services.xserver.videoDrivers = ["nvidia"];
        hardware.nvidia = {
          modesetting.enable = true;
          powerManagement.enable = false;
          powerManagement.finegrained = false;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
          open = false;
        };

        system.stateVersion = "24.05";
      })
    ];
  };
}
