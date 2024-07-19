{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.my.awesome;
in
{
  options.my.awesome = {
    enable = lib.mkEnableOption "awesome";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      layout = "us";
      windowManager.awesome.enable = true;
      displayManager.gdm.enable = true;
    };

    services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
    programs.dconf.enable = true;
    services.gvfs.enable = true;
    programs.nm-applet.enable = true;
    environment.systemPackages = with pkgs; [
      gnome3.eog
      gnome3.adwaita-icon-theme
      gnomeExtensions.appindicator
      gnome3.nautilus
      arc-icon-theme
    ];

    home-manager.users.eran = { config, pkgs, ... }:
      {
        home.file = {
          ".config/awesome/rc.lua".source = (pkgs.substituteAll {
            src = ./rc.lua;
            rofi = pkgs.rofi;
            flameshot = pkgs.flameshot;
            playerctl = pkgs.playerctl;
            kitty = pkgs.kitty;
            firefox = pkgs.firefox;
            nautilus = pkgs.gnome3.nautilus;
            nvim = pkgs.neovim;
            bash = pkgs.bash;
            xsecurelock = pkgs.xsecurelock;
          });
          ".config/awesome/set_wallpaper.sh".source = (pkgs.substituteAll {
            src = ./set_wallpaper.sh;
            feh = pkgs.feh;
          });
          ".config/awesome/wallpapers".source = ./wallpapers;
          ".config/awesome/theme".source = ./theme;
          ".config/awesome/rofi".source = ./rofi;
          ".config/awesome/lain".source = pkgs.fetchFromGitHub {
            owner = "lcpz";
            repo = "lain";
            rev = "88f5a8a";
            hash = "sha256-MH/aiYfcO3lrcuNbnIu4QHqPq25LwzTprOhEJUJBJ7I=";
          };
          ".config/awesome/freedesktop".source = pkgs.fetchFromGitHub {
            owner = "lcpz";
            repo = "awesome-freedesktop";
            rev = "c82ad29";
            hash = "sha256-lQstCcTPUYUt5hzAJIyQ16crPngeOnUla7I4QiG6gEs=";
          };
        };

        services.autorandr.enable = true;
        programs.autorandr = {
          enable = true;
          profiles.normal = {
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

        services.flameshot.enable = true;

        programs.rofi.enable = true;
        services.picom = {
          enable = true;
          backend = "glx";
          vSync = true;
        };

        services.screen-locker = {
          enable = true;
          lockCmd = "${pkgs.xsecurelock}/bin/xsecurelock";
          inactiveInterval = 30;
          xautolock.enable = false;
          xss-lock = {
            package = pkgs.xss-lock;
            extraOptions = [
              "-n"
              "${pkgs.xsecurelock}/libexec/xsecurelock/dimmer"
              "-l"
            ];
            screensaverCycle = 30;
          };
        };
      };
  };
}
