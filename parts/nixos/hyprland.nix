# Hyprland - NixOS configuration for Hyprland window manager
{inputs, ...}: {
  nixosModules = [
    ({
      pkgs,
      lib,
      config,
      ...
    }: let
      cfg = config.my.hyprland;
    in {
      config = lib.mkIf cfg.enable {
        programs.hyprland = {
          enable = true;
          package = inputs.hyprland.packages.${pkgs.system}.hyprland;
          portalPackage =
            inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
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

        environment.sessionVariables = {NIXOS_OZONE_WL = "1";};

        hardware = {
          graphics.enable = true;
          nvidia.modesetting.enable = cfg.nvidia;
        };

        services.greetd = {
          enable = true;
          settings = {
            default_session = {
              command = ''${pkgs.greetd.tuigreet}/bin/tuigreet -r --time --cmd "start-hyprland"'';
              user = "eran";
            };
          };
        };
        security.pam.services.greetd.enableGnomeKeyring = true;
      };
    })
  ];
}
