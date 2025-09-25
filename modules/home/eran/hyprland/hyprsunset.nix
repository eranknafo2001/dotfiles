{
  lib,
  config,
  ...
}: let
  cfg = config.my.hyprland;
in {
  config = lib.mkIf cfg.enable {
    services.hyprsunset = {
      enable = true;
      settings = {
        max-gamma = 100;
        profile = [
          {
            time = "7:30";
            identity = true;
          }
          {
            time = "20:00";
            temperature = 3800;
            gamma = 0.9;
          }
        ];
      };
    };
  };
}
