{
  lib,
  config,
  ...
}: let
  cfg = config.my.hyprland;
in {
  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          on_unlock_cmd = lib.mkIf cfg.asus-nmcli-fix "nmcli radio wifi on";
        };
        listener = [
          {
            timeout = 3 * 60;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 4 * 60;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 9 * 60;
            on-timeout = "pidof steam || systemctl suspend";
          }
        ];
      };
    };
  };
}
