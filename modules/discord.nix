{ pkgs, lib, config, ... }:
let
  cfg = config.my.discord;
in
{
  options.my.discord = {
    enable = lib.mkEnableOption "discord";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vesktop
    ];
  };
}
