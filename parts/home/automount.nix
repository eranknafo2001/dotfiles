# Automount - udiskie for Home Manager
{...}: {
  homeModules = [
    ({lib, config, ...}: let
      cfg = config.my.automount;
    in {
      config = lib.mkIf cfg.enable {
        services.udiskie = {
          enable = true;
          tray = "never";
          notify = true;
          automount = true;
        };
      };
    })
  ];
}
