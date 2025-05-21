{
  config,
  lib,
  ...
}: let
  cfg = config.my.hyprland;
in {
  config = lib.mkIf (cfg.enable && (cfg.bar == "eww")) {
    programs.eww = {
      enable = true;
      enableFishIntegration = true;
      configDir = ./.;
    };
  };
}
