# MPD - Music Player Daemon
{...}: {
  nixosModules = [
    ({lib, config, ...}: let
      cfg = config.my.mpd;
    in {
      config = lib.mkIf cfg.enable {
        services.mpd = {
          enable = true;
          network.listenAddress = "any";
          startWhenNeeded = true;
        };
      };
    })
  ];
}
