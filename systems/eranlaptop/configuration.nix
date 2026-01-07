{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./hardware-fixes.nix
    ../../modules/system/default.nix
  ];

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
}
