{pkgs, ...}: {
  imports = [./hardware-configuration.nix ../../modules/system/default.nix];

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

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="platform", KERNEL=="asus-wlan", \
      TAG+="systemd", ENV{SYSTEMD_WANTS}="unblock-asus-wlan.service"
  '';

  # 3) a one-shot systemd service to clear that soft-block
  systemd.services.unblock-asus-wlan = {
    description = "Re-enable Wi-Fi via nmcli after bogus asus-wlan appears";
    wants = ["systemd-udevd.service" "NetworkManager.service"];
    after = ["systemd-udevd.service" "NetworkManager.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.networkmanager}/bin/nmcli radio wifi on";
    };
    wantedBy = ["multi-user.target"];
  };

  # 4) also clear it after every suspend→resume
  systemd.services.unblock-asus-wlan-sleep = {
    description = "Re-enable Wi-Fi via nmcli on resume";
    wants = ["sleep.target" "NetworkManager.service"];
    after = ["sleep.target" "NetworkManager.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.networkmanager}/bin/nmcli radio wifi on";
    };
    wantedBy = ["suspend.target" "hibernate.target" "hybrid-sleep.target"];
  };

  environment.etc."systemd/system-sleep/unblock-wifi.sh" = {
    text = ''
      #!/usr/bin/env bash
      #
      # this script is run twice around suspend:
      #   $1 = pre  → just before suspend
      #   $1 = post → just after resume
      #
      if [ "$1" = "post" ]; then
        # ensure NM is up, then unblock wifi
        ${pkgs.networkmanager}/bin/nmcli radio wifi on
      fi
    '';
    mode = "0755";
  };

  networking.hostName = "eranlaptop";

  time.timeZone = "Asia/Jerusalem";

  services.udev.packages = [pkgs.android-udev-rules];

  system.stateVersion = "24.05";
}
