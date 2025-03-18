{
  lib,
  config,
  ...
}: let
  cfg = config.my.rustdesk;
in {
  options.my.rustdesk = {enable = lib.mkEnableOption "mpd";};

  config = lib.mkIf cfg.enable {
    services.rustdesk-server = {
      enable = true;
      openFirewall = true;
    };
  };
}
