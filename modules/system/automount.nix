{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.automount;
in {
  config = lib.mkIf cfg.enable {
    services.udisks2.enable = true;
    environment.systemPackages = with pkgs; [
      ntfs3g
      exfatprogs
    ];
  };
}
