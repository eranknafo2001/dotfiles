# Gaming - Steam, Lutris, Heroic, Gamemode
{...}: {
  nixosModules = [
    ({
      pkgs,
      lib,
      config,
      ...
    }: let
      cfg = config.my.gaming;
    in {
      config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          lutris
          heroic
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
    })
  ];
}
