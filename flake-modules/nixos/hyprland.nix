{...}: {
  flake.nixosModules.hyprland = {
    pkgs,
    lib,
    config,
    inputs,
    ...
  }: let
    cfg = config.my.hyprland;
  in {
    options.my.hyprland = {
      nvidia = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      battery = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      asus-nmcli-fix = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      bar = lib.mkOption {
        type = lib.types.enum ["waybar" "eww"];
        default = "waybar";
      };
      monitors = lib.mkOption {
        type = with lib.types;
          listOf (submodule {
            options = {
              name = lib.mkOption {type = str;};
              resolution = lib.mkOption {type = str;};
              position = lib.mkOption {type = str;};
              scale = lib.mkOption {type = float;};
            };
          });
        default = [];
      };
    };

    config = {
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };

      xdg.portal = {
        enable = true;
        wlr.enable = false;
      };

      services.dbus.enable = true;
      services.gnome.gnome-keyring.enable = true;
      programs.nm-applet.enable = true;
      security.rtkit.enable = true;

      services = {
        upower.enable = cfg.battery;
        pulseaudio.enable = false;
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
        };
      };

      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      hardware = {
        graphics.enable = true;
        nvidia.modesetting.enable = cfg.nvidia;
      };

      services.greetd = {
        enable = true;
        settings.default_session = {
          command = ''${pkgs.greetd.tuigreet}/bin/tuigreet -r --time --cmd "start-hyprland"'';
          user = "eran";
        };
      };

      security.pam.services.greetd.enableGnomeKeyring = true;
    };
  };
}
