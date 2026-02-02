# KDE Connect
{...}: {
  nixosModules = [
    ({lib, config, ...}: let
      cfg = config.my.kde-connect;
    in {
      config = lib.mkIf cfg.enable {
        programs.kdeconnect.enable = true;
      };
    })
  ];
}
