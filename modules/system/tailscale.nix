{
  lib,
  config,
  ...
}: let
  cfg = config.my.tailscale;
in {
  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;
  };
}
