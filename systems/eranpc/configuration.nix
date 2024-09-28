{ config, ... }: {
  imports = [ ./hardware-configuration.nix ../../modules/system/default.nix ];
  my = {
    gaming.enable = true;
    docker.enable = true;
    mpd.enable = true;
    hyprland = {
      enable = true;
      monitors = [
        {
          name = "DP-4";
          position = "0x0";
        }
        {
          name = "HDMI-A-3";
          position = "1920x0";
        }
      ];
    };
    vscode.enable = true;
  };

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = false;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "eranpc";

  time.timeZone = "Asia/Jerusalem";

  fileSystems."/mnt/gnas-stacks" = {
    device = "root@192.168.1.220:/mnt/user/appdata/dockge/stacks";
    fsType = "fuse.sshfs";
    options = [
      "x-systemd.idle-timeout=600"
      "rw"
      "idmap=user"
      "x-systemd.automount"
      "_netdev"
      "allow_other"
      "user"
      "identityfile=${config.users.users.eran.home}/.ssh/id_ed25519"
    ];
  };
  boot.supportedFilesystems."fuse.sshfs" = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  system.stateVersion = "24.05";
}
