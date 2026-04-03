{...}: {
  flake.nixosModules.eranpc-configuration = {
    config,
    self,
    ...
  }: {
    imports = [
      self.nixosModules.eranpc-hardware
    ];

    boot.loader.systemd-boot.enable = false;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.useOSProber = false;
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";

    hardware.keyboard.zsa.enable = true;
    networking.hostName = "eranpc";
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
  };
}
