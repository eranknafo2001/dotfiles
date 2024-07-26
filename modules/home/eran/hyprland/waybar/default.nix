{ pkgs, lib, config, inputs, osConfig, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 24;
        modules-left = ["hyprland/workspaces" "custom/media"];
        modules-center = ["hyprland/window"];
        modules-right = ["idle_inhibitor" "temperature" "cpu" "memory" "pulseaudio" "backlight" "keyboard-state" "tray" "clock"];
        "hyprland/workspaces" = {
          all-outputs = true;
        };
        "hyprland/window" = {
          separate-outputs = true;
        };
        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:L%Y-%m-%d<small>[%a]</small> <tt><small>%p</small></tt>%I:%M}";
        };
        cpu = {
          format = "  {usage}%";
        };
        memory = {
          format = "  {}%";
        };
        pulseaudio = {
          scroll-step = 5;
          format = "{icon}   {volume}% {format_source}";
          format-bluetooth = " {icon}   {volume}% {format_source}";
          format-bluetooth-muted = "  {icon} {format_source}";
          format-muted = "  {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
          on-click-right = "foot -a pw-top pw-top";
        };
      };
    };
    style = builtins.readFile ./style.css;
  };
}
