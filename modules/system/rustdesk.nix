{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.rustdesk;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rustdesk
    ];
  };
}
