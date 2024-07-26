{ pkgs, lib, config, inputs, osConfig, ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
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
# {
#   timeout = 9 * 60;
#   on-timeout = "pidof steam || systemctl suspend || loginctl suspend";
# }
      ];
    };
  };
}
