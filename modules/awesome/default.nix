{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.my.awesome;
in
{
  options.my.awesome = {
    enable = lib.mkEnableOption "awesome";
    autorandr-profiles = lib.mkOption;
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
          profiles = cfg.autorandr-profiles;
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
