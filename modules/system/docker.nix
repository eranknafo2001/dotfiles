{ lib, config, ... }:
let cfg = config.my.docker;
in {
  options.my.docker = { enable = lib.mkEnableOption "docker"; };
  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "eran" ];
  };
}
