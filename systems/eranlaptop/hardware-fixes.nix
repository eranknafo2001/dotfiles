{pkgs, ...}: {
  # ASUS WiFi fix - udev rule to trigger unblock service
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="platform", KERNEL=="asus-wlan", \
      TAG+="systemd", ENV{SYSTEMD_WANTS}="unblock-asus-wlan.service"
  '';

  # Re-enable Wi-Fi via nmcli after bogus asus-wlan appears
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

  # Re-enable Wi-Fi via nmcli on resume
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

  # Sleep hook script for WiFi unblock
  environment.etc."systemd/system-sleep/unblock-wifi.sh" = {
    text = ''
      #!/usr/bin/env bash
      if [ "$1" = "post" ]; then
        ${pkgs.networkmanager}/bin/nmcli radio wifi on
      fi
    '';
    mode = "0755";
  };

  # Unbind Intel Bluetooth PCIe before sleep to fix hibernation
  # The btintel_pcie driver fails to freeze on Lunar Lake, blocking hibernation
  # Specific to this laptop's Bluetooth chip at PCI address 0000:00:14.7
  systemd.services.bluetooth-suspend-fix = {
    description = "Unbind Intel Bluetooth before sleep to fix hibernation";
    before = ["sleep.target"];
    wantedBy = ["sleep.target"];
    unitConfig.StopWhenUnneeded = true;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0000:00:14.7 > /sys/bus/pci/drivers/btintel_pcie/unbind || true'";
      ExecStop = "${pkgs.bash}/bin/bash -c 'echo 0000:00:14.7 > /sys/bus/pci/drivers/btintel_pcie/bind || true'";
    };
  };
}
