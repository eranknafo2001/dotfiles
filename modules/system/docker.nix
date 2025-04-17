{
  lib,
  config,
  ...
}: let
  cfg = config.my.docker;
in {
  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = ["eran"];
  };
}
