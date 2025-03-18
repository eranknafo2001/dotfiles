{ pkgs, config, hyprland-config, ... }: {
  imports = [ ./hardware-configuration.nix ../../modules/system/default.nix ];
  my = {
    gaming.enable = true;
    docker.enable = true;
    mpd.enable = true;
    solaar.enable = true;
    rustdesk.enable = false;
    hyprland = hyprland-config;
  };

  # nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = false;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  networking.hostName = "eranpc";

  time.timeZone = "Asia/Jerusalem";

  # fileSystems."/mnt/gnas-stacks" = {
  #   device = "root@192.168.1.24:/mnt/user/appdata/dockge/stacks";
  #   fsType = "fuse.sshfs";
  #   options = [
  #     "x-systemd.idle-timeout=600"
  #     "rw"
  #     "idmap=user"
  #     "x-systemd.automount"
  #     "_netdev"
  #     "allow_other"
  #     "user"
  #     "identityfile=${config.users.users.eran.home}/.ssh/id_ed25519"
  #   ];
  # };

  # fileSystems."/mnt/home-assistant" = {
  #   device = "root@192.168.1.25:/homeassistant";
  #   fsType = "fuse.sshfs";
  #   options = [
  #     "x-systemd.idle-timeout=600"
  #     "rw"
  #     "idmap=user"
  #     "x-systemd.automount"
  #     "_netdev"
  #     "allow_other"
  #     "user"
  #     "identityfile=${config.users.users.eran.home}/.ssh/id_ed25519"
  #   ];
  # };
  # boot.supportedFilesystems."fuse.sshfs" = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;
  };

  services.udev.packages = [ pkgs.android-udev-rules ];

  system.stateVersion = "24.05";
}
