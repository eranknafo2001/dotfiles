{ pkgs, lib, config, ... }:
let cfg = config.my.gaming;
in {
  options.my.gaming = { enable = lib.mkEnableOption "gaming"; };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lutris
      heroic
      #bottles
      # proton-ge-bin
    ];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
    hardware.steam-hardware.enable = true;

    programs.gamemode.enable = true;
  };
}
