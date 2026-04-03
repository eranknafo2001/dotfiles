{...}: {
  flake.nixosModules.eranlaptop-configuration = {
    pkgs,
    self,
    ...
  }: {
    imports = [
      self.nixosModules.eranlaptop-hardware
      self.nixosModules.eranlaptop-hardware-fixes
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };

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

    networking.hostName = "eranlaptop";
    time.timeZone = "Asia/Jerusalem";
    system.stateVersion = "24.05";
  };
}
