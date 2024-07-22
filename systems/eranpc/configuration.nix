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
    awesome = {
      enable = true;
      autorandr-profiles.normal = {
        fingerprint = {
          DP-4 = "00ffffffffffff0010acd9d0424b4830181e0104a5351e783a0565a756529c270f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff00363244343934330a2020202020000000fc0044454c4c205032343139480a20000000fd00384c1e5311010a20202020202000e6";
          HDMI-0 = "00ffffffffffff0005e33922c30700001f14010380301b782a1425a359559b260f5054bfef0081c0814081809500b300010101010101023a801871382d40582c4500dd0c1100001e000000fd00384b1e5011000a202020202020000000fc00323233390a2020202020202020000000ff0041534441384a4130303139383701d902031ef14b0514101f04130312021101230907018301000065030c0010008c0ad08a20e02d10103e9600092521000018011d007251d01e206e28550009252100001e8c0ad08a20e02d10103e96000925210000188c0ad090204031200c40550009252100001800000000000000000000000000000000000000000000000000f7";
        };
        config = {
          DP-4 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            rotate = "normal";
          };
          HDMI-0 = {
            enable = true;
            primary = false;
            position = "1920x0";
            mode = "1920x1080";
            rotate = "normal";
          };
          DP-0.enable = false;
          DP-1.enable = false;
          DP-2.enable = false;
          DP-3.enable = false;
          DP-5.enable = false;
        };
      };
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  system.stateVersion = "24.05";
}
