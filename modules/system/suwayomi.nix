{ lib, config, ... }:
let cfg = config.my.suwayomi;
in {
  config = lib.mkIf cfg.enable {
    services.suwayomi-server = {
      enable = true;
    };
  };
}
