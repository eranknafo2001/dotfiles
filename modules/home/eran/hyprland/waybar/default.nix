{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.my.hyprland;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [font-awesome];
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          height = 28;
          modules-left = ["hyprland/workspaces" "custom/media"];
          modules-center = ["hyprland/window"];
          modules-right =
            [
              "idle_inhibitor"
              "temperature"
              "cpu"
              "memory"
              "pulseaudio"
              "backlight"
            ]
            ++ (lib.optionals cfg.battery ["upower"])
            ++ [
              "hyprland/language"
              "tray"
              "clock"
            ];
          "hyprland/workspaces".all-outputs = true;
          "hyprland/window".separate-outputs = true;
          backlight = {
            format = "{icon} {percent}%";
            format-icons = ["🔆"];
          };
          upower = lib.mkIf cfg.battery {
            format = " {percentage}";
            icon-size = 10;
          };

          "hyprland/language" = {
            format-en = "Eng";
            format-he = "Heb";
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          tray.spacing = 10;
          temperature = {
            thermal-zone = 2;
            hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
            critical-threshold = 80;
            format-critical = "{icon} {temperatureC}°C";
            format = "{icon} {temperatureC}°C";
            format-icons = ["" ""];
          };
          clock = {
            tooltip-format = ''
              <big>{:%Y %B}</big>
              <tt><small>{calendar}</small></tt>'';
            format = "{:L%Y-%m-%d<small>[%a]</small> <tt><small>%p</small></tt>%I:%M}";
          };
          cpu.format = "  {usage}%";
          memory.format = "  {}%";
          pulseaudio = {
            scroll-step = 5;
            format = "{icon}   {volume}% {format_source}";
            format-bluetooth = " {icon}   {volume}% {format_source}";
            format-bluetooth-muted = "  {icon} {format_source}";
            format-muted = "  {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons.default = ["" "" ""];
            on-click = "pavucontrol";
            on-click-right = "foot -a pw-top pw-top";
          };
        };
      };
      style = builtins.readFile ./style.css;
    };
  };
}
