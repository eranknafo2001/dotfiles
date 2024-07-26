# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/default.nix
  ];
  my = {
    gaming.enable = true;
    nvim.enable = true;
    kitty.enable = true;
    shell.enable = true;
    git.enable = true;
    discord.enable = true;
    docker.enable = true;
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
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "eranpc";

  time.timeZone = "Asia/Jerusalem";


  networking.extraHosts = ''
      192.168.1.220 gnas.local
    '';

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.printing.enable = true;


  nixpkgs.config.allowUnfree = true;


  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  system.stateVersion = "24.05";
}
