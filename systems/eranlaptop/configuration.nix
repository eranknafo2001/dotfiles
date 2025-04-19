{pkgs, ...}: {
  imports = [./hardware-configuration.nix ../../modules/system/default.nix];

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = false;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.kernelModules = ["iwlwifi" "i2c_hid" "i2c_hid_acpi"];

  #services.openssh = {
  #  enable = true;
  #  settings.PasswordAuthentication = true;
  #};

  #services.xserver.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  networking.hostName = "eranlaptop";

  time.timeZone = "Asia/Jerusalem";

  services.udev.packages = [pkgs.android-udev-rules];

  system.stateVersion = "24.05";
}
